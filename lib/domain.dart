class Domain {
  String key;
  String name;
  int likes;

  Domain(this.key, this.name, this.likes);

  factory Domain.fromMap(String key, Map map) =>
      new Domain(key, map['name'], map['likes']);
}
