import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:platzi_trips/place/model/place.dart';
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

  List<ProfilePlace> buildPlaces(List<DocumentSnapshot> placesListSnapshot){
    List<ProfilePlace> profilePlaces = List<ProfilePlace>();
    placesListSnapshot.forEach((p) {

      profilePlaces.add(ProfilePlace(
          Place(
              name: p.data['name'],
              description: p.data['description'],
              urlImage: p.data['urlImage']),true));

    });

    return profilePlaces;


  }
}
