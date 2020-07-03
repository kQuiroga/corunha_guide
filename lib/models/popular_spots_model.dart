class PopularSpotsModel {
  String id;
  String name;
  String imgUrl;
  String token;

  PopularSpotsModel({this.name, this.imgUrl, this.token});

  PopularSpotsModel.fromMap(Map snapshot, String id)
      : id = id ?? '',
        name = snapshot['nombre'],
        imgUrl = snapshot['imgUrl'];
}
