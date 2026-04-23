import 'package:flutter/material.dart';
import 'LoginPage.dart';
import 'admin_register_page.dart';
import 'package:newapp/services/api_service.dart';
import 'package:flutter/services.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  final _formKey = GlobalKey<FormState>();

  final TextEditingController businessNameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController taxIdController = TextEditingController();

  

  String? selectedBusinessType;
  String? selectedCity;

  String selectedCountryCode = "+92";

  bool isChecked = false;
  bool isLoading = false;
  bool isNTNRequired = false;

  final List<String> pakistanCities = [
    "Abbottabad","Attock","Bahawalnagar","Bahawalpur","Chaman","Chiniot",
    "Dera Ghazi Khan","Faisalabad","Gilgit","Gujranwala","Gujrat","Gwadar",
    "Hyderabad","Islamabad","Jacobabad","Jhang","Karachi","Kasur","Khairpur",
    "Kohat","Lahore","Larkana","Mardan","Multan","Muzaffarabad","Nawabshah",
    "Okara","Peshawar","Quetta","Rahim Yar Khan","Rawalpindi","Sahiwal",
    "Sargodha","Sheikhupura","Sialkot","Sukkur","Swat","Turbat","Vehari"
  ]..sort();

  // ✅ FULL COUNTRY LIST (EXTENDABLE)
final List<Map<String, String>> countries = [
  {"code": "+1", "flag": "🇺🇸"},
  {"code": "+7", "flag": "🇷🇺"},
  {"code": "+20", "flag": "🇪🇬"},
  {"code": "+27", "flag": "🇿🇦"},
  {"code": "+30", "flag": "🇬🇷"},
  {"code": "+31", "flag": "🇳🇱"},
  {"code": "+32", "flag": "🇧🇪"},
  {"code": "+33", "flag": "🇫🇷"},
  {"code": "+34", "flag": "🇪🇸"},
  {"code": "+36", "flag": "🇭🇺"},
  {"code": "+39", "flag": "🇮🇹"},
  {"code": "+40", "flag": "🇷🇴"},
  {"code": "+41", "flag": "🇨🇭"},
  {"code": "+43", "flag": "🇦🇹"},
  {"code": "+44", "flag": "🇬🇧"},
  {"code": "+45", "flag": "🇩🇰"},
  {"code": "+46", "flag": "🇸🇪"},
  {"code": "+47", "flag": "🇳🇴"},
  {"code": "+48", "flag": "🇵🇱"},
  {"code": "+49", "flag": "🇩🇪"},
  {"code": "+51", "flag": "🇵🇪"},
  {"code": "+52", "flag": "🇲🇽"},
  {"code": "+53", "flag": "🇨🇺"},
  {"code": "+54", "flag": "🇦🇷"},
  {"code": "+55", "flag": "🇧🇷"},
  {"code": "+56", "flag": "🇨🇱"},
  {"code": "+57", "flag": "🇨🇴"},
  {"code": "+58", "flag": "🇻🇪"},
  {"code": "+60", "flag": "🇲🇾"},
  {"code": "+61", "flag": "🇦🇺"},
  {"code": "+62", "flag": "🇮🇩"},
  {"code": "+63", "flag": "🇵🇭"},
  {"code": "+64", "flag": "🇳🇿"},
  {"code": "+65", "flag": "🇸🇬"},
  {"code": "+66", "flag": "🇹🇭"},
  {"code": "+81", "flag": "🇯🇵"},
  {"code": "+82", "flag": "🇰🇷"},
  {"code": "+84", "flag": "🇻🇳"},
  {"code": "+86", "flag": "🇨🇳"},
  {"code": "+90", "flag": "🇹🇷"},
  {"code": "+91", "flag": "🇮🇳"},
  {"code": "+92", "flag": "🇵🇰"},
  {"code": "+93", "flag": "🇦🇫"},
  {"code": "+94", "flag": "🇱🇰"},
  {"code": "+95", "flag": "🇲🇲"},
  {"code": "+98", "flag": "🇮🇷"},
  {"code": "+211", "flag": "🇸🇸"},
  {"code": "+212", "flag": "🇲🇦"},
  {"code": "+213", "flag": "🇩🇿"},
  {"code": "+216", "flag": "🇹🇳"},
  {"code": "+218", "flag": "🇱🇾"},
  {"code": "+220", "flag": "🇬🇲"},
  {"code": "+221", "flag": "🇸🇳"},
  {"code": "+222", "flag": "🇲🇷"},
  {"code": "+223", "flag": "🇲🇱"},
  {"code": "+224", "flag": "🇬🇳"},
  {"code": "+225", "flag": "🇨🇮"},
  {"code": "+226", "flag": "🇧🇫"},
  {"code": "+227", "flag": "🇳🇪"},
  {"code": "+228", "flag": "🇹🇬"},
  {"code": "+229", "flag": "🇧🇯"},
  {"code": "+230", "flag": "🇲🇺"},
  {"code": "+231", "flag": "🇱🇷"},
  {"code": "+232", "flag": "🇸🇱"},
  {"code": "+233", "flag": "🇬🇭"},
  {"code": "+234", "flag": "🇳🇬"},
  {"code": "+235", "flag": "🇹🇩"},
  {"code": "+236", "flag": "🇨🇫"},
  {"code": "+237", "flag": "🇨🇲"},
  {"code": "+238", "flag": "🇨🇻"},
  {"code": "+239", "flag": "🇸🇹"},
  {"code": "+240", "flag": "🇬🇶"},
  {"code": "+241", "flag": "🇬🇦"},
  {"code": "+242", "flag": "🇨🇬"},
  {"code": "+243", "flag": "🇨🇩"},
  {"code": "+244", "flag": "🇦🇴"},
  {"code": "+245", "flag": "🇬🇼"},
  {"code": "+248", "flag": "🇸🇨"},
  {"code": "+249", "flag": "🇸🇩"},
  {"code": "+250", "flag": "🇷🇼"},
  {"code": "+251", "flag": "🇪🇹"},
  {"code": "+252", "flag": "🇸🇴"},
  {"code": "+253", "flag": "🇩🇯"},
  {"code": "+254", "flag": "🇰🇪"},
  {"code": "+255", "flag": "🇹🇿"},
  {"code": "+256", "flag": "🇺🇬"},
  {"code": "+257", "flag": "🇧🇮"},
  {"code": "+258", "flag": "🇲🇿"},
  {"code": "+260", "flag": "🇿🇲"},
  {"code": "+261", "flag": "🇲🇬"},
  {"code": "+262", "flag": "🇷🇪"},
  {"code": "+263", "flag": "🇿🇼"},
  {"code": "+264", "flag": "🇳🇦"},
  {"code": "+265", "flag": "🇲🇼"},
  {"code": "+266", "flag": "🇱🇸"},
  {"code": "+267", "flag": "🇧🇼"},
  {"code": "+268", "flag": "🇸🇿"},
  {"code": "+269", "flag": "🇰🇲"},
  {"code": "+290", "flag": "🇸🇭"},
  {"code": "+291", "flag": "🇪🇷"},
  {"code": "+297", "flag": "🇦🇼"},
  {"code": "+298", "flag": "🇫🇴"},
  {"code": "+299", "flag": "🇬🇱"},
];

  Future<void> registerBusiness() async {

    if (!_formKey.currentState!.validate()) return;

    if (!isChecked) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please accept terms & conditions")),
      );
      return;
    }

    setState(() => isLoading = true);
    

    try {

      String rawPhone = phoneController.text.trim();

// remove leading 0 (IMPORTANT)
if (rawPhone.startsWith("0")) {
  rawPhone = rawPhone.substring(1);
}

String finalPhone = "$selectedCountryCode$rawPhone";

      var result = await ApiService.createBusiness(
        name: businessNameController.text.trim(),
        ntn: taxIdController.text.trim(),
        type: selectedBusinessType ?? "",
        address: addressController.text.trim(),
        city: selectedCity ?? "",
        phone: finalPhone,
      );
      if (result["duplicate"] == true) {

  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      content: Text("Business already exists. NTN is now required."),
      backgroundColor: Colors.orange,
    ),
  );

  // Force NTN validation
  if (taxIdController.text.trim().isEmpty) {
    return;
  }
}

if (result["status"] == "duplicate") {

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(result["message"] ?? "Business already exists"),
      backgroundColor: Colors.orange,
    ),
  );

  // Stop here so user can enter NTN
  return;
}

      if (result["status"] == "success") {

        int businessId = result["business"]?["id"] ?? 0;

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Business Registered Successfully")),
        );

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AdminRegisterPage(
              businessName: businessNameController.text.trim(),
              businessId: businessId,
            ),
          ),
        );

      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(result["error"] ?? "Error")),
        );
      }

    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    }

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),

      body: Center(
        child: SingleChildScrollView(
          child: Container(
            width: 500,
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(20),

            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),

            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [


                  // HEADER (ADDED ONLY)
                  Center(
                    child: Column(
                      children: const [
                        Icon(Icons.inventory_2, size: 40, color: Colors.blue),
                        SizedBox(height: 10),
                        Text("InvoicePro", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                        Text("by BMA Solutions", style: TextStyle(color: Colors.grey)),
                        SizedBox(height: 10),
                        Text("Register Your Business", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                        Text("Create your business account to get started", style: TextStyle(color: Colors.grey)),
                      ],
                    ),
                  ),

                  const SizedBox(height: 25),

                  const Text(
                    "Business Information",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 20),

                  TextFormField(
                    controller: businessNameController,
                    inputFormatters: [
  FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9 ]')),
],
                   validator: (value) {
  if (isNTNRequired && (value == null || value.isEmpty)) {
    return "NTN is required (duplicate business)";
  }
  if (!RegExp(r'^[a-zA-Z0-9 ]+$').hasMatch(value ?? "")) {
  return "Only letters and numbers allowed";
  }
  return null;
},
                    decoration: inputDecoration("Business Name *", ""),
                  ),

                  const SizedBox(height: 15),

                  TextFormField(
                    controller: taxIdController,
                    validator: (value) {
                      if (value == null || value.isEmpty) return null;
                      if (!RegExp(r'^[a-zA-Z0-9 ]+$').hasMatch(value)) {
                        return "Numbers only";
                      }
                      return null;
                    },
                    decoration: inputDecoration("NTN (Optional)", ""),
                  ),

                  const SizedBox(height: 15),

                  DropdownButtonFormField<String>(
                    value: selectedBusinessType,
                    validator: (value) =>
                        value == null ? "Select type" : null,
                    items: ["Retail", "Wholesale", "Service"]
                        .map((e) => DropdownMenuItem(
                              value: e,
                              child: Text(e),
                            ))
                        .toList(),
                    onChanged: (value) =>
                        setState(() => selectedBusinessType = value),
                    decoration: inputDecoration("Business Type *", ""),
                  ),

                  const SizedBox(height: 15),

                  TextFormField(
                    controller: addressController,
                    validator: (value) {
                      if (value == null || value.isEmpty) return "Enter address";
                      if (value.length > 350) return "Max 350 chars";
                      return null;
                    },
                    decoration: inputDecoration("Address *", ""),
                  ),

                  const SizedBox(height: 15),

                  DropdownButtonFormField<String>(
                    value: selectedCity,
                    validator: (value) =>
                        value == null ? "Select city" : null,
                    items: pakistanCities.map((city) {
                      return DropdownMenuItem(
                        value: city,
                        child: Text(city),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedCity = value;
                      });
                    },
                    decoration: inputDecoration("City *", ""),
                  ),

                  const SizedBox(height: 15),
Row(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [

    // COUNTRY CODE
    Flexible(
      flex: 3,
      child: SizedBox(
        height: 60,
        child: DropdownButtonFormField<String>(
          isExpanded: true,
          value: selectedCountryCode,
          items: countries.map((c) {
            return DropdownMenuItem(
              value: c["code"],
child: Row(
  children: [
    Text(c["flag"]!, style: const TextStyle(fontSize: 16)),
    const SizedBox(width: 4),
    Flexible(
      child: Text(
        c["code"]!,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(fontSize: 13),
      ),
    ),
  ],
),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              selectedCountryCode = value!;
            });
          },
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ),
    ),

    const SizedBox(width: 10),

    // PHONE FIELD
    Flexible(
      flex: 7,
      child: SizedBox(
        height: 60,
        child: TextFormField(
          controller: phoneController,
          inputFormatters: [
  FilteringTextInputFormatter.digitsOnly,
],
          maxLength: 11,
          validator: (value) {
            if (value == null || value.isEmpty) return "Enter phone";
            if (!RegExp(r'^[0-9]+$').hasMatch(value)) return "Numbers only";
            if (value.length != 11) return "Must be 11 digits";
            return null;
          },
          decoration: InputDecoration(
            labelText: "Phone *",
            hintText: "XXXXXXXXXXX",
            counterText: "", // removes 0/11 misalignment effect
            contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ),
    ),
  ],
),

                  Row(
                    children: [
                      Checkbox(
                        value: isChecked,
                        onChanged: (v) =>
                            setState(() => isChecked = v!),
                      ),
                      const Expanded(
                        child: Text("I agree to Terms & Privacy Policy"),
                      )
                    ],
                  ),

                  const SizedBox(height: 10),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: isLoading ? null : registerBusiness,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(15),
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: isLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text("Register Business"),



                      
                    ),
                  ),
                // 🔷 ADDED BLOCK (ONLY CHANGE)
                  const SizedBox(height: 20),

                  Row(
                    children: [
                      const Expanded(child: Divider()),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          "Already have an account?",
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                      ),
                      const Expanded(child: Divider()),
                    ],
                  ),

                  const SizedBox(height: 15),

                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => const LoginPage(),
    ),
  );
},
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        side: BorderSide(color: Colors.grey.shade300),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        "Login to Existing Account",
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

  InputDecoration inputDecoration(String label, String hint) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}