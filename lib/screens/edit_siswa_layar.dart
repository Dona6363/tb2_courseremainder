@Dona Alfianus Jikwa NIM : 41822010135
import 'package:flutter/material.dart';
import 'package:tb2_courseremainder/model/siswa.dart';
import 'package:tb2_courseremainder/utils/student_db.dart';

class EditStudentScreen extends StatefulWidget {
  final Student student;

  EditStudentScreen({required this.student});

  @override
  _EditStudentScreenState createState() => _EditStudentScreenState();
}

class _EditStudentScreenState extends State<EditStudentScreen> {
  final _nameController = TextEditingController();
  final _nimController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.student.name;
    _nimController.text = widget.student.nim;
    _phoneController.text = widget.student.phone ?? '';
    _emailController.text = widget.student.email ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Student'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: _nameController, decoration: InputDecoration(labelText: 'Name')),
            TextField(controller: _nimController, decoration: InputDecoration(labelText: 'NIM')),
            TextField(controller: _phoneController, decoration: InputDecoration(labelText: 'Phone')),
            TextField(controller: _emailController, decoration: InputDecoration(labelText: 'Email')),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // Save the updated student to the database
          Student updatedStudent = Student(
            id: widget.student.id,
            name: _nameController.text,
            nim: _nimController.text,
            phone: _phoneController.text,
            email: _emailController.text,
          );

          await DatabaseHelper.instance.updateStudent(updatedStudent);

          // Navigate back to the home screen
          Navigator.pop(context);
        },
        child: Icon(Icons.save),
      ),
    );
  }
}
