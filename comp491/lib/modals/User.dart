import 'package:comp491/modals/dbQueries.dart';
import 'package:mongo_dart/mongo_dart.dart';

class UserData {
  ObjectId? id;
  final String userUID;
  String? userEmail;
  String? userName;

  UserData({
    required this.userUID,
    this.userEmail,
    this.id,
    this.userName,
  });

  @override
  String toString() {
    return "user" +
        this.userUID +
        "userName" +
        this.userName.toString();
  }

  Future<UserData?> initUser(String uid) async {
    try {
      final response = await findOne(where.eq('userUID', uid),
          collectionType: CollectionType.UserCollection);
      print(response);
      UserData usertemp = UserData.fromJson(response);
      print(usertemp);
      print(usertemp.userEmail);
      print(usertemp.userName);
      this.userEmail = usertemp.userEmail;
      this.userName = usertemp.userName;

      return usertemp;
    } on Exception catch (e) {
      print(e.toString());
      return null;
    }
  }


  String? getUserEmail() {
    return this.userEmail;
  }

  String? getUserName() {
    return this.userName;
  }


  void userChangeEmail(String email) {
    this.userEmail = email;
    update(where.eq('userUID', userUID), modify.set('userEMail', email),
        collectionType: CollectionType.UserCollection);
  }

  Future<String> userChangeName(String userName) async {
    this.userName = userName;
    await update(where.eq('userUID', userUID), modify.set('userName', userName),
        collectionType: CollectionType.UserCollection);
    return userName;
  }


  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      id: json['_id'],
      userUID: json['userUID'],
      userEmail: json['userEmail'],
      userName: json['userName'],
    );
  }

}