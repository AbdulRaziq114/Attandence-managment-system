import 'package:flutter/material.dart';

class TimetableScreen extends StatefulWidget {
  const TimetableScreen({super.key});

  @override
  State<TimetableScreen> createState() => _TimetableScreenState();
}

class _TimetableScreenState extends State<TimetableScreen> {
  final _formKey = GlobalKey<FormState>();
  final Color accent = const Color.fromARGB(255, 0, 5, 43);

  final List<String> days = [
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday"
  ];

  final List<Map<String, TextEditingController>> periods = [];
  final Map<String, Map<int, Map<String, TextEditingController>>> inputs = {};

  final List<Map<String, dynamic>> savedTimetables = [];

  String _timetableName = "";
  final TextEditingController _nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _initPeriods(4);
  }

  void _initPeriods(int count) {
    periods.clear();
    for (int i = 0; i < count; i++) {
      periods.add({
        "time": TextEditingController(text: "Period ${i + 1} Time"),
      });
    }
    inputs.clear();
    for (var day in days) {
      inputs[day] = {};
      for (int i = 0; i < periods.length; i++) {
        inputs[day]![i] = {
          "subject": TextEditingController(),
          "teacher": TextEditingController(),
        };
      }
    }
  }

  void _addPeriod() {
    setState(() {
      int newIndex = periods.length;
      periods.add({
        "time": TextEditingController(text: "Period ${newIndex + 1} Time"),
      });
      for (var day in days) {
        inputs[day]![newIndex] = {
          "subject": TextEditingController(),
          "teacher": TextEditingController(),
        };
      }
    });
  }

  void _deletePeriod(int index) {
    setState(() {
      periods.removeAt(index);
      for (var day in days) {
        inputs[day]!.remove(index);
      }
    });
  }

  void _saveTimetable() {
    if (_formKey.currentState!.validate()) {
      Map<String, dynamic> data = {
        "name": _timetableName,
        "periods": periods.map((p) => p["time"]!.text).toList(),
        "days": days,
        "inputs": {
          for (var day in days)
            day: {
              for (int i = 0; i < periods.length; i++)
                i: {
                  "subject": inputs[day]![i]!["subject"]!.text,
                  "teacher": inputs[day]![i]!["teacher"]!.text,
                }
            }
        }
      };

      setState(() {
        savedTimetables.add(data);
        _timetableName = "";
        _nameController.clear();
        _initPeriods(4);
      });
    }
  }

  void _deleteTimetable(int index) {
    setState(() {
      savedTimetables.removeAt(index);
    });
  }

  void _editTimetable(int index) {
    var t = savedTimetables[index];

    setState(() {
      _timetableName = t["name"];
      _nameController.text = t["name"];
      _initPeriods(t["periods"].length);

      for (int i = 0; i < t["periods"].length; i++) {
        periods[i]["time"]!.text = t["periods"][i];
      }

      for (var day in days) {
        for (int i = 0; i < periods.length; i++) {
          inputs[day]![i]!["subject"]!.text = t["inputs"][day][i]["subject"];
          inputs[day]![i]!["teacher"]!.text = t["inputs"][day][i]["teacher"];
        }
      }

      savedTimetables.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            const Text("Manage Timetable", style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: accent,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addPeriod,
        backgroundColor: accent,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      labelText: "Timetable Name",
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: accent),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: accent, width: 2),
                      ),
                    ),
                    onChanged: (val) => _timetableName = val,
                    validator: (val) =>
                        val == null || val.isEmpty ? "Enter name" : null,
                  ),
                  const SizedBox(height: 20),

                  // 👉 Form table with conditional scroll
                 SingleChildScrollView(
  scrollDirection: Axis.horizontal,
  child: ConstrainedBox(
    constraints: BoxConstraints(
      minWidth: days.length * 160 .toDouble(), // har column approx 160px
    ),
    child: Table(
      border: TableBorder.all(color: accent.withOpacity(0.3)),
      defaultColumnWidth: const FixedColumnWidth(160), // fix column width
      children: [
        // 👇 header row
        TableRow(
          decoration: BoxDecoration(color: accent),
          children: [
            const TableCell(
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Text("Periods/Days",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white)),
              ),
            ),
            ...days.map(
              (d) => TableCell(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    d,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
              ),
            )
          ],
        ),

        // 👇 dynamic rows
        ...periods.asMap().entries.map((entry) {
          int index = entry.key;
          var timeCtrl = entry.value["time"]!;
          return TableRow(
            children: [
              TableCell(
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(6),
                        child: TextFormField(
                          controller: timeCtrl,
                          decoration: const InputDecoration(
                            labelText: "Time",
                            isDense: true,
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () => _deletePeriod(index),
                    )
                  ],
                ),
              ),
              ...days.map((d) {
                return TableCell(
                  child: Padding(
                    padding: const EdgeInsets.all(6),
                    child: Column(
                      children: [
                        TextFormField(
                          controller: inputs[d]![index]!["subject"],
                          decoration: const InputDecoration(
                            labelText: "Subject",
                            isDense: true,
                          ),
                        ),
                        const SizedBox(height: 4),
                        TextFormField(
                          controller: inputs[d]![index]!["teacher"],
                          decoration: const InputDecoration(
                            labelText: "Teacher",
                            isDense: true,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ],
          );
        }),
      ],
    ),
  ),
),

                  const SizedBox(height: 20),

                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: accent,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 15),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                    onPressed: _saveTimetable,
                    child: const Text("Save Timetable",
                        style: TextStyle(fontSize: 16, color: Colors.white)),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // 👉 Preview tables
            ...savedTimetables.asMap().entries.map((entry) {
              int idx = entry.key;
              var t = entry.value;

              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Preview: ${t["name"]}",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: accent),
                      ),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () => _editTimetable(idx),
                            icon: Icon(Icons.edit, color: accent),
                          ),
                          IconButton(
                            onPressed: () => _deleteTimetable(idx),
                            icon: const Icon(Icons.delete, color: Colors.red),
                          ),
                        ],  
                      ),
                    ],
                  ),
                  // Preview Section
const SizedBox(height: 20),
Text(
  "Preview",
  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: accent),
),

const SizedBox(height: 10),
// 👇 Preview Section
SingleChildScrollView(
  scrollDirection: Axis.horizontal,
  child: ConstrainedBox(
    constraints: BoxConstraints(
      minWidth: t["days"].length * 160 .toDouble(), // savedTimetable ke days
    ),
    child: Table(
      border: TableBorder.all(color: accent.withOpacity(0.3)),
      defaultColumnWidth: const FixedColumnWidth(160),
      children: [
        // Header Row
        TableRow(
          decoration: BoxDecoration(color: accent),
          children: [
            const TableCell(
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Text("Periods/Days",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white)),
              ),
            ),
            ...t["days"].map<TableCell>(
              (d) => TableCell(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    d,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
              ),
            )
          ],
        ),

        // 👇 Dynamic Rows (ab savedTimetable se data lega)
        ...t["periods"].asMap().entries.map((entry) {
          int index = entry.key;
          String time = entry.value;
          return TableRow(
            children: [
              TableCell(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(time.isEmpty ? "N/A" : time),
                ),
              ),
              ...t["days"].map<TableCell>((d) {
                var subject = t["inputs"][d][index]["subject"];
                var teacher = t["inputs"][d][index]["teacher"];
                return TableCell(
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(subject.isEmpty ? "-" : subject,
                            style: const TextStyle(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 4),
                        Text(teacher.isEmpty ? "-" : teacher,
                            style: const TextStyle(color: Colors.grey)),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ],
          );
        }),
      ],
    ),
  ),
),

                  const SizedBox(height: 25),
                ],
              );
            }),
          ],
        ),
      ),
    );
  }
}
