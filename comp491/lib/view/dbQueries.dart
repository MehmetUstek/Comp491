import 'dart:convert';
import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:http/http.dart' as http;
import 'Product.dart';
import 'User.dart';

enum CollectionType { UserCollection }

// var localIP = "172.20.147.63";
// Emulator:
var localIP = "10.0.2.2";
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
Future<String> createUser(UserData user) async {
  final queryParams = {
    'userUID': user.userUID,
    'username': user.userName,
    'userEmail': user.userEmail
  };
  final response = await http
      .post(Uri.parse('http://$localIP:9090/user/create_user'),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
      }, body: jsonEncode(queryParams));
  if (response.statusCode == 200) {
    return "OK";
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load user bag');
  }

}

Future<UserData> fetchUser(String? uid) async {
  final queryParams = {
    'userUID': uid
  };
  final response = await http
      .post(Uri.parse('http://$localIP:9090/user/getUserByUID'), headers: {
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
      .post(Uri.parse('http://$localIP:9090/user/getUsernameByUID').replace(queryParameters: queryParams), headers: {
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

Future<String?> changeUsername(String uid, String username) async {
  final queryParams = {
    'userUID': uid,
    'username': username
  };
  final response = await http
      .patch(Uri.parse('http://$localIP:9090/user/changeUsernameByUID').replace(queryParameters: queryParams), headers: {
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
      .post(Uri.parse('http://$localIP:9090/user/getUserEmailByUID').replace(queryParameters: queryParams), headers: {
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

Future<List<Product>> getAllProducts() async {
  print('http://$localIP:9090/product/getAllProducts');

  final response = await http
      .post(Uri.parse('http://$localIP:9090/product/getAllProducts'), headers: {
    HttpHeaders.contentTypeHeader: 'application/json',
  HttpHeaders.connectionHeader: 'keep-alive',
  'keep-alive': "timeout=100, max=10000",
    HttpHeaders.acceptCharsetHeader: 'utf-8'
  });
  if (response.statusCode == 200) {
    try{
      Iterable l = json.decode(response.body);
      List<Product> products = List<Product>.from(l.map((model)=> Product.fromJson(model)));
      return products;
    }
    catch(e){
      throw Exception('Failed to load user');
    }

  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load user');
  }
}
Future<Product?> getProductByPid(int Pid) async {
  final queryParams = {
    'Pid': Pid
  };
  final response = await http
      .post(Uri.parse('http://$localIP:9090/product/getProductByPid'), headers: {
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
      .post(Uri.parse('http://$localIP:9090/product/getProductNameByPid'), headers: {
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

/////BAG
Future<List<Product>> getUserBagByUserUID(String userUID) async {
  final queryParams = {
    'userUID': userUID
  };
  final response = await http
      .post(Uri.parse('http://$localIP:9090/bag/getUserBagByUserUID').replace(queryParameters: queryParams), headers: {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.connectionHeader: 'keep-alive',
    'keep-alive': "timeout=100, max=10000",
  }, body: jsonEncode(queryParams));
  if (response.statusCode == 200) {
    Iterable l = json.decode(response.body);
    List<Product> products = List<Product>.from(l.map((model)=> Product.fromJson(model)));
    return products;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load user bag');
  }
}

Future<List<int>> getUserBagItemsByUserUID(String userUID) async {
  final queryParams = {
    'userUID': userUID
  };
  final response = await http
      .post(Uri.parse('http://$localIP:9090/bag/getUserBagItemsByUserUID'), headers: {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.connectionHeader: 'keep-alive',
    'keep-alive': "timeout=100, max=10000",
  }, body: jsonEncode(queryParams));
  if (response.statusCode == 200) {
    Iterable l = json.decode(response.body);
    List<int> products = List<int>.from(l.map((model)=> model));
    return products;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load user bag');
  }
}

Future<String> addToUserBagByUserUIDandPid(String? userUID, int Pid) async {
  bool flag = false;
  final queryParams = {
    'userUID': userUID,
    'Pid': Pid
  };
  // getUserBagItemsByUserUID(userUID!).then((value) => {
  //   if(!value.contains(Pid)){
  //     flag = true
  //   }
  // });
  List<int> products = await getUserBagItemsByUserUID(userUID!);
  if (!products.contains(Pid)){
    flag = true;
  }

  if(flag) {
    final response = await http
        .put(Uri.parse('http://$localIP:9090/bag/addToUserBagByUserUIDandPid'),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.connectionHeader: 'keep-alive',
          'keep-alive': "timeout=100, max=10000",
        }, body: jsonEncode(queryParams));
    if (response.statusCode == 200) {
      return "OK";
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load user bag');
    }
  }
  else{
    return "Same product exists";
  }
}


Future<String> deleteProductFromUserBagByUserUIDandPid(String? userUID, int Pid) async {
  final queryParams = {
    'userUID': userUID,
    'Pid': Pid
  };
  final response = await http
      .put(Uri.parse('http://$localIP:9090/bag/deleteProductFromUserBagByUserUIDandPid'), headers: {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.connectionHeader: 'keep-alive',
    'keep-alive': "timeout=100, max=10000",
  }, body: jsonEncode(queryParams));
  if (response.statusCode == 200) {
    return "OK";
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load user bag');
  }
}

// Suggestions
Future<List<Product>> getSuggestedProductsByPid(String pid, double? weight1, double? weight2) async {
  weight1 ??= 0.5;
  weight2 ??= 0.5;
  final queryParams = {
    'Pid': pid,
    'weight1': weight1,
    'weight2': weight2,

  };
  final response = await http
      .post(Uri.parse('http://$localIP:9090/product/getSuggestedProductsByPid'), headers: {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.connectionHeader: 'keep-alive',
    'keep-alive': "timeout=100, max=10000",
  }, body: jsonEncode(queryParams));
  if (response.statusCode == 200) {
    Iterable l = json.decode(response.body);
    List<Product> products = List<Product>.from(l.map((model)=> Product.fromJson(model)));
    return products;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load user bag');
  }
}