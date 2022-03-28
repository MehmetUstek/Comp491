import 'dart:convert';
import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:http/http.dart' as http;
import 'Product.dart';
import 'User.dart';

enum CollectionType { UserCollection }

var db = Db(
    dotenv.get('MONGODB_URI_LOCAL', fallback: 'API_URL not found'));
//User
Future<DbCollection> getUsersCollection() async {
  db = await Db.create(
  dotenv.get('MONGODB_URI_LOCAL', fallback: 'API_URL not found'));
  await db.open();
  final collection = db.collection('Users');
  // db.close();
  return collection;
}

Future<UserData> fetchUser(String uid) async {
  final queryParams = {
    'userUID': uid
  };
  final response = await http
      .post(Uri.parse('http://10.0.2.2:9090/user/getUsernameByUID').replace(queryParameters: queryParams), headers: {
    HttpHeaders.contentTypeHeader: 'application/json',
  }, body: jsonEncode(queryParams));
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    UserData userData =UserData.fromJson(jsonDecode(response.body));
    return userData;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load user');
  }
}
Future<String?> getUsername(String uid) async {
  final queryParams = {
    'userUID': uid
  };
  final response = await http
      .post(Uri.parse('http://10.0.2.2:9090/user/getUsernameByUID').replace(queryParameters: queryParams), headers: {
    HttpHeaders.contentTypeHeader: 'application/json',
  }, body: jsonEncode(queryParams));
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    String? username = response.body;
    return username;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load user');
  }
}

Future<String?> getUserEmail(String uid) async {
  final queryParams = {
    'userUID': uid
  };
  final response = await http
      .post(Uri.parse('http://10.0.2.2:9090/user/getUserEmailByUID').replace(queryParameters: queryParams), headers: {
    HttpHeaders.contentTypeHeader: 'application/json',
  }, body: jsonEncode(queryParams));
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    String? userEmail = response.body;
    return userEmail;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load user');
  }
}

Future<String?> getAllProducts() async {
  final response = await http
      .get(Uri.parse('http://10.0.2.2:9090/user/getAllProducts'), headers: {
    HttpHeaders.contentTypeHeader: 'application/json',
  });
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    String? userEmail = response.body;
    return userEmail;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load user');
  }
}
Future<Product?> getProductByPid(String Pid) async {
  final queryParams = {
    'Pid': Pid
  };
  final response = await http
      .post(Uri.parse('http://10.0.2.2:9090/product/getProductByPid'), headers: {
    HttpHeaders.contentTypeHeader: 'application/json',
    "Connection": "keep-alive",
    "keep-alive": "timeout=5, max=1000"

  }, body: jsonEncode(queryParams));
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    Product product =Product.fromJson(jsonDecode(response.body));
    return product;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load product');
  }
}
Future<String?> getProductNameByPid(String Pid) async {
  final queryParams = {
    'Pid': Pid
  };
  final response = await http
      .post(Uri.parse('http://10.0.2.2:9090/product/getProductNameByPid'), headers: {
    HttpHeaders.contentTypeHeader: 'application/json',
    "Connection": "keep-alive",
    "keep-alive": "timeout=5, max=1000"

  }, body: jsonEncode(queryParams));
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    String productName = response.body;
    return productName;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load product');
  }
}