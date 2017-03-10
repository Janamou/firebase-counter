import 'package:angular2/core.dart';
import 'package:angular2_components/angular2_components.dart';
import 'package:firebase_counter/firebase_service.dart';
import 'package:firebase_counter/domain.dart';
import 'package:firebase_counter/domain_component.dart';

@Component(
    selector: 'main-app',
    templateUrl: 'app_component.html',
    directives: const [DomainComponent, materialDirectives],
    providers: const [FirebaseService, materialProviders])
class AppComponent {
  final FirebaseService _service;

  List<Domain> get domains => _service.domains;

  AppComponent(this._service);
}
