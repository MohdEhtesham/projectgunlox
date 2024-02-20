import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
// import 'package:flutter_des/flutter_des.dart';

// import "../utils/snackbar.dart";

// import "descriptor_tile.dart";

class CharacteristicTile extends StatefulWidget {
  final BluetoothCharacteristic characteristic;
  final List<DescriptorTile> descriptorTiles;

  const CharacteristicTile(
      {super.key, required this.characteristic, required this.descriptorTiles});

  @override
  State<CharacteristicTile> createState() => _CharacteristicTileState();
}

class _CharacteristicTileState extends State<CharacteristicTile> {
  List<int> _value = [];

  late StreamSubscription<List<int>> _lastValueSubscription;

  @override
  void initState() {
    super.initState();
    _lastValueSubscription =
        widget.characteristic.lastValueStream.listen((value) {
      _value = value;
      print("_lastValueSubscription $_value");
      if (mounted) {
        setState(() {});
      }
    });
    // Listen for notifications
    widget.characteristic.value.listen((List<int> value) {
      print("Received response: $value");
      // Handle the received data as needed
    });
  }

  @override
  void dispose() {
    _lastValueSubscription.cancel();
    super.dispose();
  }

  BluetoothCharacteristic get c => widget.characteristic;

  // Function to format the hex string with 0X prefix and separate with spaces
  String formatHexString(String hexString) {
    int decimalNumber = 12345678;
    // Convert decimal to hexadecimal string
    String hexString = decimalNumber.toRadixString(16).toUpperCase();
    List<String> chunks = hexString.split('');
    for (int i = chunks.length - 2; i > 0; i -= 2) {
      chunks.insert(i, 'X');
    }
    return '0X${chunks.join(' ')}';
  }

  List<int> _getRandomBytes() {
    // final math = Random();
    // List<int> communicationKey = List.generate(8, (_) => math.nextInt(256));
    List<int> communicationKey = [
      0X47,
      0X55,
      0X01,
      0X00,
      0X0A,
      0XC7,
      0X7F,
      0X71,
      0X2D,
      0XF5,
      0XF6,
      0XFB,
      0X78
    ];

    print("Communication Key $communicationKey");
    encryptData(communicationKey);
    return communicationKey;
    // encryptData(random);
    // return random;
  }

  encryptData(random) async {
    String hexString = random
        .map((int value) => value.toRadixString(16).padLeft(2, '0'))
        .join('');

    print('Hex Code: #$hexString');
    // var encrypted = await FlutterDes.decrypt(Uint8List.fromList(random), "Gunlox12");
    // print('encrypted Hex Code: #$encrypted');
  }

  Future onReadPressed() async {
    try {
      await c.read();
      Snackbar.show(ABC.c, "Read: Success", success: true);
    } catch (e) {
      Snackbar.show(ABC.c, prettyException("Read Error:", e), success: false);
    }
  }

  Future onWritePressed() async {
    try {
      await c.write(_getRandomBytes(),
          withoutResponse: c.properties.writeWithoutResponse);
      Snackbar.show(ABC.c, "Write: Success", success: true);
      if (c.properties.read) {
        var temp = await c.read();
        print("temp $temp");
      }
    } catch (e) {
      Snackbar.show(ABC.c, prettyException("Write Error:", e), success: false);
    }
  }

  Future onSubscribePressed() async {
    try {
      String op = c.isNotifying == false ? "Subscribe" : "Unubscribe";
      await c.setNotifyValue(c.isNotifying == false);
      Snackbar.show(ABC.c, "$op : Success", success: true);
      if (c.properties.read) {
        await c.read();
      }
      if (mounted) {
        setState(() {});
      }
    } catch (e) {
      Snackbar.show(ABC.c, prettyException("Subscribe Error:", e),
          success: false);
    }
  }

  Widget buildUuid(BuildContext context) {
    String uuid = '0x${widget.characteristic.uuid.str.toUpperCase()}';
    return Text(uuid, style: const TextStyle(fontSize: 13));
  }

  Widget buildValue(BuildContext context) {
    String data = _value.toString();
    return Text(data, style: const TextStyle(fontSize: 13, color: Colors.grey));
  }

  Widget buildReadButton(BuildContext context) {
    return TextButton(
        child: const Text("Read"),
        onPressed: () async {
          await onReadPressed();
          if (mounted) {
            setState(() {});
          }
        });
  }

  Widget buildWriteButton(BuildContext context) {
    bool withoutResp = widget.characteristic.properties.writeWithoutResponse;
    return TextButton(
        child: Text(withoutResp ? "WriteNoResp" : "Write"),
        onPressed: () async {
          await onWritePressed();
          if (mounted) {
            setState(() {});
          }
        });
  }

  Widget buildSubscribeButton(BuildContext context) {
    bool isNotifying = widget.characteristic.isNotifying;
    return TextButton(
        child: Text(isNotifying ? "Unsubscribe" : "Subscribe"),
        onPressed: () async {
          await onSubscribePressed();
          if (mounted) {
            setState(() {});
          }
        });
  }

  Widget buildButtonRow(BuildContext context) {
    bool read = widget.characteristic.properties.read;
    bool write = widget.characteristic.properties.write;
    bool notify = widget.characteristic.properties.notify;
    bool indicate = widget.characteristic.properties.indicate;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (read) buildReadButton(context),
        if (write) buildWriteButton(context),
        if (notify || indicate) buildSubscribeButton(context),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: ListTile(
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text('Characteristic'),
            buildUuid(context),
            buildValue(context),
          ],
        ),
        subtitle: buildButtonRow(context),
        contentPadding: const EdgeInsets.all(0.0),
      ),
      children: widget.descriptorTiles,
    );
  }
}

class DescriptorTile extends StatefulWidget {
  final BluetoothDescriptor descriptor;

  const DescriptorTile({super.key, required this.descriptor});

  @override
  State<DescriptorTile> createState() => _DescriptorTileState();
}

class _DescriptorTileState extends State<DescriptorTile> {
  List<int> _value = [];

  late StreamSubscription<List<int>> _lastValueSubscription;

  @override
  void initState() {
    super.initState();
    _lastValueSubscription = widget.descriptor.lastValueStream.listen((value) {
      _value = value;
      print("_lastValueSubscription $_lastValueSubscription");
      // FlutterDes.decrypt(Uint8List.fromList(_lastValueSubscription), key);
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _lastValueSubscription.cancel();
    super.dispose();
  }

  BluetoothDescriptor get d => widget.descriptor;

  // List<int> _getRandomBytes() {
  //   final math = Random();
  //   return [
  //     math.nextInt(255),
  //     math.nextInt(255),
  //     math.nextInt(255),
  //     math.nextInt(255)
  //   ];
  // }
  // List<int> _getRandomBytes() {
  //   print("Line 269");
  //   final math = Random();
  //   List<int> communicationKey = List.generate(8, (_) => math.nextInt(256));
  //   print("Communication Key $communicationKey");
  //   // encryptData(communicationKey);
  //   return communicationKey;
  // }

  // encryptData(random) async {
  //   String hexString = random
  //       .map((int value) => value.toRadixString(16).padLeft(2, '0'))
  //       .join('');

  //   print('Hex Code: #$hexString');
  //   var encrypted = await FlutterDes.encrypt(
  //       "0X47 0X55 0X01 0X00 0X0A0X31 0X32 0X33 0X34 0X35 0X36 0X37 0X380XFE 0X50",
  //       "Gunlox12");
  //   print('encrypted Hex: #$encrypted');
  // }

  Future onReadPressed() async {
    try {
      await d.read();
      Snackbar.show(ABC.c, "Descriptor Read : Success", success: true);
    } catch (e) {
      Snackbar.show(ABC.c, prettyException("Descriptor Read Error:", e),
          success: false);
    }
  }

  Future onWritePressed() async {
    // try {
    //   await d.write(_getRandomBytes());
    //   Snackbar.show(ABC.c, "Descriptor Write : Success", success: true);
    // } catch (e) {
    //   Snackbar.show(ABC.c, prettyException("Descriptor Write Error:", e),
    //       success: false);
    // }
  }

  Widget buildUuid(BuildContext context) {
    String uuid = '0x${widget.descriptor.uuid.str.toUpperCase()}';
    return Text(uuid, style: const TextStyle(fontSize: 13));
  }

  Widget buildValue(BuildContext context) {
    String data = _value.toString();
    return Text(data, style: const TextStyle(fontSize: 13, color: Colors.grey));
  }

  Widget buildReadButton(BuildContext context) {
    return TextButton(
      onPressed: onReadPressed,
      child: const Text("Read"),
    );
  }

  Widget buildWriteButton(BuildContext context) {
    return TextButton(
      onPressed: onWritePressed,
      child: const Text("Write"),
    );
  }

  Widget buildButtonRow(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        buildReadButton(context),
        buildWriteButton(context),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text('Descriptor'),
          buildUuid(context),
          buildValue(context),
        ],
      ),
      subtitle: buildButtonRow(context),
    );
  }
}

enum ABC {
  a,
  b,
  c,
}

class Snackbar {
  static final snackBarKeyA = GlobalKey<ScaffoldMessengerState>();
  static final snackBarKeyB = GlobalKey<ScaffoldMessengerState>();
  static final snackBarKeyC = GlobalKey<ScaffoldMessengerState>();

  static GlobalKey<ScaffoldMessengerState> getSnackbar(ABC abc) {
    switch (abc) {
      case ABC.a:
        return snackBarKeyA;
      case ABC.b:
        return snackBarKeyB;
      case ABC.c:
        return snackBarKeyC;
    }
  }

  static show(ABC abc, String msg, {required bool success}) {
    final snackBar = success
        ? SnackBar(content: Text(msg), backgroundColor: Colors.blue)
        : SnackBar(content: Text(msg), backgroundColor: Colors.red);
    getSnackbar(abc).currentState?.removeCurrentSnackBar();
    getSnackbar(abc).currentState?.showSnackBar(snackBar);
  }
}

String prettyException(String prefix, dynamic e) {
  if (e is FlutterBluePlusException) {
    return "$prefix ${e.description}";
  } else if (e is PlatformException) {
    return "$prefix ${e.message}";
  }
  return prefix + e.toString();
}
