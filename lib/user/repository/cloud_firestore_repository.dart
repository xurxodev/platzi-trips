import 'package:platzi_trips/place/model/place.dart';
import 'package:platzi_trips/user/model/user.dart';
import 'package:platzi_trips/user/repository/cloud_firestore_api.dart';

class CloudFirestoreRepository {

  final _cloudFirestoreAPI = CloudFirestoreAPI();

  void updateUserDataFirestore(User user) => _cloudFirestoreAPI.updateUserData(user);
  Future<void> updatePlaceData(Place place) => _cloudFirestoreAPI.updatePlaceData(place);
}