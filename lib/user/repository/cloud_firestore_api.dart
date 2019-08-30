import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:platzi_trips/place/model/place.dart';
import 'package:platzi_trips/user/model/user.dart';

class CloudFirestoreAPI {

    static const String users = "users";
    static const String places = "places";

    final Firestore _db = Firestore.instance;
    final FirebaseAuth _auth = FirebaseAuth.instance;

    void updateUserData(User user) async{
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

        String uid = (await _auth.currentUser()).uid;

        await refPlaces.add({
            'name': place.name,
            'description': place.description,
            'likes': place.likes,
            'userOwner': "$users/$uid",
            'urlImage': place.urlImage
        });
    }

}