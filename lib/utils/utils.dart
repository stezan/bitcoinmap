import 'package:location/location.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> launchUrlSafe(String url) async {
  if (await canLaunchUrl(Uri.parse(url))) {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch $url');
    }
  }
}

Future<LocationData?> getLocation() async {
  Location location = Location();

  bool serviceEnabled;
  LocationData locationData;

  serviceEnabled = await location.serviceEnabled();
  if (!serviceEnabled) {
    serviceEnabled = await location.requestService();
    if (!serviceEnabled) {
      return null;
    }
  }

  locationData = await location.getLocation();

  return locationData;
}

String humanizeNumberWithDotSeparator(int number) {
  return number.toString().replaceAllMapped(
        RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
        (Match m) => '${m[1]}.',
      );
}
