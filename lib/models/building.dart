class Building {
  final String id;
  final String name;
  final String address;
  final String imageUrl;
  final int totalRooms;
  final String wifiPassword;

  Building({
    required this.id,
    required this.name,
    required this.address,
    required this.imageUrl,
    required this.totalRooms,
    required this.wifiPassword,
  });

  factory Building.fromJson(Map<String, dynamic> json) {
    return Building(
      id: json['id'],
      name: json['name'],
      address: json['address'],
      imageUrl: json['imageUrl'],
      totalRooms: json['totalRooms'],
      wifiPassword: json['wifiPassword'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'address': address,
      'imageUrl': imageUrl,
      'totalRooms': totalRooms,
      'wifiPassword': wifiPassword,
    };
  }
}
