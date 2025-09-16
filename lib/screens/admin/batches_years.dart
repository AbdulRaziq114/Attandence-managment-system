import 'package:flutter/material.dart';

class BatchesYearsScreen extends StatefulWidget {
  const BatchesYearsScreen({super.key});

  @override
  State<BatchesYearsScreen> createState() => _BatchFormScreenState();
}

class _BatchFormScreenState extends State<BatchesYearsScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _batchNameController = TextEditingController();

  final List<int> years = [2024, 2025, 2026, 2027, 2028, 2029, 2030];
  int? _fromYear;
  int? _toYear;

  final List<Map<String, dynamic>> _batches = [
    {'name': 'Batch A', 'from': 2024, 'to': 2026},
    {'name': 'Batch B', 'from': 2025, 'to': 2028},
  ];

  int? _editingIndex;

  // Custom Theme Color
  final Color accent = const Color.fromARGB(255, 0, 5, 43);

  void _addOrUpdateBatch() {
    if (_editingIndex == null) {
      setState(() {
        _batches.add({
          'name': _batchNameController.text,
          'from': _fromYear,
          'to': _toYear,
        });
      });
    } else {
      setState(() {
        _batches[_editingIndex!] = {
          'name': _batchNameController.text,
          'from': _fromYear,
          'to': _toYear,
        };
        _editingIndex = null;
      });
    }
    _batchNameController.clear();
    _fromYear = null;
    _toYear = null;
  }

  void _editBatch(int index) {
    setState(() {
      _editingIndex = index;
      _batchNameController.text = _batches[index]['name'];
      _fromYear = _batches[index]['from'];
      _toYear = _batches[index]['to'];
    });
  }

  void _deleteBatch(int index) {
    setState(() {
      _batches.removeAt(index);
      if (_editingIndex == index) {
        _editingIndex = null;
        _batchNameController.clear();
        _fromYear = null;
        _toYear = null;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double cardWidth =
        MediaQuery.of(context).size.width > 520 ? 500 : double.infinity;

    return Scaffold(
      backgroundColor: accent.withOpacity(0.05), // light background tint
      appBar: AppBar(
        title: const Text('Batches & years',
            style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: accent,
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 1,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Form Card
            Center(
              child: Container(
                width: cardWidth,
                padding: const EdgeInsets.all(28),
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: accent.withOpacity(0.1),
                      blurRadius: 14,
                      offset: const Offset(0, 4),
                    ),
                  ],
                  border: Border.all(color: accent.withOpacity(0.2)),
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.class_, size: 48, color: accent),
                      const SizedBox(height: 12),
                      Text(
                        _editingIndex == null ? "Batch Information" : "Edit Batch",
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 28),
                      // Batch Name
                      TextFormField(
                        controller: _batchNameController,
                        style: const TextStyle(color: Colors.black87),
                        decoration: InputDecoration(
                          labelText: 'Batch Name',
                          labelStyle: const TextStyle(color: Colors.black54),
                          prefixIcon: Icon(Icons.edit, color: accent),
                          filled: true,
                          fillColor: accent.withOpacity(0.04),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide: BorderSide(color: accent, width: 1),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide: BorderSide(color: accent, width: 2),
                          ),
                        ),
                        validator: (value) =>
                            value == null || value.isEmpty ? 'Enter batch name' : null,
                      ),
                      const SizedBox(height: 20),
                      // From Year
                      DropdownButtonFormField<int>(
                        dropdownColor: Colors.white,
                        style: const TextStyle(color: Colors.black87),
                        decoration: InputDecoration(
                          labelText: 'Batch Duration From (Year)',
                          labelStyle: const TextStyle(color: Colors.black54),
                          prefixIcon: Icon(Icons.calendar_today, color: accent),
                          filled: true,
                          fillColor: accent.withOpacity(0.04),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide: BorderSide(color: accent, width: 1),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide: BorderSide(color: accent, width: 2),
                          ),
                        ),
                        value: _fromYear,
                        items: years
                            .map((year) => DropdownMenuItem(
                                  value: year,
                                  child: Text(year.toString(),
                                      style: const TextStyle(color: Colors.black87)),
                                ))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            _fromYear = value;
                          });
                        },
                        validator: (value) =>
                            value == null ? 'Select start year' : null,
                      ),
                      const SizedBox(height: 20),
                      // To Year
                      DropdownButtonFormField<int>(
                        dropdownColor: Colors.white,
                        style: const TextStyle(color: Colors.black87),
                        decoration: InputDecoration(
                          labelText: 'Batch Duration To (Year)',
                          labelStyle: const TextStyle(color: Colors.black54),
                          prefixIcon: Icon(Icons.calendar_month, color: accent),
                          filled: true,
                          fillColor: accent.withOpacity(0.04),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide: BorderSide(color: accent, width: 1),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide: BorderSide(color: accent, width: 2),
                          ),
                        ),
                        value: _toYear,
                        items: years
                            .map((year) => DropdownMenuItem(
                                  value: year,
                                  child: Text(year.toString(),
                                      style: const TextStyle(color: Colors.black87)),
                                ))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            _toYear = value;
                          });
                        },
                        validator: (value) =>
                            value == null ? 'Select end year' : null,
                      ),
                      const SizedBox(height: 32),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton.icon(
                              icon: Icon(_editingIndex == null
                                  ? Icons.save
                                  : Icons.edit),
                              label: Text(_editingIndex == null
                                  ? 'Submit'
                                  : 'Update'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: accent,
                                foregroundColor: Colors.white,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16),
                                textStyle: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                elevation: 2,
                              ),
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  _addOrUpdateBatch();
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(_editingIndex == null
                                          ? 'Batch Added!'
                                          : 'Batch Updated!'),
                                    ),
                                  );
                                }
                              },
                            ),
                          ),
                          if (_editingIndex != null) ...[
                            const SizedBox(width: 12),
                            Expanded(
                              child: OutlinedButton.icon(
                                icon: const Icon(Icons.clear),
                                label: const Text('Cancel'),
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: accent,
                                  side: BorderSide(color: accent),
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 16),
                                  textStyle: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                ),
                                onPressed: () {
                                  setState(() {
                                    _editingIndex = null;
                                    _batchNameController.clear();
                                    _fromYear = null;
                                    _toYear = null;
                                  });
                                },
                              ),
                            ),
                          ]
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 32),
            // Batch List Card
            Center(
              child: Container(
                width: cardWidth,
                padding: const EdgeInsets.all(24),
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: accent.withOpacity(0.1),
                      blurRadius: 14,
                      offset: const Offset(0, 4),
                    ),
                  ],
                  border: Border.all(color: accent.withOpacity(0.2)),
                ),
                child: Column(
                  children: [
                    const Text(
                      "Batches List",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 12),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        headingRowColor: WidgetStateProperty.all(accent),
                        dataRowColor:
                            WidgetStateProperty.all(Colors.white),
                        columns: const [
                          DataColumn(
                            label: Text(
                              'Batch Name',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'From',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'To',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'Actions',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                              ),
                            ),
                          ),
                        ],
                        rows: List.generate(_batches.length, (index) {
                          final batch = _batches[index];
                          return DataRow(
                            cells: [
                              DataCell(Text(batch['name'].toString(),
                                  style:
                                      const TextStyle(color: Colors.black87))),
                              DataCell(Text(batch['from'].toString(),
                                  style:
                                      const TextStyle(color: Colors.black87))),
                              DataCell(Text(batch['to'].toString(),
                                  style:
                                      const TextStyle(color: Colors.black87))),
                              DataCell(Row(
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.edit, color: accent),
                                    tooltip: 'Edit',
                                    onPressed: () => _editBatch(index),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.delete,
                                        color: Colors.red),
                                    tooltip: 'Delete',
                                    onPressed: () => _deleteBatch(index),
                                  ),
                                ],
                              )),
                            ],
                          );
                        }),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
