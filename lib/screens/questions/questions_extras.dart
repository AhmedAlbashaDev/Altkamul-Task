
import '../../models/response.dart';

class QuestionsEvent {}

class LoadQuestions extends QuestionsEvent {}

class LoadMoreQuestions extends QuestionsEvent {}

class LoadAnswers extends QuestionsEvent {
  dynamic questionId;
  LoadAnswers({this.questionId});
}

class LoadMoreAnswers extends QuestionsEvent {
  dynamic questionId;
  dynamic answersPageNumber;
  LoadMoreAnswers({this.questionId,this.answersPageNumber});
}

class LoadComments extends QuestionsEvent {
  dynamic questionId;
  LoadComments({this.questionId});
}

class LoadMoreComments extends QuestionsEvent {
  dynamic questionId;
  dynamic commentsPageNumber;
  LoadMoreComments({this.questionId , this.commentsPageNumber});
}

class QuestionsState {}

class Idle extends QuestionsState {}

class Loading extends QuestionsState {}

class QuestionsLoadedSuccess extends QuestionsState {
  ResponseModel? responseModel;
  QuestionsLoadedSuccess({this.responseModel});
}

class MoreQuestionsLoadedSuccess extends QuestionsState {
  ResponseModel? responseModel;
  MoreQuestionsLoadedSuccess({this.responseModel});
}

class QuestionsLoadedFailed extends QuestionsState {
  String? message;
  QuestionsLoadedFailed({this.message});
}

class AnswersLoadedSuccess extends QuestionsState {
  AnswerResponseModel? answersResponseModel;
  AnswersLoadedSuccess({this.answersResponseModel});
}

class MoreAnswersLoadedSuccess extends QuestionsState {
  AnswerResponseModel? answersResponseModel;
  MoreAnswersLoadedSuccess({this.answersResponseModel});
}

class AnswersLoadedFailed extends QuestionsState {
  String? message;
  AnswersLoadedFailed({this.message});
}

class CommentsLoadedSuccess extends QuestionsState {
  CommentResponseModel? commentsResponseModel;
  CommentsLoadedSuccess({this.commentsResponseModel});
}

class MoreCommentsLoadedSuccess extends QuestionsState {
  CommentResponseModel? commentsResponseModel;
  MoreCommentsLoadedSuccess({this.commentsResponseModel});
}

class CommentsLoadedFailed extends QuestionsState {
  String? message;
  CommentsLoadedFailed({this.message});
}

