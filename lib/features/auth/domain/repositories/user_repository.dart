

import 'package:dartz/dartz.dart';
import 'package:dsi32_flutter_project/features/auth/domain/entities/user_entity.dart';

import '../../../../core/exceptions/failures.dart';



abstract class UserRepository{

  Future<Either<Failure,Unit>> registerUser(UserEntity user);
  Future<Either<Failure,Unit>> updateUser(UserEntity user);

  Future<Either<Failure,Unit>> signIn(UserEntity user);
  Future<Either<Failure,Unit>> signOut();
}

