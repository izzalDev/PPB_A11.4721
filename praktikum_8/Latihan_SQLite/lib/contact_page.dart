import 'package:flutter/material.dart';
import 'package:flutter_aplication_sqlite/add_contact_page.dart';
import 'package:flutter_aplication_sqlite/database/db_helper.dart';
import 'package:flutter_aplication_sqlite/models/contact.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({super.key});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  List<Contact> listContact = [];
  final DbHelper db = DbHelper();

  @override
  void initState() {
    super.initState();
    // Menjalankan fungsi getAllContact saat pertama kali dimuat
    _getAllContact();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text("Contact App"),
        ),
      ),
      body: ListView.builder(
        itemCount: listContact.length,
        itemBuilder: (context, index) {
          Contact contact = listContact[index];
          return Padding(
            padding: const EdgeInsets.only(top: 20),
            child: ListTile(
              leading: const Icon(
                Icons.person,
                size: 50,
              ),
              title: Text(contact.name ?? ''),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),
                  Text("Email: ${contact.email ?? '-'}"),
                  const SizedBox(height: 8),
                  Text("Phone: ${contact.phone ?? '-'}"),
                  const SizedBox(height: 8),
                  Text("Company: ${contact.company ?? '-'}"),
                ],
              ),
              trailing: FittedBox(
                fit: BoxFit.fill,
                child: Row(
                  children: [
                    // Button edit
                    IconButton(
                      onPressed: () {
                        _openFormEdit(contact);
                      },
                      icon: const Icon(Icons.edit),
                    ),
                    // Button hapus
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        _showDeleteConfirmation(contact, index);
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      // Membuat button mengapung di bagian bawah kanan layar
      floatingActionButton: FloatingActionButton(
        onPressed: _openFormCreate,
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> _getAllContact() async {
    var list = await db.getAllcontact();
    setState(() {
      listContact.clear();
      for (var contact in list ?? []) {
        listContact.add(Contact.fromMap(contact));
      }
    });
  }

  Future<void> _deleteContact(Contact contact, int position) async {
    await db.deletecontact(contact.id!);
    setState(() {
      listContact.removeAt(position);
    });
  }

  Future<void> _openFormCreate() async {
    var result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddContactPage()),
    );
    if (result == 'save') {
      await _getAllContact();
    }
  }

  Future<void> _openFormEdit(Contact contact) async {
    var result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddContactPage(contact: contact),
      ),
    );
    if (result == 'update') {
      await _getAllContact();
    }
  }

  void _showDeleteConfirmation(Contact contact, int index) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Information"),
          content: Text("Yakin ingin menghapus data\n\n${contact.name}?"),
          actions: [
            TextButton(
              onPressed: () {
                _deleteContact(contact, index);
                Navigator.pop(context);
              },
              child: const Text("Ya"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Tidak"),
            ),
          ],
        );
      },
    );
  }
}
