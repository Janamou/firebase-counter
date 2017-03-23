import 'dart:async';

import 'package:angular2/core.dart';
import 'package:angular2_components/angular2_components.dart';
import 'package:firebase/firebase.dart';

@Component(
    selector: 'main-app',
    styleUrls: const ['app_component.css'],
    templateUrl: 'app_component.html',
    directives: const [materialDirectives],
    providers: const [materialProviders])
class AppComponent {
  DatabaseReference _ref;
  int count;

  AppComponent() {
    _ref = database().ref('counter');

    _ref.onValue.listen((e) {
      DataSnapshot snapshot = e.snapshot;
      count = snapshot.val();
    });
  }

  dislike() async {
    count = await _transactionHelper((c) => c - 1);
  }

  like() async {
    count = await _transactionHelper((c) => c + 1);
  }

  // no try catch?
  Future<int> _transactionHelper(Function f) async {
    Transaction transaction = await _ref.transaction((current) {
      if (current != null) {
        current = f(current);
      }
      return current;
    });

    return transaction.snapshot.val();
  }
}
