import 'package:corunha_guide/models/category_items_model.dart';
import 'package:corunha_guide/services/storage_repository.dart';
import 'package:flutter/material.dart';

class PhotoAlbum extends StatelessWidget {
  final CategoryItemsModel itemSelected;
  final String categoryType;

  PhotoAlbum({Key key, this.itemSelected, this.categoryType}) : super(key: key);

  final StorageRepository _repository = StorageRepository();

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Text(
            'Fotos',
            style: textTheme.subtitle1.copyWith(fontSize: 18.0),
          ),
        ),
        SizedBox.fromSize(
          size: Size.fromHeight(100.0),
          child: FutureBuilder(
            future: _repository.getFolder(itemSelected, categoryType),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data['items'].length,
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.only(top: 8.0, left: 20.0),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 16.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(4.0),
                        child: FutureBuilder(
                          future: _repository.getImage(
                              snapshot, index, categoryType, itemSelected),
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
                                      width: 200.0,
                                      height: 200.0,
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
