class SuperHero {
  String id;
  String name;
  String fullName;
  String imageUrl;
  bool isFavorite;

  SuperHero({
    required this.id,
    required this.name,
    required this.fullName,
    required this.imageUrl,
    required this.isFavorite,
  });

  factory SuperHero.fromJson(Map<String, dynamic> json) => SuperHero(
        id: json['id'],
        name: json['name'],
        fullName: json['biography']['full-name'],
        imageUrl: json['image']['url'],
        isFavorite: false,
      );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'image_url': imageUrl,
      'full_name': fullName,
      'is_favorite': 1,
    };
  }

  factory SuperHero.fromDbMap(Map<String, dynamic> map) => SuperHero(
        id: map['id'],
        name: map['name'],
        imageUrl: map['image_url'],
        fullName: map['full_name'],
        isFavorite: map['is_favorite'] == 1 ? true : false,
      );
}
