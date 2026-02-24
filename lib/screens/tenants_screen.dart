import 'package:flutter/material.dart';
import '../models/tenant.dart';
import '../models/building.dart';
import '../services/data_service.dart';
import 'tenant_details_screen.dart';

class TenantsScreen extends StatefulWidget {
  const TenantsScreen({super.key});

  @override
  State<TenantsScreen> createState() => _TenantsScreenState();
}

class _TenantsScreenState extends State<TenantsScreen> {
  final DataService _dataService = DataService();
  List<Tenant> _tenants = [];
  List<Building> _buildings = [];
  String? _selectedBuildingId;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() {
    setState(() {
      _buildings = _dataService.getBuildings();
      _tenants = _dataService.getTenants();
      if (_selectedBuildingId != null) {
        _tenants = _tenants
            .where((t) => t.buildingId == _selectedBuildingId)
            .toList();
      }
      if (_searchQuery.isNotEmpty) {
        _tenants = _tenants
            .where((t) =>
                t.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
                t.phone.contains(_searchQuery))
            .toList();
      }
    });
  }

  String _getBuildingName(String buildingId) {
    final building = _dataService.getBuildingById(buildingId);
    return building?.name ?? 'Unknown';
  }

  String _getRoomNumber(String roomId) {
    final room = _dataService.getRoomById(roomId);
    return room?.roomNumber ?? 'Unknown';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tenants'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search tenants...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
                _loadData();
              },
            ),
          ),
          // Building Filter
          SizedBox(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _buildings.length + 1,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: ChoiceChip(
                      label: const Text('All Buildings'),
                      selected: _selectedBuildingId == null,
                      onSelected: (selected) {
                        setState(() {
                          _selectedBuildingId = null;
                        });
                        _loadData();
                      },
                      selectedColor: Colors.teal,
                      labelStyle: TextStyle(
                        color: _selectedBuildingId == null
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                  );
                }
                final building = _buildings[index - 1];
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: ChoiceChip(
                    label: Text(building.name),
                    selected: _selectedBuildingId == building.id,
                    onSelected: (selected) {
                      setState(() {
                        _selectedBuildingId = selected ? building.id : null;
                      });
                      _loadData();
                    },
                    selectedColor: Colors.teal,
                    labelStyle: TextStyle(
                      color: _selectedBuildingId == building.id
                          ? Colors.white
                          : Colors.black,
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 8),
          // Tenants List
          Expanded(
            child: _tenants.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.people_outline,
                            size: 64, color: Colors.grey[400]),
                        const SizedBox(height: 16),
                        Text(
                          'No tenants found',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: _tenants.length,
                    itemBuilder: (context, index) {
                      final tenant = _tenants[index];
                      return _buildTenantCard(tenant);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildTenantCard(Tenant tenant) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TenantDetailsScreen(tenant: tenant),
            ),
          ).then((_) => _loadData());
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              CircleAvatar(
                radius: 28,
                backgroundColor: Colors.teal,
                child: Text(
                  tenant.name[0].toUpperCase(),
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      tenant.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(Icons.phone, size: 14, color: Colors.grey[600]),
                        const SizedBox(width: 4),
                        Text(
                          tenant.phone,
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(Icons.apartment, size: 14, color: Colors.grey[600]),
                        const SizedBox(width: 4),
                        Text(
                          _getBuildingName(tenant.buildingId),
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey[600],
                          ),
                        ),
                        const SizedBox(width: 12),
                        Icon(Icons.meeting_room,
                            size: 14, color: Colors.grey[600]),
                        const SizedBox(width: 4),
                        Text(
                          'Room ${_getRoomNumber(tenant.roomId)}',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }
}
