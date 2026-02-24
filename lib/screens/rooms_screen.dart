import 'package:flutter/material.dart';
import '../models/building.dart';
import '../models/room.dart';
import '../models/tenant.dart';
import '../services/data_service.dart';
import 'tenant_details_screen.dart';
import 'add_tenant_screen.dart';
import 'buildings_screen.dart';

class RoomsScreen extends StatefulWidget {
  final Building building;

  const RoomsScreen({super.key, required this.building});

  @override
  State<RoomsScreen> createState() => _RoomsScreenState();
}

class _RoomsScreenState extends State<RoomsScreen> {
  final DataService _dataService = DataService();
  List<Room> _rooms = [];
  RoomStatus? _filterStatus;

  @override
  void initState() {
    super.initState();
    _dataService.initialize();
    _loadRooms();
  }

  void _loadRooms() {
    setState(() {
      _rooms = List<Room>.from(_dataService.getRoomsByBuilding(widget.building.id));
      if (_filterStatus != null) {
        _rooms = _rooms.where((r) => r.status == _filterStatus).toList();
      }
    });
  }

  Color _getStatusColor(RoomStatus status) {
    switch (status) {
      case RoomStatus.available:
        return Colors.green;
      case RoomStatus.occupied:
        return Colors.blue;
      case RoomStatus.maintenance:
        return Colors.orange;
    }
  }

  String _getStatusText(RoomStatus status) {
    switch (status) {
      case RoomStatus.available:
        return 'Available';
      case RoomStatus.occupied:
        return 'Occupied';
      case RoomStatus.maintenance:
        return 'Maintenance';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.building.name),
        backgroundColor: const Color(0xFF2563EB),
        foregroundColor: Colors.white,
        actions: [
          PopupMenuButton<RoomStatus?>(
            icon: const Icon(Icons.filter_list),
            onSelected: (status) {
              setState(() {
                _filterStatus = status;
              });
              _loadRooms();
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: null,
                child: Text('All Rooms'),
              ),
              PopupMenuItem(
                value: RoomStatus.available,
                child: Row(
                  children: [
                    Icon(Icons.circle, color: Colors.green, size: 12),
                    const SizedBox(width: 8),
                    const Text('Available'),
                  ],
                ),
              ),
              PopupMenuItem(
                value: RoomStatus.occupied,
                child: Row(
                  children: [
                    Icon(Icons.circle, color: Colors.blue, size: 12),
                    const SizedBox(width: 8),
                    const Text('Occupied'),
                  ],
                ),
              ),
              PopupMenuItem(
                value: RoomStatus.maintenance,
                child: Row(
                  children: [
                    Icon(Icons.circle, color: Colors.orange, size: 12),
                    const SizedBox(width: 8),
                    const Text('Maintenance'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.85,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        itemCount: _rooms.length,
        itemBuilder: (context, index) {
          final room = _rooms[index];
          return _buildRoomCard(room);
        },
      ),
    );
  }

  Widget _buildRoomCard(Room room) {
    final tenant = room.tenantId != null
        ? _dataService.getTenantById(room.tenantId!)
        : null;

    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () => _showRoomDetails(room, tenant),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: _getStatusColor(room.status),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      _getStatusText(room.status),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Text(
                    '₹${room.rent.toInt()}',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF2563EB),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Center(
                child: Column(
                  children: [
                    Icon(
                      Icons.meeting_room,
                      size: 40,
                      color: _getStatusColor(room.status).withOpacity(0.7),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Room ${room.roomNumber}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              if (tenant != null) ...[
                const Divider(height: 16),
                Row(
                  children: [
                    const Icon(Icons.person, size: 14, color: Colors.grey),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        tenant.name,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[700],
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ] else ...[
                const Divider(height: 16),
                Row(
                  children: [
                    Icon(Icons.people, size: 14, color: Colors.grey[400]),
                    const SizedBox(width: 4),
                    Text(
                      'Capacity: ${room.capacity}',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  void _showRoomDetails(Room room, Tenant? tenant) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(20),
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.7,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Room ${room.roomNumber}',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: _getStatusColor(room.status).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      _getStatusText(room.status),
                      style: TextStyle(
                        color: _getStatusColor(room.status),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                widget.building.name,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 20),
              _buildDetailRow('Monthly Rent', '₹${room.rent.toInt()}'),
              _buildDetailRow('Capacity', '${room.capacity} persons'),
              const SizedBox(height: 16),
              const Text(
                'Amenities',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: room.amenities
                    .map((amenity) => Chip(
                          label: Text(amenity),
                          backgroundColor: const Color(0xFF2563EB).withOpacity(0.1),
                          labelStyle: const TextStyle(fontSize: 12),
                        ))
                    .toList(),
              ),
              if (tenant != null) ...[
                const SizedBox(height: 20),
                const Divider(),
                const SizedBox(height: 16),
                const Text(
                  'Current Tenant',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: CircleAvatar(
                    backgroundColor: const Color(0xFF2563EB),
                    child: Text(
                      tenant.name[0],
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  title: Text(tenant.name),
                  subtitle: Text(tenant.phone),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            TenantDetailsScreen(tenant: tenant),
                      ),
                    );
                  },
                ),
              ] else ...[
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddTenantScreen(
                            building: widget.building,
                            room: room,
                          ),
                        ),
                      ).then((_) => _loadRooms());
                    },
                    icon: const Icon(Icons.person_add),
                    label: const Text('Add Tenant'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2563EB),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
              ],
            ],
          ),
        );
      },
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
