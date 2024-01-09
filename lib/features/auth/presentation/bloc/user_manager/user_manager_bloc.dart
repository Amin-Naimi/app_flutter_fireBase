import 'package:bloc/bloc.dart';
import 'package:dsi32_flutter_project/core/exceptions/failures.dart';
import 'package:dsi32_flutter_project/features/auth/domain/usecases/register_user.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/exceptions/auth_failures.dart';
import '../../../../../core/strings/failures.dart';
import '../../../domain/entities/user_entity.dart';
part 'user_manager_event.dart';
part 'user_manager_state.dart';

class UserManagerBloc extends Bloc<UserManagerEvent, UserManagerState> {
  final RegisterUserUseCase registerUserUseCase;
  UserManagerBloc({required this.registerUserUseCase})
      : super(UserManagerInitial()) {
    on<UserManagerEvent>((event, emit) async {
      print('register 1');
      if (event is RegisterEvent) {        
        emit(RegisteringUserState());        
        final failureOrDoneRegister = await registerUserUseCase(event.user);
        
        failureOrDoneRegister.fold(
            (left) => emit(RegisterUserErrorState(
                message: _mapRegisterFailureToMessage(left))),
            (_) => emit(RegisteredUserState()));
      }
    });
  }

  String _mapRegisterFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case OfflineFailure:
        return OFFLINE_FAILURE_MESSAGE;
      case RegisterUserWeakPwdFailure:
        return REGISTER_USER_WEAK_PWD;
      case RegisterUserUsedEmailFailure:
        return REGISTER_USER_EMAIL_USED;
      default:
        return "Erreur inconnue...";
    }
  }

}
