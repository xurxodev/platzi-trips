import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:platzi_trips/user/model/user.dart';
import 'package:platzi_trips/user/repository/cloud_firestore_api.dart';

class CloudFirestoreRepository {

  final _cloudFirestoreAPI = CloudFirestoreAPI();

  void updateUserDataFirestore(User user) => _cloudFirestoreAPI.updateUserData(user);

}