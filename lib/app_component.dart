import 'package:angular2/core.dart';
import 'package:angular2_components/angular2_components.dart';
import 'package:firebase/firebase.dart' as fb;
import 'package:firebase_counter/domain.dart';

@Component(
    selector: 'main-app',
    styleUrls: const ['app_component.css'],
    templateUrl: 'app_component.html',
    directives: const [materialDirectives],
    providers: const [materialProviders])
class AppComponent implements OnInit {
  final fb.DatabaseReference _ref;
  final List<Domain> domains = [];

  String get likeMsg => 'Add like to domain';
  String get dislikeMsg => 'Add dislike to domain';

  AppComponent() : _ref = fb.database().ref('domains');

  @override
  ngOnInit() {
    _ref.onChildAdded.listen((e) {
      //TODO this method is also called when persmission denied
      fb.DataSnapshot snapshot = e.snapshot;
      Map map = snapshot.val();
      domains.add(new Domain.fromMap(snapshot.key, map));
    });
  }

  like(Domain d) async {
    try {
      await _ref.child(d.key).child('favourites').transaction((current) {
        if (current != null) {
          d.favourites = ++current;
        }
        return current;
      });
    } catch (e) {
      print('Unable to do like:\n$e');
    }
  }

  dislike(Domain d) async {
    try {
      await _ref.child(d.key).child('favourites').transaction((current) {
        if (current != null) {
          d.favourites = --current;
        }
        return current;
      });
    } catch (e) {
      print('Unable to do dislike:\n$e');
    }
  }
}
