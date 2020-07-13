import 'package:corunha_guide/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class GoogleMapsButton extends StatelessWidget {
  final String address;
  GoogleMapsButton(this.address);
  var buildContext;

  getContext(BuildContext context) {
    return context;
  }

  _launchUrlMaps() async {
    String query = Uri.encodeComponent(address);
    String error = AppLocalizations.of(buildContext)
        .getTranslatedValue('google_maps_error');

    final googleUrl = "https://www.google.com/maps/search/?api=1&query=$query";

    if (await canLaunch(googleUrl)) {
      await launch(
        googleUrl,
      );
    } else {
      throw error + '$googleUrl';
    }
  }

  @override
  Widget build(BuildContext context) {
    buildContext = getContext(context);

    return RaisedButton.icon(
      label: Text(
        AppLocalizations.of(context).getTranslatedValue('open_google_maps'),
      ),
      onPressed: _launchUrlMaps,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
      icon: Icon(
        Icons.location_on,
        color: Colors.red,
      ),
      color: Colors.white,
      splashColor: Colors.blue,
    );
  }
}
