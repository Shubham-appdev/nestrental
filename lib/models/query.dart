enum QueryStatus {
  pending,
  resolved,
  inProgress,
}

enum QueryType {
  general,
  maintenance,
  complaint,
  request,
}

class Query {
  final String id;
  final String tenantId;
  final String tenantName;
  final String roomNumber;
  final String buildingId;
  final QueryType type;
  final String subject;
  final String description;
  final QueryStatus status;
  final DateTime createdAt;
  final DateTime? resolvedAt;
  final String? response;

  Query({
    required this.id,
    required this.tenantId,
    required this.tenantName,
    required this.roomNumber,
    required this.buildingId,
    required this.type,
    required this.subject,
    required this.description,
    required this.status,
    required this.createdAt,
    this.resolvedAt,
    this.response,
  });

  factory Query.fromJson(Map<String, dynamic> json) {
    return Query(
      id: json['id'],
      tenantId: json['tenantId'],
      tenantName: json['tenantName'],
      roomNumber: json['roomNumber'],
      buildingId: json['buildingId'],
      type: QueryType.values.firstWhere(
        (e) => e.toString() == 'QueryType.${json['type']}',
        orElse: () => QueryType.general,
      ),
      subject: json['subject'],
      description: json['description'],
      status: QueryStatus.values.firstWhere(
        (e) => e.toString() == 'QueryStatus.${json['status']}',
        orElse: () => QueryStatus.pending,
      ),
      createdAt: DateTime.parse(json['createdAt']),
      resolvedAt:
          json['resolvedAt'] != null ? DateTime.parse(json['resolvedAt']) : null,
      response: json['response'],
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
      'subject': subject,
      'description': description,
      'status': status.toString().split('.').last,
      'createdAt': createdAt.toIso8601String(),
      'resolvedAt': resolvedAt?.toIso8601String(),
      'response': response,
    };
  }

  Query copyWith({
    String? id,
    String? tenantId,
    String? tenantName,
    String? roomNumber,
    String? buildingId,
    QueryType? type,
    String? subject,
    String? description,
    QueryStatus? status,
    DateTime? createdAt,
    DateTime? resolvedAt,
    String? response,
  }) {
    return Query(
      id: id ?? this.id,
      tenantId: tenantId ?? this.tenantId,
      tenantName: tenantName ?? this.tenantName,
      roomNumber: roomNumber ?? this.roomNumber,
      buildingId: buildingId ?? this.buildingId,
      type: type ?? this.type,
      subject: subject ?? this.subject,
      description: description ?? this.description,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      resolvedAt: resolvedAt ?? this.resolvedAt,
      response: response ?? this.response,
    );
  }
}
