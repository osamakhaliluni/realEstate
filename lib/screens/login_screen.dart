import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/core/style/colors.dart';
import 'package:frontend/cubits/user/user_cubit.dart';
import 'package:frontend/utils/size_config.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: primaryColor,
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back,
                color: lightColor,
              )),
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
                          SizedBox(
                            height: 50,
                            child: Row(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Icon(
                                    Icons.email,
                                    color: Colors.red,
                                  ),
                                ),
                                Expanded(
                                  child: TextField(
                                    controller: emailController,
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.never,
                                      labelText: "Email",
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
                          SizedBox(
                            height: 50,
                            child: Row(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Icon(
                                    Icons.lock_open,
                                    color: Colors.red,
                                  ),
                                ),
                                Expanded(
                                  child: TextField(
                                    controller: passwordController,
                                    obscureText: true,
                                    decoration: const InputDecoration(
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
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 5, bottom: 10, top: 10),
                          child: Row(
                            children: [
                              const Text(
                                "Don`t have account?",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, "register");
                                },
                                child: Text(
                                  "Register.",
                                  style: TextStyle(
                                    color: primaryColor,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: SizeConfig.screenWidth / 2,
                          height: 50,
                          child: _submitButton(context),
                        ),
                      ],
                    ),
                    // IconButtons section
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            icon: Icon(
                              Icons.facebook,
                              size: 50,
                              color: primaryColor,
                            ),
                            onPressed: () {},
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Image.asset(
                              "assets/images/google.webp",
                              width: 50,
                            ),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.apple,
                              size: 50,
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

  BlocConsumer<UserCubit, UserState> _submitButton(BuildContext context) {
    return BlocConsumer<UserCubit, UserState>(
      listener: (context, state) {
        if (state is UserLoggedIn) {
          Navigator.pushReplacementNamed(context, "home");
        } else if (state is UserError) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(state.message),
          ));
        }
      },
      builder: (context, state) {
        if (state is UserLoading) {
          return CircularProgressIndicator();
        }
        return ElevatedButton(
          onPressed: () {
            if (emailController.text.isEmpty ||
                passwordController.text.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("Please fill in all fields."),
              ));
            } else {
              UserCubit.get(context)
                  .login(emailController.text, passwordController.text);
            }
          },
          child: const Text(
            "Login",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      },
    );
  }
}
