import 'package:altkamul_task/models/owner.dart';
import 'package:hive/hive.dart';

part 'question.g.dart';

@HiveType(typeId: 1)

class QuestionModel extends HiveObject{
  @HiveField(0)
  List<String>? tags;
  @HiveField(1)
  Owner? owner;
  @HiveField(2)
  bool? isAnswered;
  @HiveField(3)
  int? viewCount;
  @HiveField(4)
  int? protectedDate;
  @HiveField(5)
  int? acceptedAnswerId;
  @HiveField(6)
  int? answerCount;
  @HiveField(7)
  int? communityOwnedDate;
  @HiveField(8)
  int? score;
  @HiveField(9)
  int? lastActivityDate;
  @HiveField(10)
  int? creationDate;
  @HiveField(11)
  int? lastEditDate;
  @HiveField(12)
  int? questionId;
  @HiveField(13)
  String? contentLicense;
  @HiveField(14)
  String? link;
  @HiveField(15)
  String? title;
  @HiveField(16)

  QuestionModel(
      {this.tags,
        this.owner,
        this.isAnswered,
        this.viewCount,
        this.protectedDate,
        this.acceptedAnswerId,
        this.answerCount,
        this.communityOwnedDate,
        this.score,
        this.lastActivityDate,
        this.creationDate,
        this.lastEditDate,
        this.questionId,
        this.contentLicense,
        this.link,
        this.title});

  QuestionModel.fromJson(Map<String, dynamic> json) {
    tags = json['tags'].cast<String>();
    owner = json['owner'] != null ? Owner.fromJson(json['owner']) : null;
    isAnswered = json['is_answered'];
    viewCount = json['view_count'];
    protectedDate = json['protected_date'];
    acceptedAnswerId = json['accepted_answer_id'];
    answerCount = json['answer_count'];
    communityOwnedDate = json['community_owned_date'];
    score = json['score'];
    lastActivityDate = json['last_activity_date'];
    creationDate = json['creation_date'];
    lastEditDate = json['last_edit_date'];
    questionId = json['question_id'];
    contentLicense = json['content_license'];
    link = json['link'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['tags'] = tags;
    if (owner != null) {
      data['owner'] = owner!.toJson();
    }
    data['is_answered'] = isAnswered;
    data['view_count'] = viewCount;
    data['protected_date'] = protectedDate;
    data['accepted_answer_id'] = acceptedAnswerId;
    data['answer_count'] = answerCount;
    data['community_owned_date'] = communityOwnedDate;
    data['score'] = score;
    data['last_activity_date'] = lastActivityDate;
    data['creation_date'] = creationDate;
    data['last_edit_date'] = lastEditDate;
    data['question_id'] = questionId;
    data['content_license'] = contentLicense;
    data['link'] = link;
    data['title'] = title;
    return data;
  }
}