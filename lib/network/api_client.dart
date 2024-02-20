import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart' as http;

class ApiClient {
  Future<Map<String, dynamic>?> commonPostAPIMethod(url, headers, body) async {
    Map<String, dynamic>? responseBody;
    try {
      http.Response response;
      if (headers != null) {
        response =
            await http.post(Uri.parse(url), headers: headers, body: body);
      } else {
        response = await http.post(Uri.parse(url), body: body);
      }
      print("POST API ${response.statusCode}");
      if (response.statusCode == 200) {
        responseBody = jsonDecode(response.body);
        // ("Request Success");
      } else if (response.statusCode == 204) {
        // if(response!)
        responseBody = {"statusCode": 204};
      } else if (response.statusCode == 401) {
        // Get.offAll(() => LoginScreen());
        responseBody = jsonDecode(response.body);
        // ("Your session has expired. please log in");
        // responseBody = jsonDecode(response.body);
        ("${responseBody!["error"]["message"]}");
      } else if (response.statusCode == 400) {
        responseBody = jsonDecode(response.body);
        // ("${responseBody!["error"]["message"]}");
      } else if (response.statusCode == 404) {
        responseBody = jsonDecode(response.body);
        // ("${responseBody!["error"]["message"]}");
      } else if (response.statusCode == 409) {
        responseBody = jsonDecode(response.body);
        // ("${responseBody!["error"]["message"]}");
      } else if (response.statusCode == 422) {
        responseBody = jsonDecode(response.body);
        // ("${responseBody!["error"]["message"]}");
      }
    } on SocketException {
      ("Please check your internet connection and try again.");
    } catch (e) {
      log(e.toString());
      (" $e Error Occured");
    } finally {
      // Get.rawSnackbar(
      //     message: " Error Occured",
      //     snackPosition: SnackPosition.BOTTOM,
      //     margin: EdgeInsets.zero,
      //     snackStyle: SnackStyle.GROUNDED,
      //     backgroundColor: Colors.red);
    }
    return responseBody;
  }

  Future<Map<String, dynamic>?> commonGetAPIMethod(url, headers) async {
    Map<String, dynamic>? responseBody;
    try {
      final http.Response response;
      if (headers != null) {
        response = await http.get(Uri.parse(url), headers: headers);
      } else {
        response = await http.get(Uri.parse(url));
      }
      print(response.statusCode);
      if (response.statusCode == 200) {
        responseBody = jsonDecode(response.body);
      } else if (response.statusCode == 401) {
        responseBody = jsonDecode(response.body);
        ("Your session has expired. please log in");
        // responseBody = jsonDecode(response.body);
        // ("Something went wrong");
      } else if (response.statusCode == 400) {
        responseBody = jsonDecode(response.body);
        (" ${response.statusCode} Error Occurred");
      }
    } on SocketException {
      ("Please check your internet connection and try again.");
    } catch (e) {
      log(e.toString());
      (" $e Error Occured");
    } finally {
      // Get.rawSnackbar(
      //     message: " Error Occured",
      //     snackPosition: SnackPosition.BOTTOM,
      //     margin: EdgeInsets.zero,
      //     snackStyle: SnackStyle.GROUNDED,
      //     backgroundColor: Colors.red);
    }
    return responseBody;
  }

  Future<Map<String, dynamic>?> commonGetAPIMethodWithQuery(
      url, headers, queryParameters) async {
    Map<String, dynamic>? responseBody;
    try {
      final uri = Uri.http('159.89.234.66:8912', '/firearms', queryParameters);
      print("uri:commonGetAPIMethodWithQuery $uri ");
      final http.Response response;
      if (headers != null) {
        response = await http.get(uri, headers: headers);
      } else {
        response = await http.get(uri);
      }
      print(response.statusCode);
      if (response.statusCode == 200) {
        responseBody = jsonDecode(response.body);
      } else if (response.statusCode == 401) {
        responseBody = jsonDecode(response.body);
        ("Your session has expired. please log in");
        // responseBody = jsonDecode(response.body);
        // ("Something went wrong");
      } else if (response.statusCode == 400) {
        responseBody = jsonDecode(response.body);
        (" ${response.statusCode} Error Occurred");
      }
    } on SocketException {
      ("Please check your internet connection and try again.");
    } catch (e) {
      log(e.toString());
      (" $e Error Occured");
    } finally {
      // Get.rawSnackbar(
      //     message: " Error Occured",
      //     snackPosition: SnackPosition.BOTTOM,
      //     margin: EdgeInsets.zero,
      //     snackStyle: SnackStyle.GROUNDED,
      //     backgroundColor: Colors.red);
    }
    return responseBody;
  }

  Future<List<dynamic>> commonGetListAPIMethod(url, headers) async {
    List<dynamic>? responseBody;
    try {
      final http.Response response;
      if (headers != null) {
        response = await http.get(Uri.parse(url), headers: headers);
      } else {
        response = await http.get(Uri.parse(url));
      }
      if (response.statusCode == 200) {
        responseBody = jsonDecode(response.body);
        // print("Get API resp $responseBody");
      } else if (response.statusCode == 401) {
        responseBody = jsonDecode(response.body);
        ("Your session has expired. please log in");
      } else if (response.statusCode == 400) {
        responseBody = jsonDecode(response.body);
        (" ${response.statusCode} Error Occurred");
      }
    } on SocketException {
      ("Please check your internet connection and try again.");
    } catch (e) {
      log(e.toString());
      (" $e Error Occured");
    } finally {
      // Get.rawSnackbar(
      //     message: " Error Occured",
      //     snackPosition: SnackPosition.BOTTOM,
      //     margin: EdgeInsets.zero,
      //     snackStyle: SnackStyle.GROUNDED,
      //     backgroundColor: Colors.red);
    }
    return responseBody!;
  }

  Future<Map<String, dynamic>?> commonHeaderPostAPIMethod(url, body) async {
    Map<String, dynamic>? responseBody;
    try {
      http.Response response;
      if (body != null) {
        response = await http.post(Uri.parse(url),
            headers: {
              // 'Authorization': common.getToken,
              'Content-Type': 'application/json',
            },
            body: body);
      } else {
        response = await http.post(Uri.parse(url), headers: {
          // 'Authorization': common.getToken,
          'Content-Type': 'application/json',
        });
      }

      if (response.statusCode == 200) {
        responseBody = jsonDecode(response.body);
        // ("Request Success");
      } else if (response.statusCode == 204) {
        print("status code 204");
        responseBody = {
          "statusCode": response.statusCode,
        };
      } else if (response.statusCode == 401) {
        responseBody = jsonDecode(response.body);
        ("Your session has expired. please log in");
      } else if (response.statusCode == 400) {
        responseBody = jsonDecode(response.body);
        ("${responseBody!["error"]["message"]}");
      } else if (response.statusCode == 422) {
        responseBody = jsonDecode(response.body);
        ("${responseBody!["error"]["message"]}");
      } else {
        responseBody = jsonDecode(response.body);
      }
    } on SocketException {
      ("Please check your internet connection and try again.");
    } catch (e) {
      log(e.toString());
      (" $e Error Occured");
    } finally {
      // Get.rawSnackbar(
      //     message: " Error Occured",
      //     snackPosition: SnackPosition.BOTTOM,
      //     margin: EdgeInsets.zero,
      //     snackStyle: SnackStyle.GROUNDED,
      //     backgroundColor: Colors.red);
    }
    return responseBody;
  }

  Future<Map<String, dynamic>?> commonPatchAPIMethod(url, headers, body) async {
    Map<String, dynamic>? responseBody;
    try {
      http.Response response;
      if (headers != null) {
        response =
            await http.patch(Uri.parse(url), headers: headers, body: body);
      } else {
        response = await http.patch(Uri.parse(url), body: body);
      }
      print(response.statusCode);
      if (response.statusCode == 200) {
        responseBody = jsonDecode(response.body);
        // ("Request Success");
      } else if (response.statusCode == 401) {
        responseBody = jsonDecode(response.body);
        ("Your session has expired. please log in");
      } else if (response.statusCode == 400) {
        responseBody = jsonDecode(response.body);
        // ("${responseBody!["error"]["message"]}");
      } else if (response.statusCode == 404) {
        responseBody = jsonDecode(response.body);
        // ("${responseBody!["error"]["message"]}");
      } else if (response.statusCode == 422) {
        responseBody = jsonDecode(response.body);
        // ("${responseBody!["error"]["message"]}");
      }
    } on SocketException {
      ("Please check your internet connection and try again.");
    } catch (e) {
      log(e.toString());
      (" $e Error Occured");
    } finally {
      // Get.rawSnackbar(
      //     message: " Error Occured",
      //     snackPosition: SnackPosition.BOTTOM,
      //     margin: EdgeInsets.zero,
      //     snackStyle: SnackStyle.GROUNDED,
      //     backgroundColor: Colors.red);
    }
    return responseBody;
  }

  Future<Map<String, dynamic>?> commonDeleteAPIMethod(url, body) async {
    Map<String, dynamic>? responseBody;
    try {
      http.Response response;
      if (body != null) {
        response = await http.delete(Uri.parse(url),
            headers: {
              // 'Authorization': common.getToken,
              'Content-Type': 'application/json',
            },
            body: body);
      } else {
        response = await http.delete(Uri.parse(url), headers: {
          // 'Authorization': common.getToken,
          'Content-Type': 'application/json',
        });
      }

      if (response.statusCode == 200) {
        responseBody = jsonDecode(response.body);
        // ("Request Success");
      } else if (response.statusCode == 204) {
        print("status code 204");
        responseBody = {
          "statusCode": response.statusCode,
        };
      } else if (response.statusCode == 401) {
        responseBody = jsonDecode(response.body);
        ("Your session has expired. please log in");
      } else if (response.statusCode == 400) {
        responseBody = jsonDecode(response.body);
        ("${responseBody!["error"]["message"]}");
      } else if (response.statusCode == 422) {
        responseBody = jsonDecode(response.body);
        ("${responseBody!["error"]["message"]}");
      } else {
        responseBody = jsonDecode(response.body);
      }
    } on SocketException {
      ("Please check your internet connection and try again.");
    } catch (e) {
      log(e.toString());
      (" $e Error Occured");
    } finally {
      // Get.rawSnackbar(
      //     message: " Error Occured",
      //     snackPosition: SnackPosition.BOTTOM,
      //     margin: EdgeInsets.zero,
      //     snackStyle: SnackStyle.GROUNDED,
      //     backgroundColor: Colors.red);
    }
    return responseBody;
  }
}
