// ignore_for_file: unnecessary_this
class FirearmConnectivityModel {
  // String? name;
  // String? firearmId;
  String? lastUpdatedState;
  // bool? isConnected;

  FirearmConnectivityModel({
    // this.name,
    // this.firearmId,
    // this.isConnected,
    this.lastUpdatedState,
    // this.serialNumber,
  });

  FirearmConnectivityModel.fromJson(Map<String, dynamic> json) {
    // name = json['name'];
    // firearmId = json['firearmId'];
    // isConnected = json['isConnected'];
    lastUpdatedState = json['lastUpdatedState'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    // data['name'] = this.name;
    // data['firearmId'] = this.firearmId;
    // data['isConnected'] = this.isConnected;
    data['lastUpdatedState'] = this.lastUpdatedState;
    return data;
  }
}
