import 'package:altkamul_task/models/answer.dart';
import 'package:altkamul_task/models/comment.dart';
import 'package:altkamul_task/models/question.dart';

class ResponseModel {
  List<QuestionModel>? questions;
  bool? hasMore;
  int? quotaMax;
  int? quotaRemaining;

  ResponseModel({this.questions, this.hasMore, this.quotaMax, this.quotaRemaining});

  ResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      questions = <QuestionModel>[];
      json['items'].forEach((v) {
        questions!.add(QuestionModel.fromJson(v));
      });
    }
    hasMore = json['has_more'];
    quotaMax = json['quota_max'];
    quotaRemaining = json['quota_remaining'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (questions != null) {
      data['items'] = questions!.map((v) => v.toJson()).toList();
    }
    data['has_more'] = hasMore;
    data['quota_max'] = quotaMax;
    data['quota_remaining'] = quotaRemaining;
    return data;
  }
}

class AnswerResponseModel {
  List<AnswerModel>? answers;
  bool? hasMore;
  int? quotaMax;
  int? quotaRemaining;

  AnswerResponseModel({this.answers, this.hasMore, this.quotaMax, this.quotaRemaining});

  AnswerResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      answers = <AnswerModel>[];
      json['items'].forEach((v) {
        answers!.add(AnswerModel.fromJson(v));
      });
    }
    hasMore = json['has_more'];
    quotaMax = json['quota_max'];
    quotaRemaining = json['quota_remaining'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (answers != null) {
      data['items'] = answers!.map((v) => v.toJson()).toList();
    }
    data['has_more'] = hasMore;
    data['quota_max'] = quotaMax;
    data['quota_remaining'] = quotaRemaining;
    return data;
  }
}

class CommentResponseModel {
  List<CommentModel>? comments;
  bool? hasMore;
  int? quotaMax;
  int? quotaRemaining;

  CommentResponseModel({this.comments, this.hasMore, this.quotaMax, this.quotaRemaining});

  CommentResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      comments = <CommentModel>[];
      json['items'].forEach((v) {
        comments!.add(CommentModel.fromJson(v));
      });
    }
    hasMore = json['has_more'];
    quotaMax = json['quota_max'];
    quotaRemaining = json['quota_remaining'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (comments != null) {
      data['items'] = comments!.map((v) => v.toJson()).toList();
    }
    data['has_more'] = hasMore;
    data['quota_max'] = quotaMax;
    data['quota_remaining'] = quotaRemaining;
    return data;
  }
}

