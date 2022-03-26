import 'dart:convert';
import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:http/http.dart' as http;
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
    'userUID': 'dETjut6S7UhvU3fCXGCidh6LF8B3'
  };
  final response = await http
      .post(Uri.parse('http://10.0.2.2:9090/user/getUsernameByUID').replace(queryParameters: queryParams), headers: {
    HttpHeaders.contentTypeHeader: 'application/json',
  }, body: jsonEncode(queryParams));
  // final uri =
  // Uri.http('10.0.2.2:9090', '/user/getUsernameByUID', queryParams);
  // final response = await http.get(uri, headers: {
  //   HttpHeaders.contentTypeHeader: 'application/json',
  // });
  // final uri = Uri.http('10.0.2.2:9090', '/user/getUsernameByUID', queryParams);
  // final headers = {HttpHeaders.contentTypeHeader: 'application/json'};
  // final response = await http.get(uri, headers: headers);
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
Future<String> getUsername(String uid) async {
  final queryParams = {
    'userUID': 'dETjut6S7UhvU3fCXGCidh6LF8B3'
  };
  final response = await http
      .post(Uri.parse('http://10.0.2.2:9090/user/getUsernameByUID').replace(queryParameters: queryParams), headers: {
    HttpHeaders.contentTypeHeader: 'application/json',
  }, body: jsonEncode(queryParams));
  // final uri =
  // Uri.http('10.0.2.2:9090', '/user/getUsernameByUID', queryParams);
  // final response = await http.get(uri, headers: {
  //   HttpHeaders.contentTypeHeader: 'application/json',
  // });
  // final uri = Uri.http('10.0.2.2:9090', '/user/getUsernameByUID', queryParams);
  // final headers = {HttpHeaders.contentTypeHeader: 'application/json'};
  // final response = await http.get(uri, headers: headers);
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    String username = jsonDecode(response.body);
    return username;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load user');
  }
}

// Future<DbCollection> getCorrespondingCollection(
//     CollectionType collectionType) async {
//   late Future<DbCollection> collection;
//   if (collectionType == CollectionType.UserCollection) {
//     collection = getUsersCollection();
//   }
//   return collection;
// }
//
// find(SelectorBuilder? str,
//     {CollectionType collectionType = CollectionType.UserCollection}) async {
//   late Future<DbCollection> collection;
//   collection = getCorrespondingCollection(collectionType);
//   var list = collection.then((value) => value.find(str).toList());
//   db.close();
//   return list;
// }
//
// findOne(SelectorBuilder str,
//     {CollectionType collectionType = CollectionType.UserCollection}) async {
//   late Future<DbCollection> collection;
//   collection = getCorrespondingCollection(collectionType);
//   var elm = collection.then((value) => value.findOne(str));
//   db.close();
//   return elm;
// }
//
// update(SelectorBuilder str, ModifierBuilder updateValue,
//     {CollectionType collectionType = CollectionType.UserCollection}) async {
//   late Future<DbCollection> collection;
//   collection = getCorrespondingCollection(collectionType);
//   var elm = collection.then((value) => value.update(str, updateValue));
//   db.close();
//   return elm;
// }
//
// remove(SelectorBuilder str, String updateValue,
//     {CollectionType collectionType = CollectionType.UserCollection}) async {
//   late Future<DbCollection> collection;
//   collection = getCorrespondingCollection(collectionType);
//   var elm = collection.then((value) => value.remove(str));
//   db.close();
//   return elm;
// }
//
// insertOne(Map<String, dynamic> insertValue,
//     {CollectionType collectionType = CollectionType.UserCollection}) async {
//   late Future<DbCollection> collection;
//   collection = getCorrespondingCollection(collectionType);
//   var elm = collection.then((value) => value.insertOne(insertValue));
//   db.close();
//   return elm;
// }
