import 'UserModel.dart';

// class PhoneLoginModel {
//   // Message? message;

//   // PhoneLoginModel({this.message});

//   // PhoneLoginModel.fromJson(Map<String, dynamic> json) {
//   //   message =
//   //       json['message'] != null ? new Message.fromJson(json['message']) : null;
//   // }

//   // Map<String, dynamic> toJson() {
//   //   final Map<String, dynamic> data = new Map<String, dynamic>();
//   //   if (this.message != null) {
//   //     data['message'] = this.message!.toJson();
//   //   }
//   //   return data;
//   // }
// }

class PhoneLoginModel {
  // Token? token;
  // User? user;
  String? id;
  User? user;
  int? ttl;
  String? created;
  String? userId;

  PhoneLoginModel({this.id, this.ttl, this.created, this.userId, this.user});

  PhoneLoginModel.fromJson(Map<String, dynamic> json) {
    // token = json['token'] != null ? new Token.fromJson(json['token']) : null;
    // user = json['user'] != null ? new User.fromJson(json['user']) : null;

    print("json['roleId']: ${json['roleId']}");
    id = json['token']['id'];
    ttl = json['token']['ttl'];
    created = json['token']['created'];
    userId = json['token']['userId'];
    user = json["user"] != null ? User.fromJson(json["user"]) : null;
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

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   if (this.token != null) {
  //     data['token'] = this.token!.toJson();
  //   }
  //   if (this.user != null) {
  //     data['user'] = this.user!.toJson();
  //   }
  //   return data;
  // }
}

// class Token {
//   String? id;
//   int? ttl;
//   String? created;
//   String? userId;

//   Token({this.id, this.ttl, this.created, this.userId});

//   Token.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     ttl = json['ttl'];
//     created = json['created'];
//     userId = json['userId'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['ttl'] = this.ttl;
//     data['created'] = this.created;
//     data['userId'] = this.userId;
//     return data;
//   }
// }
