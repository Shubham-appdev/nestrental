class Tenant {
  final String id;
  final String name;
  final String phone;
  final String email;
  final String address;
  final String roomId;
  final String buildingId;
  final DateTime moveInDate;
  final DateTime? moveOutDate;
  final double depositAmount;
  final String emergencyContact;
  final String emergencyPhone;

  Tenant({
    required this.id,
    required this.name,
    required this.phone,
    required this.email,
    required this.address,
    required this.roomId,
    required this.buildingId,
    required this.moveInDate,
    this.moveOutDate,
    required this.depositAmount,
    required this.emergencyContact,
    required this.emergencyPhone,
  });

  factory Tenant.fromJson(Map<String, dynamic> json) {
    return Tenant(
      id: json['id'],
      name: json['name'],
      phone: json['phone'],
      email: json['email'],
      address: json['address'],
      roomId: json['roomId'],
      buildingId: json['buildingId'],
      moveInDate: DateTime.parse(json['moveInDate']),
      moveOutDate: json['moveOutDate'] != null
          ? DateTime.parse(json['moveOutDate'])
          : null,
      depositAmount: json['depositAmount'].toDouble(),
      emergencyContact: json['emergencyContact'],
      emergencyPhone: json['emergencyPhone'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'email': email,
      'address': address,
      'roomId': roomId,
      'buildingId': buildingId,
      'moveInDate': moveInDate.toIso8601String(),
      'moveOutDate': moveOutDate?.toIso8601String(),
      'depositAmount': depositAmount,
      'emergencyContact': emergencyContact,
      'emergencyPhone': emergencyPhone,
    };
  }

  Tenant copyWith({
    String? id,
    String? name,
    String? phone,
    String? email,
    String? address,
    String? roomId,
    String? buildingId,
    DateTime? moveInDate,
    DateTime? moveOutDate,
    double? depositAmount,
    String? emergencyContact,
    String? emergencyPhone,
  }) {
    return Tenant(
      id: id ?? this.id,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      address: address ?? this.address,
      roomId: roomId ?? this.roomId,
      buildingId: buildingId ?? this.buildingId,
      moveInDate: moveInDate ?? this.moveInDate,
      moveOutDate: moveOutDate ?? this.moveOutDate,
      depositAmount: depositAmount ?? this.depositAmount,
      emergencyContact: emergencyContact ?? this.emergencyContact,
      emergencyPhone: emergencyPhone ?? this.emergencyPhone,
    );
  }
}
