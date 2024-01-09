import 'package:dsi32_flutter_project/features/auth/domain/entities/user_entity.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserModel extends UserEntity {
  const UserModel(
      {String? uid,
      required String name,
      required String email,
      required String? profileURL,
      required String password})
      : super(
            uid: uid,
            name: name,
            email: email,
            profilURL: profileURL,
            password: password);

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        uid: json['uid'],
        name: json['name'],
        email: json['email'],
        profileURL: json['profileURL'],
        password: json['password']);
  }

  factory UserModel.fromFirebaseAuth(User user) {
    return UserModel(
        uid: user.uid,
        name: user.displayName!,
        email: user.email!,
        profileURL: user.photoURL,
        password: "");
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'profileURL': profilURL,
      'password': password
    };
  }
}
