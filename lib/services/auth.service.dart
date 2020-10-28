import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<String> registerUser(emailID, password) async {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  CollectionReference dbRef = FirebaseFirestore.instance.collection("users");

  try {
    await firebaseAuth
        .createUserWithEmailAndPassword(email: emailID, password: password)
        .then((result) {
      dbRef.doc(emailID).set({'username': 'kad99kev'});
    });
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      return 'The password provided is too weak.';
    } else if (e.code == 'email-already-in-use') {
      return 'The account already exists for that email.';
    }
  } catch (e) {
    return 'Some error has occurred. Please try again!';
  }
  return 'success';
}

Future<dynamic> loginUser(emailID, password) async {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  CollectionReference dbRef = FirebaseFirestore.instance.collection("users");

  try {
    await firebaseAuth.signInWithEmailAndPassword(
        email: emailID, password: password);
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      return 'No user found for that email.';
    } else if (e.code == 'wrong-password') {
      return 'Wrong password provided for that user.';
    }
  }
  DocumentSnapshot result = await dbRef.doc(emailID).get();
  return result.data();
}
