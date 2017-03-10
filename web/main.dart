import 'package:angular2/platform/browser.dart';
import 'package:firebase_counter/app_component.dart';
import 'package:firebase/firebase.dart' as fb;

void main() {
  fb.initializeApp(
      apiKey: "AIzaSyAcd73Ww0ojuMsBpHM58EKtTvxkmsgAG0A",
      authDomain: "counter-2a392.firebaseapp.com",
      databaseURL: "https://counter-2a392.firebaseio.com",
      storageBucket: "counter-2a392.appspot.com");

  bootstrap(AppComponent);
}
