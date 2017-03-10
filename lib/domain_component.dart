import 'package:angular2/core.dart';
import 'package:angular2_components/angular2_components.dart';
import 'package:firebase_counter/firebase_service.dart';
import 'package:firebase_counter/domain.dart';

@Component(
    selector: 'domain',
    templateUrl: 'domain_component.html',
    styleUrls: const <String>['domain_component.css'],
    directives: const [materialDirectives],
    providers: const [materialProviders])
class DomainComponent {
  final FirebaseService _service;

  String likeMessage = 'Add like to domain';
  String dislikeMessage = 'Add dislike to domain';

  @Input()
  Domain domain;

  DomainComponent(this._service);

  like() async {
    domain.likes = await _service.sendLike(domain.key);
  }

  dislike() async {
    domain.likes = await _service.sendDislike(domain.key);
  }
}
