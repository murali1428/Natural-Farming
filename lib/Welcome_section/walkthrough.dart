import 'package:flutter/material.dart';

import '../Login_section/language_screen.dart';
import '../Login_section/signup.dart';


class WalkthroughScreen extends StatefulWidget {
  const WalkthroughScreen({super.key});

  @override
  State<WalkthroughScreen> createState() => _WalkthroughScreenState();
}

class _WalkthroughScreenState extends State<WalkthroughScreen>
    with AutomaticKeepAliveClientMixin {

  final PageController _controller = PageController();
  int currentIndex = 0;

  final List<Map<String, String>> walkthroughData = [
    {
      "image": "assets/walk1.png",
      "title": "Welcome to Natural Farming App",
      "desc": "Daily fresh broiler and country chicken,Cleanly processed and hygienically handled."
    },
    {
      "image": "assets/walk2.png",
      "title": "Fresh Eggs",
      "desc":
      "Naturally sourced eggs,Carefully selected for quality and freshness."
    },
    {
      "image": "assets/walk3.png",
      "title": "Delivery Available",
      "desc": "Delivery Available within 5kms Surrounding."
    },
  ];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    for (var item in walkthroughData) {
      precacheImage(
        AssetImage(item["image"]!),
        context,
      );
    }
  }

  @override
  bool get wantKeepAlive => true;

  void navigateToLanguage() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const SignupScreen()),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 12, top: 8),
                child: ElevatedButton(
                  onPressed: navigateToLanguage,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green.shade800,
                    elevation: 0,
                    padding:
                    const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text(
                    "Skip",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),

            Expanded(
              child: PageView.builder(
                controller: _controller,
                itemCount: walkthroughData.length,
                allowImplicitScrolling: true,

                onPageChanged: (index) {
                  setState(() => currentIndex = index);
                },
                itemBuilder: (context, index) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: size.height * 0.35,
                        child: Image.asset(
                          walkthroughData[index]["image"]!,
                          fit: BoxFit.contain,
                          cacheWidth: (size.width * 0.8).toInt(),
                          cacheHeight: (size.height * 0.35).toInt(),

                          filterQuality: FilterQuality.medium,
                          gaplessPlayback: true,
                        ),
                      ),

                      const SizedBox(height: 30),

                      /// TITLE
                      Text(
                        walkthroughData[index]["title"]!,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: size.width * 0.06,
                          fontWeight: FontWeight.bold,
                          color:Colors.green.shade800,
                        ),
                      ),

                      const SizedBox(height: 12),

                      /// DESCRIPTION
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Text(
                          walkthroughData[index]["desc"]!,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: size.width * 0.04,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),

            /// DOT INDICATOR
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                walkthroughData.length,
                    (index) => AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: currentIndex == index ? 20 : 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color:
                    currentIndex == index ? Colors.green.shade800 : Colors.grey,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 25),

            /// GET STARTED BUTTON
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: navigateToLanguage,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green.shade800,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    "Get Started",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
