import 'package:flutter/material.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff5f6fa),
      appBar: AppBar(
        title: const Text("Dashboard"),
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              const Text(
                "Overview of your business",
                style: TextStyle(color: Colors.grey),
              ),

              const SizedBox(height: 20),

              /// 🔹 METRIC CARDS
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1.6,
                children: const [
                  DashboardCard(
                    title: "Sales Today",
                    value: "Rs. 12,500",
                    color: Colors.green,
                    icon: Icons.trending_up,
                  ),
                  DashboardCard(
                    title: "Low Stock Items",
                    value: "3",
                    color: Colors.orange,
                    icon: Icons.warning,
                  ),
                  DashboardCard(
                    title: "Closing Till",
                    value: "Rs. 45,000",
                    color: Colors.blue,
                    icon: Icons.account_balance_wallet,
                  ),
                  DashboardCard(
                    title: "Total Customers",
                    value: "24",
                    color: Colors.purple,
                    icon: Icons.people,
                  ),
                ],
              ),

              const SizedBox(height: 20),

              /// 🔹 RECENT SALES / INVOICES
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Recent Sales",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    const Divider(),

                    /// Example empty state
                    SizedBox(
                      height: 120,
                      child: Center(
                        child: Text(
                          "No sales yet",
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              /// 🔹 LOW STOCK ALERT LIST
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    const Text(
                      "Low Stock Alerts",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),

                    const SizedBox(height: 10),
                    const Divider(),

                    LowStockItem(
                      name: "Mechanical Keyboard",
                      sku: "KB-002",
                      qty: 8,
                      min: 10,
                    ),
                    LowStockItem(
                      name: "Laptop Stand",
                      sku: "LS-004",
                      qty: 5,
                      min: 10,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


/// 🔹 CARD WIDGET
class DashboardCard extends StatelessWidget {
  final String title;
  final String value;
  final Color color;
  final IconData icon;

  const DashboardCard({
    super.key,
    required this.title,
    required this.value,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          /// TEXT
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(title, style: const TextStyle(color: Colors.grey)),
              const SizedBox(height: 6),
              Text(
                value,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),

          /// ICON
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withOpacity(0.15),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: color),
          )
        ],
      ),
    );
  }
}

/// 🔹 LOW STOCK ITEM
class LowStockItem extends StatelessWidget {
  final String name;
  final String sku;
  final int qty;
  final int min;

  const LowStockItem({
    super.key,
    required this.name,
    required this.sku,
    required this.qty,
    required this.min,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [

          /// LEFT SIDE
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name, style: const TextStyle(fontWeight: FontWeight.w500)),
              Text("SKU: $sku", style: const TextStyle(color: Colors.grey)),
            ],
          ),

          /// RIGHT SIDE
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "$qty left",
                style: const TextStyle(
                    color: Colors.red, fontWeight: FontWeight.bold),
              ),
              Text("Min: $min", style: const TextStyle(color: Colors.grey)),
            ],
          ),
        ],
      ),
    );
  }
}