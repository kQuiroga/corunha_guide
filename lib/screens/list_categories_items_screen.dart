import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
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
    return Card(
      elevation: 5.0,
      shadowColor: Colors.black38,
      margin: EdgeInsets.symmetric(
        horizontal: 10.0,
        vertical: 10.0,
      ),
      child: ListTile(
        trailing: Icon(Icons.keyboard_arrow_right),
        contentPadding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width / 40,
          vertical: MediaQuery.of(context).size.width / 40,
        ),
        leading: CircleAvatar(
          radius: 30.0,
        ),
        title: Text(
          items[index].name,
        ),
        subtitle: Text('Breve Descripción'),
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
