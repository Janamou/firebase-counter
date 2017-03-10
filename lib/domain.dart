class Domain {
  String key;
  String name;
  int favourites;

  Domain(this.key, this.name, this.favourites);

  factory Domain.fromMap(String key, Map map) =>
      new Domain(key, map["name"], map["favourites"]);
}
