@Dona Alfianus Jikwa NIM : 41822010135
import 'package:flutter/material.dart';
import 'package:tb2_courseremainder/model/siswa.dart';
import 'package:tb2_courseremainder/utils/student_db.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DatabaseHelper databaseHelper = DatabaseHelper.instance;
  List<Student> students = [];
  int totalStudents = 0;

  @override
  void initState() {
    super.initState();
    _loadStudents();
  }

  void _loadStudents() async {
    List<Student> studentsList = await databaseHelper.getStudents();
    setState(() {
      students = studentsList;
      totalStudents = students.length;
    });
  }

  void _showAddStudentDialog() {
    TextEditingController nameController = TextEditingController();
    TextEditingController nimController = TextEditingController();
    TextEditingController phoneController = TextEditingController();
    TextEditingController emailController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Create Student"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Student Name'),
                keyboardType: TextInputType.text,
              ),
              TextField(
                controller: nimController,
                decoration: InputDecoration(labelText: 'NIM'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: phoneController,
                decoration: InputDecoration(labelText: 'Phone'),
                keyboardType: TextInputType.phone,
              ),
              TextField(
                controller: emailController,
                decoration: InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.grey), // Ubah warna tombol menjadi abu-abu
              ),
              onPressed: () async {
                Student student = Student(
                  name: nameController.text,
                  nim: nimController.text,
                  phone: phoneController.text,
                  email: emailController.text,
                );
                await databaseHelper.insertStudent(student);
                _loadStudents();
                Navigator.of(context).pop();
              },
              child: Text("Create"),
            ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.grey), // Ubah warna tombol menjadi abu-abu
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Cancel"),
            ),
          ],
        );
      },
    );
  }

  void _showEditStudentDialog(Student student) {
    TextEditingController nameController = TextEditingController(text: student.name);
    TextEditingController nimController = TextEditingController(text: student.nim);
    TextEditingController phoneController = TextEditingController(text: student.phone);
    TextEditingController emailController = TextEditingController(text: student.email);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Update student information"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Student Name'),
                keyboardType: TextInputType.text,
              ),
              TextField(
                controller: nimController,
                decoration: InputDecoration(labelText: 'NIM'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: phoneController,
                decoration: InputDecoration(labelText: 'Phone'),
                keyboardType: TextInputType.phone,
              ),
              TextField(
                controller: emailController,
                decoration: InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.grey), // Ubah warna tombol menjadi abu-abu
              ),
              onPressed: () async {
                Student updatedStudent = Student(
                  id: student.id,
                  name: nameController.text,
                  nim: nimController.text,
                  phone: phoneController.text,
                  email: emailController.text,
                );
                await databaseHelper.updateStudent(updatedStudent);
                _loadStudents();
                Navigator.of(context).pop();
              },
              child: Text("Update"),
            ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.grey), // Ubah warna tombol menjadi abu-abu
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Cancel"),
            ),
          ],
        );
      },
    );
  }

  void _showDeleteConfirmationDialog(Student student) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text("Are You sure, You wanted to delete this student?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Tutup dialog jika tombol 'Delete' ditekan
              },
              child: Text(
                "NO",
                style: TextStyle(color: Colors.pinkAccent), // Ubah warna tombol Delete menjadi abu-abu
              ),
            ),
            TextButton(
              onPressed: () async {
                await databaseHelper.deleteStudent(student.id!);
                _loadStudents();
                Navigator.of(context).pop();
              },
              child: Text(
                "YES",
                style: TextStyle(color: Colors.pinkAccent), // Ubah warna tulisan YES menjadi pinkAccent
              ),
            ),
          ],
        );
      },
    );
  }

  void _showDeleteAllConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Delete All Students"),
          content: Text("Are you sure you want to delete all students?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Tutup dialog jika tombol 'Cancel' ditekan
              },
              child: Text(
                "Cancel",
                style: TextStyle(color: Colors.pinkAccent), // Ubah warna tulisan Cancel menjadi pinkAccent
              ),
            ),
            TextButton(
              onPressed: () {
                _deleteAllStudents(); // Panggil fungsi untuk menghapus semua data
                Navigator.of(context).pop(); // Tutup dialog setelah selesai
              },
              child: Text(
                "Delete",
                style: TextStyle(color: Colors.pinkAccent), // Ubah warna tulisan Delete menjadi pinkAccent
              ),
            ),
          ],
        );
      },
    );
  }

  void _deleteAllStudents() async {
    await databaseHelper.deleteAllStudents(); // Panggil metode untuk menghapus semua data dari database
    setState(() {
      students.clear(); // Kosongkan daftar mahasiswa setelah dihapus
      totalStudents = 0; // Set total mahasiswa kembali ke 0
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Student List",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.indigo,
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              _showDeleteAllConfirmationDialog();
            },
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Total Students: $totalStudents',
              style: TextStyle(fontSize: 12),
            ),
          ),
          Expanded(
            child: students.isEmpty
                ? Center(
              child: Text(
                'List is Empty!',
                style: TextStyle(fontSize: 12),
              ),
            )
                : ListView.builder(
              itemCount: students.length,
              itemBuilder: (BuildContext context, int index) {
                Student student = students[index];
                return Container(
                  margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              student.name,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Row(
                              children: [
                                IconButton(
                                  icon: Icon(Icons.edit, color: Colors.grey),
                                  onPressed: () {
                                    _showEditStudentDialog(student);
                                  },
                                ),
                                IconButton(
                                  icon: Icon(Icons.delete, color: Colors.grey),
                                  onPressed: () {
                                    _showDeleteConfirmationDialog(student);
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                        Text("NIM: ${student.nim}"),
                        Text("Phone: ${student.phone != null ? student.phone : 'N/A'}"),
                        Text("Email: ${student.email != null ? student.email : 'N/A'}"),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddStudentDialog();
        },
        backgroundColor: Colors.pinkAccent,
        child: Icon(Icons.person_add),
      ),
    );
  }
}
