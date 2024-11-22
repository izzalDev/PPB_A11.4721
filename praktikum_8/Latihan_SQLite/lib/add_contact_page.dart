// ignore_for_file: prefer_const_constructors_in_immutables
import 'package:flutter/material.dart';
import 'package:flutter_aplication_sqlite/database/db_helper.dart';
import 'package:flutter_aplication_sqlite/models/contact.dart';

class AddContactPage extends StatefulWidget {
  final Contact? contact;

  AddContactPage({super.key, this.contact});

  @override
  State<AddContactPage> createState() => _AddContactPageState();
}

class _AddContactPageState extends State<AddContactPage> {
  final DbHelper db = DbHelper();

  late TextEditingController nameController;
  late TextEditingController phoneController;
  late TextEditingController emailController;
  late TextEditingController companyController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(
        text: widget.contact == null ? '' : widget.contact!.name);
    phoneController = TextEditingController(
        text: widget.contact == null ? '' : widget.contact!.phone);
    emailController = TextEditingController(
        text: widget.contact == null ? '' : widget.contact!.email);
    companyController = TextEditingController(
        text: widget.contact == null ? '' : widget.contact!.company);
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    companyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Form Contact'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: TextField(
              controller: phoneController,
              decoration: InputDecoration(
                labelText: 'Mobile No',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: TextField(
              controller: companyController,
              decoration: InputDecoration(
                labelText: 'Company',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: ElevatedButton(
              onPressed: () => _upsertContact(),
              child: Text(widget.contact == null ? 'Add' : 'Update'),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _upsertContact() async {
  if (widget.contact != null) {
    // Update contact
    await db.updatecontact(Contact(
      id: widget.contact!.id,
      name: nameController.text,
      phone: phoneController.text,
      email: emailController.text,
      company: companyController.text,
    ));

    if (mounted) {
      // Gunakan context jika widget masih aktif
      Navigator.pop(context, 'update');
    }
  } else {
    // Add new contact
    await db.savecontact(Contact(
      name: nameController.text,
      phone: phoneController.text,
      email: emailController.text,
      company: companyController.text,
    ));

    if (mounted) {
      // Gunakan context jika widget masih aktif
      Navigator.pop(context, 'save');
    }
  }
}

}
