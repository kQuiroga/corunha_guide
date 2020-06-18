import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';

class CrudCategory {
  final _db = Firestore.instance;

  Stream<QuerySnapshot> getCategoriesList() {
    Stream<QuerySnapshot> snapshots = _db.collection('categorias').snapshots();
    return snapshots;
  }
}
