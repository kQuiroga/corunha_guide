import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class GoogleMapsButton extends StatelessWidget {
  final String address;
  GoogleMapsButton(this.address);

  _launchUrlMaps() async {
    String query = Uri.encodeComponent(address);
    String googleUrl = "https://www.google.com/maps/search/?api=1&query=$query";

    if (await canLaunch(googleUrl)) {
      await launch(
        googleUrl,
      );
    } else {
      throw 'No se pudo abrir Google Maps para $googleUrl';
    }
  }

  @override
  Widget build(BuildContext context) {
    return RaisedButton.icon(
      label: Text('Abrir en Google Maps'),
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
