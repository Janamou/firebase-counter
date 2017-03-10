import 'dart:async';
import 'package:angular2/core.dart';
import 'package:firebase/firebase.dart';
import 'package:firebase_counter/domain.dart';

@Injectable()
class FirebaseService {
  DatabaseReference _ref;
  List<Domain> domains = [];

  FirebaseService() {
    _ref = database().ref('domains');

    // Maybe use once() instead
    _ref.onChildAdded.listen((e) {
      DataSnapshot snapshot = e.snapshot;
      Map map = snapshot.val();
      domains.add(new Domain.fromMap(snapshot.key, map));
    });
  }

  Future<int> sendLike(String key) async {
    try {
      Transaction transaction =
          await _ref.child(key).child('likes').transaction((current) {
        if (current != null) {
          current++;
        }
        return current;
      });

      return transaction.snapshot.val();
    } catch (e) {
      throw _handleError(e, 'Unable to post like');
    }
  }

  Future<int> sendDislike(String key) async {
    try {
      Transaction transaction =
          await _ref.child(key).child('likes').transaction((current) {
        if (current != null) {
          current--;
        }
        return current;
      });

      return transaction.snapshot.val();
    } catch (e) {
      throw _handleError(e, 'Unable to post dislike');
    }
  }

  Exception _handleError(e, String message) {
    print(e);
    return new Exception('$message\n$e');
  }
}
