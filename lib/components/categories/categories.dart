import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shine/flutter_shine.dart';
import 'package:corunha_guide/services/crud_category.dart';
import 'package:corunha_guide/models/category_model.dart';
import 'dart:math';

class Categories extends StatefulWidget {
  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  List<CategoryModel> items;
  CrudCategory _crud = CrudCategory();
  StreamSubscription<QuerySnapshot> categoriesSub;

  @override
  void initState() {
    super.initState();
    items = List();
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

  Widget _buildListItem(BuildContext context, int index) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            height: 200,
            width: 175,
            margin: EdgeInsets.fromLTRB(10, 10, 0, 10),
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(items[index].imgUrl), fit: BoxFit.cover),
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 4,
                  offset: Offset(0, 3),
                ),
              ],
            ),
          ),
          FlutterShine(
            config: Config(
              shadowColor: Colors.black,
            ),
            light: Light(intensity: 1, position: Point(-10, -10)),
            builder: (context, shineShadow) {
              return Text(
                "${items[index].name}",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  shadows: shineShadow.shadows,
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: items.length,
        itemBuilder: (context, index) {
          return _buildListItem(context, index);
        },
      ),
    );
  }
}
