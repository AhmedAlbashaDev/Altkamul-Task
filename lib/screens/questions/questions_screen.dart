import 'package:altkamul_task/screens/questions/question_details_screen.dart';
import 'package:altkamul_task/screens/questions/questions_bloc.dart';
import 'package:altkamul_task/screens/questions/questions_extras.dart';
import 'package:altkamul_task/utils/globals.dart';
import 'package:altkamul_task/widgets/question_widget.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class QuestionsScreen extends StatelessWidget {
  QuestionsScreen({Key? key}) : super(key: key);

  QuestionsBloc bloc = QuestionsBloc(Idle());

  double? width , height;
  final RefreshController _refreshController = RefreshController(initialRefresh: false);


  @override
  Widget build(BuildContext context) {

    height = MediaQuery.of(context).size.height / 100;
    width = MediaQuery.of(context).size.width / 100;

    return Scaffold(
      appBar: AppBar(
        title: const AutoSizeText('Altkamul Task'),
      ),
      body: SafeArea(
        child: BlocListener(
          bloc: bloc,
          listener: (context,state){
            if(state is QuestionsLoadedSuccess){
              if(networkStatusOn!){
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Theme.of(context).primaryColor,
                      content: const AutoSizeText(
                        'You are in online mode',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 17
                        ),
                      ),
                    )
                );
              }
              else{
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Theme.of(context).primaryColor,
                      content: const AutoSizeText(
                        'You are in offline mode',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 17
                        ),
                      ),
                    )
                );
              }
            }
          },
          child: BlocBuilder(
            bloc: bloc,
            builder: (context , state){

              if(state is Idle){

                if(responseModel == null){
                  bloc.add(LoadQuestions());
                }

              }

              if(state is QuestionsLoadedSuccess){
                questionsPageNumber++;
                responseModel = state.responseModel;
              }

              if(state is MoreQuestionsLoadedSuccess){
                questionsPageNumber++;
                _refreshController.loadComplete();
                responseModel = state.responseModel;
              }

              if (responseModel == null) {
                return Center(
                    child: SpinKitCubeGrid(size: 55,color: Theme.of(context).primaryColor,),
                  );
              } else if (responseModel!.questions!.isNotEmpty) {
                return SmartRefresher(
                  controller: _refreshController,
                  enablePullDown: false,
                  enablePullUp: networkStatusOn == true ? true : false,
                  footer: CustomFooter(
                    builder: (context, status){
                      Widget? body ;
                      if(status == LoadStatus.loading){
                        body =  SpinKitCubeGrid(
                          size: 30,
                          color: Theme.of(context).primaryColor,
                        );
                      }
                      else if(status  == LoadStatus.noMore){
                        body = const AutoSizeText("No more data");
                      }
                      return SizedBox(
                        height: 60.0,
                        child: Center(child:body),
                      );
                    },
                  ),
                  onLoading: (){
                      if(responseModel!.hasMore!){
                        bloc.add(LoadMoreQuestions());
                      }
                      else{
                        _refreshController.loadNoData();
                      }
                  },
                  child: ListView.builder(
                      itemCount: responseModel!.questions!.length,
                      itemBuilder: (context , index){
                        return QuestionWidget(
                          onTap: (){
                            bloc.emit(Idle());
                            Navigator.push(context, MaterialPageRoute(builder: (context) => QuestioDetailsScreen(bloc: bloc,questionModel: responseModel!.questions?[index],)));
                          },
                          questionModel: responseModel!.questions?[index],
                        );
                      },
                    ),
                );
              } else {
                return Center(
                  child: AutoSizeText(
                    'No Questions Yet!',
                    style: TextStyle(
                        color: Colors.grey.shade700,
                        fontWeight: FontWeight.w500,
                        fontSize: 13
                    ),
                  ),
                );
              }
            }
          ),
        ),
      ),
    );
  }
}
