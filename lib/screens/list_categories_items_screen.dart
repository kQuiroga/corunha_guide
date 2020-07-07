import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:corunha_guide/screens/details_screen.dart';
import 'package:flutter/material.dart';
import 'package:corunha_guide/services/list_categories_items_repository.dart';
import 'package:corunha_guide/models/category_items_model.dart';

class ListCategoriesItemsScreen extends StatefulWidget {
  final String categoriesType;

  ListCategoriesItemsScreen({Key key, this.categoriesType}) : super(key: key);

  @override
  _ListCategoriesItemsScreenState createState() =>
      _ListCategoriesItemsScreenState();
}

class _ListCategoriesItemsScreenState extends State<ListCategoriesItemsScreen> {
  final _repo = ListCategoiresItemsRepository();
  List<CategoryItemsModel> items;
  StreamSubscription<QuerySnapshot> categoriesItemsSub;

  @override
  void initState() {
    super.initState();
    items = List();
    categoriesItemsSub?.cancel();
    categoriesItemsSub = _repo
        .getCategoryItems(widget.categoriesType)
        .listen((QuerySnapshot snapshot) {
      final List<CategoryItemsModel> categories = snapshot.documents
          .map((documentsSnapshot) => CategoryItemsModel.fromMap(
              documentsSnapshot.data, documentsSnapshot.documentID))
          .toList();
      setState(() {
        this.items = categories;
      });
    });
  }

  Widget _buildListItems(BuildContext context, int index) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (BuildContext context) {
            return DetailsScreen(
              itemSelected: items[index],
            );
          },
        ),
      ),
      child: Card(
        elevation: 8.0,
        shadowColor: Colors.black87,
        margin: EdgeInsets.symmetric(
          horizontal: 10.0,
          vertical: 10.0,
        ),
        child: Center(
          child: Stack(
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                child: Image.network(
                  items[index].imgUrl,
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                alignment: Alignment.center,
                child: Text(
                  items[index].name,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 22.0),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.categoriesType),
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return _buildListItems(context, index);
        },
      ),
    );
  }
}
