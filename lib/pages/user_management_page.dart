import 'package:flutter/material.dart';
import 'add_user_dialog.dart';
import 'create_role_dialog.dart';

class UserManagementPage extends StatelessWidget {
  final int businessId; // ✅ ADDED

  const UserManagementPage({
    super.key,
    required this.businessId, // ✅ ADDED
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FA),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              /// HEADER
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade200,
                      blurRadius: 10,
                    )
                  ],
                ),
                child: Row(
                  children: [

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "User Management",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            "Set up user accounts for your team with role-based access control",
                          ),
                          SizedBox(height: 15),
                          Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: "Getting Started: ",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                TextSpan(
                                  text:
                                      "Add users, assign roles, and control access securely.",
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    const Icon(
                      Icons.group,
                      size: 60,
                      color: Colors.blue,
                    )
                  ],
                ),
              ),

              const SizedBox(height: 20),

              /// BUTTONS
              Row(
                children: [

                  /// ADD USER
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => AddUserDialog(
                            businessId: businessId, // ✅ PASS
                          ),
                        );
                      },
                      icon: const Icon(Icons.add),
                      label: const Text("Add New User"),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 10),

                  /// CREATE ROLE
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => CreateRoleDialog(
                            businessId: businessId, // ✅ PASS
                          ),
                        );
                      },
                      icon: const Icon(Icons.security),
                      label: const Text("Create Role"),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        backgroundColor: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              /// TABLE
              Expanded(
                child: LayoutBuilder(
                  builder: (context, constraints) {

                    /// MOBILE
                    if (constraints.maxWidth < 600) {
                      return Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: const Center(
                          child: Text("No users yet"),
                        ),
                      );
                    }

                    /// DESKTOP
                    return Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Center(
                        child: Text("User table will appear here"),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}