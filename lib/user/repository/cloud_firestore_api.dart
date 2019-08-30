import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:platzi_trips/place/model/place.dart';
import 'package:platzi_trips/place/ui/widgets/card_image.dart';
import 'package:platzi_trips/user/model/user.dart';
import 'package:platzi_trips/user/ui/widgets/profile_place.dart';

class CloudFirestoreAPI {
  static const String users = "users";
  static const String places = "places";

  final Firestore _db = Firestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void updateUserData(User user) async {
    DocumentReference ref = _db.collection(users).document(user.uid);
    return await ref.setData({
      'uid': user.uid,
      'name': user.name,
      'email': user.email,
      'photoURL': user.photoURL,
      'myPlaces': user.myPlaces,
      'myFavoritePlaces': user.myFavoritePlaces,
      'lastSignIn': DateTime.now()
    }, merge: true);
  }

  Future<void> updatePlaceData(Place place) async {
    CollectionReference refPlaces = _db.collection(places);

    FirebaseUser firebaseUser = await _auth.currentUser();

    await refPlaces.add({
      'name': place.name,
      'description': place.description,
      'likes': place.likes,
      'userOwner': _db.document("$users/${firebaseUser.uid}"),
      'urlImage': place.urlImage
    }).then((DocumentReference dr) {
      dr.get().then((DocumentSnapshot ds) {
        DocumentReference refUser =
            _db.collection(users).document(firebaseUser.uid);

        refUser.updateData({
          'myPlaces':
              FieldValue.arrayUnion([_db.document("$places/${ds.documentID}")])
        });
      });
    });
  }

  List<ProfilePlace> buildMyPlaces(List<DocumentSnapshot> placesListSnapshot) {
    List<ProfilePlace> profilePlaces = List<ProfilePlace>();
    placesListSnapshot.forEach((p) {
      profilePlaces.add(ProfilePlace(
          Place(
              name: p.data['name'],
              description: p.data['description'],
              urlImage: p.data['urlImage'],
              likes: p.data['likes']),
          true));
    });

    return profilePlaces;
  }

  List<Place> buildPlaces(
      List<DocumentSnapshot> placesListSnapshot, User user) {
    List<Place> places = List<Place>();

    placesListSnapshot.forEach((p) {
      Place place = Place(
          uid: p.documentID,
          name: p.data["name"],
          description: p.data["description"],
          urlImage: p.data["urlImage"],
          likes: p.data["likes"]);
      List usersLikedRefs = p.data["usersLiked"];
      place.liked = false;
      usersLikedRefs?.forEach((drUL) {
        if (user.uid == drUL.documentID) {
          place.liked = true;
        }
      });
      places.add(place);
    });
    return places;
  }

  Future likePlace(Place place, String uid) async {
    await _db
        .collection(places)
        .document(place.uid)
        .get()
        .then((DocumentSnapshot ds) {
      int likes = ds.data["likes"];

      _db.collection(places).document(place.uid).updateData({
        'likes': place.liked ? likes + 1 : likes - 1,
        'usersLiked': place.liked
            ? FieldValue.arrayUnion([_db.document("${users}/${uid}")])
            : FieldValue.arrayRemove([_db.document("${users}/${uid}")])
      });
    });
  }
}
