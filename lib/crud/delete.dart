import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:inclass_test/components/button.dart';
import 'package:inclass_test/components/theme.dart';

class DeleteDetails extends StatelessWidget {
  const DeleteDetails({Key? key});

  void _deleteDataFromFirestore(BuildContext context, TextEditingController indexNumberController) async {
    await Firebase.initializeApp();

    try {
      String indexNumber = indexNumberController.text.trim();
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('student_details').where('index_number', isEqualTo: indexNumber).get();
      querySnapshot.docs.forEach((doc) {
        doc.reference.delete();
      });
      print('Data deleted from Firestore');

      indexNumberController.clear();

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Success'),
            content: Text('Data deleted successfully.'),
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
    } catch (error) {
      print('Failed to delete data: $error');

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Failed to delete data. Please try again later.'),
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
    TextEditingController _indexNumberController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text("Delete Details", style: TextStyle(color: primaryColor)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Column(
            children: [
              SizedBox(height: 25),
              TextFormField(
                controller: _indexNumberController,
                cursorColor: accentColor,
                decoration: InputDecoration(
                  labelText: '   Index Number : ',
                  labelStyle: TextStyle(color: accentColor, fontSize: 16),
                  border: UnderlineInputBorder(),
                  focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: accentColor)),
                ),
              ),
              SizedBox(height: 45),
              MyButton(
                text: "Delete",
                onTap: () {
                  String indexNumber = _indexNumberController.text.trim();
                  if (indexNumber.isNotEmpty) {
                    _deleteDataFromFirestore(context, _indexNumberController);
                  } else {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Error'),
                          content: Text('Please enter an index number.'),
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
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
