@Dona Alfianus Jikwa NIM : 41822010135
import 'package:flutter/material.dart';
import 'package:tb2_courseremainder/model/siswa.dart';
import 'package:tb2_courseremainder/utils/student_db.dart';

class AddStudentDialog extends StatefulWidget {
  @override
  _AddStudentDialogState createState() => _AddStudentDialogState();
}

class _AddStudentDialogState extends State<AddStudentDialog> {
  final _nameController = TextEditingController();
  final _nimController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add Student'),
      content: SingleChildScrollView(
        child: Column(
          children: [
            TextField(controller: _nameController, decoration: InputDecoration(labelText: 'Name')),
            TextField(controller: _nimController, decoration: InputDecoration(labelText: 'NIM')),
            TextField(controller: _phoneController, decoration: InputDecoration(labelText: 'Phone')),
            TextField(controller: _emailController, decoration: InputDecoration(labelText: 'Email')),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context); // Close the dialog
          },
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () async {
            // Save the student to the database
            Student newStudent = Student(
              name: _nameController.text,
              nim: _nimController.text,
              phone: _phoneController.text,
              email: _emailController.text,
            );

            await DatabaseHelper.instance.insertStudent(newStudent);

            // Close the dialog
            Navigator.pop(context);
          },
          child: Text('Create'),
        ),
      ],
    );
  }
}
