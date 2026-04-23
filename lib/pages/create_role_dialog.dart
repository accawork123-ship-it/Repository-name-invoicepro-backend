import 'package:flutter/material.dart';

class CreateRoleDialog extends StatefulWidget {
  final int businessId; // ✅ ADDED

  const CreateRoleDialog({
    super.key,
    required this.businessId, // ✅ ADDED
  });

  @override
  State<CreateRoleDialog> createState() => _CreateRoleDialogState();
}

class _CreateRoleDialogState extends State<CreateRoleDialog> {

  final TextEditingController roleNameController = TextEditingController();

  bool isLoading = false;

  // ✅ MODULES & PERMISSIONS (RBAC BASE)
  final Map<String, List<String>> modules = {
    "Inventory Management": ["View", "Add", "Delete", "Full"],
    "Billing": ["View", "Add", "Delete", "Full"],
    "Purchases": ["View", "Add", "Delete", "Full"],
    "Expense Management": ["View", "Add", "Delete", "Full"],
    "Till Book": ["View", "Open", "Close", "Lock", "Delete Entry"],
  };

  Map<String, Map<String, bool>> selectedPermissions = {};

  @override
  void initState() {
    super.initState();

    for (var module in modules.keys) {
      selectedPermissions[module] = {};
      for (var action in modules[module]!) {
        selectedPermissions[module]![action] = false;
      }
    }
  }

  // ================================
  // SAVE ROLE FUNCTION
  // ================================
  Future<void> saveRole() async {

    if (roleNameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Enter role name")),
      );
      return;
    }

    // Extract selected permissions
    Map<String, List<String>> finalPermissions = {};

    selectedPermissions.forEach((module, actions) {
      List<String> selected = actions.entries
          .where((e) => e.value)
          .map((e) => e.key)
          .toList();

      if (selected.isNotEmpty) {
        finalPermissions[module] = selected;
      }
    });

    if (finalPermissions.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Select at least one permission")),
      );
      return;
    }

    setState(() => isLoading = true);

    try {
      // 🔥 FUTURE BACKEND API
      /*
      await ApiService.createRole(
        businessId: widget.businessId,
        roleName: roleNameController.text,
        permissions: finalPermissions,
      );
      */

      await Future.delayed(const Duration(seconds: 1));

      setState(() => isLoading = false);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Role Created Successfully")),
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
        width: 500,
        padding: const EdgeInsets.all(20),

        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              /// TITLE
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Create Custom Role",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  )
                ],
              ),

              const SizedBox(height: 20),

              /// ROLE NAME
              const Text("Role Name *"),
              const SizedBox(height: 5),
              TextField(
                controller: roleNameController,
                decoration: InputDecoration(
                  hintText: "e.g. Accountant / Manager",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              /// PERMISSIONS
              const Text(
                "Assign Permissions",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 10),

              ...modules.keys.map((module) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Text(
                      module,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),

                    Wrap(
                      children: modules[module]!.map((action) {
                        return Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Checkbox(
                              value: selectedPermissions[module]![action],
                              onChanged: (value) {
                                setState(() {
                                  selectedPermissions[module]![action] = value!;
                                });
                              },
                            ),
                            Text(action),
                          ],
                        );
                      }).toList(),
                    ),

                    const Divider(),
                  ],
                );
              }),

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
                      onPressed: isLoading ? null : saveRole,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                      ),
                      child: isLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text("Save Role"),
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
}