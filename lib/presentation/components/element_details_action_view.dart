import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import '../../domain/model/bitcoin_shop_model.dart';
import '../../utils/utils.dart';
import 'main_button_view.dart';

class ElementDetailsActionsView extends StatelessWidget {
  final BitcoinShopModel element;

  const ElementDetailsActionsView({super.key, required this.element});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          MainButtonView(
            onPressed: () async {
              launchUrlSafe(getGoogleMapsUrl());
            },
            text: 'Directions',
            icon: Icons.directions,
          ),
          const SizedBox(width: 8.0),
          element.website == null
              ? const SizedBox()
              : getRow(
                  MainButtonView(
                    onPressed: () async {
                      final url = element.website!;
                      launchUrlSafe(url);
                    },
                    text: 'Website',
                    icon: Icons.web,
                  ),
                ),
          element.phoneNumber == null
              ? const SizedBox()
              : getRow(MainButtonView(
                  onPressed: () async {
                    final url = 'tel:${element.phoneNumber}';
                    launchUrlSafe(url);
                  },
                  text: 'Call',
                  icon: Icons.phone,
                )),
          element.email == null
              ? const SizedBox()
              : getRow(MainButtonView(
                  onPressed: () async {
                    final url = 'mailto:${element.email}';
                    launchUrlSafe(url);
                  },
                  text: 'Email',
                  icon: Icons.email,
                )),
          MainButtonView(onPressed: () => onShare(), text: 'Share', icon: Icons.share)
        ],
      ),
    );
  }

  Widget getRow(Widget widget) {
    return Row(
      children: [
        widget,
        const SizedBox(width: 8.0),
      ],
    );
  }

  String getGoogleMapsUrl() {
    if (element.getAddress() == null) {
      return 'https://www.google.com/maps/search/?api=1&query=${element.name}';
    }
    return 'https://www.google.com/maps/search/?api=1&query=${element.name} ${element.getAddress()}';
  }

  void onShare() async {
    await Share.share("Go and check it at ${element.name} ${getGoogleMapsUrl()}");
  }
}
