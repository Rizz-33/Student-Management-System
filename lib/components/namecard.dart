import 'package:flutter/material.dart';
import 'package:inclass_test/components/theme.dart';
import 'package:inclass_test/crud/update.dart';

class NameCard extends StatelessWidget {
  final String name;
  final String indexNumber;
  final String degree;
  final String documentId;

  const NameCard({
    Key? key,
    required this.name,
    required this.indexNumber,
    required this.degree,
    required this.documentId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      color: secondary50,
      margin: EdgeInsets.all(16),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'Name :',
                      style: TextStyle(color: accentColor),
                    ),
                    SizedBox(width: 16),
                    Text(
                      name,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Text(
                      'Index Number :',
                      style: TextStyle(color: accentColor),
                    ),
                    SizedBox(width: 16),
                    Text(
                      indexNumber,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Text(
                      'Degree :',
                      style: TextStyle(color: accentColor),
                    ),
                    SizedBox(width: 16),
                    Text(
                      degree,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            top: 8,
            right: 8,
            child: IconButton(
              icon: Icon(Icons.edit, size: 18, color: accent75),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UpdateDetails(documentId: documentId),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
