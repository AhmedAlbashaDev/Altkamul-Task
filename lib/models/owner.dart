import 'package:hive/hive.dart';

part 'owner.g.dart';

@HiveType(typeId: 2)
class Owner extends HiveObject{
  @HiveField(0)
  int? accountId;
  @HiveField(1)
  int? reputation;
  @HiveField(2)
  int? userId;
  @HiveField(3)
  String? userType;
  @HiveField(4)
  int? acceptRate;
  @HiveField(5)
  String? profileImage;
  @HiveField(6)
  String? displayName;
  @HiveField(7)
  String? link;

  Owner(
      {this.accountId,
        this.reputation,
        this.userId,
        this.userType,
        this.acceptRate,
        this.profileImage,
        this.displayName,
        this.link});

  Owner.fromJson(Map<String, dynamic> json) {
    accountId = json['account_id'];
    reputation = json['reputation'];
    userId = json['user_id'];
    userType = json['user_type'];
    acceptRate = json['accept_rate'];
    profileImage = json['profile_image'];
    displayName = json['display_name'];
    link = json['link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['account_id'] = accountId;
    data['reputation'] = reputation;
    data['user_id'] = userId;
    data['user_type'] = userType;
    data['accept_rate'] = acceptRate;
    data['profile_image'] = profileImage;
    data['display_name'] = displayName;
    data['link'] = link;
    return data;
  }
}