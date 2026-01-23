import 'package:flutter/material.dart';
import '../models/engineer.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  static final List<Engineer> engineers = [
    Engineer(
      name: "YUFENYUY RODRICK",
      role: "Lead Developer",
      description:
          "Passionate about creating innovative mobile applications and delivering high-quality solutions for authentic Cameroonian craftsmanship.",
      imageUrl: "assets/rodrick.png",
    ),
    Engineer(
      name: "YOUNGA DYLANE",
      role: "Full Stack Developer",
      description:
          "Expert in building scalable applications with focus on user experience and robust backend infrastructure.",
      imageUrl: "assets/dylane.png",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("About Us"),
        backgroundColor: const Color(0xFF1B2B3A),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Meet Our Team",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1B2B3A),
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "We are a passionate team of developers dedicated to promoting authentic Cameroonian craftsmanship through innovative technology.",
              style: TextStyle(fontSize: 16, color: Colors.grey, height: 1.5),
            ),
            const SizedBox(height: 30),
            ...engineers.map((engineer) => _EngineerCard(engineer: engineer)),
          ],
        ),
      ),
    );
  }
}

class _EngineerCard extends StatelessWidget {
  final Engineer engineer;

  const _EngineerCard({required this.engineer});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            CircleAvatar(
              radius: 40,
              backgroundImage: AssetImage(engineer.imageUrl),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    engineer.name,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1B2B3A),
                    ),
                  ),
                  Text(
                    engineer.role,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Color(0xFFD27C4B),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    engineer.description,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
