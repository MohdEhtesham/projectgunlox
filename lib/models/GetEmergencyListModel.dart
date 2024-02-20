class GetEmergencyListModel {
  String? name;
  String? brand;
  String? model;
  String? serialNumber;
  String? caliber;
  bool? emergency;
  String? description;
  bool? storage;
  bool? concealed;
  int? active;
  bool? isDeleted;
  String? userId;
  String? id;
  String? createdAt;
  String? updatedAt;

  GetEmergencyListModel(
      {this.name,
      this.brand,
      this.model,
      this.serialNumber,
      this.caliber,
      this.emergency,
      this.description,
      this.storage,
      this.concealed,
      this.active,
      this.isDeleted,
      this.userId,
      this.id,
      this.createdAt,
      this.updatedAt});

  GetEmergencyListModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    brand = json['brand'];
    model = json['model'];
    serialNumber = json['serialNumber'];
    caliber = json['caliber'];
    emergency = json['emergency'];
    description = json['description'];
    storage = json['storage'];
    concealed = json['concealed'];
    active = json['active'];
    isDeleted = json['is_deleted'];
    userId = json['userId'];
    id = json['id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['brand'] = brand;
    data['model'] = model;
    data['serialNumber'] = serialNumber;
    data['caliber'] = caliber;
    data['emergency'] = emergency;
    data['description'] = description;
    data['storage'] = storage;
    data['concealed'] = concealed;
    data['active'] = active;
    data['is_deleted'] = isDeleted;
    data['userId'] = userId;
    data['id'] = id;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}