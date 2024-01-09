part of 'landing_page_bloc.dart';

sealed class LandingPageState {
  final int tabIndex;
  LandingPageState({required this.tabIndex});

}

final class LandingPageInitial extends LandingPageState {
  LandingPageInitial({required super.tabIndex});
}
