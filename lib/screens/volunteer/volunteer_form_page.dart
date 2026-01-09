import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../models/volunteer_model.dart';

class VolunteerFormPage extends StatefulWidget {
  final Volunteer? volunteer;

  const VolunteerFormPage({
    super.key,
    this.volunteer,
  });

  @override
  State<VolunteerFormPage> createState() => _VolunteerFormPageState();
}

class _VolunteerFormPageState extends State<VolunteerFormPage> {
  final _formKey = GlobalKey<FormState>();

  final String mockUrl =
      "https://694d37b1ad0f8c8e6e200fe8.mockapi.io/volunteers";

  late TextEditingController nameC;
  late TextEditingController descC;
  late TextEditingController imageC;
  late TextEditingController locationC;
  late TextEditingController linkC;

  @override
  void initState() {
    super.initState();

    nameC = TextEditingController(
      text: widget.volunteer?.name ?? "",
    );
    descC = TextEditingController(
      text: widget.volunteer?.description ?? "",
    );
    imageC = TextEditingController(
      text: widget.volunteer?.image ?? "",
    );
    locationC = TextEditingController(
      text: widget.volunteer?.location ?? "",
    );
    linkC = TextEditingController(
      text: widget.volunteer?.registrationLink ?? "",
    );
  }

  Future<void> submit() async {
    if (!_formKey.currentState!.validate()) return;

    final data = {
      "name": nameC.text,
      "description": descC.text,
      "image": imageC.text,
      "location": locationC.text,
      "registrationLink": linkC.text,
    };

    if (widget.volunteer == null) {
      // POST
      await http.post(
        Uri.parse(mockUrl),
        headers: {"Content-Type": "application/json"},
        body: json.encode(data),
      );
    } else {
      // PUT
      await http.put(
        Uri.parse("$mockUrl/${widget.volunteer!.id}"),
        headers: {"Content-Type": "application/json"},
        body: json.encode(data),
      );
    }

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.volunteer == null
              ? "Tambah Volunteer"
              : "Edit Volunteer",
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              _input(nameC, "Nama"),
              _input(descC, "Deskripsi"),
              _input(imageC, "Image URL"),
              _input(locationC, "Lokasi"),
              _input(linkC, "Link Pendaftaran"),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: submit,
                child: const Text("Simpan"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _input(TextEditingController c, String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: c,
        validator: (v) => v!.isEmpty ? "Wajib diisi" : null,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}
