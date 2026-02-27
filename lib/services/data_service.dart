import '../models/building.dart';
import '../models/room.dart';
import '../models/tenant.dart';
import '../models/query.dart';
import '../models/cleaning_request.dart';
import '../models/gate_pass.dart';
import '../models/rent_payment.dart';
import '../models/notice.dart';
import '../models/emergency_contact.dart';
import '../models/tenant_registration.dart';
import '../models/chat_message.dart';

// Export all enums for easy access
export '../models/room.dart' show RoomStatus;
export '../models/query.dart' show QueryStatus, QueryType;
export '../models/cleaning_request.dart' show CleaningStatus, CleaningType;
export '../models/gate_pass.dart' show GatePassStatus, GatePassType;
export '../models/rent_payment.dart' show PaymentStatus, PaymentMethod;
export '../models/notice.dart' show NoticePriority;
export '../models/emergency_contact.dart' show ContactType;
export '../models/tenant_registration.dart' show RegistrationStatus;

class DataService {
  static final DataService _instance = DataService._internal();
  factory DataService() => _instance;
  DataService._internal();

  final List<Building> _buildings = [];
  final List<Room> _rooms = [];
  final List<Tenant> _tenants = [];
  final List<Query> _queries = [];
  final List<CleaningRequest> _cleaningRequests = [];
  final List<GatePass> _gatePasses = [];
  final List<RentPayment> _rentPayments = [];
  final List<Notice> _notices = [];
  final List<EmergencyContact> _emergencyContacts = [];
  final List<TenantRegistration> _tenantRegistrations = [];
  final List<ChatMessage> _chatMessages = [];

  bool _initialized = false;

  void initialize() {
    if (_initialized) return;

    // Building 1
    _buildings.add(Building(
      id: 'b1',
      name: 'Sunrise Residency',
      address: '123 Main Street, Delhi',
      imageUrl: 'https://images.unsplash.com/photo-1545324418-cc1a3fa10c00?w=400',
      totalRooms: 20,
      wifiPassword: 'Sunrise@2024',
    ));

    // Building 2
    _buildings.add(Building(
      id: 'b2',
      name: 'Moonlight Apartments',
      address: '456 Park Avenue, Mumbai',
      imageUrl: 'https://images.unsplash.com/photo-1512917774080-9991f1c4c750?w=400',
      totalRooms: 15,
      wifiPassword: 'Moonlight@2024',
    ));

    // Building 3
    _buildings.add(Building(
      id: 'b3',
      name: 'Green Valley PG',
      address: '789 Garden Road, Bangalore',
      imageUrl: 'https://images.unsplash.com/photo-1570129477492-45c003edd2be?w=400',
      totalRooms: 25,
      wifiPassword: 'GreenValley@2024',
    ));

    // Rooms for Building 1
    for (int i = 1; i <= 10; i++) {
      _rooms.add(Room(
        id: 'b1_r$i',
        buildingId: 'b1',
        roomNumber: '10$i',
        status: i <= 6 ? RoomStatus.occupied : RoomStatus.available,
        rent: 8000 + (i * 500),
        capacity: 2,
        amenities: ['AC', 'TV', 'WiFi', 'Attached Bathroom'],
        tenantId: i <= 6 ? 't$i' : null,
      ));
    }

    // Rooms for Building 2
    for (int i = 1; i <= 8; i++) {
      _rooms.add(Room(
        id: 'b2_r$i',
        buildingId: 'b2',
        roomNumber: '20$i',
        status: i <= 5 ? RoomStatus.occupied : RoomStatus.available,
        rent: 10000 + (i * 500),
        capacity: 2,
        amenities: ['AC', 'TV', 'WiFi', 'Geyser', 'Attached Bathroom'],
        tenantId: i <= 5 ? 't${i + 10}' : null,
      ));
    }

    // Rooms for Building 3
    for (int i = 1; i <= 12; i++) {
      _rooms.add(Room(
        id: 'b3_r$i',
        buildingId: 'b3',
        roomNumber: '30$i',
        status: i <= 8 ? RoomStatus.occupied : RoomStatus.available,
        rent: 7000 + (i * 300),
        capacity: 3,
        amenities: ['Fan', 'WiFi', 'Common Bathroom', 'Study Table'],
        tenantId: i <= 8 ? 't${i + 20}' : null,
      ));
    }

    // Tenants for Building 1
    _tenants.add(Tenant(
      id: 't1',
      name: 'Rahul Sharma',
      phone: '9876543210',
      email: 'rahul.sharma@email.com',
      address: 'Jaipur, Rajasthan',
      roomId: 'b1_r1',
      buildingId: 'b1',
      moveInDate: DateTime(2024, 1, 15),
      depositAmount: 16000,
      emergencyContact: 'Suresh Sharma',
      emergencyPhone: '9876543211',
    ));

    _tenants.add(Tenant(
      id: 't2',
      name: 'Priya Patel',
      phone: '9876543220',
      email: 'priya.patel@email.com',
      address: 'Ahmedabad, Gujarat',
      roomId: 'b1_r2',
      buildingId: 'b1',
      moveInDate: DateTime(2024, 2, 1),
      depositAmount: 17000,
      emergencyContact: 'Meena Patel',
      emergencyPhone: '9876543221',
    ));

    _tenants.add(Tenant(
      id: 't3',
      name: 'Amit Kumar',
      phone: '9876543230',
      email: 'amit.kumar@email.com',
      address: 'Patna, Bihar',
      roomId: 'b1_r3',
      buildingId: 'b1',
      moveInDate: DateTime(2024, 1, 20),
      depositAmount: 18000,
      emergencyContact: 'Sunita Kumar',
      emergencyPhone: '9876543231',
    ));

    _tenants.add(Tenant(
      id: 't4',
      name: 'Sneha Gupta',
      phone: '9876543240',
      email: 'sneha.gupta@email.com',
      address: 'Lucknow, UP',
      roomId: 'b1_r4',
      buildingId: 'b1',
      moveInDate: DateTime(2024, 3, 1),
      depositAmount: 19000,
      emergencyContact: 'Rajesh Gupta',
      emergencyPhone: '9876543241',
    ));

    _tenants.add(Tenant(
      id: 't5',
      name: 'Vikram Singh',
      phone: '9876543250',
      email: 'vikram.singh@email.com',
      address: 'Chandigarh',
      roomId: 'b1_r5',
      buildingId: 'b1',
      moveInDate: DateTime(2024, 2, 15),
      depositAmount: 20000,
      emergencyContact: 'Kiran Singh',
      emergencyPhone: '9876543251',
    ));

    _tenants.add(Tenant(
      id: 't6',
      name: 'Neha Reddy',
      phone: '9876543260',
      email: 'neha.reddy@email.com',
      address: 'Hyderabad, Telangana',
      roomId: 'b1_r6',
      buildingId: 'b1',
      moveInDate: DateTime(2024, 3, 10),
      depositAmount: 21000,
      emergencyContact: 'Ramesh Reddy',
      emergencyPhone: '9876543261',
    ));

    // Tenants for Building 2
    _tenants.add(Tenant(
      id: 't11',
      name: 'Arjun Mehta',
      phone: '9876543310',
      email: 'arjun.mehta@email.com',
      address: 'Pune, Maharashtra',
      roomId: 'b2_r1',
      buildingId: 'b2',
      moveInDate: DateTime(2024, 1, 5),
      depositAmount: 20000,
      emergencyContact: 'Priya Mehta',
      emergencyPhone: '9876543311',
    ));

    _tenants.add(Tenant(
      id: 't12',
      name: 'Kavita Joshi',
      phone: '9876543320',
      email: 'kavita.joshi@email.com',
      address: 'Nagpur, Maharashtra',
      roomId: 'b2_r2',
      buildingId: 'b2',
      moveInDate: DateTime(2024, 2, 20),
      depositAmount: 21000,
      emergencyContact: 'Anil Joshi',
      emergencyPhone: '9876543321',
    ));

    _tenants.add(Tenant(
      id: 't13',
      name: 'Raj Malhotra',
      phone: '9876543330',
      email: 'raj.malhotra@email.com',
      address: 'Indore, MP',
      roomId: 'b2_r3',
      buildingId: 'b2',
      moveInDate: DateTime(2024, 1, 25),
      depositAmount: 22000,
      emergencyContact: 'Sonia Malhotra',
      emergencyPhone: '9876543331',
    ));

    _tenants.add(Tenant(
      id: 't14',
      name: 'Divya Nair',
      phone: '9876543340',
      email: 'divya.nair@email.com',
      address: 'Kochi, Kerala',
      roomId: 'b2_r4',
      buildingId: 'b2',
      moveInDate: DateTime(2024, 3, 5),
      depositAmount: 23000,
      emergencyContact: 'Suresh Nair',
      emergencyPhone: '9876543341',
    ));

    _tenants.add(Tenant(
      id: 't15',
      name: 'Karan Verma',
      phone: '9876543350',
      email: 'karan.verma@email.com',
      address: 'Bhopal, MP',
      roomId: 'b2_r5',
      buildingId: 'b2',
      moveInDate: DateTime(2024, 2, 10),
      depositAmount: 24000,
      emergencyContact: 'Anita Verma',
      emergencyPhone: '9876543351',
    ));

    // Tenants for Building 3
    _tenants.add(Tenant(
      id: 't21',
      name: 'Manish Das',
      phone: '9876543410',
      email: 'manish.das@email.com',
      address: 'Kolkata, WB',
      roomId: 'b3_r1',
      buildingId: 'b3',
      moveInDate: DateTime(2024, 1, 10),
      depositAmount: 14000,
      emergencyContact: 'Rita Das',
      emergencyPhone: '9876543411',
    ));

    _tenants.add(Tenant(
      id: 't22',
      name: 'Ananya Bose',
      phone: '9876543420',
      email: 'ananya.bose@email.com',
      address: 'Siliguri, WB',
      roomId: 'b3_r2',
      buildingId: 'b3',
      moveInDate: DateTime(2024, 2, 5),
      depositAmount: 14300,
      emergencyContact: 'Pradip Bose',
      emergencyPhone: '9876543421',
    ));

    _tenants.add(Tenant(
      id: 't23',
      name: 'Siddharth Roy',
      phone: '9876543430',
      email: 'siddharth.roy@email.com',
      address: 'Guwahati, Assam',
      roomId: 'b3_r3',
      buildingId: 'b3',
      moveInDate: DateTime(2024, 1, 30),
      depositAmount: 14600,
      emergencyContact: 'Mitali Roy',
      emergencyPhone: '9876543431',
    ));

    _tenants.add(Tenant(
      id: 't24',
      name: 'Pooja Iyer',
      phone: '9876543440',
      email: 'pooja.iyer@email.com',
      address: 'Chennai, Tamil Nadu',
      roomId: 'b3_r4',
      buildingId: 'b3',
      moveInDate: DateTime(2024, 3, 15),
      depositAmount: 14900,
      emergencyContact: 'Venkat Iyer',
      emergencyPhone: '9876543441',
    ));

    _tenants.add(Tenant(
      id: 't25',
      name: 'Harsh Jain',
      phone: '9876543450',
      email: 'harsh.jain@email.com',
      address: 'Bhubaneswar, Odisha',
      roomId: 'b3_r5',
      buildingId: 'b3',
      moveInDate: DateTime(2024, 2, 25),
      depositAmount: 15200,
      emergencyContact: 'Sneha Jain',
      emergencyPhone: '9876543451',
    ));

    _tenants.add(Tenant(
      id: 't26',
      name: 'Meera Krishnan',
      phone: '9876543460',
      email: 'meera.krishnan@email.com',
      address: 'Coimbatore, Tamil Nadu',
      roomId: 'b3_r6',
      buildingId: 'b3',
      moveInDate: DateTime(2024, 1, 18),
      depositAmount: 15500,
      emergencyContact: 'Krishnan Iyer',
      emergencyPhone: '9876543461',
    ));

    _tenants.add(Tenant(
      id: 't27',
      name: 'Naveen Prasad',
      phone: '9876543470',
      email: 'naveen.prasad@email.com',
      address: 'Mysore, Karnataka',
      roomId: 'b3_r7',
      buildingId: 'b3',
      moveInDate: DateTime(2024, 3, 1),
      depositAmount: 15800,
      emergencyContact: 'Lakshmi Prasad',
      emergencyPhone: '9876543471',
    ));

    _tenants.add(Tenant(
      id: 't28',
      name: 'Shalini Rao',
      phone: '9876543480',
      email: 'shalini.rao@email.com',
      address: 'Mangalore, Karnataka',
      roomId: 'b3_r8',
      buildingId: 'b3',
      moveInDate: DateTime(2024, 2, 12),
      depositAmount: 16100,
      emergencyContact: 'Raghav Rao',
      emergencyPhone: '9876543481',
    ));

    // Sample Queries
    _queries.add(Query(
      id: 'q1',
      tenantId: 't1',
      tenantName: 'Rahul Sharma',
      roomNumber: '101',
      buildingId: 'b1',
      type: QueryType.maintenance,
      subject: 'AC not working properly',
      description: 'The AC in my room is making noise and not cooling properly.',
      status: QueryStatus.inProgress,
      createdAt: DateTime.now().subtract(const Duration(days: 2)),
    ));

    _queries.add(Query(
      id: 'q2',
      tenantId: 't2',
      tenantName: 'Priya Patel',
      roomNumber: '102',
      buildingId: 'b1',
      type: QueryType.general,
      subject: 'WiFi password change',
      description: 'Can you please share the updated WiFi password?',
      status: QueryStatus.resolved,
      createdAt: DateTime.now().subtract(const Duration(days: 5)),
      resolvedAt: DateTime.now().subtract(const Duration(days: 4)),
      response: 'WiFi password is: Sunrise@2024',
    ));

    _queries.add(Query(
      id: 'q3',
      tenantId: 't11',
      tenantName: 'Arjun Mehta',
      roomNumber: '201',
      buildingId: 'b2',
      type: QueryType.complaint,
      subject: 'Noise complaint',
      description: 'There is loud music playing in the room next door at night.',
      status: QueryStatus.pending,
      createdAt: DateTime.now().subtract(const Duration(hours: 12)),
    ));

    // Sample Cleaning Requests
    _cleaningRequests.add(CleaningRequest(
      id: 'c1',
      tenantId: 't3',
      tenantName: 'Amit Kumar',
      roomNumber: '103',
      buildingId: 'b1',
      type: CleaningType.regular,
      status: CleaningStatus.scheduled,
      requestedDate: DateTime.now().add(const Duration(days: 1)),
      scheduledDate: DateTime.now().add(const Duration(days: 1)),
      notes: 'Please come in the morning',
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
    ));

    _cleaningRequests.add(CleaningRequest(
      id: 'c2',
      tenantId: 't12',
      tenantName: 'Kavita Joshi',
      roomNumber: '202',
      buildingId: 'b2',
      type: CleaningType.deep,
      status: CleaningStatus.pending,
      requestedDate: DateTime.now().add(const Duration(days: 3)),
      notes: 'Need deep cleaning before weekend',
      createdAt: DateTime.now().subtract(const Duration(hours: 6)),
    ));

    // Sample Gate Passes
    _gatePasses.add(GatePass(
      id: 'gp1',
      tenantId: 't1',
      tenantName: 'Rahul Sharma',
      roomNumber: '101',
      buildingId: 'b1',
      type: GatePassType.exit,
      status: GatePassStatus.approved,
      purpose: 'Weekend trip to hometown',
      validFrom: DateTime.now().subtract(const Duration(hours: 2)),
      validUntil: DateTime.now().add(const Duration(days: 2)),
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
      approvedAt: DateTime.now().subtract(const Duration(hours: 1)),
      approvedBy: 'Admin',
    ));

    _gatePasses.add(GatePass(
      id: 'gp2',
      tenantId: 't11',
      tenantName: 'Arjun Mehta',
      roomNumber: '201',
      buildingId: 'b2',
      type: GatePassType.entry,
      status: GatePassStatus.pending,
      purpose: 'Late night entry',
      validFrom: DateTime.now().add(const Duration(hours: 4)),
      validUntil: DateTime.now().add(const Duration(hours: 6)),
      visitorName: 'Guest Visitor',
      visitorPhone: '9876549999',
      createdAt: DateTime.now().subtract(const Duration(hours: 2)),
    ));

    _initialized = true;
  }

  // Buildings
  List<Building> getBuildings() => List.unmodifiable(_buildings);

  Building? getBuildingById(String id) {
    try {
      return _buildings.firstWhere((b) => b.id == id);
    } catch (e) {
      return null;
    }
  }

  // Rooms
  List<Room> getRooms() => List.unmodifiable(_rooms);

  List<Room> getRoomsByBuilding(String buildingId) {
    return _rooms.where((r) => r.buildingId == buildingId).toList();
  }

  Room? getRoomById(String id) {
    try {
      return _rooms.firstWhere((r) => r.id == id);
    } catch (e) {
      return null;
    }
  }

  void updateRoom(Room room) {
    final index = _rooms.indexWhere((r) => r.id == room.id);
    if (index != -1) {
      _rooms[index] = room;
    }
  }

  // Tenants
  List<Tenant> getTenants() => List.unmodifiable(_tenants);

  List<Tenant> getTenantsByBuilding(String buildingId) {
    return _tenants.where((t) => t.buildingId == buildingId).toList();
  }

  Tenant? getTenantById(String id) {
    try {
      return _tenants.firstWhere((t) => t.id == id);
    } catch (e) {
      return null;
    }
  }

  Tenant? getTenantByRoom(String roomId) {
    try {
      return _tenants.firstWhere((t) => t.roomId == roomId);
    } catch (e) {
      return null;
    }
  }

  void addTenant(Tenant tenant) {
    _tenants.add(tenant);
    // Update room status
    final roomIndex = _rooms.indexWhere((r) => r.id == tenant.roomId);
    if (roomIndex != -1) {
      _rooms[roomIndex] = _rooms[roomIndex].copyWith(
        status: RoomStatus.occupied,
        tenantId: tenant.id,
      );
    }
  }

  void updateTenant(Tenant tenant) {
    final index = _tenants.indexWhere((t) => t.id == tenant.id);
    if (index != -1) {
      _tenants[index] = tenant;
    }
  }

  void removeTenant(String tenantId) {
    final tenant = getTenantById(tenantId);
    if (tenant != null) {
      // Update room status
      final roomIndex = _rooms.indexWhere((r) => r.id == tenant.roomId);
      if (roomIndex != -1) {
        _rooms[roomIndex] = _rooms[roomIndex].copyWith(
          status: RoomStatus.available,
          tenantId: null,
        );
      }
      _tenants.removeWhere((t) => t.id == tenantId);
    }
  }

  // Queries
  List<Query> getQueries() => List.unmodifiable(_queries);

  List<Query> getQueriesByBuilding(String buildingId) {
    return _queries.where((q) => q.buildingId == buildingId).toList();
  }

  void addQuery(Query query) {
    _queries.add(query);
  }

  void updateQuery(Query query) {
    final index = _queries.indexWhere((q) => q.id == query.id);
    if (index != -1) {
      _queries[index] = query;
    }
  }

  // Cleaning Requests
  List<CleaningRequest> getCleaningRequests() =>
      List.unmodifiable(_cleaningRequests);

  List<CleaningRequest> getCleaningRequestsByBuilding(String buildingId) {
    return _cleaningRequests.where((c) => c.buildingId == buildingId).toList();
  }

  void addCleaningRequest(CleaningRequest request) {
    _cleaningRequests.add(request);
  }

  void updateCleaningRequest(CleaningRequest request) {
    final index = _cleaningRequests.indexWhere((c) => c.id == request.id);
    if (index != -1) {
      _cleaningRequests[index] = request;
    }
  }

  // Gate Passes
  List<GatePass> getGatePasses() => List.unmodifiable(_gatePasses);

  List<GatePass> getGatePassesByBuilding(String buildingId) {
    return _gatePasses.where((g) => g.buildingId == buildingId).toList();
  }

  void addGatePass(GatePass gatePass) {
    _gatePasses.add(gatePass);
  }

  void updateGatePass(GatePass gatePass) {
    final index = _gatePasses.indexWhere((g) => g.id == gatePass.id);
    if (index != -1) {
      _gatePasses[index] = gatePass;
    }
  }

  // Rent Payments
  List<RentPayment> getRentPayments() => List.unmodifiable(_rentPayments);

  List<RentPayment> getRentPaymentsByTenant(String tenantId) {
    return _rentPayments.where((p) => p.tenantId == tenantId).toList();
  }

  List<RentPayment> getRentPaymentsByBuilding(String buildingId) {
    return _rentPayments.where((p) => p.buildingId == buildingId).toList();
  }

  void addRentPayment(RentPayment payment) {
    _rentPayments.add(payment);
  }

  void updateRentPayment(RentPayment payment) {
    final index = _rentPayments.indexWhere((p) => p.id == payment.id);
    if (index != -1) {
      _rentPayments[index] = payment;
    }
  }

  // Notices
  List<Notice> getNotices() => List.unmodifiable(_notices);

  List<Notice> getNoticesByBuilding(String? buildingId) {
    if (buildingId == null) {
      return _notices.where((n) => n.buildingId == null).toList();
    }
    return _notices
        .where((n) => n.buildingId == null || n.buildingId == buildingId)
        .toList();
  }

  void addNotice(Notice notice) {
    _notices.add(notice);
  }

  void updateNotice(Notice notice) {
    final index = _notices.indexWhere((n) => n.id == notice.id);
    if (index != -1) {
      _notices[index] = notice;
    }
  }

  void deleteNotice(String id) {
    _notices.removeWhere((n) => n.id == id);
  }

  // Emergency Contacts
  List<EmergencyContact> getEmergencyContacts() =>
      List.unmodifiable(_emergencyContacts);

  List<EmergencyContact> getEmergencyContactsByBuilding(String? buildingId) {
    if (buildingId == null) {
      return _emergencyContacts.where((c) => c.buildingId == null).toList();
    }
    return _emergencyContacts
        .where((c) => c.buildingId == null || c.buildingId == buildingId)
        .toList();
  }

  void addEmergencyContact(EmergencyContact contact) {
    _emergencyContacts.add(contact);
  }

  void updateEmergencyContact(EmergencyContact contact) {
    final index = _emergencyContacts.indexWhere((c) => c.id == contact.id);
    if (index != -1) {
      _emergencyContacts[index] = contact;
    }
  }

  void deleteEmergencyContact(String id) {
    _emergencyContacts.removeWhere((c) => c.id == id);
  }

  // Tenant Registrations
  List<TenantRegistration> getTenantRegistrations() =>
      List.unmodifiable(_tenantRegistrations);

  List<TenantRegistration> getPendingRegistrations() {
    return _tenantRegistrations
        .where((r) => r.status == RegistrationStatus.pending)
        .toList();
  }

  List<TenantRegistration> getRegistrationsByBuilding(String buildingId) {
    return _tenantRegistrations
        .where((r) => r.buildingId == buildingId)
        .toList();
  }

  TenantRegistration? getRegistrationById(String id) {
    try {
      return _tenantRegistrations.firstWhere((r) => r.id == id);
    } catch (e) {
      return null;
    }
  }

  void addTenantRegistration(TenantRegistration registration) {
    _tenantRegistrations.add(registration);
  }

  void updateTenantRegistration(TenantRegistration registration) {
    final index = _tenantRegistrations.indexWhere((r) => r.id == registration.id);
    if (index != -1) {
      _tenantRegistrations[index] = registration;
    }
  }

  void approveRegistration(String registrationId, String approvedBy) {
    final index = _tenantRegistrations.indexWhere((r) => r.id == registrationId);
    if (index != -1) {
      final registration = _tenantRegistrations[index];
      _tenantRegistrations[index] = registration.copyWith(
        status: RegistrationStatus.approved,
        approvedAt: DateTime.now(),
        approvedBy: approvedBy,
      );

      // Create the actual tenant
      final tenant = Tenant(
        id: 't${DateTime.now().millisecondsSinceEpoch}',
        name: registration.name,
        phone: registration.phone,
        email: registration.email,
        address: registration.address,
        roomId: registration.roomId,
        buildingId: registration.buildingId,
        moveInDate: registration.moveInDate,
        depositAmount: registration.depositAmount,
        emergencyContact: registration.emergencyContact,
        emergencyPhone: registration.emergencyPhone,
      );

      addTenant(tenant);
    }
  }

  void rejectRegistration(String registrationId, String reason) {
    final index = _tenantRegistrations.indexWhere((r) => r.id == registrationId);
    if (index != -1) {
      final registration = _tenantRegistrations[index];
      _tenantRegistrations[index] = registration.copyWith(
        status: RegistrationStatus.rejected,
        rejectionReason: reason,
      );
    }
  }

  // Chat Messages
  List<ChatMessage> getChatMessages(String buildingId) {
    return _chatMessages
        .where((m) => m.buildingId == buildingId)
        .toList()
      ..sort((a, b) => a.timestamp.compareTo(b.timestamp));
  }

  void addChatMessage(ChatMessage message) {
    _chatMessages.add(message);
  }

  int getPendingRegistrationsCount() {
    return _tenantRegistrations
        .where((r) => r.status == RegistrationStatus.pending)
        .length;
  }

  // Statistics
  Map<String, dynamic> getStatistics() {
    final totalRooms = _rooms.length;
    final occupiedRooms = _rooms.where((r) => r.status == RoomStatus.occupied).length;
    final availableRooms = _rooms.where((r) => r.status == RoomStatus.available).length;
    final maintenanceRooms = _rooms.where((r) => r.status == RoomStatus.maintenance).length;
    final totalTenants = _tenants.length;
    final pendingQueries = _queries.where((q) => q.status == QueryStatus.pending).length;
    final pendingCleaning = _cleaningRequests.where((c) => c.status == CleaningStatus.pending).length;
    final pendingGatePasses = _gatePasses.where((g) => g.status == GatePassStatus.pending).length;

    final pendingRentPayments = _rentPayments
        .where((p) => p.status == PaymentStatus.pending || p.status == PaymentStatus.overdue)
        .length;

    return {
      'totalBuildings': _buildings.length,
      'totalRooms': totalRooms,
      'occupiedRooms': occupiedRooms,
      'availableRooms': availableRooms,
      'maintenanceRooms': maintenanceRooms,
      'totalTenants': totalTenants,
      'pendingQueries': pendingQueries,
      'pendingCleaning': pendingCleaning,
      'pendingGatePasses': pendingGatePasses,
      'pendingRentPayments': pendingRentPayments,
    };
  }
}
