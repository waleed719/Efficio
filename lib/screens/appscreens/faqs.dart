import 'package:flutter/material.dart';

class FAQPage extends StatelessWidget {
  FAQPage({super.key});
  final List<Map<String, String>> faqData = [
    {
      "question": "What is Efficio?",
      "answer":
          "Efficio is a task management app designed to help you stay productive and organized. It includes features like task categorization, Focus Mode, and reminders to enhance efficiency."
    },
    {
      "question": "Is Efficio free to use?",
      "answer":
          "Yes! Efficio is completely free to use. We may introduce premium features in the future for additional functionality."
    },
    {
      "question": "How does Focus Mode work?",
      "answer":
          "Focus Mode helps you eliminate distractions by setting a countdown timer and enabling Do Not Disturb (DND) mode. A persistent notification ensures you stay on track."
    },
    {
      "question": "Who do I contact for support?",
      "answer":
          "If you need help, feel free to contact us at support@Efficio.com."
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('FAQs')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: faqData.length,
        itemBuilder: (context, index) {
          return FAQTile(
            question: faqData[index]['question']!,
            answer: faqData[index]['answer']!,
          );
        },
      ),
    );
  }
}

class FAQTile extends StatelessWidget {
  final String question;
  final String answer;

  const FAQTile({super.key, required this.question, required this.answer});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: 12.0),
      child: ExpansionTile(
        title: Text(
          question,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(answer, style: TextStyle(fontSize: 15)),
          ),
        ],
      ),
    );
  }
}
