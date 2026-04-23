import 'package:flutter/material.dart';

class AddUserDialog extends StatefulWidget {
  final int businessId; // ✅ ADDED

  const AddUserDialog({
    super.key,
    required this.businessId, // ✅ ADDED
  });

  @override
  State<AddUserDialog> createState() => _AddUserDialogState();
}

class _AddUserDialogState extends State<AddUserDialog> {

  final TextEditingController nameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController pinController = TextEditingController();

  bool obscurePin = true;
  bool isLoading = false;

  // Roles
  Map<String, bool> roles = {
    "IT and Systems Admin": false,
    "Managers": false,
    "Accountants": false,
    "Supervisors": false,
    "Store Keepers": true,
    "Viewers": false,
  };

  // ================================
  // ADD USER FUNCTION
  // ================================
  Future<void> addUser() async {

    if (nameController.text.isEmpty ||
        usernameController.text.isEmpty ||
        pinController.text.length != 4) {

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Fill all fields correctly")),
      );
      return;
    }

    // Check at least one role
    List<String> selectedRoles =
        roles.entries.where((e) => e.value).map((e) => e.key).toList();

    if (selectedRoles.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Select at least one role")),
      );
      return;
    }

    setState(() => isLoading = true);

    try {
      // 🔥 FUTURE BACKEND CALL
      /*
      await ApiService.createUser(
        businessId: widget.businessId,
        name: nameController.text,
        username: usernameController.text,
        pin: pinController.text,
        roles: selectedRoles,
      );
      */

      await Future.delayed(const Duration(seconds: 1)); // temporary

      setState(() => isLoading = false);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("User Added Successfully")),
      );

      Navigator.pop(context);

    } catch (e) {
      setState(() => isLoading = false);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        width: 400,
        padding: const EdgeInsets.all(20),

        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              /// HEADER
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Add New User",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  )
                ],
              ),

              const SizedBox(height: 20),

              /// NAME
              const Text("Full Name *"),
              const SizedBox(height: 5),
              TextField(
                controller: nameController,
                decoration: inputDecoration("Enter full name"),
              ),

              const SizedBox(height: 15),

              /// USERNAME
              const Text("Username *"),
              const SizedBox(height: 5),
              TextField(
                controller: usernameController,
                decoration: inputDecoration("Enter username"),
              ),

              const SizedBox(height: 15),

              /// PIN
              const Text("4-Digit PIN Code *"),
              const SizedBox(height: 5),
              TextField(
                controller: pinController,
                keyboardType: TextInputType.number,
                obscureText: obscurePin,
                maxLength: 4,
                decoration: InputDecoration(
                  hintText: "1234",
                  prefixIcon: const Icon(Icons.key),
                  suffixIcon: IconButton(
                    icon: Icon(
                      obscurePin ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        obscurePin = !obscurePin;
                      });
                    },
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),

              const SizedBox(height: 15),

              /// ROLES
              const Text("Roles *"),
              const SizedBox(height: 10),

              Container(
                height: 200,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(10),
                ),

                child: ListView(
                  children: roles.keys.map((role) {
                    return CheckboxListTile(
                      value: roles[role],
                      title: Text(role),
                      onChanged: (value) {
                        setState(() {
                          roles[role] = value!;
                        });
                      },
                    );
                  }).toList(),
                ),
              ),

              const SizedBox(height: 20),

              /// BUTTONS
              Row(
                children: [

                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text("Cancel"),
                    ),
                  ),

                  const SizedBox(width: 10),

                  Expanded(
                    child: ElevatedButton(
                      onPressed: isLoading ? null : addUser,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                      ),
                      child: isLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text("Add User"),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}