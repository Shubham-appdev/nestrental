enum RoomStatus {
  available,
  occupied,
  maintenance,
}

class Room {
  final String id;
  final String buildingId;
  final String roomNumber;
  final RoomStatus status;
  final double rent;
  final int capacity;
  final List<String> amenities;
  final String? tenantId;

  Room({
    required this.id,
    required this.buildingId,
    required this.roomNumber,
    required this.status,
    required this.rent,
    required this.capacity,
    required this.amenities,
    this.tenantId,
  });

  factory Room.fromJson(Map<String, dynamic> json) {
    return Room(
      id: json['id'],
      buildingId: json['buildingId'],
      roomNumber: json['roomNumber'],
      status: RoomStatus.values.firstWhere(
        (e) => e.toString() == 'RoomStatus.${json['status']}',
        orElse: () => RoomStatus.available,
      ),
      rent: json['rent'].toDouble(),
      capacity: json['capacity'],
      amenities: List<String>.from(json['amenities']),
      tenantId: json['tenantId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'buildingId': buildingId,
      'roomNumber': roomNumber,
      'status': status.toString().split('.').last,
      'rent': rent,
      'capacity': capacity,
      'amenities': amenities,
      'tenantId': tenantId,
    };
  }

  Room copyWith({
    String? id,
    String? buildingId,
    String? roomNumber,
    RoomStatus? status,
    double? rent,
    int? capacity,
    List<String>? amenities,
    String? tenantId,
  }) {
    return Room(
      id: id ?? this.id,
      buildingId: buildingId ?? this.buildingId,
      roomNumber: roomNumber ?? this.roomNumber,
      status: status ?? this.status,
      rent: rent ?? this.rent,
      capacity: capacity ?? this.capacity,
      amenities: amenities ?? this.amenities,
      tenantId: tenantId ?? this.tenantId,
    );
  }
}
