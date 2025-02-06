import 'package:js/js.dart';

bool get isSupported => platform.toLowerCase() != "unknown";

// Declare the external JavaScript function
@JS('Telegram.WebApp.disableVerticalSwipes')
external Future<void> disableVerticalSwipes();

@JS('Telegram.WebApp.expand')
external Future<void> expand();

@JS('Telegram.WebApp.platform')
external String get platform;

@JS('Telegram.WebApp.isExpanded')
external bool get isExpanded;

@JS('Telegram.WebApp.initDataUnsafe')
external WebAppInitData get initDataUnsafe;

@JS()
@anonymous
class WebAppInitData {
  external WebAppUser? get user;
}

@JS()
@anonymous
class WebAppUser {
  external String? get id;

  external String? get firstName;

  external String? get photoUrl;
}
