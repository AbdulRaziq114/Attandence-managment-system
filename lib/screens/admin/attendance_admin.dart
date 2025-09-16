import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DailyAttendanceScreen extends StatefulWidget {
  const DailyAttendanceScreen({super.key});

  @override
  State<DailyAttendanceScreen> createState() => _DailyAttendanceScreenState();
}

class _DailyAttendanceScreenState extends State<DailyAttendanceScreen> {
  final Color accent = const Color.fromARGB(255, 0, 5, 43);

  String? selectedMonth = "January";
  String? selectedYear = "2025";

  // Filter Form Fields
  final _formKey = GlobalKey<FormState>();
  String? selectedBatch;
  String? selectedTech;
  String? enteredGR;

  final List<String> months = [
    "January","February","March","April","May","June",
    "July","August","September","October","November","December"
  ];
  final List<String> years = ["2023","2024","2025","2026","2027"];
  final List<String> batches = ["Batch 1", "Batch 2", "Batch 3"];
  final List<String> technologies = ["Software", "Electrical", "Auto Diesel"];

  List<Map<String, dynamic>> attendanceData = [
    {"gr": "101", "name": "Ali Khan", "1": "P", "2": "P", "3": "A", "4": "P"},
    {"gr": "102", "name": "Sara Ahmed", "1": "A", "2": "P", "3": "P", "4": "A"},
    {"gr": "103", "name": "Bilal Hussain", "1": "P", "2": "L", "3": "P", "4": "P"},
    {"gr": "104", "name": "Ayesha Noor", "1": "P", "2": "A", "3": "A", "4": "P"},
  ];

  List<String> days = [];
  int? selectedIndex;
  bool showTable = false; // toggle for filter

  List<String> generateDays(int year, int month) {
    int totalDays = DateUtils.getDaysInMonth(year, month);
    return List.generate(totalDays, (index) => (index + 1).toString());
  }

  @override
  void initState() {
    super.initState();
    int monthIndex = months.indexOf(selectedMonth!) + 1;
    days = generateDays(int.parse(selectedYear!), monthIndex);
  }

  int getStudentTotal(Map<String, dynamic> student) {
    int total = 0;
    for (var d in days) {
      if (student[d] == "P") total++;
    }
    return total;
  }

  int getDayTotal(String day) {
    int total = 0;
    for (var student in attendanceData) {
      if (student[day] == "P") total++;
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 5, 43).withOpacity(0.05),
      appBar: AppBar(
        title: const Text('Daily Attendance',
            style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: accent,
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 1,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 🔹 FILTER FORM
            Card(
              margin: const EdgeInsets.all(12),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: dropdownField(
                                "Batch", batches, selectedBatch, (val) {
                              setState(() => selectedBatch = val);
                            }),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: dropdownField(
                                "Year", years, selectedYear, (val) {
                              setState(() => selectedYear = val);
                            }),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: dropdownField("Technology", technologies,
                                selectedTech, (val) {
                              setState(() => selectedTech = val);
                            }),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: dropdownField("Month", months, selectedMonth,
                                (val) {
                              setState(() {
                                selectedMonth = val;
                                int monthIndex =
                                    months.indexOf(selectedMonth!) + 1;
                                days = generateDays(
                                    int.parse(selectedYear!), monthIndex);
                              });
                            }),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: "GR Number (Optional)",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                        onChanged: (val) => enteredGR = val,
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: accent,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 12),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        onPressed: () {
                          if (selectedBatch != null &&
                              selectedTech != null &&
                              selectedYear != null &&
                              selectedMonth != null) {
                            setState(() {
                              showTable = true;
                            });
                          }
                        },
                        child: const Text("Apply Filter",
                            style: TextStyle(color: Colors.white)),
                      )
                    ],
                  ),
                ),
              ),
            ),

            // 🔹 ATTENDANCE TABLE
            if (showTable)
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Column(
                  children: [
                    // First row -> Days Name
                    Row(
                      children: [
                        headerCell("", 80),
                        headerCell("", 120),
                        ...days.map((d) {
                          DateTime date = DateTime(
                              int.parse(selectedYear!),
                              months.indexOf(selectedMonth!) + 1,
                              int.parse(d));
                          String dayName = DateFormat('E').format(date);
                          return Container(
                            width: 60,
                            height: 40,
                            alignment: Alignment.center,
                            color: accent,
                            child: Text(dayName,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12)),
                          );
                        }),
                        headerCell("Total", 80),
                      ],
                    ),

                    // Second row -> GR, Name, Dates
                    Row(
                      children: [
                        headerCell("GR No", 80),
                        headerCell("Name", 120),
                        ...days.map((d) {
                          return Container(
                            width: 60,
                            height: 40,
                            alignment: Alignment.center,
                            color: accent,
                            child: Text(d,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)),
                          );
                        }),
                        headerCell("Present", 80),
                      ],
                    ),

                    // Data rows -> Students
                    ...attendanceData.asMap().entries.map((entry) {
                      int index = entry.key;
                      Map<String, dynamic> student = entry.value;

                      // filter GR (optional)
                      if (enteredGR != null &&
                          enteredGR!.isNotEmpty &&
                          student["gr"] != enteredGR) {
                        return const SizedBox.shrink();
                      }

                      return GestureDetector(
                        onLongPress: () {
                          setState(() {
                            selectedIndex = index;
                          });
                        },
                        child: Container(
                          color: selectedIndex == index
                              ? Colors.yellow.withOpacity(0.3)
                              : null,
                          child: Row(
                            children: [
                              dataCell(student["gr"] ?? "", 80),
                              dataCell(student["name"] ?? "", 120),
                              ...days.map((d) {
                                String status = student[d] ?? "-";
                                return dataCell(status, 60);
                              }),
                              dataCell(getStudentTotal(student).toString(), 80),
                            ],
                          ),
                        ),
                      );
                    }),

                    // Last Row -> Sum of Each Day + Total Students
                    Row(
                      children: [
                        footerCell("Total", 80),
                        footerCell(
                            "Total Students: ${attendanceData.length}", 120),
                        ...days.map((d) {
                          return footerCell(getDayTotal(d).toString(), 60);
                        }),
                        footerCell(" ", 80),
                      ],
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  // Widgets
  Widget dropdownField(String label, List<String> items, String? selectedValue,
      void Function(String?) onChanged) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        filled: true,
        fillColor: Colors.white,
      ),
      value: selectedValue,
      items: items
          .map((e) =>
              DropdownMenuItem(value: e, child: Text(e, overflow: TextOverflow.ellipsis)))
          .toList(),
      onChanged: onChanged,
    );
  }

  Widget headerCell(String text, double width) {
    return Container(
      width: width,
      height: 40,
      alignment: Alignment.center,
      color: accent,
      child: Text(text,
          style: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold)),
    );
  }

  Widget dataCell(String text, double width) {
    return Container(
      width: width,
      height: 40,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Text(text, style: const TextStyle(color: Colors.black87)),
    );
  }

  Widget footerCell(String text, double width) {
    return Container(
      width: width,
      height: 40,
      alignment: Alignment.center,
      color: accent,
      child: Text(text,
          style: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold)),
    );
  }
}
