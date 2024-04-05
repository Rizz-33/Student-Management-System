import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:inclass_test/components/button.dart';
import 'package:inclass_test/components/theme.dart';

class UpdateDetails extends StatelessWidget {
  final String documentId;

  UpdateDetails({Key? key, required this.documentId});

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _indexNumberController = TextEditingController();
  final TextEditingController _degreeController = TextEditingController();

  Future<bool> _checkUniqueIndexNumber(String newIndexNumber) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('student_details')
        .where('index_number', isEqualTo: newIndexNumber)
        .get();
    return querySnapshot.docs.isEmpty;
  }

  void _updateDataInFirestore(BuildContext context) async {
    await Firebase.initializeApp();

    String newIndexNumber = _indexNumberController.text;

    if (await _checkUniqueIndexNumber(newIndexNumber)) {
      try {
        await FirebaseFirestore.instance.collection('student_details').doc(documentId).update({
          'name': _nameController.text,
          'index_number': newIndexNumber,
          'degree': _degreeController.text,
        });
        print('Data updated in Firestore');

        Navigator.pop(context);
      } catch (error) {
        print('Failed to update data: $error');

        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Error'),
              content: Text('Failed to update data. Please try again later.'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK', style: TextStyle(color: accentColor),),
                ),
              ],
            );
          },
        );
      }
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('The index number is already in use. Please choose a different one.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK', style: TextStyle(color: accentColor),),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Edit Details",
          style: TextStyle(color: primaryColor),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                cursorColor: accentColor,
                decoration: InputDecoration(
                  labelText: '   Name : ',
                  labelStyle: TextStyle(
                    color: accentColor,
                    fontSize: 16,
                  ),
                  border: UnderlineInputBorder(),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: accentColor),
                  ),
                ),
              ),
              SizedBox(height: 25),
              TextFormField(
                controller: _indexNumberController,
                cursorColor: accentColor,
                decoration: InputDecoration(
                  labelText: '   Index Number : ',
                  labelStyle: TextStyle(
                    color: accentColor,
                    fontSize: 16,
                  ),
                  border: UnderlineInputBorder(),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: accentColor),
                  ),
                ),
              ),
              SizedBox(height: 25),
              TextFormField(
                controller: _degreeController,
                cursorColor: accentColor,
                decoration: InputDecoration(
                  labelText: '   Degree : ',
                  labelStyle: TextStyle(
                    color: accentColor,
                    fontSize: 16,
                  ),
                  border: UnderlineInputBorder(),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: accentColor),
                  ),
                ),
              ),
              SizedBox(height: 45),
              MyButton(text: "Save", onTap: () => _updateDataInFirestore(context))
            ],
          ),
        ),
      ),
    );
  }
}
