import 'package:auto_size_text/auto_size_text.dart';
import 'package:corunha_guide/components/details/google_maps_button.dart';
import 'package:flutter/material.dart';

class ItemMainInfo extends StatelessWidget {
  final itemInfo;
  const ItemMainInfo(this.itemInfo);

  bool _checkTimeExists(String time) {
    if (time == '') {
      return false;
    } else {
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;

    return Container(
      margin: EdgeInsets.only(left: 30, top: 100, right: 30, bottom: 50),
      height: MediaQuery.of(context).size.height / 4,
      width: MediaQuery.of(context).size.width / 1.3,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 8, left: 10, right: 10),
            child: AutoSizeText(
              itemInfo.name,
              style: textTheme.headline6.copyWith(fontSize: 20.0),
              maxLines: 1,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: AutoSizeText(
              itemInfo.address,
              style: textTheme.headline3.copyWith(fontSize: 12.0),
              maxLines: 1,
            ),
          ),
          _checkTimeExists(itemInfo.time)
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.av_timer),
                    Text(itemInfo.time),
                  ],
                )
              : SizedBox(
                  height: 5,
                ),
          Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            child: Divider(
              color: Colors.black87,
              height: 1,
              indent: 70,
              endIndent: 70,
            ),
          ),
          GoogleMapsButton(
            itemInfo.address,
          ),
        ],
      ),
    );
  }
}
