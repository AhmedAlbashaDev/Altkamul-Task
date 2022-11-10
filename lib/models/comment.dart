
import 'package:altkamul_task/models/owner.dart';

class CommentModel {
  Owner? owner;
  bool? edited;
  int? score;
  int? creationDate;
  int? postId;
  int? commentId;
  String? contentLicense;
  String? body;
  String? link;

  CommentModel(
      {this.owner,
        this.edited,
        this.score,
        this.creationDate,
        this.postId,
        this.commentId,
        this.contentLicense,
        this.body,
        this.link,
      });

  CommentModel.fromJson(Map<String, dynamic> json) {
    owner = json['owner'] != null ? Owner.fromJson(json['owner']) : null;
    edited = json['edited'];
    score = json['score'];
    creationDate = json['creation_date'];
    postId = json['post_id'];
    commentId = json['comment_id'];
    contentLicense = json['content_license'];
    body = json['body'];
    link = json['link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (owner != null) {
      data['owner'] = owner!.toJson();
    }
    data['edited'] = edited;
    data['score'] = score;
    data['creation_date'] = creationDate;
    data['post_id'] = postId;
    data['comment_id'] = commentId;
    data['content_license'] = contentLicense;
    data['body'] = body;
    data['link'] = link;
    return data;
  }
}