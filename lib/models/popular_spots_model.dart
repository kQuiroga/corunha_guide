class PopularSpotsModel {
  String id;
  String name;
  String imgUrl;
  String desc;
  String address;
  String imgsLoc;
  double mediaRating;
  List marks;
  String time;
  String token;

  PopularSpotsModel({this.name, this.imgUrl, this.token});

  PopularSpotsModel.fromMap(Map snapshot, String id)
      : id = id ?? '',
        name = snapshot['nombre'],
        desc = snapshot['desc'],
        address = snapshot['direccion'],
        imgsLoc = snapshot['imgsLoc'],
        time = snapshot['horario'] ?? '',
        mediaRating = snapshot['media_rating'],
        marks = snapshot['notas_array'],
        imgUrl = snapshot['imgUrl'];
}
