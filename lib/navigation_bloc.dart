import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobi_pharmacy_project/HomePage.dart';
import 'package:mobi_pharmacy_project/OrdersPage.dart';
import 'package:mobi_pharmacy_project/auth.dart';
import 'package:mobi_pharmacy_project/waitingPharmacy.dart';
import 'package:mobi_pharmacy_project/welcomePage.dart';

enum NavigationEvents {
  WaitingPharmacyEvent,
  MyAccountClickedEvent,
  MyOrdersClickedEvent,
}

abstract class NavigationStates {}

class NavigationBloc extends Bloc<NavigationEvents, NavigationStates> {
  NavigationBloc(this.auth) : super(WelcomePage(auth));
  final BaseAuth auth;
  @override
  Stream<NavigationStates> mapEventToState(NavigationEvents event) async* {
    switch (event) {
      case NavigationEvents.MyAccountClickedEvent:
        yield WelcomePage(this.auth);
        break;
      case NavigationEvents.MyOrdersClickedEvent:
        yield OrderPage(this.auth);
        break;
      case NavigationEvents.WaitingPharmacyEvent:
        yield WaitingPharmacy(this.auth);
        break;
    }
  }
}
