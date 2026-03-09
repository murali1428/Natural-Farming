import 'package:flutter/material.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  int selectedIndex = -1;

  final List<Map<String, String>> languages = [
    {"code": "en", "label": "English", "icon": "A"},
    {"code": "ta", "label": "தமிழ்", "icon": "அ"},
    // {"code": "hi", "label": "हिन्दी", "icon": "अ"},
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context);
    final width = size.size.width;
    final height = size.size.height;

    return Scaffold(
      backgroundColor: const Color(0xFFF7F3F9),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: height * 0.05),
            SizedBox(
              height: height * 0.22,
              child: Image.asset(
                "assets/earth.gif",
                fit: BoxFit.contain,
              ),
            ),

            SizedBox(height: height * 0.02),

            /// Title
            Text(
              "Select Your Language to Get Started.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: width * 0.045,
                fontWeight: FontWeight.w600,
              ),
            ),

            SizedBox(height: height * 0.05),

            /// Language Cards
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.08),
              child: Wrap(
                spacing: width * 0.05,
                runSpacing: width * 0.05,
                alignment: WrapAlignment.center,
                children: List.generate(
                  languages.length,
                      (index) => _languageCard(
                    width,
                    index,
                    languages[index]["icon"]!,
                    languages[index]["label"]!,
                  ),
                ),
              ),
            ),

            const Spacer(),

            /// Continue Button
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: width * 0.08,
                vertical: height * 0.03,
              ),
              child:
              SizedBox(
                width: double.infinity,
                height: height * 0.065,
                child: ElevatedButton(
                  onPressed: selectedIndex == -1
                      ? null // 🔒 disabled
                      : () {
                    // TODO: save selected language
                    // Navigator.pushReplacement(...)
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: selectedIndex == -1
                        ? Colors.green.shade200 // disabled color
                        : Colors.green.shade700,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    "Continue",
                    style: TextStyle(
                      fontSize: width * 0.045,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

            ),
          ],
        ),
      ),
    );
  }

  Widget _languageCard(double width, int index, String icon, String label) {
    final bool isSelected = selectedIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() => selectedIndex = index);
      },
      child: Container(
        width: width * 0.35,
        height: width * 0.35,
        decoration: BoxDecoration(
          color: isSelected ? Colors.green.shade700 : Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: Colors.green.shade700,
            width: 1.5,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              icon,
              style: TextStyle(
                fontSize: width * 0.12,
                fontWeight: FontWeight.bold,
                color: isSelected ? Colors.white : Colors.black,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              label,
              style: TextStyle(
                fontSize: width * 0.045,
                fontWeight: FontWeight.w500,
                color: isSelected ? Colors.white : Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
