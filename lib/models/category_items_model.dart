class CategoryItemsModel {
  String id;
  String name;
  String token;

  CategoryItemsModel({this.name, this.token});

  CategoryItemsModel.fromMap(Map snapshot, String id)
      : id = id ?? '',
        name = snapshot['nombre'];
}
