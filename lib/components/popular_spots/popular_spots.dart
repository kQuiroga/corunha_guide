import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:corunha_guide/screens/details_screen.dart';
import 'package:corunha_guide/repository/crud_category.dart';
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
          GestureDetector(
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return DetailsScreen(
                    itemPopularSelected: items[index],
                  );
                },
              ),
            ),
            child: Container(
              height: 200,
              width: 200,
              margin: EdgeInsets.fromLTRB(10, 10, 0, 10),
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(items[index].imgUrl),
                    fit: BoxFit.cover),
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
