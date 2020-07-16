import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:corunha_guide/services/general_services.dart';

class ListCategoiresItemsRepository {
  final _db = Firestore.instance;
  final _generalServices = GeneralServices();

  Stream<QuerySnapshot> getCategoryItems(String category) {
    String query;

    query = _generalServices.changeCategoryName(category);

    Stream<QuerySnapshot> snapshot = _db.collection(query).snapshots();
    return snapshot;
  }
}
