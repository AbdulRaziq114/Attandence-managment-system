import 'package:flutter/material.dart';
import 'admin/dashboard.dart';
import 'admin/batches_years.dart';
import 'admin/technologies.dart';
import 'admin/teachers.dart';
import 'admin/timetable.dart';
import 'admin/students.dart';
import 'admin/attendance_admin.dart';
import 'admin/attendance_teachers.dart';
import 'admin/sign.dart';
import 'admin/scane.dart';


class AdminPanel extends StatefulWidget {
  const AdminPanel({super.key});

  @override
  State<AdminPanel> createState() => _AdminPanelState();
}

class _AdminPanelState extends State<AdminPanel> {
  int _selectedIndex = 0;

  final List<String> options = [
    "Dashboard",
    "Batches & Years Setup",
    "Technologies Manage",
    "Teachers Manage",
    "Timetable Manage",
    "Students Manage",
    "DailyAttendanceScreen",
    "Attendance (Period-wise - Teachers)",
    "AuthScreen",
    "QRAttendanceScreen"
   
  ];
  final List<Widget> screens = [
    const DashboardScreen(),
    const BatchesYearsScreen(),
    const TechnologiesScreen(),
    const TeachersScreen(),
    const TimetableScreen(),
    const StudentsScreen(),
    const DailyAttendanceScreen(),
    const AttendanceTeachersScreen(),
    const AuthScreen(),
    const QRAttendanceScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255), // Dark background
      appBar: AppBar(
        elevation: 4,
        backgroundColor: Color.fromARGB(255, 0, 5, 43), // Dark AppBar
        iconTheme: const IconThemeData(
          color: Colors.white, // <-- Navigation icon color white
        ),
        title: const Text(
          "Attendance Management System",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
            letterSpacing: 1.1,
            shadows: [
              Shadow(
                color: Colors.black26,
                blurRadius: 4,
                offset: Offset(1, 2),
              ),
            ],
          ),
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
        ),
        centerTitle: true,
      ),
      drawer: Drawer(
        backgroundColor:const Color.fromARGB(255, 0, 5, 43), // Dark drawer
        child: Column(
          children: [
            // Profile section
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 16),
              color: const Color.fromARGB(255, 0, 4, 34),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 28,
                    backgroundColor: Colors.grey[900],
                    child: const Icon(Icons.admin_panel_settings, size: 32, color: Colors.white),
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "Admin Panel",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        "Welcome!",
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // List
            Expanded(
              child: ListView.builder(
                itemCount: options.length,
                itemBuilder: (context, index) {
                  final isSelected = _selectedIndex == index;
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? const Color.fromARGB(255, 255, 255, 255).withOpacity(0.25)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: ListTile(
                      leading: Icon(
                        Icons.arrow_right,
                        color: isSelected ? const Color.fromARGB(255, 255, 255, 255) : Colors.white70,
                      ),
                      title: Text(
                        options[index], 
                        style: TextStyle(
                          color: isSelected ? const Color.fromARGB(255, 255, 255, 255) : Colors.white,
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                      selected: isSelected,
                      onTap: () {
                        setState(() {
                          _selectedIndex = index;
                        }); 
                        Navigator.pop(context);
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      body: screens[_selectedIndex],
    );
  }
}
