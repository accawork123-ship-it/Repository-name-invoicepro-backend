import 'package:flutter/material.dart';
import 'pages/register.dart';
import 'pages/LoginPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'InvoicePro',

      routes: {
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
      },

      home: const LandingPage(),
    );
  }
}

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F6FB),

      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 40),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.inventory_2, color: Colors.blue, size: 32),
                SizedBox(width: 10),
                Text(
                  "InvoicePro",
                  style: TextStyle(
                      fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ],
            ),

            const SizedBox(height: 30),

            const Text(
              "Complete Inventory & Billing Solution",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 26, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "Streamline your business operations with powerful inventory management and billing.",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),
            ),

            const SizedBox(height: 20),

            /// ✅ BUTTON FIXED
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/register');
                  },
                  child: const Text("Get Started"),
                ),
                const SizedBox(width: 10),
                OutlinedButton(
                  onPressed: () {
                     Navigator.pushNamed(context, '/login'); // ✅ GO TO LOGIN PAGE
                  },
                  child: const Text("Login"),
                ),
              ],
            ),

            const SizedBox(height: 30),

            /// ✅ FEATURE SECTION (NOW WORKING)
            buildFeatureSection(context),

            const SizedBox(height: 30),

            /// ❌ REMOVE CONST FROM HERE (IMPORTANT FIX)
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.symmetric(vertical: 15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 8,
                    color: Colors.grey.shade300,
                  )
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  StatItem(title: "100%", subtitle: "Cloud"),
                  StatItem(title: "Real-Time", subtitle: "Sync"),
                  StatItem(title: "Secure", subtitle: "Data"),
                ],
              ),
            ),

            const SizedBox(height: 30),

            const Text(
              "© 2026 BMA Solutions",
              style: TextStyle(color: Colors.grey),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

/// ✅ ADD THIS FUNCTION (YOU WERE MISSING THIS)
Widget buildFeatureSection(BuildContext context) {
  double width = MediaQuery.of(context).size.width;

  int crossAxisCount = width < 600 ? 2 : 3;

  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 15),
    child: GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: crossAxisCount,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      childAspectRatio: width < 600 ? 1.3 : 1.5,
      children: const [
        FeatureCard(icon: Icons.inventory, title: "Inventory", desc: "Track stock"),
        FeatureCard(icon: Icons.receipt_long, title: "Billing", desc: "Smart invoices"),
        FeatureCard(icon: Icons.people, title: "Customers", desc: "Manage ledger"),
        FeatureCard(icon: Icons.bar_chart, title: "Finance", desc: "Cash flow"),
        FeatureCard(icon: Icons.analytics, title: "Analytics", desc: "Insights"),
        FeatureCard(icon: Icons.security, title: "Security", desc: "Role access"),
      ],
    ),
  );
}

/// ✅ ADD THIS CLASS (YOU WERE MISSING THIS)
class FeatureCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String desc;

  const FeatureCard({
    super.key,
    required this.icon,
    required this.title,
    required this.desc,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            blurRadius: 6,
            color: Colors.grey.shade300,
          )
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 22, color: Colors.blue),
          const SizedBox(height: 5),
          Text(title,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
          const SizedBox(height: 3),
          Text(desc,
              style: const TextStyle(fontSize: 10, color: Colors.grey)),
        ],
      ),
    );
  }
}

/// ✅ ADD THIS CLASS (YOU WERE MISSING THIS)
class StatItem extends StatelessWidget {
  final String title;
  final String subtitle;

  const StatItem({super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(title,
            style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.blue)),
        const SizedBox(height: 5),
        Text(subtitle, style: const TextStyle(color: Colors.grey)),
      ],
    );
  }
}