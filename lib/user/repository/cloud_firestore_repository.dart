import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:platzi_trips/place/model/place.dart';
import 'package:platzi_trips/user/model/user.dart';
import 'package:platzi_trips/user/repository/cloud_firestore_api.dart';
import 'package:platzi_trips/user/ui/widgets/profile_place.dart';

class CloudFirestoreRepository {
  final _cloudFirestoreAPI = CloudFirestoreAPI();

  void updateUserDataFirestore(User user) =>
      _cloudFirestoreAPI.updateUserData(user);

  Future<void> updatePlaceData(Place place) =>
      _cloudFirestoreAPI.updatePlaceData(place);

  List<ProfilePlace> buildPlaces(List<DocumentSnapshot> placesListSnapshot) =>
      _cloudFirestoreAPI.buildPlaces(placesListSnapshot);
}
