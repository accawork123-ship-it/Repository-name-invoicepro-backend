import 'package:flutter/material.dart';
import 'user_management_page.dart';

class AdminRegisterPage extends StatefulWidget {
  final String businessName;
  final int businessId;

  const AdminRegisterPage({
    super.key,
    required this.businessName,
    required this.businessId,
  });

  @override
  State<AdminRegisterPage> createState() => _AdminRegisterPageState();
}

class _AdminRegisterPageState extends State<AdminRegisterPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController cnicController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final TextEditingController adpincodeController = TextEditingController();

  bool isLoading = false;
  bool obscurePin = true;

  Future<void> submitForm() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => isLoading = true);

    try {
      // 🔥 (Next step: connect API here)

      await Future.delayed(const Duration(seconds: 1));

      setState(() => isLoading = false);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Admin Registered Successfully")),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => UserManagementPage(
            businessId: widget.businessId, // ✅ pass forward
          ),
        ),
      );

    } catch (e) {
      setState(() => isLoading = false);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FA),

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Back to Business Info",
          style: TextStyle(color: Colors.black),
        ),
      ),

      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Center(
                child: Container(
                  width: 420,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),

                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [

                        Text(
                          "Create admin for ${widget.businessName}",
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),

                        const SizedBox(height: 20),

                        TextFormField(
                          controller: fullNameController,
                          decoration: inputDecoration("Full Name"),
                          validator: (v) =>
                              v!.isEmpty ? "Enter full name" : null,
                        ),

                        const SizedBox(height: 10),

                        TextFormField(
                          controller: emailController,
                          decoration: inputDecoration("Email"),
                          validator: (v) =>
                              v!.contains("@") ? null : "Invalid email",
                        ),

                        const SizedBox(height: 10),

                        TextFormField(
                          controller: passwordController,
                          obscureText: true,
                          decoration: inputDecoration("Password"),
                          validator: (v) =>
                              v!.length < 6 ? "Min 6 chars" : null,
                        ),

                        const SizedBox(height: 10),

                        TextFormField(
                          controller: confirmPasswordController,
                          obscureText: true,
                          decoration: inputDecoration("Confirm Password"),
                          validator: (v) =>
                              v != passwordController.text
                                  ? "Passwords not match"
                                  : null,
                        ),

                        const SizedBox(height: 20),

                        ElevatedButton(
                          onPressed: isLoading ? null : submitForm,
                          child: isLoading
                              ? const CircularProgressIndicator()
                              : const Text("Complete Registration"),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
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