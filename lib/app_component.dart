import 'package:angular2/core.dart';
import 'package:firebase/firebase.dart';

@Component(
    selector: 'main-app',
    styleUrls: const ['app_component.css'],
    templateUrl: 'app_component.html')
class AppComponent {
  final DatabaseReference _ref;
  int count;

  increase() async {
    try {
      Transaction transaction =
          await _ref.transaction((current) {
        if (current != null) {
          count = ++current;
        }
        return current;
      });
    } catch (e) {
      print("Unable to post like");
    }
  }

  decrease() async {
    try {
      Transaction transaction =
      await _ref.transaction((current) {
        if (current != null) {
          count = --current;
        }
        return current;
      });
    } catch (e) {
      print("Unable to post dislike");
    }
  }

  AppComponent() : _ref = database().ref('counter') {
    _ref.onValue.listen((e) {
      DataSnapshot snapshot = e.snapshot;
      count = snapshot.val();
    });
  }
}
