import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:inclass_test/components/namecard.dart';
import 'package:inclass_test/components/theme.dart';

class ReadDetails extends StatelessWidget {
  const ReadDetails({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Student Details",
          style: TextStyle(color: primaryColor),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: StreamBuilder(
            stream: FirebaseFirestore.instance.collection('student_details').snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              }
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }
              return Column(
                children: snapshot.data!.docs.map((DocumentSnapshot document) {
                  Map<String, dynamic> data = document.data() as Map<String, dynamic>;
                  return NameCard(
                    name: data['name'] ?? '',
                    indexNumber: data['index_number'] ?? '',
                    degree: data['degree'] ?? '',
                    documentId: document.id,
                  );
                }).toList(),
              );
            },
          ),
        ),
      ),
    );
  }
}
