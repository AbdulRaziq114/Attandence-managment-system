import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _formKey = GlobalKey<FormState>();
  static const Color accent = Color.fromARGB(255, 0, 5, 43);

  int selectedTab = 0; // 0 = Student, 1 = Teacher, 2 = Admin
  bool isSignUp = false;

  // Controllers
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();
  final TextEditingController _grController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();

  String? selectedTech;
  String? selectedBatch;
  String? selectedShift;

  final List<String> technologies = ["Software", "Electrical", "Auto Diesel"];
  final List<String> batches = ["2023-2026", "2024-2027", "2025-2028"];
  final List<String> shifts = ["Morning", "Evening"];

  @override
  Widget build(BuildContext context) {
    double cardWidth =
        MediaQuery.of(context).size.width > 540 ? 520 : double.infinity;

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text("Authentication Dashboard",
            style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: accent,
        elevation: 1,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 24),
        child: Center(
          child: Container(
            width: cardWidth,
            padding: const EdgeInsets.all(28),
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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
                  // Tabs with Animated underline
                  SizedBox(
                    height: 40,
                    width:300,
                    
                    child: Stack(

                      alignment: Alignment.topCenter,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            buildTab("Student", 0),
                            buildTab("Admin", 1),
                            buildTab("Teacher", 2),
                          ],
                        ),
                        AnimatedAlign(
                          alignment: selectedTab == 0
                              ? Alignment.centerLeft
                              : selectedTab == 1
                                  ? Alignment.center
                                  : Alignment.centerRight,
                          duration: const Duration(milliseconds: 200),
                          curve: Curves.easeInOut,
                          child: Container(
                            height: 3,
                            width: 60,
                            color: accent,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Dynamic form
                  if (selectedTab == 0 && isSignUp) ...[
                    buildInput(_nameController, "Name", icon: Icons.person),
                    buildInput(_surnameController, "Surname",
                        icon: Icons.person_outline),
                    buildInput(_grController, "GR Number",
                        icon: Icons.confirmation_number),
                    buildDropdown(
                      value: selectedTech,
                      label: "Select Technology",
                      items: technologies,
                      onChanged: (val) => setState(() => selectedTech = val),
                      icon: Icons.computer,
                    ),
                    buildDropdown(
                      value: selectedBatch,
                      label: "Select Batch",
                      items: batches,
                      onChanged: (val) => setState(() => selectedBatch = val),
                      icon: Icons.calendar_today,
                    ),
                    buildInput(_mobileController, "Mobile Number",
                        icon: Icons.phone),
                    buildDropdown(
                      value: selectedShift,
                      label: "Select Shift",
                      items: shifts,
                      onChanged: (val) => setState(() => selectedShift = val),
                      icon: Icons.schedule,
                    ),
                  ] else if (selectedTab == 0 && !isSignUp) ...[
                    buildInput(_nameController, "Name", icon: Icons.person),
                    buildInput(_grController, "GR Number",
                        icon: Icons.confirmation_number),
                  ] else ...[
                    buildInput(_usernameController, "Username",
                        icon: Icons.account_circle),
                    buildInput(_passwordController, "Password",
                        icon: Icons.lock, isPassword: true),
                  ],

                  const SizedBox(height: 24),

                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: accent,
                      foregroundColor: Colors.white,
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14)),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        if (selectedTab == 0) {
                          if (isSignUp) {
                            print("Student signed up!");
                          } else {
                            print("Student logged in!");
                          }
                        } else if (selectedTab == 1) {
                          print("Teacher logged in!");
                        } else {
                          print("Admin logged in!");
                        }
                      }
                    },
                    child: Text(
                      selectedTab == 0
                          ? (isSignUp ? "Sign Up" : "Login")
                          : "Login",
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),

                  const SizedBox(height: 15),

                  if (selectedTab == 0)
                    TextButton(
                      onPressed: () => setState(() {
                        isSignUp = !isSignUp;
                      }),
                      child: Text(
                        isSignUp
                            ? "Already have account? Login"
                            : "Don’t have account? Sign Up",
                        style: const TextStyle(
                            color: accent, fontWeight: FontWeight.w500),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Tabs
  Widget buildTab(String title, int index) {
    bool isActive = selectedTab == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedTab = index;
          isSignUp = false;
        });
      },
      child: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
          color: isActive ? accent : Colors.grey[600],
        ),
      ),
    );
  }

  // TextFormField
  Widget buildInput(TextEditingController controller, String label,
      {bool isPassword = false, IconData? icon}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        controller: controller,
        obscureText: isPassword,
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: accent),
          labelText: label,
          filled: true,
          fillColor: Colors.grey[50],
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(color: accent, width: 1)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(color: accent, width: 2)),
        ),
      ),
    );
  }

  // Dropdown
  Widget buildDropdown({
    required String? value,
    required String label,
    required List<String> items,
    required void Function(String?) onChanged,
    IconData? icon,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: DropdownButtonFormField<String>(
        value: value,
        items: items
            .map((e) => DropdownMenuItem(value: e, child: Text(e)))
            .toList(),
        onChanged: onChanged,
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: accent),
          labelText: label,
          filled: true,
          fillColor: Colors.grey[50],
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(color: accent, width: 1)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(color: accent, width: 2)),
        ),
      ),
    );
  }
}
