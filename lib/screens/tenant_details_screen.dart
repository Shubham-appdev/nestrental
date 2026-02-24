import 'package:flutter/material.dart';
import '../models/tenant.dart';
import '../services/data_service.dart';

class TenantDetailsScreen extends StatefulWidget {
  final Tenant tenant;

  const TenantDetailsScreen({super.key, required this.tenant});

  @override
  State<TenantDetailsScreen> createState() => _TenantDetailsScreenState();
}

class _TenantDetailsScreenState extends State<TenantDetailsScreen> {
  final DataService _dataService = DataService();

  String _getBuildingName(String buildingId) {
    final building = _dataService.getBuildingById(buildingId);
    return building?.name ?? 'Unknown';
  }

  String _getRoomNumber(String roomId) {
    final room = _dataService.getRoomById(roomId);
    return room?.roomNumber ?? 'Unknown';
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tenant Details'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () => _showDeleteConfirmation(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Profile Header
            Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.teal,
                      child: Text(
                        widget.tenant.name[0].toUpperCase(),
                        style: const TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      widget.tenant.name,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.teal.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        'Room ${_getRoomNumber(widget.tenant.roomId)}',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.teal,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Contact Information
            _buildInfoCard(
              'Contact Information',
              [
                _buildInfoRow(Icons.phone, 'Phone', widget.tenant.phone),
                _buildInfoRow(Icons.email, 'Email', widget.tenant.email),
                _buildInfoRow(
                    Icons.location_on, 'Address', widget.tenant.address),
              ],
            ),
            const SizedBox(height: 16),
            // Room Information
            _buildInfoCard(
              'Room Information',
              [
                _buildInfoRow(
                  Icons.apartment,
                  'Building',
                  _getBuildingName(widget.tenant.buildingId),
                ),
                _buildInfoRow(
                  Icons.meeting_room,
                  'Room Number',
                  _getRoomNumber(widget.tenant.roomId),
                ),
                _buildInfoRow(
                  Icons.calendar_today,
                  'Move-in Date',
                  _formatDate(widget.tenant.moveInDate),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Payment Information
            _buildInfoCard(
              'Payment Information',
              [
                _buildInfoRow(
                  Icons.account_balance_wallet,
                  'Deposit Amount',
                  '₹${widget.tenant.depositAmount.toInt()}',
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Emergency Contact
            _buildInfoCard(
              'Emergency Contact',
              [
                _buildInfoRow(
                  Icons.person,
                  'Name',
                  widget.tenant.emergencyContact,
                ),
                _buildInfoRow(
                  Icons.phone,
                  'Phone',
                  widget.tenant.emergencyPhone,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(String title, List<Widget> children) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
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
            const Divider(height: 24),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.teal),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showDeleteConfirmation() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Tenant'),
        content: Text(
          'Are you sure you want to remove ${widget.tenant.name}? This will also vacate the room.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              _dataService.removeTenant(widget.tenant.id);
              Navigator.pop(context);
              Navigator.pop(context, true);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}
