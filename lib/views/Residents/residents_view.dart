import 'package:dema/views/Residents/resident_model.dart';
import 'package:dema/views/Residents/resident_details_view.dart';
import 'package:flutter/material.dart';

class ResidentsView extends StatefulWidget {
  const ResidentsView({super.key});

  @override
  State<ResidentsView> createState() => _ResidentsViewState();
}

class _ResidentsViewState extends State<ResidentsView> {
  late List<ResidentModel> _filteredResidents;
  String _searchQuery = '';
  ResidentStatus? _selectedStatus;

  @override
  void initState() {
    super.initState();
    _filteredResidents = List.from(dummyResidents);
  }

  void _applyFilters() {
    setState(() {
      _filteredResidents = dummyResidents.where((resident) {
        final statusMatch =
            _selectedStatus == null || resident.status == _selectedStatus;
        final searchMatch =
            _searchQuery.isEmpty ||
            resident.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
            resident.unitNumber.contains(_searchQuery);
        return statusMatch && searchMatch;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: const Color(0xFFF1F5F9),
        title: const Text(
          'إدارة المستأجرين',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.add),
              label: const Text("إضافة مستأجر"),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          _buildFilterBar(),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _filteredResidents.length,
              itemBuilder: (context, index) {
                return _buildResidentCard(_filteredResidents[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterBar() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              onChanged: (value) {
                _searchQuery = value;
                _applyFilters();
              },
              decoration: InputDecoration(
                hintText: "بحث بالاسم أو رقم الوحدة...",
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<ResidentStatus?>(
                hint: const Text("كل الحالات"),
                value: _selectedStatus,
                items: [
                  const DropdownMenuItem(
                    value: null,
                    child: Text("كل الحالات"),
                  ),
                  ...ResidentStatus.values.map(
                    (status) => DropdownMenuItem(
                      value: status,
                      child: Text(
                        status == ResidentStatus.Active ? 'نشط' : 'غير نشط',
                      ),
                    ),
                  ),
                ],
                onChanged: (value) {
                  _selectedStatus = value;
                  _applyFilters();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResidentCard(ResidentModel resident) {
    final bool isActive = resident.status == ResidentStatus.Active;
    return Card(
      color: const Color(0xFFF1F5F9),

      margin: const EdgeInsets.only(bottom: 12),
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ResidentDetailsView(resident: resident),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              CircleAvatar(
                radius: 24,
                backgroundImage: NetworkImage(resident.imageUrl),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      resident.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'الوحدة: ${resident.unitNumber} • ${resident.phone}',
                      style: TextStyle(color: Colors.grey.shade600),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Chip(
                label: Text(isActive ? 'نشط' : 'غير نشط'),
                backgroundColor: (isActive ? Colors.green : Colors.red)
                    .withOpacity(0.1),
                labelStyle: TextStyle(
                  color: isActive ? Colors.green.shade800 : Colors.red.shade800,
                ),
                side: BorderSide.none,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
