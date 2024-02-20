class User {
  String? roleId;
  String? firstName;
  String? lastName;
  String? fullName;
  bool? isDeleted;
  bool? active;
  String? phone;
  String? email;
  bool? phoneNumberVerified;
  String? deviceToken;
  String? id;
  String? createdAt;
  String? updatedAt;

  User(
      {this.roleId,
      this.firstName,
      this.lastName,
      this.fullName,
      this.isDeleted,
      this.active,
      this.phone,
      this.email,
      this.phoneNumberVerified,
      this.deviceToken,
      this.id,
      this.createdAt,
      this.updatedAt});

  User.fromJson(Map<String, dynamic> json) {
    roleId = json['roleId'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    fullName = json['fullName'];
    isDeleted = json['is_deleted'];
    active = json['active'];
    phone = json['phone'];
    email = json['email'];
    phoneNumberVerified = json['phoneNumberVerified'];
    deviceToken = json['deviceToken'];
    id = json['id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['roleId'] = roleId;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['fullName'] = fullName;
    data['is_deleted'] = isDeleted;
    data['active'] = active;
    data['phone'] = phone;
    data['email'] = email;
    data['phoneNumberVerified'] = phoneNumberVerified;
    data['deviceToken'] = deviceToken;
    data['id'] = id;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
