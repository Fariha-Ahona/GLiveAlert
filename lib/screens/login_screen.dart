// import 'dart:ui';  // Importing dart:ui for ImageFilter
// import 'package:flutter/material.dart';
// import 'sign_in_page.dart'; // Adjust this import according to your project structure for the sign-in page

// class LoginScreen extends StatefulWidget {
//   @override
//   _LoginScreenState createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   String? selectedRole;

//   final List<Map<String, dynamic>> roles = [
//     {'label': 'Everyday User', 'icon': '../assets/icons/user.png'},
//     {'label': 'Agricultural Team', 'icon': '../assets/icons/agri.png'},
//     {'label': 'Space Planners', 'icon': '../assets/icons/airplane.png'},
//     {'label': 'Wildlife Monitors', 'icon': '../assets/icons/wildlife.png'},
//     {'label': 'Emergency Team', 'icon': '../assets/icons/emergency.png'},
//     {'label': 'Tech Support', 'icon': '../assets/icons/tech.png'},
//   ];

//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;
//     final screenHeight = MediaQuery.of(context).size.height;

//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: SingleChildScrollView(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             SizedBox(height: screenHeight * 0.1),
//             GridView.builder(
//               shrinkWrap: true,
//               physics: NeverScrollableScrollPhysics(),
//               itemCount: roles.length,
//               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: screenWidth > 600 ? 3 : 2,
//                 childAspectRatio: (screenWidth / screenHeight) * 0.8,
//                 crossAxisSpacing: 20,
//                 mainAxisSpacing: 20,
//               ),
//               itemBuilder: (context, index) {
//                 return GestureDetector(
//                   onTap: () {
//                     setState(() {
//                       selectedRole = roles[index]['label'];
//                     });
//                   },
//                   child: ClipRRect(
//                     borderRadius: BorderRadius.circular(15),
//                     child: BackdropFilter(
//                       filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
//                       child: Container(
//                         height: screenHeight * 0.2,
//                         width: screenWidth * 0.4,
//                         decoration: BoxDecoration(
//                           color: Colors.white.withOpacity(0.1),
//                           borderRadius: BorderRadius.circular(15),
//                           border: Border.all(
//                             color: selectedRole == roles[index]['label'] ? Colors.orangeAccent : Colors.white,
//                             width: 2,
//                           ),
//                         ),
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Image.asset(roles[index]['icon'], height: screenHeight * 0.08, color: Colors.white),
//                             Text(
//                               roles[index]['label'],
//                               style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             ),
//             Padding(
//               padding: EdgeInsets.symmetric(vertical: 20.0),
//               child: ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.orange,
//                   padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(20),
//                   ),
//                 ),
//                 onPressed: () {
//                   if (selectedRole != null) {
//                     Navigator.push(context, MaterialPageRoute(builder: (context) => SignInPage()));
//                   } else {
//                     showDialog(
//                       context: context,
//                       builder: (context) => AlertDialog(
//                         title: Text('No Role Selected'),
//                         content: Text('Please select a role to proceed.'),
//                         actions: [
//                           TextButton(
//                             onPressed: () => Navigator.of(context). pop(),
//                             child: Text('OK'),
//                           ),
//                         ],
//                       ),
//                     );
//                   }
//                 },
//                 child: Text('Log In', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'dart:ui';  // Importing dart:ui for ImageFilter
import 'package:flutter/material.dart';
import 'discover.dart'; // Adjust this import according to your project structure for the sign-in page

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String? selectedRole;

  final List<Map<String, dynamic>> roles = [
    {'label': 'Everyday User', 'icon': '../assets/icons/user.png'},
    {'label': 'Agricultural Team', 'icon': '../assets/icons/agri.png'},
    {'label': 'Space Planners', 'icon': '../assets/icons/airplane.png'},
    {'label': 'Wildlife Monitors', 'icon': '../assets/icons/wildlife.png'},
    {'label': 'Emergency Team', 'icon': '../assets/icons/emergency.png'},
    {'label': 'Tech Support', 'icon': '../assets/icons/tech.png'},
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.asset(
              '../assets/img/background_home.png',  // Path to your background image
              fit: BoxFit.cover,
            ),
          ),
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: screenHeight * 0.1),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: roles.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: screenWidth > 600 ? 3 : 2,
                    childAspectRatio: (screenWidth / screenHeight) * 0.8,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                  ),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedRole = roles[index]['label'];
                        });
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                          child: Container(
                            padding: const EdgeInsets.all(10),  // Added padding inside the container
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                color: selectedRole == roles[index]['label'] ? Colors.orangeAccent : Colors.white,
                                width: 2,
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(roles[index]['icon'], height: screenHeight * 0.08, color: Colors.white),
                                Text(
                                  roles[index]['label'],
                                  style: const TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: () {
                      if (selectedRole != null) {
                        Navigator.push(context, MaterialPageRoute(builder: (context) =>  const DiscoverPage()));
                      } else {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text('No Role Selected'),
                            content: const Text('Please select a role to proceed.'),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.of(context). pop(),
                                child: const Text('OK'),
                              ),
                            ],
                          ),
                        );
                      }
                    },
                    child: const Text('Log In', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}