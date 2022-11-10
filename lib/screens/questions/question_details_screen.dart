import 'package:altkamul_task/models/answer.dart';
import 'package:altkamul_task/models/comment.dart';
import 'package:altkamul_task/models/question.dart';
import 'package:altkamul_task/models/response.dart';
import 'package:altkamul_task/screens/questions/questions_bloc.dart';
import 'package:altkamul_task/screens/questions/questions_extras.dart';
import 'package:altkamul_task/widgets/question_widget.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:collection/collection.dart';

class QuestioDetailsScreen extends StatelessWidget {
  QuestioDetailsScreen({Key? key , this.bloc , this.questionModel}) : super(key: key);

  double? width , height;
  QuestionsBloc? bloc;
  QuestionModel? questionModel;

  AnswerResponseModel? answersResponseModel;
  CommentResponseModel? commentsResponseModel;

  int answersPageNumber = 1;
  int commentsPageNumber = 1;

  final RefreshController _answersRefreshController = RefreshController(initialRefresh: false);
  final RefreshController _commentsRefreshController = RefreshController(initialRefresh: false);


  @override
  Widget build(BuildContext context) {

    height = MediaQuery.of(context).size.height / 100;
    width = MediaQuery.of(context).size.width / 100;

    return Scaffold(
      appBar: AppBar(
        title: const AutoSizeText('Altkamul Task'),
      ),
      body: SafeArea(
        child: BlocBuilder(
            bloc: bloc,
            builder: (context , state){

              if(state is Idle){
                bloc!.add(LoadAnswers(questionId: questionModel!.questionId));
              }

              if(state is AnswersLoadedSuccess){
                bloc!.add(LoadComments(questionId: questionModel!.questionId));
                answersPageNumber++;
                answersResponseModel = state.answersResponseModel!;
              }

              if(state is CommentsLoadedSuccess){
                commentsPageNumber++;
                commentsResponseModel = state.commentsResponseModel!;
              }

              if(state is MoreAnswersLoadedSuccess){
                answersPageNumber++;
                answersResponseModel!.hasMore = state.answersResponseModel!.hasMore;
                answersResponseModel!.quotaRemaining = state.answersResponseModel!.quotaRemaining;
                answersResponseModel!.quotaMax = state.answersResponseModel!.quotaMax;

                for(AnswerModel answer in state.answersResponseModel!.answers!){
                  if(answersResponseModel!.answers!.firstWhereOrNull((element) => element.answerId == answer.answerId) == null){
                    answersResponseModel!.answers!.add(answer);
                  }
                }

                _answersRefreshController.loadComplete();
              }

              if(state is MoreCommentsLoadedSuccess){
                commentsPageNumber++;

                commentsResponseModel!.hasMore = state.commentsResponseModel!.hasMore;
                commentsResponseModel!.quotaRemaining = state.commentsResponseModel!.quotaRemaining;
                commentsResponseModel!.quotaMax = state.commentsResponseModel!.quotaMax;

                for(CommentModel comment in state.commentsResponseModel!.comments!){
                  if(commentsResponseModel!.comments!.firstWhereOrNull((element) => element.commentId == comment.commentId) == null){
                    commentsResponseModel!.comments!.add(comment);
                  }
                }

                _commentsRefreshController.loadComplete();

              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  QuestionWidget(questionModel: questionModel,),
                  const SizedBox(height: 10,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      children: [
                        questionModel!.acceptedAnswerId != null ? Icon(Icons.check_box,size: 22,color: Theme.of(context).primaryColor) : const Icon(Icons.check_box_outline_blank,size: 22,color: Colors.white,),
                        const SizedBox(width: 5,),
                        AutoSizeText(
                          'Accepted Answer',
                          style: TextStyle(
                              color: Colors.grey.shade700,
                              fontWeight: FontWeight.w500,
                              fontSize: 13
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 5,),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: DefaultTabController(
                          length: 2,
                          child: Scaffold(
                            backgroundColor: Colors.white,
                            appBar: TabBar(
                              indicatorWeight: 2,
                              indicatorColor: Theme.of(context).primaryColor,
                              unselectedLabelColor: const Color(0xff6d6d6d),
                              labelColor: Theme.of(context).primaryColor,
                              onTap: (index) {
                                // selectedTab = index;
                                // bloc.add(SelectProfileTab(tabIndex: index));
                              },
                              tabs: const [
                                Tab(
                                  height: 37,
                                  child: Center(
                                      child: AutoSizeText(
                                        'Answers',
                                        style: TextStyle(fontWeight: FontWeight.w600 , fontSize: 15),
                                      )),
                                ),
                                Tab(
                                  height: 37,
                                  child: Center(
                                      child: AutoSizeText(
                                        'Comments',
                                        style: TextStyle(fontWeight: FontWeight.w600 ,  fontSize: 15),
                                      )),
                                ),
                              ],
                            ),
                            body: TabBarView(
                              physics: const NeverScrollableScrollPhysics(),
                              children: [
                                //Answers
                                if (answersResponseModel == null) Center(child:  SpinKitCubeGrid(size: 55,color: Theme.of(context).primaryColor,),)
                                else if (answersResponseModel!.answers!.isNotEmpty) SmartRefresher(
                                  controller: _answersRefreshController,
                                  enablePullDown: false,
                                  enablePullUp: true,
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
                                    if(answersResponseModel!.hasMore!){
                                      bloc!.add(LoadMoreAnswers(questionId: questionModel!.questionId , answersPageNumber: answersPageNumber));
                                    }
                                    else{
                                      _answersRefreshController.loadNoData();
                                    }
                                  },
                                  child: ListView.builder(
                                    itemCount: answersResponseModel!.answers!.length,
                                    itemBuilder: (context,index){
                                      return Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 15 , vertical: 20),
                                        decoration:  BoxDecoration(
                                            border: Border(
                                              bottom: BorderSide(color: Theme.of(context).primaryColor , width: 4),
                                            )
                                        ),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Visibility(
                                              visible: answersResponseModel!.answers![index].isAccepted ?? false,
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  questionModel!.acceptedAnswerId != null ? Icon(Icons.check_box,size: 22,color: Theme.of(context).primaryColor) : const Icon(Icons.check_box_outline_blank,size: 22,color: Colors.white,),
                                                  const SizedBox(width: 5,),
                                                  AutoSizeText(
                                                    'Accepted Answer',
                                                    style: TextStyle(
                                                        color: Colors.grey.shade700,
                                                        fontWeight: FontWeight.w500,
                                                        fontSize: 13
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),

                                            const SizedBox(height: 5,),

                                            Row(
                                              children: [
                                                AutoSizeText(
                                                  '${answersResponseModel!.answers![index].score} scores',
                                                  style: const TextStyle(
                                                      color: Colors.black,
                                                      fontWeight: FontWeight.w500,
                                                      fontSize: 14
                                                  ),
                                                ),
                                              ],
                                            ),

                                            const SizedBox(height: 5,),

                                            Html(
                                              data: """${answersResponseModel!.answers![index].body}""",
                                            ),

                                            const SizedBox(height: 5,),

                                            AutoSizeText(
                                              'Answer Link :',
                                              style: TextStyle(
                                                  color: Theme.of(context).primaryColor,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 15
                                              ),
                                            ),

                                            const SizedBox(height: 5,),

                                            InkWell(
                                              onTap: () async {
                                                if (!await launchUrl(Uri.parse(answersResponseModel!.answers![index].link!))) {
                                                  ScaffoldMessenger.of(context).showSnackBar(
                                                      SnackBar(
                                                        backgroundColor: Theme.of(context).primaryColor,
                                                        content: const AutoSizeText(
                                                          'Can\'t Open This Link',
                                                          style: TextStyle(
                                                              color: Colors.white,
                                                              fontWeight: FontWeight.w600,
                                                              fontSize: 15
                                                          ),
                                                        ),
                                                      )
                                                  );
                                                }
                                              },
                                              child: AutoSizeText(
                                                answersResponseModel!.answers![index].link ?? '',
                                                style: TextStyle(
                                                    color: Colors.blue.shade800,
                                                    fontWeight: FontWeight.normal,
                                                    fontSize: 14,
                                                    decoration: TextDecoration.underline
                                                ),
                                                maxLines: 3,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),

                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                )
                                else Center(
                                    child: AutoSizeText(
                                      'No Answers Yet!',
                                      style: TextStyle(
                                          color: Colors.grey.shade700,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 13
                                      ),
                                    ),
                                  ),

                                //Comments
                                if (commentsResponseModel == null) Center(child:  SpinKitCubeGrid(size: 55,color: Theme.of(context).primaryColor,),)
                                else if (commentsResponseModel!.comments!.isNotEmpty) SmartRefresher(
                                  controller: _commentsRefreshController,
                                  enablePullDown: false,
                                  enablePullUp: true,
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
                                    if(commentsResponseModel!.hasMore!){
                                      bloc!.add(LoadMoreComments(questionId: questionModel!.questionId,commentsPageNumber: commentsPageNumber));
                                    }
                                    else{
                                    _commentsRefreshController.loadNoData();
                                    }
                                  },
                                  child: ListView.builder(
                                    itemCount: commentsResponseModel!.comments!.length,
                                    itemBuilder: (context,index){
                                      return Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 15 , vertical: 20),
                                        decoration:  BoxDecoration(
                                            border: Border(
                                              bottom: BorderSide(color: Theme.of(context).primaryColor , width: 4),
                                            )
                                        ),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [

                                            const SizedBox(height: 5,),

                                            Row(
                                              children: [
                                                AutoSizeText(
                                                  '${commentsResponseModel!.comments![index].score} scores',
                                                  style: const TextStyle(
                                                      color: Colors.black,
                                                      fontWeight: FontWeight.w500,
                                                      fontSize: 14
                                                  ),
                                                ),
                                              ],
                                            ),

                                            const SizedBox(height: 5,),

                                            Html(
                                              data: """${commentsResponseModel!.comments![index].body}""",
                                            ),

                                            const SizedBox(height: 5,),

                                            AutoSizeText(
                                              'Comment Link :',
                                              style: TextStyle(
                                                  color: Theme.of(context).primaryColor,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 15
                                              ),
                                            ),

                                            const SizedBox(height: 5,),

                                            InkWell(
                                              onTap: () async {
                                                if (!await launchUrl(Uri.parse(commentsResponseModel!.comments![index].link!))) {
                                                  ScaffoldMessenger.of(context).showSnackBar(
                                                    SnackBar(
                                                      backgroundColor: Theme.of(context).primaryColor,
                                                    content: const AutoSizeText(
                                                      'Can\'t Open This Link',
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight: FontWeight.w600,
                                                          fontSize: 15
                                                      ),
                                                    ),
                                                    )
                                                  );
                                                }
                                              },
                                              child: AutoSizeText(
                                                commentsResponseModel!.comments![index].link ?? '',
                                                style: TextStyle(
                                                    color: Colors.blue.shade800,
                                                    fontWeight: FontWeight.normal,
                                                    fontSize: 14,
                                                    decoration: TextDecoration.underline
                                                ),
                                                maxLines: 3,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),

                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                )
                                else Center(
                                    child: AutoSizeText(
                                      'No Comments Yet!',
                                      style: TextStyle(
                                          color: Colors.grey.shade700,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 13
                                      ),
                                    ),
                                  )
                              ],
                            )
                          )
                      ),
                    ),
                  )
                ],
              );
            }
        ),
      ),
    );
  }
}
