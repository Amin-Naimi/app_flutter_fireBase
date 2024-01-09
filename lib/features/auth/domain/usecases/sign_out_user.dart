import 'package:dartz/dartz.dart';

import '../../../../core/exceptions/failures.dart';
import '../repositories/user_repository.dart';



class SignOutUserUseCase {
  final UserRepository userRepository;

  SignOutUserUseCase(this.userRepository);

  Future<Either<Failure, Unit>> call() async {
    return await userRepository.signOut();
  }
}
