import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void registerUser(emailID, password) {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  CollectionReference dbRef = FirebaseFirestore.instance.collection("Users");

  firebaseAuth
      .createUserWithEmailAndPassword(email: emailID, password: password)
      .then((result) {
    dbRef.add({'email': emailID, 'username': 'kad99kev'});
  });
}
