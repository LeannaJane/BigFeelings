import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> initializeFirebase() async {
  WidgetsFlutterBinding.ensureInitialized();
  //! Initialise firebase.
  await Firebase.initializeApp(
    //! My firebase web config. Copied from firebase console s.
    options: const FirebaseOptions(
      apiKey: "AIzaSyAb003siF7HEjnysZ2HKX3xoF7msO5CmNc",
      authDomain: "big-feelings-project-1234.firebaseapp.com",
      projectId: "big-feelings-project-1234",
      storageBucket: "big-feelings-project-1234.appspot.com",
      messagingSenderId: "77742859028",
      appId: "1:77742859028:web:afbfb0b229e3e915045801",
      measurementId: "G-R0H8DPSL85",
    ),
  );
}
