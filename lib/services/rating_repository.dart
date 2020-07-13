import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:corunha_guide/services/general_services.dart';

class RatingRepository {
  final _db = Firestore.instance;
  final GeneralServices _generalServices = GeneralServices();

  Stream<QuerySnapshot> getRating(String categoryType, String itemName) {
    String category = _generalServices.changeCategoryName(categoryType);

    return _db
        .collection(category)
        .where('nombre', isEqualTo: itemName)
        .snapshots();
  }

  Future<List<dynamic>> sendRating(
      String categoryType, double rating, String itemName) async {
    String category = _generalServices.changeCategoryName(categoryType);
    List valuesMedia = List();
    var documentReference;
    var finalData;

    final snapshot = await _db.collection(category).getDocuments();
    var data = snapshot.documents..map((e) => e.data);
    var document = data.map((e) {
      if (e.data['nombre'] == itemName) {
        documentReference = e.documentID;
        finalData = e.data;
        return finalData;
      }
    });

    print(document);

    _db.collection(category).document(documentReference).updateData({
      'notas_array': FieldValue.arrayUnion([rating])
    });

    var updatedSnapshot =
        await _db.collection(category).document(documentReference).get();

    updatedSnapshot.data.forEach((key, value) {
      if (key == 'notas_array') valuesMedia.add(value);
    });

    return valuesMedia[0];
  }

  void updateMediaRating(
      double media, String itemName, String categoryType) async {
    String category = _generalServices.changeCategoryName(categoryType);
    var documentReference;

    final querySnapshot = await _db.collection(category).getDocuments();
    var data = querySnapshot.documents..map((e) => e.data);

    data.forEach((e) {
      if (e.data['nombre'] == itemName) {
        documentReference = e.documentID;
      }
    });

    _db
        .collection(category)
        .document(documentReference)
        .updateData({'media_rating': media});
  }
}
