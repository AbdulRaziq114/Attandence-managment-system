import 'package:flutter/material.dart';

class StudentsScreen extends StatefulWidget {
  const StudentsScreen({super.key});

  @override
  State<StudentsScreen> createState() => _StudentsScreenState();
}

class _StudentsScreenState extends State<StudentsScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _grNoController = TextEditingController();

  final List<String> _students = ['GR123', 'GR124', 'GR125'];
  int? _editingIndex;

  void _addOrUpdateStudent() {
    if (_editingIndex == null) {
      setState(() {
        _students.add(_grNoController.text);
      });
    } else {
      setState(() {
        _students[_editingIndex!] = _grNoController.text;
        _editingIndex = null;
      });
    }
    _grNoController.clear();
  }

  void _editStudent(int index) {
    setState(() {
      _editingIndex = index;
      _grNoController.text = _students[index];
    });
  }

  void _deleteStudent(int index) {
    setState(() {
      _students.removeAt(index);
      if (_editingIndex == index) {
        _editingIndex = null;
        _grNoController.clear();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final Color accent = const Color.fromARGB(255, 0, 5, 43);
    double cardWidth = MediaQuery.of(context).size.width > 420 ? 400 : double.infinity;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 5, 43).withOpacity(0.05),
      appBar: AppBar(
        title: const Text('Manage Students',
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
                      color: accent.withOpacity(0.06),
                      blurRadius: 14,
                      offset: const Offset(0, 4),
                    ),
                  ],
                  border: Border.all(color: accent.withOpacity(0.08)),
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.badge, size: 48, color: accent), // GR icon
                      const SizedBox(height: 12),
                      Text(
                        _editingIndex == null ? "Add Student GR" : "Edit Student GR",
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 28),
                      TextFormField(
                        controller: _grNoController,
                        style: const TextStyle(color: Colors.black87),
                        decoration: InputDecoration(
                          labelText: 'GR Number',
                          labelStyle: const TextStyle(color: Colors.black54),
                          prefixIcon: Icon(Icons.numbers, color: accent),
                          filled: true,
                          fillColor: const Color.fromARGB(255, 0, 5, 43).withOpacity(0.03),
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
                            value == null || value.isEmpty ? 'Enter GR Number' : null,
                      ),
                      const SizedBox(height: 32),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton.icon(
                              icon: Icon(_editingIndex == null ? Icons.save : Icons.edit),
                              label: Text(_editingIndex == null ? 'Submit' : 'Update'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: accent,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(vertical: 16),
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
                                  _addOrUpdateStudent();
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(_editingIndex == null
                                          ? 'Student GR Added!'
                                          : 'Student GR Updated!'),
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
                                  padding: const EdgeInsets.symmetric(vertical: 16),
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
                                    _grNoController.clear();
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
            // Students List Card
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
                      color: accent.withOpacity(0.06),
                      blurRadius: 14,
                      offset: const Offset(0, 4),
                    ),
                  ],
                  border: Border.all(color: accent.withOpacity(0.08)),
                ),
                child: Column(
                  children: [
                    const Text(
                      "Students GR List",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 0, 5, 43),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: const [
                          Expanded(
                            flex: 2,
                            child: Text(
                              "GR Number",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Text(
                              "Actions",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    _students.isEmpty
                        ? const Text("No students added yet.")
                        : ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: _students.length,
                            separatorBuilder: (_, __) => Divider(height: 1, color: accent.withOpacity(0.3)),
                            itemBuilder: (context, index) {
                              return ListTile(
                                leading: Icon(Icons.badge, color: accent),
                                title: Text(
                                  _students[index],
                                  style: const TextStyle(
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      icon: Icon(Icons.edit, color: accent),
                                      tooltip: 'Edit',
                                      onPressed: () => _editStudent(index),
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.delete, color: Colors.red),
                                      tooltip: 'Delete',
                                      onPressed: () => _deleteStudent(index),
                                    ),
                                  ],
                                ),
                              );
                            },
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
