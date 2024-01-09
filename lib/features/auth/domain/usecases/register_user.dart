import 'package:dartz/dartz.dart';
import 'package:dsi32_flutter_project/features/auth/domain/entities/user_entity.dart';
import 'package:dsi32_flutter_project/features/auth/domain/repositories/user_repository.dart';

import '../../../../core/exceptions/failures.dart';


class RegisterUserUseCase{
  final UserRepository userRepository;

  RegisterUserUseCase(this.userRepository);

  Future<Either<Failure,Unit>> call(UserEntity user) async{
    return await userRepository.registerUser(user);
  }

}