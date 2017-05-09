import 'dart:async';

import 'package:angular2/core.dart';
import 'package:angular2_components/angular2_components.dart';
import 'package:firebase/firebase.dart';

typedef T UpdateFunction<T>(T value);

@Component(
    selector: 'main-app',
    styleUrls: const ['app_component.css'],
    templateUrl: 'app_component.html',
    directives: const [materialDirectives],
    providers: const [materialProviders])
class AppComponent implements OnInit {
  DatabaseReference _ref;

  int count = 0;

  dislike() async {
    count = await _updateDatabase((c) => c - 1);
  }

  like() async {
    count = await _updateDatabase((c) => c + 1);
  }

  @override
  ngOnInit() {
    initializeApp(
        apiKey: "AIzaSyAcd73Ww0ojuMsBpHM58EKtTvxkmsgAG0A",
        authDomain: "counter-2a392.firebaseapp.com",
        databaseURL: "https://counter-2a392.firebaseio.com",
        storageBucket: "counter-2a392.appspot.com");

    _ref = database().ref('counter');
    _ref.onValue.listen((e) {
      DataSnapshot snapshot = e.snapshot;
      count = snapshot.val();
    });
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
