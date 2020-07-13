import 'package:corunha_guide/app_localizations.dart';
import 'package:corunha_guide/components/details/item_detail_about.dart';
import 'package:corunha_guide/components/details/item_detail_header.dart';
import 'package:corunha_guide/components/details/photo_album.dart';
import 'package:corunha_guide/components/details/rating.dart';
import 'package:corunha_guide/models/category_items_model.dart';
import 'package:flutter/material.dart';

class DetailsScreen extends StatefulWidget {
  final CategoryItemsModel itemSelected;
  final String categoryType;

  DetailsScreen({Key key, this.itemSelected, this.categoryType})
      : super(key: key);

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title:
              Text(AppLocalizations.of(context).getTranslatedValue('details')),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              ItemDetailHeader(widget.itemSelected),
              Rating(
                categoryType: widget.categoryType,
                itemName: widget.itemSelected.name,
              ),
              Padding(
                padding: EdgeInsets.only(left: 10, right: 10, bottom: 20),
                child: ItemAbout(widget.itemSelected.desc),
              ),
              PhotoAlbum(
                categoryType: widget.categoryType,
                itemSelected: widget.itemSelected,
              )
            ],
          ),
        ));
  }
}
