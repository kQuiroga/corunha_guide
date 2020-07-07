import 'package:corunha_guide/components/details/item_detail_about.dart';
import 'package:corunha_guide/components/details/item_detail_header.dart';
import 'package:corunha_guide/models/category_items_model.dart';
import 'package:flutter/material.dart';

class DetailsScreen extends StatefulWidget {
  final CategoryItemsModel itemSelected;

  DetailsScreen({Key key, this.itemSelected}) : super(key: key);

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Detalles'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              ItemDetailHeader(widget.itemSelected),
              Padding(
                padding: EdgeInsets.only(
                  left: 10,
                  right: 10,
                ),
                child: ItemAbout(widget.itemSelected.desc),
              ),
            ],
          ),
        ));
  }
}
