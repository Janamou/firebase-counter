import 'package:angular2/core.dart';
import 'package:firebase/firebase.dart';

@Component(
    selector: 'main-app',
    styleUrls: const ['app_component.css'],
    templateUrl: 'app_component.html')
class AppComponent {
  final DatabaseReference _ref;
  int count;

  AppComponent() : _ref = database().ref('counter') {
    _ref.onValue.listen((e) {
      DataSnapshot snapshot = e.snapshot;
      count = snapshot.val();
    });
  }

  increase() {
    count = _transactionHelper((c) => ++c);
  }

  decrease() {
    count = _transactionHelper((c) => --c);
  }

  // no try catch?
  _transactionHelper(Function f) async {
    var newCount = 0;

    await _ref.transaction((current) {
      if (current != null) {
        current = f(current);
        newCount = current;
      }
      return current;
    });

    return newCount;
  }
}
