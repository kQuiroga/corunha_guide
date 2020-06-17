import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';
import 'package:corunha_guide/services/crud_category.dart';
import 'package:corunha_guide/models/category_model.dart';
import 'dart:math';

class Categories extends StatefulWidget {
  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  int _focusedIndex = -1;
  List<String> listImages;
  List<CategoryModel> items;
  CrudCategory _crud = CrudCategory();
  StreamSubscription<QuerySnapshot> categoriesSub;

  @override
  void initState() {
    super.initState();
    items = List();
    listImages = List();
    categoriesSub?.cancel();
    categoriesSub = _crud.getCategoriesList().listen((QuerySnapshot snapshot) {
      final List<CategoryModel> categories = snapshot.documents
          .map((documentsSnapshot) => CategoryModel.fromMap(
              documentsSnapshot.data, documentsSnapshot.documentID))
          .toList();
      setState(() {
        this.items = categories;
      });
    });
  }

  void _onItemFocus(int index) {
    print(index);
    setState(() {
      _focusedIndex = index;
    });
  }

  Widget _buildListItem(BuildContext context, int index) {
    return Container(
      width: 150,
      child: Column(
        children: <Widget>[
          Container(
            height: 200,
            width: 200,
            margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(items[index].imgUrl),
                    fit: BoxFit.cover),
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                border: Border.all(color: Colors.black, width: 0.5)),
            child: Text(
              "${items[index].name}",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 16.0, shadows: [
                Shadow(
                    blurRadius: 20.0,
                    color: Colors.black,
                    offset: Offset(10.0, 10.0))
              ]),
            ),
          ),
        ],
      ),
    );
  }

  ///Override default dynamicItemSize calculation
  double customEquation(double distance) {
    // return 1-min(distance.abs()/500, 0.2);
    return 1 - (distance / 1000);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Text(
            'Categories',
            textAlign: TextAlign.left,
          ),
          Expanded(
            child: ScrollSnapList(
              onItemFocus: _onItemFocus,
              itemSize: 150,
              itemBuilder: _buildListItem,
              itemCount: items.length,
              dynamicItemSize: true,
              // dynamicSizeEquation: customEquation, //optional
            ),
          ),
        ],
      ),
    );
  }
}
