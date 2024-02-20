class GetAuthorizedModel {
  String? firearmsId;
  String? userId;
  String? id;
  String? createdAt;
  String? updatedAt;
  String? firstName;
  String? lastName;
  String? email;
  String? phone;

  GetAuthorizedModel(
      {this.firearmsId,
      this.userId,
      this.id,
      this.createdAt,
      this.updatedAt,
      this.firstName,
      this.lastName,
      this.email,
      this.phone});

  GetAuthorizedModel.fromJson(Map<String, dynamic> json) {
    firearmsId = json['firearmsId'];
    userId = json['userId'];
    id = json['id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['firearmsId'] = firearmsId;
    data['userId'] = userId;
    data['id'] = id;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['email'] = email;
    data['phone'] = phone;
    return data;
  }
}