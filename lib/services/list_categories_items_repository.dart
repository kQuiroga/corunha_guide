import 'package:cloud_firestore/cloud_firestore.dart';

class ListCategoiresItemsRepository {
  final _db = Firestore.instance;

  Stream<QuerySnapshot> getCategoryItems(String category) {
    String query;

    if (category.toLowerCase() == 'playas') query = 'listado_playas';

    if (category.toLowerCase() == 'monumentos') query = 'listado_monumentos';

    if (category.toLowerCase() == 'museos') query = 'listado_museos';

    if (category.toLowerCase() == 'restaurantes')
      query = 'listado_restaurantes';

    Stream<QuerySnapshot> snapshot = _db.collection(query).snapshots();
    return snapshot;
  }
}
