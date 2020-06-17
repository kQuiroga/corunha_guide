import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryModel {
  String id;
  String name;
  String imgUrl;
  String token;

  CategoryModel({this.name, this.imgUrl, this.token});

  CategoryModel.fromMap(Map snapshot, String id)
      : id = id ?? '',
        name = snapshot['nombre'],
        imgUrl = snapshot['imgUrl'];
}
