import '../../models/UserModel.dart';

class Login {
  String? id;
  int? ttl;
  String? created;
  String? userId;
  User? user;

  Login({this.id, this.ttl, this.created, this.userId, this.user});

  Login.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    ttl = json['ttl'];
    created = json['created'];
    userId = json['userId'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
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
    return data;
  }
}
