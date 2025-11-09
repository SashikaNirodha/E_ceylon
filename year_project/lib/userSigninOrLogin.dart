
import 'package:e_ceylon_unified_app/main.dart';
import 'package:flutter/material.dart';

class SigninOrLogin extends StatelessWidget {
  const SigninOrLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //leading: Icon(Icons.home_filled),
        title: const Text("E-CEYLON", style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600),),
        centerTitle: true,
       /* actions: [
          Padding(padding: const EdgeInsets.all(8.0), child: Icon(Icons.menu)),
        ],*/
        backgroundColor: const Color(0xff4DA1A9),
      ),
      backgroundColor: const Color(0xff4DA1A9),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.account_circle_rounded, size: 100), //user icon REPLACE HERE IMAGE
            const SizedBox(height: 20),
            Container(
              height: 200,
              width: 311,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: const Color(0xff92BCC0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Center(
                      child: Column(
                        children: [
                          Text(
                            "",
                            style: TextStyle(
                              color: Color(0xff2E5077),
                              fontSize: 30,
                            ),
                          ),
                          
                        ],
                      ),
                    ),
                   // SizedBox(height: 30),
                    Center(
                      child: SizedBox(
                        width: 200,
                        height: 60,
                        child: ElevatedButton(
                          onPressed: () {
                            // Navigate to the login page
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => UserLoginScreen()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(30), // Rounded corners
                            ),
                            backgroundColor:
                                const Color(0xff2E5077), // Background color
                            foregroundColor:
                                Colors.white, // Text (and icon) color
                          ),
                          child: const Text("Log in", style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600
                          ),), //need to convert as a button
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Center(
                      child: SizedBox(
                        width: 200,
                        height: 60,
                        child: ElevatedButton(
                          onPressed: () {
                            // Navigate to the sign-in page
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => UserSigninScreen()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(30), // Rounded corners
                            ),
                            backgroundColor:
                                const Color(0xff2E5077), // Background color
                            foregroundColor:
                                Colors.white, // Text (and icon) color
                          ),
                          child: const Text("Sign in", 
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600
                          ),), //need to convert as a button
                        ),
                      ),
                    ),
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