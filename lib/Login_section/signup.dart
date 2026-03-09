import 'package:farm/admin/admin_dashboard.dart';
import 'package:flutter/material.dart';

import 'Sign-in.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool _isPasswordVisible = false;
  bool _isAgreed = false;


  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double width = size.width;
    final double height = size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.07),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: height * 0.02),

                /// Logo
                Center(
                  child: Image.asset(
                    'assets/splash_logo.png',
                    width: width * 0.50,
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(height: height * 0.01),

                /// Signup title
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Signup",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),

                SizedBox(height: height * 0.005),

                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Create your account",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),

                SizedBox(height: height * 0.02),

                _inputField("Enter Your  Name"),

                SizedBox(height: height * 0.02),

                _inputField("Enter Your email"),

                SizedBox(height: height * 0.02),

                _inputField("Enter Mobile Number",
                    keyboardType: TextInputType.phone),

                SizedBox(height: height * 0.01),

                _inputField(
                  "Enter Password",
                  obscureText: !_isPasswordVisible,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                  ),

                  // "Enter Password",
                  // obscureText: true,
                  // suffixIcon: Icons.visibility_off,
                ),
                // SizedBox(height: height * 0.01),
                //
                // /// Terms checkbox
                // Row(
                //   children: [
                //     Checkbox(
                //       value: _isAgreed,
                //       activeColor: const Color(0xFF2E7D32),
                //       onChanged: (value) {
                //         setState(() {
                //           _isAgreed = value!;
                //         });
                //       },
                //     ),
                //     // Expanded(
                //     //   child: RichText(
                //     //     text: const TextSpan(
                //     //       text: "I agree to the ",
                //     //       style: TextStyle(
                //     //         fontSize: 14,
                //     //         color: Colors.black54,
                //     //       ),
                //     //       children: [
                //     //         TextSpan(
                //     //           text: "Terms of Service ",
                //     //           style: TextStyle(
                //     //             color: Color(0xFF2E7D32),
                //     //             fontWeight: FontWeight.w600,
                //     //           ),
                //     //         ),
                //     //         TextSpan(text: "and "),
                //     //         TextSpan(
                //     //           text: "Privacy Policy",
                //     //           style: TextStyle(
                //     //             color: Color(0xFF2E7D32),
                //     //             fontWeight: FontWeight.w600,
                //     //           ),
                //     //         ),
                //     //       ],
                //     //     ),
                //     //   ),
                //     // ),
                //   ],
                // ),

                SizedBox(height: height * 0.02),

                /// Get Started button
                SizedBox(
                  width: double.infinity,
                  height: 44,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green.shade800,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      "GET STARTED",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: height * 0.02),

                // /// Social login
                // const Text(
                //   "or Signup with",
                //   style: TextStyle(fontSize: 12, color: Colors.black54),
                // ),
                //
                // SizedBox(height: height * 0.02),
                //
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     Image.asset(
                //       'assets/google.png',
                //       width: 36,
                //       height: 36,
                //       fit: BoxFit.contain,
                //     ),
                //     const SizedBox(width: 20),
                //     Image.asset(
                //       'assets/apple.png',
                //       width: 48,
                //       height: 48,
                //       fit: BoxFit.contain,
                //     ),
                //   ],
                // ),
                // SizedBox(height: height * 0.02),

                /// Already have account
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Already have an account? ",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginScreen(),
                          ),
                        );
                      },
                      child: const Text(
                        "Signin",
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFF2E7D32),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: height * 0.02),
                GestureDetector(
                  onTap: () {
                    // TODO: Navigate to Admin Login Screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const AdminDashboard()),
                    );
                  },
                  child: RichText(
                    text: const TextSpan(
                      text: "Admin Login ",
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF2E7D32),
                        fontWeight: FontWeight.w600,
                      ),
                      children: [
                        TextSpan(
                          text: "(Only for Admins)",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.redAccent,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: height * 0.03),

              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _inputField(
      String hint, {
        bool obscureText = false,
        TextInputType keyboardType = TextInputType.text,
        Widget? suffixIcon,
        // IconData? suffixIcon,
      }) {
    return TextField(
      obscureText: obscureText,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hint,
        suffixIcon:suffixIcon,
        // suffixIcon != null ? Icon(suffixIcon, size: 18) : null,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: const BorderSide(color: Colors.black26),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: const BorderSide(color: Color(0xFF2E7D32)),
        ),
        contentPadding:
        const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      ),
    );
  }
}