import 'package:flutter/material.dart';
import '../services/data_service.dart';
import '../services/auth_service.dart';
import 'buildings_screen.dart';
import 'tenants_screen.dart';
import 'queries_screen.dart';
import 'cleaning_requests_screen.dart';
import 'wifi_password_screen.dart';
import 'gate_pass_screen.dart';
import 'rent_payment_screen.dart';
import 'notices_screen.dart';
import 'emergency_contacts_screen.dart';
import 'role_selection_screen.dart';
import 'tenant_approvals_screen.dart';
import 'group_chat_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final DataService _dataService = DataService();
  final AuthService _authService = AuthService();
  Map<String, dynamic> _stats = {};

  @override
  void initState() {
    super.initState();
    _dataService.initialize();
    _loadStats();
  }

  void _loadStats() {
    setState(() {
      _stats = _dataService.getStatistics();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Owner Dashboard',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF2563EB),
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.switch_account),
            tooltip: 'Switch Role',
            onPressed: () {
              _authService.logout();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const RoleSelectionScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          _loadStats();
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Welcome Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF2563EB), Color(0xFF60A5FA)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Welcome to Nest Rental',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Manage your properties with ease',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white.withOpacity(0.9),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Statistics Section
              const Text(
                'Overview',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                children: [
                  _buildStatCard(
                    'Buildings',
                    _stats['totalBuildings']?.toString() ?? '0',
                    Icons.apartment,
                    Colors.blue,
                  ),
                  _buildStatCard(
                    'Total Rooms',
                    _stats['totalRooms']?.toString() ?? '0',
                    Icons.meeting_room,
                    Colors.purple,
                  ),
                  _buildStatCard(
                    'Occupied',
                    _stats['occupiedRooms']?.toString() ?? '0',
                    Icons.people,
                    Colors.green,
                  ),
                  _buildStatCard(
                    'Available',
                    _stats['availableRooms']?.toString() ?? '0',
                    Icons.check_circle,
                    Colors.orange,
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Quick Actions
              const Text(
                'Quick Actions',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              _buildActionCard(
                'Group Chat',
                'Chat with tenants in your buildings',
                Icons.chat,
                Colors.teal,
                () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const GroupChatScreen(isOwner: true),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              _buildActionCard(
                'Buildings & Rooms',
                'View all buildings and manage rooms',
                Icons.apartment,
                Colors.blue,
                () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const BuildingsScreen(),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              _buildActionCard(
                'Tenants',
                'Manage tenant information',
                Icons.people,
                Colors.green,
                () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const TenantsScreen(),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              _buildActionCard(
                'Tenant Approvals',
                'Review and approve new tenant registrations',
                Icons.person_add,
                Colors.purple,
                () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const TenantApprovalsScreen(),
                  ),
                ).then((_) => _loadStats()),
                badge: _dataService.getPendingRegistrationsCount(),
              ),
              const SizedBox(height: 12),
              _buildActionCard(
                'Queries',
                'View and respond to tenant queries',
                Icons.help_outline,
                Colors.orange,
                () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const QueriesScreen(),
                  ),
                ),
                badge: _stats['pendingQueries'] ?? 0,
              ),
              const SizedBox(height: 12),
              _buildActionCard(
                'Cleaning Requests',
                'Manage cleaning service requests',
                Icons.cleaning_services,
                Colors.pink,
                () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CleaningRequestsScreen(),
                  ),
                ),
                badge: _stats['pendingCleaning'] ?? 0,
              ),
              const SizedBox(height: 12),
              _buildActionCard(
                'Gate Pass',
                'Apply and manage gate passes',
                Icons.card_membership,
                Colors.teal,
                () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const GatePassScreen(),
                  ),
                ),
                badge: _stats['pendingGatePasses'] ?? 0,
              ),
              const SizedBox(height: 12),
              _buildActionCard(
                'WiFi Passwords',
                'View WiFi passwords for all buildings',
                Icons.wifi,
                Colors.indigo,
                () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const WiFiPasswordScreen(),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              _buildActionCard(
                'Rent Payments',
                'Manage rent payments and dues',
                Icons.payment,
                Colors.green,
                () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const RentPaymentScreen(),
                  ),
                ),
                badge: _stats['pendingRentPayments'] ?? 0,
              ),
              const SizedBox(height: 12),
              _buildActionCard(
                'Notices',
                'Post and view announcements',
                Icons.campaign,
                Colors.orange,
                () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const NoticesScreen(),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              _buildActionCard(
                'Emergency Contacts',
                'Important contacts and helplines',
                Icons.contact_phone,
                Colors.red,
                () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const EmergencyContactsScreen(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard(
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: color),
            const SizedBox(height: 8),
            Text(
              value,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              title,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionCard(
    String title,
    String subtitle,
    IconData icon,
    Color color,
    VoidCallback onTap, {
    int badge = 0,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Stack(
                  children: [
                    Icon(icon, size: 28, color: color),
                    if (badge > 0)
                      Positioned(
                        right: -2,
                        top: -2,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            badge.toString(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey[400]),
            ],
          ),
        ),
      ),
    );
  }
}
