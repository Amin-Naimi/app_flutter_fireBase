part of 'landing_page_bloc.dart';

sealed class LandingPageEvent {
  const LandingPageEvent();
}
class TabChange extends LandingPageEvent {
  
  final int tabIndex;
  TabChange({required this.tabIndex});
}

/*
L’index est passé dans l’événement TabChange pour indiquer quel onglet a été sélectionné dans la BottomNavigationBar.

Lorsque vous appuyez sur un onglet dans la BottomNavigationBar, l’index de cet onglet est passé à l’événement TabChange. Cet événement est ensuite ajouté au bloc. Dans le bloc, lorsque l’événement TabChange est reçu, il émet un nouvel état avec l’index de l’onglet qui a été sélectionné. Cela déclenche la reconstruction de la BottomNavigationBar avec le nouvel index de l’onglet sélectionné.

C’est une façon de gérer l’état de la BottomNavigationBar en utilisant le bloc. L’état de l’onglet sélectionné est maintenu dans le bloc plutôt que dans l’état du widget. Cela permet de garder la logique de l’application séparée de l’interface utilisateur et rend le code plus maintenable et testable.
*/