import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:platzi_trips/place/model/place.dart';
import 'package:platzi_trips/place/repository/firebase_storage_repository.dart';
import 'package:platzi_trips/place/ui/widgets/card_image.dart';
import 'package:platzi_trips/user/model/user.dart';
import 'package:platzi_trips/user/repository/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:platzi_trips/user/repository/cloud_firestore_api.dart';
import 'package:platzi_trips/user/repository/cloud_firestore_repository.dart';
import 'package:platzi_trips/user/ui/widgets/profile_place.dart';

class UserBloc implements Bloc {
  User user;

  final _auth_repository = AuthRepository();

  //Flujo de datos - Streams
  //Stream - Firebase
  //StreamController
  Stream<FirebaseUser> streamFirebase =
      FirebaseAuth.instance.onAuthStateChanged;

  Stream<FirebaseUser> get authStatus => streamFirebase;

  UserBloc() {
    streamFirebase.listen((FirebaseUser firebaseUser) {
      if (firebaseUser != null) {
        user = User(
            uid: firebaseUser.uid,
            name: firebaseUser.displayName,
            email: firebaseUser.email,
            photoURL: firebaseUser.photoUrl);
      } else {
        user = null;
      }

      print("Firebase onAuthStateChanged ${user}");
    });
  }

  //Casos uso
  //1. SignIn a la aplicación Google
  Future<FirebaseUser> signIn() => _auth_repository.signInFirebase();

  //2. Registrar usuario en base de datos
  final _cloudFirestoreRepository = CloudFirestoreRepository();

  void updateUserData(User user) =>
      _cloudFirestoreRepository.updateUserDataFirestore(user);

  //3. Update place
  Future<void> updatePlaceData(Place place) =>
      _cloudFirestoreRepository.updatePlaceData(place);

  Stream<QuerySnapshot> placesListStream =
      Firestore.instance.collection(CloudFirestoreAPI.places).snapshots();

  Stream<QuerySnapshot> get placesStream => placesListStream;

  //List<CardImageWithFabIcon> buildPlaces(List<DocumentSnapshot> placesListSnapshot) => _cloudFirestoreRepository.buildPlaces(placesListSnapshot);
  List<Place> buildPlaces(List<DocumentSnapshot> placesListSnapshot, User user) => _cloudFirestoreRepository.buildPlaces(placesListSnapshot, user);
  Future likePlace(Place place, String uid) => _cloudFirestoreRepository.likePlace(place,uid);

  //4. MyPlaces
  Stream<QuerySnapshot> myPlacesListSream(String uid) => Firestore.instance
      .collection(CloudFirestoreAPI.places)
      .where("userOwner",
          isEqualTo:
              Firestore.instance.document("${CloudFirestoreAPI.users}/${uid}"))
      .snapshots();

  List<ProfilePlace> buildMyPlaces(List<DocumentSnapshot> placesListSnapshot) =>
      _cloudFirestoreRepository.buildMyPlaces(placesListSnapshot);

  //5. uploadFile
  final _firebaseStorageRepository = FirebaseStorageRepository();

  Future<StorageUploadTask> uploadFile(String path, File image) =>
      _firebaseStorageRepository.uploadFile(path, image);

  signOut() {
    _auth_repository.signOut();
  }

  @override
  void dispose() {}

  User getCurrentUser() => user;
}
