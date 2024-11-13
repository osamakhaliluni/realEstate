import 'package:flutter/material.dart';
import 'package:frontend/core/style/colors.dart';
import 'package:frontend/utils/size_config.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: primaryColor,
        appBar: AppBar(
          backgroundColor: primaryColor,
        ),
        body: Stack(
          children: [
            // Logo section
            Positioned(
              top: 0,
              right: 0,
              left: 0,
              child: SizedBox(
                height: SizeConfig.screenHeight / 4,
                child: const Center(
                  child: Text(
                    "Real Estate",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),

            Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              child: Container(
                constraints: BoxConstraints(
                  minHeight: SizeConfig.screenHeight / 3 * 2,
                ),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: lightColor,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Text(
                      "Login",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    // Input section
                    Container(
                      padding: const EdgeInsets.all(5),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        color: Colors.white,
                      ),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 50,
                            child: Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Icon(
                                    Icons.person,
                                    color: Colors.red,
                                  ),
                                ),
                                Expanded(
                                  child: TextField(
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.never,
                                      labelText: "Username",
                                      labelStyle: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w100,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: 1,
                            decoration: const BoxDecoration(
                              color: Colors.black38,
                            ),
                          ),
                          const SizedBox(
                            height: 50,
                            child: Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Icon(
                                    Icons.lock_open,
                                    color: Colors.blue,
                                  ),
                                ),
                                Expanded(
                                  child: TextField(
                                    obscureText: true,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.never,
                                      labelText: "Password",
                                      labelStyle: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w100,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Buttons section
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextButton(
                              onPressed: () {},
                              child: Text(
                                "Don`t have account? Register.",
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                            TextButton(
                              onPressed: () {},
                              child: Text(
                                "Forgot password?",
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: SizeConfig.screenWidth / 3,
                          height: 60,
                          child: ElevatedButton(
                            onPressed: () {},
                            child: const Text("Login"),
                          ),
                        )
                      ],
                    ),
                    // IconButtons section
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            icon: Icon(
                              Icons.facebook,
                              size: 70,
                              color: primaryColor,
                            ),
                            onPressed: () {},
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Image.asset(
                              "assets/images/google.webp",
                              width: 70,
                            ),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.apple,
                              size: 70,
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
