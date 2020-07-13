import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:corunha_guide/services/crud_category.dart';
import 'package:flutter/material.dart';
import 'package:corunha_guide/models/popular_spots_model.dart';

class PopularSpots extends StatefulWidget {
  @override
  _PopularSpotsState createState() => _PopularSpotsState();
}

class _PopularSpotsState extends State<PopularSpots> {
  List<PopularSpotsModel> items;
  CrudCategory _crud = CrudCategory();
  StreamSubscription<QuerySnapshot> pupularSpotsSub;

  @override
  void initState() {
    super.initState();
    items = List();
    pupularSpotsSub?.cancel();
    pupularSpotsSub =
        _crud.getPopularSpotsList().listen((QuerySnapshot snapshot) {
      final List<PopularSpotsModel> categories = snapshot.documents
          .map((documentsSnapshot) => PopularSpotsModel.fromMap(
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
            width: 200,
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
          Text(
            "${items[index].name}",
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
    return Container(
      child: Expanded(
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemCount: items.length,
          itemBuilder: (context, index) {
            return _buildListItem(context, index);
          },
        ),
      ),
    );
  }
}
