class CategoryItemsModel {
  String id;
  String name;
  String imgUrl;
  String desc;
  String address;
  String time;
  String token;

  CategoryItemsModel({this.name, this.token});

  CategoryItemsModel.fromMap(Map snapshot, String id)
      : id = id ?? '',
        name = snapshot['nombre'],
        desc = snapshot['desc'],
        address = snapshot['direccion'],
        time = snapshot['horario'] ?? '',
        imgUrl = snapshot['imgUrl'];
}
