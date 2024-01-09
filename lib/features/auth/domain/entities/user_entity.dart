import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String? uid;
  final String name;
  final String email;
  final String? profilURL;
  final String password;

  const UserEntity(
      {this.uid,
      required this.name,
      required this.email,
      this.profilURL,
      required this.password});

  @override
  List<Object?> get props => [uid, email, name];
}
