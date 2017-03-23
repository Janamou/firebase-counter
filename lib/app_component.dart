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
    count = await _updateDatabase((c) => c - 1);
  }

  like() async {
    count = await _updateDatabase((c) => c + 1);
  }

  Future<int> _updateDatabase(UpdateFunction<int> update) async {
    var transaction = await _ref.transaction((current) {
      if (current != null) {
        current = update(current);
      }
      return current;
    });

    return transaction.snapshot.val();
  }
}

typedef T UpdateFunction<T>(T value);
