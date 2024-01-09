import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dsi32_flutter_project/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseService {
  final _firebaseAuth = FirebaseAuth.instance;
  final _firebaseStorage = FirebaseStorage.instance;
  final _cloudfirestore = FirebaseFirestore.instance;

  static Future<FirebaseService> init() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    return FirebaseService();
  }

  FirebaseAuth getAuth() {
    return _firebaseAuth;
  }

  FirebaseStorage getStorage() {
    return _firebaseStorage;
  }

  FirebaseFirestore getFirestore() {
    return _cloudfirestore;
  }
}
