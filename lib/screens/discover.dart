import 'package:flutter/material.dart';
import 'package:glivealert/screens/GMS.dart';

class DiscoverPage extends StatelessWidget {
  const DiscoverPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          double width = constraints.maxWidth;
          bool isLargeScreen = width > 600;

          return Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('../assets/img/sigin_bg.png'), // Fixed path
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.black.withOpacity(0.6),
                    Colors.black.withOpacity(0.4),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 30.0),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 1200),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Discover Section Header
                        buildHeader('Discover', isLargeScreen, width),

                        // Past History Section
                        buildSectionHeader('Past History', isLargeScreen),
                        GlassmorphicButton(
                          label: 'View Past History',
                          onPressed: () {
                            // Action for Past History
                          },
                        ),

                        // Chatbot Section
                        buildSectionHeader('Chatbot', isLargeScreen),
                        const SizedBox(height: 10),
                        ChatbotOptionsSection(),

                        // Storm Tracker Section
                        buildSectionHeader('Storm Tracker', isLargeScreen),
                        const SizedBox(height: 10),
                        ResponsiveTrackerSection(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildHeader(String title, bool isLargeScreen, double width) {
    return Text(
      title,
      style: TextStyle(
        color: Colors.white,
        fontSize: isLargeScreen ? 40 : 28,
        fontWeight: FontWeight.bold,
        letterSpacing: 1.5,
        shadows: [
          Shadow(
            color: Colors.black.withOpacity(0.8),
            offset: const Offset(0, 4),
            blurRadius: 8,
          ),
        ],
      ),
    );
  }

  Widget buildSectionHeader(String title, bool isLargeScreen) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Text(
        title,
        style: TextStyle(
          color: Colors.white.withOpacity(0.9),
          fontSize: isLargeScreen ? 24 : 18,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class GlassmorphicButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const GlassmorphicButton({super.key, required this.label, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        width: width * 0.6,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.white.withOpacity(0.1),
              Colors.white.withOpacity(0.05),
            ],
          ),
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: Colors.white.withOpacity(0.2)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 15,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              color: Colors.white,
              fontSize: width > 600 ? 18 : 16,
              fontWeight: FontWeight.bold,
              shadows: [
                Shadow(
                  color: Colors.black.withOpacity(0.5),
                  offset: const Offset(0, 2),
                  blurRadius: 5,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ChatbotOptionsSection extends StatelessWidget {
  final List<String> chatbotLabels = const [
    'Chat with Bot',
    'Talk with Bot',
    'Search with Bot'
  ];
  final List<IconData> chatbotIcons = [Icons.chat, Icons.mic, Icons.search];
  final List<VoidCallback> chatbotActions = [
    () {
      // Action for Chat with Bot
    },
    () {
      // Action for Talk with Bot
    },
    () {
      // Action for Search with Bot
    }
  ];

  ChatbotOptionsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: MediaQuery.of(context).size.width < 600 ? 1 : 3,
        childAspectRatio: 3.5,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
      itemCount: chatbotLabels.length,
      itemBuilder: (context, index) {
        return ChatbotOptionCard(
          label: chatbotLabels[index],
          icon: chatbotIcons[index],
          onPressed: chatbotActions[index],
        );
      },
    );
  }
}

class ChatbotOptionCard extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onPressed;

  const ChatbotOptionCard(
      {super.key, required this.label, required this.icon, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.15),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white.withOpacity(0.3)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 15,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(icon, color: Colors.white, size: 30),
            const SizedBox(width: 15),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ResponsiveTrackerSection extends StatelessWidget {
  final List<String> trackerLabels = [
    'Solar Storm',
    'Van Allen Belt',
    'Geomagnetic Storm'
  ];

  final List<String> trackerImagePaths = const [
    '../assets/img/dis_solarstorm.png', // Fixed path
    '../assets/img/dis_VAR.png', // Fixed path
    '../assets/img/dis_GMS.png' // Fixed path
  ];

  ResponsiveTrackerSection({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: MediaQuery.of(context).size.width < 600 ? 2 : 3,
        childAspectRatio: 0.75,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
      itemCount: trackerLabels.length,
      itemBuilder: (context, index) {
        return StormTrackerCard(
          label: trackerLabels[index],
          imagePath: trackerImagePaths[index],
          onPressed: () {
            // Define navigation actions for each tracker
            if (index == 2) {
              // Geomagnetic Storm - navigate to GMSPage
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        const GMSDetails()), // Correct navigation to GMS page
              );
            } else {
              // Add actions for other sections if needed
            }
          },
        );
      },
    );
  }
}

class StormTrackerCard extends StatelessWidget {
  final String label;
  final String imagePath;
  final VoidCallback onPressed;

  const StormTrackerCard(
      {super.key, required this.label, required this.imagePath, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.15),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white.withOpacity(0.3)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 15,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(imagePath, fit: BoxFit.cover),
            const SizedBox(height: 10),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
