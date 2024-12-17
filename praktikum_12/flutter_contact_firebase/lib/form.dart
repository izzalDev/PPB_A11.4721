// ignore_for_file: unnecessary_new, unused_field, prefer_const_constructors,prefer_const_literals_to_create_immutables, unused_local_variable, unused_import, use_key_in_widget_constructors, avoid_print, unused_element
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:firebase_core/firebase_core.dart';
import 'main.dart';

class FormPage extends StatefulWidget {
//constructor have one parameter, optional paramter
//if have id we will show data and run update method
//else run add data
  const FormPage({this.id});
  final String? id;
  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
//set form key
  final _formKey = GlobalKey<FormState>();
//set texteditingcontroller variable
  var nameController = TextEditingController();
  var phoneNumberController = TextEditingController();
  var emailController = TextEditingController();
  var addressController = TextEditingController();
//inisialize firebase instance
  FirebaseFirestore firebase = FirebaseFirestore.instance;
  CollectionReference? users;
  void getData() async {
//get users collection from firebase
//collection is table in mysql
    users = firebase.collection('users');
//if have id
    if (widget.id != null) {
//get users data based on id document
      var data = await users!.doc(widget.id).get();
//we get data.data()
//so that it can be accessed, we make as a map
      var item = data.data() as Map<String, dynamic>;
//set state to fill data controller from data firebase
      setState(() {
        nameController = TextEditingController(text: item['name']);
        phoneNumberController =
            TextEditingController(text: item['phoneNumber']);
        emailController = TextEditingController(text: item['email']);
        addressController = TextEditingController(text: item['address']);
      });
    }
  }

  @override
  void initState() {
// ignore: todo
// TODO: implement initState
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("CONTACT FORM"),
          actions: [
//if have data show delete button
            widget.id != null
                ? IconButton(
                    onPressed: () {
//method to delete data based on id
                      users!.doc(widget.id).delete();
//back to main page
// '/' is home
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          '/', (Route<dynamic> route) => false);
                    },
                    icon: Icon(Icons.delete))
                : SizedBox()
          ],
        ),
//this form for add and edit data
//if have id passed from main, field will show data
        body: Form(
          key: _formKey,
          child: ListView(padding: EdgeInsets.all(16.0), children: [
            SizedBox(
              height: 10,
            ),
            CircleAvatar(
              radius: 30,
              child: Icon(
                Icons.person,
                size: 30,
              ),
            ),
            Text(
              'Name',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(
                  hintText: "Name",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  fillColor: Colors.white,
                  filled: true),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Name is Required!';
                }
                return null;
              },
            ),
            SizedBox(height: 20),
            Text(
              'Phone Number',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: phoneNumberController,
              decoration: InputDecoration(
                  hintText: "Phone Number",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  fillColor: Colors.white,
                  filled: true),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Phone Number is Required!';
                }
                return null;
              },
            ),
            SizedBox(height: 20),
            Text(
              'Email',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                  hintText: "Email",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  fillColor: Colors.white,
                  filled: true),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Email is Required!';
                }
                return null;
              },
            ),
            SizedBox(height: 20),
            Text(
              'Address',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: addressController,
              keyboardType: TextInputType.multiline,
              minLines: 5,
              maxLines: null,
              decoration: InputDecoration(
                  hintText: "Address",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  fillColor: Colors.white,
                  filled: true),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Address is Required!';
                }
                return null;
              },
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Text(
                  "Submit",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
//if id not null run add data to store data into firebase
//else update data based on id
                  if (widget.id == null) {
                    users!.add({
                      'name': nameController.text,
                      'phoneNumber': phoneNumberController.text,
                      'email': emailController.text,
                      'address': addressController.text
                    });
                  } else {
                    users!.doc(widget.id).update({
                      'name': nameController.text,
                      'phoneNumber': phoneNumberController.text,
                      'email': emailController.text,
                      'address': addressController.text
                    });
                  }
//snackbar notification
                  final snackBar =
                      SnackBar(content: Text('Data savedsuccessfully!'));
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
//back to main page
//home page => '/'
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      '/', (Route<dynamic> route) => false);
                }
              },
            )
          ]),
        ));
  }
}
