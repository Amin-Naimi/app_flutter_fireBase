import 'package:dartz/dartz.dart';
import 'package:dsi32_flutter_project/features/auth/domain/repositories/user_repository.dart';

import '../../../../core/exceptions/failures.dart';
import '../entities/user_entity.dart';




class SignInUserUseCase {
  final UserRepository userRepository;

  SignInUserUseCase(this.userRepository);

  Future<Either<Failure, Unit>> call(UserEntity user) async {
    return await userRepository.signIn(user);
  }
}
