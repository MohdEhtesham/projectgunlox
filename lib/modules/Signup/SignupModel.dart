import '../../models/UserModel.dart';

class Signup {
  // Token? token;
  // String? firstName;
  // String? lastName;
  // String? fullName;
  // String? email;
  // String? password;
  // String? phone;
  // String? createdAt;
  // String? deviceToken;
  // bool? phoneNumberVerified;
  // bool? active;
  // bool? isDeleted;
  // // String? updatedAt;
  // String? roleId;

  // Added after
  // String? token;
  String? id;
  User? user;
  int? ttl;
  String? created;
  String? userId;

  // Signup(
  //     {this.token,
  //     this.firstName,
  //     this.lastName,
  //     this.fullName,
  //     this.email,
  //     this.password,
  //     this.phone,
  //     this.createdAt,
  //     this.deviceToken,
  //     this.phoneNumberVerified,
  //     this.active,
  //     this.isDeleted,
  //     this.updatedAt,
  // this.id,
  //     this.roleId});
  Signup({this.id, this.ttl, this.created, this.userId, this.user});

  Signup.fromJson(Map<String, dynamic> json) {
    // token = json['token'] != null ? new Token.fromJson(json['token']) : null;
    // firstName = json['firstName'];
    // lastName = json['lastName'];
    // fullName = json['fullName'];
    // email = json['email'];
    // password = json['password'];
    // phone = json['phone'];
    // createdAt = json['createdAt'];
    // deviceToken = json['deviceToken'];
    // phoneNumberVerified = json['phoneNumberVerified'];
    // active = json['active'];
    // isDeleted = json['is_deleted'];
    // updatedAt = json['updatedAt'];
    // id = json['id'];
    // roleId = json['roleId'];
    print("json['roleId']: ${json['roleId']}");
    id = json['token']['id'];
    ttl = json['token']['ttl'];
    created = json['token']['created'];
    userId = json['token']['userId'];
    Map<String, dynamic> userJson = {
      "roleId": json['roleId'],
      "firstName": json['firstName'],
      "lastName": json['lastName'],
      "fullName": json['fullName'],
      "is_deleted": json['is_deleted'],
      "active": json['active'],
      "phone": json['phone'],
      "email": json['email'],
      "phoneNumberVerified": json['phoneNumberVerified'],
      "deviceToken": json['deviceToken'],
      "id": json['id'],
      "createdAt": json['createdAt'],
      "updatedAt": json['updatedAt'],
    };
    print("user json $userJson");
    user = userJson.isNotEmpty ? User.fromJson(userJson) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['ttl'] = ttl;
    data['created'] = created;
    data['userId'] = userId;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    // data['roleId'] = this.roleId;
    return data;
  }
}
