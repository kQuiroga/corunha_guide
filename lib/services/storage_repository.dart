import 'package:corunha_guide/models/category_items_model.dart';
import 'package:corunha_guide/services/general_services.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';

class StorageRepository {
  final GeneralServices _generalServices = GeneralServices();

  getFolder(CategoryItemsModel itemSelected, String categoryType) async {
    var folder = _generalServices.changeCategoryName(categoryType);
    var ref = FirebaseStorage.instance
        .ref()
        .child(folder)
        .child(itemSelected.imgsLoc);

    return await ref.listAll();
  }

  Future<String> getImage(AsyncSnapshot snapshot, int index,
      String categoryType, CategoryItemsModel itemSelected) async {
    final ref = FirebaseStorage.instance
        .ref()
        .child(_generalServices.changeCategoryName(categoryType))
        .child(itemSelected.imgsLoc)
        .child(snapshot.data['items']['image_${index + 1}.jpg']['name']);

    return await ref.getDownloadURL() as String;
  }
}
