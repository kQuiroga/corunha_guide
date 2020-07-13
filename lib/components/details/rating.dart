import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:corunha_guide/app_localizations.dart';
import 'package:corunha_guide/models/category_items_model.dart';
import 'package:corunha_guide/services/rating_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class Rating extends StatefulWidget {
  final String categoryType;
  final String itemName;

  Rating({this.categoryType, this.itemName});

  @override
  _RatingState createState() => _RatingState();
}

class _RatingState extends State<Rating> {
  double rating = 2.5;
  List ratings;
  RatingRepository _ratingRepository = RatingRepository();
  StreamSubscription<QuerySnapshot> subStreamGetRatings;
  var globalRating;

  @override
  void initState() {
    super.initState();
    ratings = List();
    subStreamGetRatings?.cancel();
    subStreamGetRatings = _ratingRepository
        .getRating(widget.categoryType, widget.itemName)
        .listen((QuerySnapshot snapshot) {
      List subStreamValues = snapshot.documents
          .map((e) => CategoryItemsModel.fromMap(e.data, e.documentID))
          .toList();
      setState(() {
        this.ratings = subStreamValues;
        this.globalRating =
            double.parse(ratings.first.mediaRating.toStringAsFixed(2));
      });
    });
  }

  _setRating(double rating) async {
    List<dynamic> valuesToCalculateMedia = await _ratingRepository.sendRating(
        widget.categoryType, rating, widget.itemName);

    final numOfRatings = valuesToCalculateMedia.length;
    var sum = valuesToCalculateMedia
        .map((val) => val.toDouble())
        .fold(0, (previous, current) => previous + current);

    double globalRating = sum / numOfRatings;

    _ratingRepository.updateMediaRating(
        globalRating, widget.itemName, widget.categoryType);

    setState(() {
      this.rating = rating;
      this.globalRating = globalRating.round();
    });
  }

  @override
  Widget build(BuildContext context) {
    String ratingLocale =
        AppLocalizations.of(context).getTranslatedValue('rating');
    String globalRatingLocale =
        AppLocalizations.of(context).getTranslatedValue('rating_global');

    return Column(
      children: <Widget>[
        RatingBar(
          initialRating: rating,
          minRating: 1,
          direction: Axis.horizontal,
          glow: false,
          allowHalfRating: true,
          itemPadding: EdgeInsets.symmetric(horizontal: 0.1),
          onRatingUpdate: (rating) {
            this.rating = rating;
            _setRating(this.rating);
          },
          itemBuilder: (context, _) => Icon(
            Icons.star,
            color: Colors.amber,
          ),
        ),
        Text(ratingLocale + ': $rating'),
        Text(globalRatingLocale + ': $globalRating')
      ],
    );
  }
}
