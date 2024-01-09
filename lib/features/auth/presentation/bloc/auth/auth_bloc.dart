import 'package:dsi32_flutter_project/features/auth/domain/entities/user_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/exceptions/auth_failures.dart';
import '../../../../../core/exceptions/failures.dart';
import '../../../../../core/strings/failures.dart';
import '../../../domain/usecases/sign_in_user.dart';
import '../../../domain/usecases/sign_out_user.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignInUserUseCase signInUserUseCase;
  final SignOutUserUseCase signOutUserUseCase;

  AuthBloc({required this.signInUserUseCase, required this.signOutUserUseCase})
      : super(AuthInitial()) {
    on<AuthEvent>((event, emit) async {
      if (event is LoginEvent) {
        emit(LoginProgressState());

        final failureOrDoneLogin = await signInUserUseCase(event.user);

        failureOrDoneLogin.fold((left) {
          emit(AuthErrorState(message: _mapLoginFailureToMessage(left)));
          emit(UnAuthenticatedState());
        }, (_) => emit(AuthenticatedState(message: "authenticated")));
      } else if (event is LogoutEvent) {
        emit(LogOutInProgressState());

        final failureOrDoneLogOut = await signOutUserUseCase();

        failureOrDoneLogOut.fold((left) {
          emit(AuthErrorState(message: _mapLogOutFailureToMessage(left)));
          emit(AuthenticatedState(message: "authenticated"));
        }, (_) => emit(UnAuthenticatedState()));
      }
    });
  }

  String _mapLoginFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case OfflineFailure:
        return OFFLINE_FAILURE_MESSAGE;
      case SignInWrongPwdFailure:
        return LOGIN_USER_WRONG_PWD;
      case SignInUserNotFoundFailure:
        return LOGIN_USER_NOT_FOUND;
      default:
        return "Erreur inconnue...";
    }
  }

  String _mapLogOutFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case OfflineFailure:
        return OFFLINE_FAILURE_MESSAGE;
      default:
        return "Erreur inconnue...";
    }
  }
}
