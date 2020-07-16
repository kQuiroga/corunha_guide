import 'package:corunha_guide/app_localizations.dart';
import 'package:corunha_guide/components/details/item_detail_about.dart';
import 'package:corunha_guide/components/details/item_detail_header.dart';
import 'package:corunha_guide/components/details/photo_album.dart';
import 'package:corunha_guide/components/details/rating.dart';
import 'package:corunha_guide/models/category_items_model.dart';
import 'package:corunha_guide/models/popular_spots_model.dart';
import 'package:flutter/material.dart';

class DetailsScreen extends StatefulWidget {
  final CategoryItemsModel itemCategorySelected;
  final PopularSpotsModel itemPopularSelected;
  final String categoryType;

  DetailsScreen(
      {Key key,
      this.itemCategorySelected,
      this.itemPopularSelected,
      this.categoryType})
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
              widget.itemPopularSelected == null
                  ? ItemDetailHeader(widget.itemCategorySelected)
                  : ItemDetailHeader(widget.itemPopularSelected),
              widget.itemPopularSelected == null
                  ? Rating(
                      itemName: widget.itemCategorySelected.name,
                      categoryType: widget.categoryType)
                  : Rating(
                      itemName: widget.itemPopularSelected.name,
                      categoryType: '',
                    ),
              widget.itemPopularSelected == null
                  ? Padding(
                      padding: EdgeInsets.only(left: 10, right: 10, bottom: 20),
                      child: ItemAbout(widget.itemCategorySelected.desc))
                  : Padding(
                      padding: EdgeInsets.only(left: 10, right: 10, bottom: 20),
                      child: ItemAbout(widget.itemPopularSelected.desc)),
              widget.itemPopularSelected == null
                  ? PhotoAlbum(
                      categoryType: widget.categoryType,
                      itemCategorySelected: widget.itemCategorySelected,
                    )
                  : PhotoAlbum(
                      itemPopularSelected: widget.itemPopularSelected,
                    ),
              SizedBox(
                height: 10,
              )
            ],
          ),
        ));
  }
}
