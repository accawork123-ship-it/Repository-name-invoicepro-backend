import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  // Controllers to get user input
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool rememberMe = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      // Light background like your design
      backgroundColor: const Color(0xFFEFF3F9),

      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(

            child: Container(
              width: 420, // keeps UI centered (web + mobile)
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(24),

              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  /// 🔙 BACK BUTTON
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      const Text(""),
                    ],
                  ),

                  const SizedBox(height: 10),

                  /// 🔷 LOGO + TITLE
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(Icons.inventory, color: Colors.white),
                      ),

                      const SizedBox(width: 10),

                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "InvoicePro",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                          Text("by BMA Solutions"),
                        ],
                      )
                    ],
                  ),

                  const SizedBox(height: 25),

                  /// 🏷 TITLE
                  const Center(
                    child: Column(
                      children: [
                        Text(
                          "Welcome Back",
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 5),
                        Text("Login to access your account"),
                      ],
                    ),
                  ),

                  const SizedBox(height: 30),

                  /// 📧 EMAIL
                  const Text("Email Address"),
                  const SizedBox(height: 8),

                  TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      hintText: "Enter your email",
                      prefixIcon: const Icon(Icons.email_outlined),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  /// 🔒 PASSWORD
                  const Text("Password"),
                  const SizedBox(height: 8),

                  TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: "Enter your password",
                      prefixIcon: const Icon(Icons.lock_outline),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),

                  const SizedBox(height: 15),

                  /// ☑ REMEMBER + FORGOT
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      Row(
                        children: [
                          Checkbox(
                            value: rememberMe,
                            onChanged: (value) {
                              setState(() {
                                rememberMe = value!;
                              });
                            },
                          ),
                          const Text("Remember me"),
                        ],
                      ),

                      TextButton(
                        onPressed: () {},
                        child: const Text("Forgot password?"),
                      ),
                    ],
                  ),

                  const SizedBox(height: 15),

                  /// 🔵 LOGIN BUTTON
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        print("Login clicked");
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        "Login",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  /// ➖ DIVIDER TEXT
                  Row(
                    children: const [
                      Expanded(child: Divider()),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Text("Not Registered ?"),
                      ),
                      Expanded(child: Divider()),
                    ],
                  ),

                  const SizedBox(height: 20),

                  /// ⚪ REGISTER BUTTON
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/register');
                      },
                      style: OutlinedButton.styleFrom(
                        backgroundColor: const Color(0xFFF3F4F6),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        "Register Your Business",
                        style: TextStyle(color: Colors.black),
                      ),
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
}