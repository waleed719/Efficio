import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SupportUsPage extends StatelessWidget {
  final String githubUrl = "https://github.com/your-github-username";

  const SupportUsPage({super.key}); // Update with your actual GitHub profile

  void _launchGitHub() async {
    final Uri url = Uri.parse("https://github.com/your-github-username");
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw Exception("Could not launch $url");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Support Us')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Support Efficio',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Thank you for using Efficio! If you like this project and want to support it, here\'s how you can help:',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            SupportOption(
              icon: Icons.favorite,
              title: 'Show Some Love',
              description:
                  'Enjoy using Efficio? Let your friends know about it!',
              buttonText: 'Got it!',
              onTap: () {}, // No action needed, just a dummy button
            ),
            SupportOption(
              icon: Icons.bug_report,
              title: 'Report a Bug',
              description:
                  'If you find any issues, feel free to report them so I can fix them.',
              buttonText: 'Noted!',
              onTap: () {}, // No action needed
            ),
            SupportOption(
              icon: Icons.star,
              title: 'Star on GitHub',
              description:
                  'If you like this project, consider starring it on GitHub!',
              buttonText: 'Visit GitHub',
              onTap: _launchGitHub,
            ),
          ],
        ),
      ),
    );
  }
}

class SupportOption extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final String buttonText;
  final VoidCallback onTap;

  const SupportOption({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
    required this.buttonText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: 12.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, size: 30, color: Colors.blue),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Text(description, style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: onTap,
                child: Text(buttonText),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
