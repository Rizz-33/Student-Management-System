import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:inclass_test/components/button.dart';
import 'package:inclass_test/components/theme.dart';

class CreateDetails extends StatelessWidget {
  CreateDetails({Key? key});

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _indexNumberController = TextEditingController();
  final TextEditingController _degreeController = TextEditingController();

  Future<bool> _checkUniqueIndexNumber(String indexNumber) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('student_details')
        .where('index_number', isEqualTo: indexNumber)
        .get();
    return querySnapshot.docs.isEmpty;
  }

  void _saveDataToFirestore(BuildContext context) async {
    await Firebase.initializeApp();

    String indexNumber = _indexNumberController.text;
    if (await _checkUniqueIndexNumber(indexNumber)) {
      FirebaseFirestore.instance.collection('student_details').add({
        'name': _nameController.text,
        'index_number': indexNumber,
        'degree': _degreeController.text,
      }).then((value) {
        print('Data saved to Firestore');
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Success'),
              content: Text('Data submitted successfully.'),
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
      }).catchError((error) {
        print('Failed to save data: $error');
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Error'),
              content: Text('Failed to submit data. Please try again later.'),
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
      });
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
          "Add Details",
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
              SizedBox(height: 25,),
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
              SizedBox(height: 25,),
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
              SizedBox(height: 45,),
              MyButton(text: "Submit", onTap: () => _saveDataToFirestore(context))
            ],
          ),
        ),
      ),
    );
  }
}
