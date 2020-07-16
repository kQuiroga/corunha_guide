import 'package:corunha_guide/models/category_items_model.dart';
import 'package:corunha_guide/models/popular_spots_model.dart';
import 'package:corunha_guide/services/general_services.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';

class StorageRepository {
  final GeneralServices _generalServices = GeneralServices();

  getFolder(
      {CategoryItemsModel itemCategorySelected, String categoryType}) async {
    var folder = _generalServices.changeCategoryName(categoryType);
    var ref = FirebaseStorage.instance
        .ref()
        .child(folder)
        .child(itemCategorySelected.imgsLoc);

    return await ref.listAll();
  }

  getFolderPopularSpot(PopularSpotsModel itemPopularSelected) async {
    return await FirebaseStorage.instance
        .ref()
        .child('sitiosPopulares')
        .child(itemPopularSelected.imgsLoc)
        .listAll();
  }

  Future<String> getImage({
    AsyncSnapshot snapshot,
    int index,
    String categoryType,
    CategoryItemsModel itemCategorySelected,
  }) async {
    final ref = FirebaseStorage.instance
        .ref()
        .child(_generalServices.changeCategoryName(categoryType))
        .child(itemCategorySelected.imgsLoc)
        .child(snapshot.data['items']['image_${index + 1}.jpg']['name']);

    return await ref.getDownloadURL() as String;
  }

  Future<String> getImagePopularSpot(
      {AsyncSnapshot snapshot,
      int index,
      PopularSpotsModel itemPopularSelected}) async {
    final ref = FirebaseStorage.instance
        .ref()
        .child('sitiosPopulares')
        .child(itemPopularSelected.imgsLoc)
        .child(snapshot.data['items']['image_${index + 1}.jpg']['name']);

    return await ref.getDownloadURL() as String;
  }
}
