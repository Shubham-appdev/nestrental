enum CleaningStatus {
  pending,
  scheduled,
  completed,
  cancelled,
}

enum CleaningType {
  regular,
  deep,
  emergency,
}

class CleaningRequest {
  final String id;
  final String tenantId;
  final String tenantName;
  final String roomNumber;
  final String buildingId;
  final CleaningType type;
  final CleaningStatus status;
  final DateTime requestedDate;
  final DateTime? scheduledDate;
  final String? notes;
  final DateTime createdAt;

  CleaningRequest({
    required this.id,
    required this.tenantId,
    required this.tenantName,
    required this.roomNumber,
    required this.buildingId,
    required this.type,
    required this.status,
    required this.requestedDate,
    this.scheduledDate,
    this.notes,
    required this.createdAt,
  });

  factory CleaningRequest.fromJson(Map<String, dynamic> json) {
    return CleaningRequest(
      id: json['id'],
      tenantId: json['tenantId'],
      tenantName: json['tenantName'],
      roomNumber: json['roomNumber'],
      buildingId: json['buildingId'],
      type: CleaningType.values.firstWhere(
        (e) => e.toString() == 'CleaningType.${json['type']}',
        orElse: () => CleaningType.regular,
      ),
      status: CleaningStatus.values.firstWhere(
        (e) => e.toString() == 'CleaningStatus.${json['status']}',
        orElse: () => CleaningStatus.pending,
      ),
      requestedDate: DateTime.parse(json['requestedDate']),
      scheduledDate: json['scheduledDate'] != null
          ? DateTime.parse(json['scheduledDate'])
          : null,
      notes: json['notes'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'tenantId': tenantId,
      'tenantName': tenantName,
      'roomNumber': roomNumber,
      'buildingId': buildingId,
      'type': type.toString().split('.').last,
      'status': status.toString().split('.').last,
      'requestedDate': requestedDate.toIso8601String(),
      'scheduledDate': scheduledDate?.toIso8601String(),
      'notes': notes,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  CleaningRequest copyWith({
    String? id,
    String? tenantId,
    String? tenantName,
    String? roomNumber,
    String? buildingId,
    CleaningType? type,
    CleaningStatus? status,
    DateTime? requestedDate,
    DateTime? scheduledDate,
    String? notes,
    DateTime? createdAt,
  }) {
    return CleaningRequest(
      id: id ?? this.id,
      tenantId: tenantId ?? this.tenantId,
      tenantName: tenantName ?? this.tenantName,
      roomNumber: roomNumber ?? this.roomNumber,
      buildingId: buildingId ?? this.buildingId,
      type: type ?? this.type,
      status: status ?? this.status,
      requestedDate: requestedDate ?? this.requestedDate,
      scheduledDate: scheduledDate ?? this.scheduledDate,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
