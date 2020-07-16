import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:corunha_guide/services/general_services.dart';

class RatingRepository {
  static String _sitiosPopulares = 'stitiosPopulares';
  final _db = Firestore.instance;
  final GeneralServices _generalServices = GeneralServices();

  Stream<QuerySnapshot> getRating(String categoryType, String itemName) {
    if (categoryType != '') {
      String category = _generalServices.changeCategoryName(categoryType);
      Stream<QuerySnapshot> querySnap = _db
          .collection(category)
          .where('nombre', isEqualTo: itemName)
          .snapshots();
      return querySnap;
    } else {
      Stream<QuerySnapshot> querySnapPopular = _db
          .collection(_sitiosPopulares)
          .where('nombre', isEqualTo: itemName)
          .snapshots();
      return querySnapPopular;
    }
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

  Future<List<dynamic>> sendRatingPopularSpot(
      double rating, String itemName) async {
    List valuesMedia = List();
    var documentReference;

    final querySnapshot = await _db.collection(_sitiosPopulares).getDocuments();
    final data = querySnapshot.documents..map((e) => e.data);
    data.forEach((e) {
      if (e.data['nombre'] == itemName) {
        documentReference = e.documentID;
      }
    });

    print(documentReference);

    _db.collection(_sitiosPopulares).document(documentReference).updateData({
      'notas_array': FieldValue.arrayUnion([rating])
    });

    final updatedSnapshot = await _db
        .collection(_sitiosPopulares)
        .document(documentReference)
        .get();

    updatedSnapshot.data.forEach((key, value) {
      if (key == 'notas_array') valuesMedia.add(value);
    });

    return valuesMedia[0];
  }

  void updateMediaRating(
      {double media, String itemName, String categoryType}) async {
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

  void updateMediaPopularSpotRating({double media, String itemName}) async {
    var documentReference;

    final querySnapshot = await _db.collection(_sitiosPopulares).getDocuments();
    final data = querySnapshot.documents..map((e) => e.data);

    data.forEach((e) {
      if (e.data['nombre'] == itemName) {
        documentReference = e.documentID;
      }
    });

    _db
        .collection(_sitiosPopulares)
        .document(documentReference)
        .updateData({'media_rating': media});
  }
}
