import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:corunha_guide/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:corunha_guide/repository/crud_category.dart';
import 'package:corunha_guide/models/category_model.dart';
import 'package:corunha_guide/screens/list_categories_items_screen.dart';

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
    String categoryLocale =
        AppLocalizations.of(context).getTranslatedValue(items[index].name);
    return Container(
      child: Column(
        children: <Widget>[
          GestureDetector(
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return ListCategoriesItemsScreen(
                    categoriesType: items[index].name,
                  );
                },
              ),
            ),
            child: Container(
              margin: EdgeInsets.fromLTRB(10, 10, 0, 10),
              decoration: BoxDecoration(
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
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(
                  items[index].imgUrl,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.white,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes
                            : Icon(Icons.error),
                      ),
                    );
                  },
                  fit: BoxFit.cover,
                  height: 200,
                  width: 175,
                ),
              ),
            ),
          ),
          Text(
            categoryLocale,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey,
              fontSize: 20.0,
            ),
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
