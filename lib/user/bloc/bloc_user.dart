import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:platzi_trips/user/model/user.dart';
import 'package:platzi_trips/user/repository/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserBloc implements Bloc {

  User user;

  final _auth_repository = AuthRepository();

  //Flujo de datos - Streams
  //Stream - Firebase
  //StreamController
  Stream<FirebaseUser> streamFirebase = FirebaseAuth.instance.onAuthStateChanged;
  Stream<FirebaseUser> get authStatus => streamFirebase;


  UserBloc(){
    streamFirebase.listen((FirebaseUser firebaseUser) {
      if (firebaseUser != null){
        user = User(
            name: firebaseUser.displayName,
            email: firebaseUser.email,
            photoURL: firebaseUser.photoUrl);
      } else {
        user = null;
      }
      ///////// notice that this is not called after linkWithGoogleCredential succeeded
      print("Firebase onAuthStateChanged ${user}");
    });
  }

  //Casos uso
  //1. SignIn a la aplicación Google
  Future<FirebaseUser> signIn() {
    return _auth_repository.signInFirebase();
  }

  signOut() {
    _auth_repository.signOut();
  }

  @override
  void dispose() {

  }

  User getCurrentUser() => user;
}