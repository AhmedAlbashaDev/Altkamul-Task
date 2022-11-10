import 'package:altkamul_task/models/question.dart';
import 'package:altkamul_task/models/response.dart';
import 'package:altkamul_task/screens/questions/questions_extras.dart';
import 'package:altkamul_task/utils/globals.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:collection/collection.dart';

class QuestionsBloc extends Bloc{
  QuestionsBloc(super.initialState){
    on<LoadQuestions>(_loadQuestions);
    on<LoadMoreQuestions>(_loadMoreQuestions);
    on<LoadAnswers>(_loadAnswers);
    on<LoadMoreAnswers>(_loadMoreAnswers);
    on<LoadComments>(_loadComments);
    on<LoadMoreComments>(_loadMoreComments);
  }

  Box<QuestionModel>? questionsBox;

  _loadQuestions(LoadQuestions event, Emitter emit) async {

    questionsBox = await Hive.openBox<QuestionModel>('questions');

    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {
      client.interceptors.add(PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseBody: true,
          responseHeader: true,
          error: true,
          compact: true,
          maxWidth: 90));

      final response = await client.get('questions',queryParameters: {'page' : questionsPageNumber, 'pagesize' : 15 , 'order' : 'desc' , 'sort' : 'votes' , 'site' : 'stackoverflow'});

      responseModel = ResponseModel.fromJson(response.data);

      for(QuestionModel question in responseModel!.questions!){
        if(questionsBox!.get(question.questionId) == null){
          await questionsBox!.put(question.questionId, question);
        }
      }

      networkStatusOn = true;

    }
    else{

      List<QuestionModel> questions = [];

      for(QuestionModel question in questionsBox!.values){
        questions.add(question);
      }

      responseModel = ResponseModel(questions: questions , hasMore: false , quotaMax: 0,quotaRemaining: 0);

      networkStatusOn = false;
    }

    emit(QuestionsLoadedSuccess(responseModel: responseModel));
  }

  _loadMoreQuestions(LoadMoreQuestions event, Emitter emit) async {

    final response = await client.get('questions',queryParameters: {'page' : questionsPageNumber, 'pagesize' : 15 , 'order' : 'desc' , 'sort' : 'votes' , 'site' : 'stackoverflow'});

    responseModel!.hasMore = ResponseModel.fromJson(response.data).hasMore;
    responseModel!.quotaMax = ResponseModel.fromJson(response.data).quotaMax;
    responseModel!.quotaRemaining = ResponseModel.fromJson(response.data).quotaRemaining;

    for(QuestionModel question in ResponseModel.fromJson(response.data).questions!){
      if(responseModel!.questions!.firstWhereOrNull((element) => element.questionId == question.questionId) == null){
        responseModel!.questions!.add(question);
      }
    }

    for(QuestionModel question in ResponseModel.fromJson(response.data).questions!){
      if(questionsBox!.get(question.questionId) == null){
        await questionsBox!.put(question.questionId, question);
      }
    }

    emit(MoreQuestionsLoadedSuccess(responseModel: responseModel));
  }

  _loadAnswers(LoadAnswers event, Emitter emit) async {

    final response = await client.get('questions/${event.questionId}/answers',
        queryParameters: {'page' : 1, 'pagesize' : 15 , 'order' : 'desc' , 'sort' : 'votes' , 'site' : 'stackoverflow' , 'filter' : '!LJ-PME0t2sxAvLH*FmvoD9'});

    AnswerResponseModel answerResponseModel = AnswerResponseModel.fromJson(response.data);

    emit(AnswersLoadedSuccess(answersResponseModel: answerResponseModel));
  }

  _loadMoreAnswers(LoadMoreAnswers event, Emitter emit) async {

    final response = await client.get('questions/${event.questionId}/answers',queryParameters: {'page' : event.answersPageNumber ?? 2, 'pagesize' : 15 , 'order' : 'desc' , 'sort' : 'votes' , 'site' : 'stackoverflow', 'filter' : '!LJ-PME0t2sxAvLH*FmvoD9'});

    AnswerResponseModel answerResponseModel = AnswerResponseModel.fromJson(response.data);

    emit(MoreAnswersLoadedSuccess(answersResponseModel: answerResponseModel));
  }

  _loadComments(LoadComments event, Emitter emit) async {

    final response = await client.get('questions/${event.questionId}/comments',queryParameters: {'page' : 1, 'pagesize' : 15 , 'order' : 'desc' , 'sort' : 'votes' , 'site' : 'stackoverflow','filter' : '!6VvPDzR)tamp0'});

    CommentResponseModel commentResponseModel = CommentResponseModel.fromJson(response.data);

    emit(CommentsLoadedSuccess(commentsResponseModel: commentResponseModel));
  }

  _loadMoreComments(LoadMoreComments event, Emitter emit) async {

    final response = await client.get('questions/${event.questionId}/comments',queryParameters: {'page' : event.commentsPageNumber ?? 2, 'pagesize' : 15 , 'order' : 'desc' , 'sort' : 'votes' , 'site' : 'stackoverflow','filter' : '!6VvPDzR)tamp0'});

    CommentResponseModel commentResponseModel = CommentResponseModel.fromJson(response.data);

    emit(MoreCommentsLoadedSuccess(commentsResponseModel: commentResponseModel));
  }

}