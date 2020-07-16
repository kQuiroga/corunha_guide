import 'package:corunha_guide/app_localizations.dart';
import 'package:corunha_guide/models/category_items_model.dart';
import 'package:corunha_guide/models/popular_spots_model.dart';
import 'package:corunha_guide/repository/storage_repository.dart';
import 'package:flutter/material.dart';

class PhotoAlbum extends StatelessWidget {
  final CategoryItemsModel itemCategorySelected;
  final PopularSpotsModel itemPopularSelected;
  final String categoryType;

  PhotoAlbum(
      {Key key,
      this.itemCategorySelected,
      this.itemPopularSelected,
      this.categoryType})
      : super(key: key);

  final StorageRepository _repository = StorageRepository();

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;

    if (itemCategorySelected != null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              AppLocalizations.of(context).getTranslatedValue('pictures'),
              style: textTheme.subtitle1.copyWith(fontSize: 18.0),
            ),
          ),
          SizedBox.fromSize(
            size: Size.fromHeight(200.0),
            child: FutureBuilder(
              future: _repository.getFolder(
                  itemCategorySelected: itemCategorySelected,
                  categoryType: categoryType),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data['items'].length,
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.only(top: 8.0, left: 20.0),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.only(right: 16.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(4.0),
                          child: FutureBuilder(
                            future: _repository.getImage(
                                snapshot: snapshot,
                                index: index,
                                categoryType: categoryType,
                                itemCategorySelected: itemCategorySelected),
                            builder: (context, stringSnapshot) {
                              if (snapshot.hasData) {
                                return stringSnapshot.data != null
                                    ? Image.network(
                                        stringSnapshot.data,
                                        loadingBuilder:
                                            (context, child, loadingProgress) {
                                          if (loadingProgress == null)
                                            return child;
                                          return Center(
                                            child: CircularProgressIndicator(
                                              backgroundColor: Colors.blue,
                                              valueColor:
                                                  AlwaysStoppedAnimation<Color>(
                                                      Colors.amber),
                                              value: loadingProgress
                                                          .expectedTotalBytes !=
                                                      null
                                                  ? loadingProgress
                                                          .cumulativeBytesLoaded /
                                                      loadingProgress
                                                          .expectedTotalBytes
                                                  : Icon(
                                                      Icons.error,
                                                      color: Colors.red,
                                                    ),
                                            ),
                                          );
                                        },
                                        fit: BoxFit.cover,
                                      )
                                    : Container();
                              } else {
                                return Icon(Icons.error);
                              }
                            },
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  return Container(
                    height: 4,
                    child: Center(
                      child: LinearProgressIndicator(
                        value: 0.5,
                        backgroundColor: Colors.white,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                      ),
                    ),
                  );
                }
              },
            ),
          ),
        ],
      );
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              AppLocalizations.of(context).getTranslatedValue('pictures'),
              style: textTheme.subtitle1.copyWith(fontSize: 18.0),
            ),
          ),
          SizedBox.fromSize(
            size: Size.fromHeight(200.0),
            child: FutureBuilder(
              future: _repository.getFolderPopularSpot(itemPopularSelected),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data['items'].length,
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.only(top: 8.0, left: 20.0),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.only(right: 16.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(4.0),
                          child: FutureBuilder(
                            future: _repository.getImagePopularSpot(
                                snapshot: snapshot,
                                index: index,
                                itemPopularSelected: itemPopularSelected),
                            builder: (context, stringSnapshot) {
                              if (snapshot.hasData) {
                                return stringSnapshot.data != null
                                    ? Image.network(
                                        stringSnapshot.data,
                                        loadingBuilder:
                                            (context, child, loadingProgress) {
                                          if (loadingProgress == null)
                                            return child;
                                          return Center(
                                            child: CircularProgressIndicator(
                                              backgroundColor: Colors.blue,
                                              valueColor:
                                                  AlwaysStoppedAnimation<Color>(
                                                      Colors.amber),
                                              value: loadingProgress
                                                          .expectedTotalBytes !=
                                                      null
                                                  ? loadingProgress
                                                          .cumulativeBytesLoaded /
                                                      loadingProgress
                                                          .expectedTotalBytes
                                                  : Icon(Icons.error),
                                            ),
                                          );
                                        },
                                        fit: BoxFit.cover,
                                      )
                                    : Container();
                              } else {
                                return Icon(Icons.error);
                              }
                            },
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  return Container(
                    height: 4,
                    child: Center(
                      child: LinearProgressIndicator(
                        value: 0.5,
                        backgroundColor: Colors.white,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                      ),
                    ),
                  );
                }
              },
            ),
          ),
        ],
      );
    }
  }
}
