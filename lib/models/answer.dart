import 'package:altkamul_task/models/owner.dart';

class AnswerModel {
  Owner? owner;
  bool? isAccepted;
  int? communityOwnedDate;
  int? score;
  int? lastActivityDate;
  int? lastEditDate;
  int? creationDate;
  int? answerId;
  int? questionId;
  String? contentLicense;
  String? body;
  String? link;

  AnswerModel(
      {this.owner,
        this.isAccepted,
        this.communityOwnedDate,
        this.score,
        this.lastActivityDate,
        this.lastEditDate,
        this.creationDate,
        this.answerId,
        this.questionId,
        this.contentLicense,
        this.body,
        this.link,
      });

  AnswerModel.fromJson(Map<String, dynamic> json) {
    owner = json['owner'] != null ? Owner.fromJson(json['owner']) : null;
    isAccepted = json['is_accepted'];
    communityOwnedDate = json['community_owned_date'];
    score = json['score'];
    lastActivityDate = json['last_activity_date'];
    lastEditDate = json['last_edit_date'];
    creationDate = json['creation_date'];
    answerId = json['answer_id'];
    questionId = json['question_id'];
    contentLicense = json['content_license'];
    body = json['body'];
    link = json['link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (owner != null) {
      data['owner'] = owner!.toJson();
    }
    data['is_accepted'] = isAccepted;
    data['community_owned_date'] = communityOwnedDate;
    data['score'] = score;
    data['last_activity_date'] = lastActivityDate;
    data['last_edit_date'] = lastEditDate;
    data['creation_date'] = creationDate;
    data['answer_id'] = answerId;
    data['question_id'] = questionId;
    data['content_license'] = contentLicense;
    data['body'] = body;
    data['link'] = link;
    return data;
  }
}
