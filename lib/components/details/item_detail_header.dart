import 'package:corunha_guide/components/details/arc_banner_image.dart';
import 'package:corunha_guide/components/details/item_main_info.dart';
import 'package:flutter/cupertino.dart';

class ItemDetailHeader extends StatelessWidget {
  ItemDetailHeader(this.item);
  var item;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(bottom: 210.0),
          child: ArcBannerImage(item.imgUrl),
        ),
        Positioned(
          bottom: 0.0,
          left: 16.0,
          right: 16.0,
          top: 100,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ItemMainInfo(item),
            ],
          ),
        ),
      ],
    );
  }
}
