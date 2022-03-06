import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mongo_dart/mongo_dart.dart';

enum CollectionType { UserCollection }

var db = Db(
    dotenv.get('MONGODB_URI', fallback: 'API_URL not found'));
//User
Future<DbCollection> getUsersCollection() async {
  db = await Db.create(
  dotenv.get('MONGODB_URI', fallback: 'API_URL not found'));
  await db.open();
  final collection = db.collection('Users');
  // db.close();
  return collection;
}


Future<DbCollection> getCorrespondingCollection(
    CollectionType collectionType) async {
  late Future<DbCollection> collection;
  if (collectionType == CollectionType.UserCollection) {
    collection = getUsersCollection();
  }
  return collection;
}

find(SelectorBuilder? str,
    {CollectionType collectionType = CollectionType.UserCollection}) async {
  late Future<DbCollection> collection;
  collection = getCorrespondingCollection(collectionType);
  var list = collection.then((value) => value.find(str).toList());
  db.close();
  return list;
}

findOne(SelectorBuilder str,
    {CollectionType collectionType = CollectionType.UserCollection}) async {
  late Future<DbCollection> collection;
  collection = getCorrespondingCollection(collectionType);
  var elm = collection.then((value) => value.findOne(str));
  db.close();
  return elm;
}

update(SelectorBuilder str, ModifierBuilder updateValue,
    {CollectionType collectionType = CollectionType.UserCollection}) async {
  late Future<DbCollection> collection;
  collection = getCorrespondingCollection(collectionType);
  var elm = collection.then((value) => value.update(str, updateValue));
  db.close();
  return elm;
}

remove(SelectorBuilder str, String updateValue,
    {CollectionType collectionType = CollectionType.UserCollection}) async {
  late Future<DbCollection> collection;
  collection = getCorrespondingCollection(collectionType);
  var elm = collection.then((value) => value.remove(str));
  db.close();
  return elm;
}

insertOne(Map<String, dynamic> insertValue,
    {CollectionType collectionType = CollectionType.UserCollection}) async {
  late Future<DbCollection> collection;
  collection = getCorrespondingCollection(collectionType);
  var elm = collection.then((value) => value.insertOne(insertValue));
  db.close();
  return elm;
}
