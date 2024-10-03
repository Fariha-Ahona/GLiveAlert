import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("../assets/img/background_home.png"), // Background image for home page
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(Colors.black54, BlendMode.darken), // Darken for better contrast
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Title (GLiveAlert) with brown and coffee gradient
              ShaderMask(
                shaderCallback: (bounds) => const LinearGradient(
                  colors: [Color(0xFF8B4513), Color(0xFFCD853F)], // New gradient: brown to light brown
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ).createShader(bounds),
                child: const Text(
                  'GLiveAlert',
                  style: TextStyle(
                    fontSize: 60, // Larger font size to make it stand out
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 3.0, // Spacing between letters for a modern look
                    shadows: [
                      Shadow(
                        blurRadius: 15.0,
                        color: Colors.black38, // Softer black shadow for depth
                        offset: Offset(4.0, 4.0),
                      ),
                      Shadow(
                        blurRadius: 25.0,
                        color: Color(0xFF8B4513), // Soft brown glow for added effect
                        offset: Offset(-3.0, -3.0),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),

              // Short description with updated colors
              const Text(
                'Stay ahead of solar storms & space weather with real-time alerts!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18, // Larger font size for description
                  color: Color(0xFFD2B48C), // Light brown for readability
                  fontWeight: FontWeight.w500,
                  height: 1.5, // Line height for readability
                ),
              ),
              const SizedBox(height: 50),

              // Updated Get Started Button with brown to coffee gradient
              MouseRegion(
                onEnter: (_) {
                  // Hover effect can be added here
                },
                onExit: (_) {
                  // Exit hover effect
                },
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/signin');
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 20),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF8B4513), Color(0xFFD2B48C)], // Brown to coffee gradient
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0xFFCD853F), // Coffee color shadow
                          blurRadius: 20,
                          spreadRadius: 1,
                          offset: Offset(0, 6),
                        ),
                      ],
                      borderRadius: BorderRadius.circular(30), // Rounded corners for sleekness
                    ),
                    child: const Text(
                      'Get Started',
                      style: TextStyle(
                        fontSize: 22, // Larger button text for readability
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}