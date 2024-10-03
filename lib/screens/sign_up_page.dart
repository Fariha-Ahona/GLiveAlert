// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart'; // Import Firebase Auth

// class SignUpPage extends StatefulWidget {
//   const SignUpPage({super.key});

//   @override
//   _SignUpPageState createState() => _SignUpPageState();
// }

// class _SignUpPageState extends State<SignUpPage> {
//   TextEditingController mailcontroller = TextEditingController();
//   TextEditingController passwordcontroller = TextEditingController();
//   final _formKey = GlobalKey<FormState>();
//   bool _rememberMe = false;
//   bool _isLoading = false;

//   // Firebase Authentication instance
//   final FirebaseAuth _auth = FirebaseAuth.instance;

//   // Sign-up logic
//   Future<void> _signUp() async {
//     if (_formKey.currentState!.validate()) {
//       setState(() {
//         _isLoading = true;
//       });

//       try {
//         // Create a new user with email and password using controllers
//         UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
//           email: mailcontroller.text,  // using the mailcontroller
//           password: passwordcontroller.text,
//         );

//         // If the sign-up is successful, navigate to the home page
//         _showSuccessDialog();
//       } on FirebaseAuthException catch (e) {
//         // Handle specific Firebase errors
//         String errorMessage;
//         switch (e.code) {
//           case 'weak-password':
//             errorMessage = 'The password provided is too weak.';
//             break;
//           case 'email-already-in-use':
//             errorMessage = 'An account already exists for that email.';
//             break;
//           case 'invalid-email':
//             errorMessage = 'The email address is not valid.';
//             break;
//           default:
//             errorMessage = e.message ?? 'An unknown error occurred.';
//             break;
//         }
//         _showErrorDialog(errorMessage);
//       } finally {
//         setState(() {
//           _isLoading = false;
//         });
//       }
//     }
//   }

//   void _showSuccessDialog() {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text('Sign Up Successful'),
//           content: const Text('Your account has been created successfully!'),
//           actions: <Widget>[
//             TextButton(
//               child: const Text('OK'),
//               onPressed: () {
//                 Navigator.of(context)
//                     .pushNamed('/signin'); // Navigate to sign-in page
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }

//   void _showErrorDialog(String message) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text('Sign Up Error'),
//           content: Text(message),
//           actions: <Widget>[
//             TextButton(
//               child: const Text('OK'),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         decoration: const BoxDecoration(
//           image: DecorationImage(
//             image: AssetImage("../assets/img/signin_bg.png"),
//             fit: BoxFit.cover,
//           ),
//         ),
//         padding: const EdgeInsets.all(20),
//         child: Center(
//           child: SingleChildScrollView(
//             child: Form(
//               key: _formKey,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: <Widget>[
//                   const Text(
//                     'Sign Up',
//                     style: TextStyle(
//                       fontSize: 36,
//                       color: Colors.white,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   const SizedBox(height: 20),

//                   // Email Address Field
//                   TextFormField(
//                     controller: mailcontroller,
//                     decoration: InputDecoration(
//                       labelText: 'E-mail address',
//                       labelStyle: const TextStyle(color: Colors.white),
//                       prefixIcon: const Icon(Icons.email, color: Colors.white),
//                       filled: true,
//                       fillColor: Colors.black.withOpacity(0.3),
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(10),
//                         borderSide: BorderSide.none,
//                       ),
//                     ),
//                     style: const TextStyle(color: Colors.white),
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please enter your email';
//                       }
//                       if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
//                         return 'Please enter a valid email address';
//                       }
//                       return null;
//                     },
//                   ),
//                   const SizedBox(height: 20),

//                   // Password Field
//                   TextFormField(
//                     controller: passwordcontroller,
//                     obscureText: true,
//                     decoration: InputDecoration(
//                       labelText: 'Enter your password',
//                       labelStyle: const TextStyle(color: Colors.white),
//                       prefixIcon: const Icon(Icons.lock, color: Colors.white),
//                       filled: true,
//                       fillColor: Colors.black.withOpacity(0.3),
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(10),
//                         borderSide: BorderSide.none,
//                       ),
//                     ),
//                     style: const TextStyle(color: Colors.white),
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please enter your password';
//                       }
//                       if (value.length < 6) {
//                         return 'Password must be at least 6 characters long';
//                       }
//                       return null;
//                     },
//                   ),
//                   const SizedBox(height: 10),

//                   // Remember me checkbox and Forgot password button
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Row(
//                         children: [
//                           Checkbox(
//                             value: _rememberMe,
//                             onChanged: (bool? value) {
//                               setState(() {
//                                 _rememberMe = value ?? false;
//                               });
//                             },
//                             activeColor: Colors.orange,
//                           ),
//                           const Text(
//                             'Remember me',
//                             style: TextStyle(color: Colors.white),
//                           ),
//                         ],
//                       ),
//                       TextButton(
//                         onPressed: () {
//                           // Handle forgot password
//                         },
//                         child: const Text(
//                           'Forgot password?',
//                           style: TextStyle(color: Colors.redAccent),
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 20),

//                   // Continue Button
//                   Center(
//                     child: _isLoading
//                         ? const CircularProgressIndicator()
//                         : ElevatedButton(
//                             onPressed: _signUp,
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: Colors.orange,
//                               padding: const EdgeInsets.symmetric(
//                                   horizontal: 100, vertical: 15),
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(10),
//                               ),
//                             ),
//                             child: const Text(
//                               'Continue',
//                               style: TextStyle(fontSize: 18),
//                             ),
//                           ),
//                   ),
//                   const SizedBox(height: 20),

//                   // Already have an account option
//                   Center(
//                     child: GestureDetector(
//                       onTap: () {
//                         Navigator.of(context)
//                             .pushNamed('/signin'); // Navigate to sign-in page
//                       },
//                       child: const Text(
//                         'Already have an account? Sign in.',
//                         style: TextStyle(
//                           color: Colors.white,
//                           decoration: TextDecoration.underline,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Import Firebase Auth

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController mailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _rememberMe = false;
  bool _isLoading = false;

  // Firebase Authentication instance
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Sign-up logic
  Future<void> _signUp() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        // Create a new user with email and password using controllers
        UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
          email: mailcontroller.text,  // using the mailcontroller
          password: passwordcontroller.text,
        );

        // Send email verification
        if (!userCredential.user!.emailVerified) {
          await userCredential.user!.sendEmailVerification();
          _showVerificationDialog();
        }
      } on FirebaseAuthException catch (e) {
        // Handle specific Firebase errors
        String errorMessage;
        switch (e.code) {
          case 'weak-password':
            errorMessage = 'The password provided is too weak.';
            break;
          case 'email-already-in-use':
            errorMessage = 'An account already exists for that email.';
            break;
          case 'invalid-email':
            errorMessage = 'The email address is not valid.';
            break;
          default:
            errorMessage = e.message ?? 'An unknown error occurred.';
            break;
        }
        _showErrorDialog(errorMessage);
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _showVerificationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Verify Your Email'),
          content: const Text('A verification link has been sent to your email. Please verify your email before signing in.'),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Sign Up Error'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("../assets/img/signin_bg.png"),
            fit: BoxFit.cover,
          ),
        ),
        padding: const EdgeInsets.all(20),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    'Sign Up',
                    style: TextStyle(
                      fontSize: 36,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Email Address Field
                  TextFormField(
                    controller: mailcontroller,
                    decoration: InputDecoration(
                      labelText: 'E-mail address',
                      labelStyle: const TextStyle(color: Colors.white),
                      prefixIcon: const Icon(Icons.email, color: Colors.white),
                      filled: true,
                      fillColor: Colors.black.withOpacity(0.3),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    style: const TextStyle(color: Colors.white),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                        return 'Please enter a valid email address';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),

                  // Password Field
                  TextFormField(
                    controller: passwordcontroller,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Enter your password',
                      labelStyle: const TextStyle(color: Colors.white),
                      prefixIcon: const Icon(Icons.lock, color: Colors.white),
                      filled: true,
                      fillColor: Colors.black.withOpacity(0.3),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    style: const TextStyle(color: Colors.white),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      if (value.length < 6) {
                        return 'Password must be at least 6 characters long';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),

                  // Remember me checkbox and Forgot password button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Checkbox(
                            value: _rememberMe,
                            onChanged: (bool? value) {
                              setState(() {
                                _rememberMe = value ?? false;
                              });
                            },
                            activeColor: Colors.orange,
                          ),
                          const Text(
                            'Remember me',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                      TextButton(
                        onPressed: () {
                          // Handle forgot password
                        },
                        child: const Text(
                          'Forgot password?',
                          style: TextStyle(color: Colors.redAccent),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Continue Button
                  Center(
                    child: _isLoading
                        ? const CircularProgressIndicator()
                        : ElevatedButton(
                            onPressed: _signUp,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.orange,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 100, vertical: 15),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: const Text(
                              'Continue',
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                  ),
                  const SizedBox(height: 20),

                  // Already have an account option
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context)
                            .pushNamed('/signin'); // Navigate to sign-in page
                      },
                      child: const Text(
                        'Already have an account? Sign in.',
                        style: TextStyle(
                          color: Colors.white,
                          decoration: TextDecoration.underline,
                        ),
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
