import 'package:flutter/material.dart';

class TeachersScreen extends StatefulWidget {
  const TeachersScreen({super.key});

  @override
  State<TeachersScreen> createState() => _TeachersScreenState();
}

class _TeachersScreenState extends State<TeachersScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _teacherNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPassController = TextEditingController();

  String? _selectedShift;

  final List<Map<String, String>> _teachers = [
  {
    'name': 'Ali Khan',
    'shift': 'Morning',
    'password': 'abc12345',
  },
  {
    'name': 'Sara Ahmed',
    'shift': 'Evening',
    'password': 'pass6789',
  },
];


  int? _editingIndex;

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      if (_editingIndex == null) {
        setState(() {
          _teachers.add({
            'name': _teacherNameController.text,
            'shift': _selectedShift!,
            'password': _passwordController.text,
          });
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Teacher Added!')),
        );
      } else {
        setState(() {
          _teachers[_editingIndex!] = {
            'name': _teacherNameController.text,
            'shift': _selectedShift!,
            'password': _passwordController.text,
          };

          _editingIndex = null;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Teacher Updated!')),
        );
      }

      _teacherNameController.clear();
      _passwordController.clear();
      _confirmPassController.clear();
      setState(() {
        _selectedShift = null;
      });
    }
  }

  void _editTeacher(int index) {
    setState(() {
      _editingIndex = index;
      _teacherNameController.text = _teachers[index]['name']!;
      _selectedShift = _teachers[index]['shift'];
      _passwordController.text = _teachers[index]['password']!;
      _confirmPassController.text = _teachers[index]['password']!;
    });
  }

  void _deleteTeacher(int index) {
    setState(() {
      _teachers.removeAt(index);
      if (_editingIndex == index) {
        _editingIndex = null;
        _teacherNameController.clear();
        _passwordController.clear();
        _confirmPassController.clear();
        _selectedShift = null;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // 🎨 Batch wali theme ka Dark Navy Blue
    const Color accent = Color.fromARGB(255, 0, 5, 43);

    double cardWidth =
        MediaQuery.of(context).size.width > 540 ? 520 : double.infinity;

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('Manage Teachers',
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
            // ✅ Form Card
            Center(
              child: Container(
                width: cardWidth,
                padding: const EdgeInsets.all(28),
                margin:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: accent.withOpacity(0.15),
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
                      const Icon(Icons.person_add,
                          size: 48, color: accent),
                      const SizedBox(height: 12),
                      Text(
                        _editingIndex == null
                            ? "Add Teacher"
                            : "Edit Teacher",
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 28),
                      // Teacher Name
                      TextFormField(
                        controller: _teacherNameController,
                        style: const TextStyle(color: Colors.black87),
                        decoration: InputDecoration(
                          labelText: 'Teacher Name',
                          labelStyle: const TextStyle(color: Colors.black54),
                          prefixIcon: const Icon(Icons.person, color: accent),
                          filled: true,
                          fillColor: Colors.grey[50],
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide: const BorderSide(color: accent, width: 1),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide: const BorderSide(color: accent, width: 2),
                          ),
                        ),
                        validator: (value) => value == null || value.isEmpty
                            ? 'Enter teacher name'
                            : null,
                      ),
                      const SizedBox(height: 20),
                      // Create Password
                      TextFormField(
                        controller: _passwordController,
                        obscureText: true,
                        style: const TextStyle(color: Colors.black87),
                        decoration: InputDecoration(
                          labelText: 'Create Password',
                          labelStyle: const TextStyle(color: Colors.black54),
                          prefixIcon: const Icon(Icons.lock, color: accent),
                          filled: true,
                          fillColor: Colors.grey[50],
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide: const BorderSide(color: accent, width: 1),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide: const BorderSide(color: accent, width: 2),
                          ),
                        ),
                        validator: (value) => value == null || value.length < 6
                            ? 'Password must be at least 6 characters'
                            : null,
                      ),
                      const SizedBox(height: 20),
                      // Confirm Password
                      TextFormField(
                        controller: _confirmPassController,
                        obscureText: true,
                        style: const TextStyle(color: Colors.black87),
                        decoration: InputDecoration(
                          labelText: 'Confirm Password',
                          labelStyle: const TextStyle(color: Colors.black54),
                          prefixIcon:
                              const Icon(Icons.lock_outline, color: accent),
                          filled: true,
                          fillColor: Colors.grey[50],
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide: const BorderSide(color: accent, width: 1),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide: const BorderSide(color: accent, width: 2),
                          ),
                        ),
                        validator: (value) => value != _passwordController.text
                            ? 'Passwords do not match'
                            : null,
                      ),
                      const SizedBox(height: 20),
                      // Teacher Shift
                      DropdownButtonFormField<String>(
                        value: _selectedShift,
                        dropdownColor: Colors.white,
                        style: const TextStyle(color: Colors.black87),
                        decoration: InputDecoration(
                          labelText: 'Teacher Shift',
                          labelStyle: const TextStyle(color: Colors.black54),
                          prefixIcon: const Icon(Icons.access_time, color: accent),
                          filled: true,
                          fillColor: Colors.grey[50],
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide: const BorderSide(color: accent, width: 1),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide: const BorderSide(color: accent, width: 2),
                          ),
                        ),
                        items: const [
                          DropdownMenuItem(
                              value: 'Morning', child: Text('Morning')),
                          DropdownMenuItem(
                              value: 'Evening', child: Text('Evening')),
                        ],
                        onChanged: (value) {
                          setState(() {
                            _selectedShift = value;
                          });
                        },
                        validator: (value) =>
                            value == null ? 'Select teacher shift' : null,
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
                              onPressed: _submitForm,
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
                                  side: const BorderSide(color: accent),
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
                                    _teacherNameController.clear();
                                    _passwordController.clear();
                                    _confirmPassController.clear();
                                    _selectedShift = null;
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
            // ✅ Teachers List Card
            Center(
              child: Container(
                width: cardWidth,
                padding: const EdgeInsets.all(24),
                margin:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: accent.withOpacity(0.15),
                      blurRadius: 14,
                      offset: const Offset(0, 4),
                    ),
                  ],
                  border: Border.all(color: accent.withOpacity(0.2)),
                ),
                child: Column(
                  children: [
                    const Text(
                      "Teachers List",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 12),
                    _teachers.isEmpty
                        ? const Text("No teachers added yet.")
                        :SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: DataTable(
                            border: TableBorder(
                              horizontalInside: BorderSide(color: Colors.grey.shade300, width: 1),
                            ),
                            headingRowColor: WidgetStateProperty.all(accent), // 🎨 Dark Navy header
                            columns: const [
                              DataColumn(
                                label: Text(
                                  "Name",
                                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  "Shift",
                                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  "Password",
                                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  "Actions",
                                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                            rows: List.generate(_teachers.length, (index) {
                              final teacher = _teachers[index];
                              return DataRow(
                                cells: [
                                  DataCell(Text(teacher['name'] ?? "")),
                                  DataCell(Text(teacher['shift'] ?? "")),
                                  DataCell(Text(teacher['password'] ?? "")),
                                  DataCell(Row(
                                    children: [
                                      IconButton(
                                        icon: const Icon(Icons.edit, color: accent),
                                        tooltip: 'Edit',
                                        onPressed: () => _editTeacher(index),
                                      ),
                                      IconButton(
                                        icon: const Icon(Icons.delete, color: Colors.red),
                                        tooltip: 'Delete',
                                        onPressed: () => _deleteTeacher(index),
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
