import 'package:bloc/bloc.dart';

part 'landing_page_event.dart';
part 'landing_page_state.dart';

class LandingPageBloc extends Bloc<TabChange, LandingPageState> {
  LandingPageBloc() : super(LandingPageInitial(tabIndex: 0)) {
    on<TabChange>((event, emit) {
      emit(LandingPageInitial(tabIndex: event.tabIndex ));
    });
  }
}
