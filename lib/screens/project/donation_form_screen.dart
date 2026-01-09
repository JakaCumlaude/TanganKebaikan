import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb; 
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../api_service.dart';

class DonationFormScreen extends StatefulWidget {
  const DonationFormScreen({super.key});

  @override
  State<DonationFormScreen> createState() => _DonationFormScreenState();
}

class _DonationFormScreenState extends State<DonationFormScreen> {
  bool _isAnonymous = false;
  bool _isLoading = false;
  String? _selectedMethod;
  XFile? _imageFile; 
  final ImagePicker _picker = ImagePicker();

  final _nameController = TextEditingController();
  final _amountController = TextEditingController();
  final _noteController = TextEditingController();

  final Map<String, String> _paymentDetails = {
    "Transfer Bank (BCA)": "No. Rek: 12345678 a/n Tangan Kebaikan",
    "E-Wallet (OVO/Dana)": "No. HP: 0812-3456-7890",
  };

  @override
  void dispose() {
    _nameController.dispose();
    _amountController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final XFile? selected = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 70, 
    );
    if (selected != null) {
      setState(() => _imageFile = selected);
    }
  }

  bool _isFormFull() {
    bool nameFilled = _isAnonymous || _nameController.text.isNotEmpty;
    return nameFilled && 
           _amountController.text.isNotEmpty && 
           _selectedMethod != null && 
           _imageFile != null;
  }

  void _submitData() async {
    if (_isFormFull()) {
      setState(() => _isLoading = true);

      final Map<String, dynamic> donationData = {
        "name": _isAnonymous ? "Anonim" : _nameController.text,
        "amount": _amountController.text,
        "note": _noteController.text,
        "payment_method": _selectedMethod,
        "proof_image": _imageFile!.name,
        "date": DateTime.now().toIso8601String(),
      };

   
      await ApiService.postDonation(donationData);

      setState(() => _isLoading = false);

     
      if (mounted) {
        _showAdminConfirmationDialog();
      }
    }
  }

  void _showAdminConfirmationDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        title: const Icon(Icons.check_circle, color: Colors.green, size: 50),
        content: const Text(
          "Terima Kasih, Donasi anda berhasil terkirim, mohon tunggu konfirmasi Admin.",
          textAlign: TextAlign.center,
        ),
        actions: [
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false),
              child: const Text("Selesai"),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Formulir Donasi")),
      body: _isLoading 
        ? const Center(child: CircularProgressIndicator()) 
        : SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CheckboxListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text("Kirim sebagai Anonim"),
                  value: _isAnonymous,
                  onChanged: (val) => setState(() => _isAnonymous = val!),
                ),
                if (!_isAnonymous)
                  TextField(
                    controller: _nameController, 
                    decoration: const InputDecoration(labelText: "Nama Lengkap", border: OutlineInputBorder()),
                    onChanged: (_) => setState(() {}), 
                  ),
                const SizedBox(height: 16),
                TextField(
                  controller: _amountController, 
                  decoration: const InputDecoration(labelText: "Jumlah Donasi (Rp)", border: OutlineInputBorder()), 
                  keyboardType: TextInputType.number,
                  onChanged: (_) => setState(() {}),
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(labelText: "Metode Pembayaran", border: OutlineInputBorder()),
                  items: _paymentDetails.keys.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                  onChanged: (val) => setState(() => _selectedMethod = val),
                ),
                const SizedBox(height: 20),
                
                const Text("Bukti Transfer", style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                InkWell(
                  onTap: _pickImage,
                  child: Container(
                    height: 180,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(color: _imageFile == null ? Colors.grey[400]! : Colors.blue), 
                      borderRadius: BorderRadius.circular(10), 
                      color: Colors.grey[50]
                    ),
                    child: _imageFile == null 
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(Icons.camera_alt, size: 40, color: Colors.grey),
                            Text("Klik untuk pilih bukti pembayaran", style: TextStyle(color: Colors.grey)),
                          ],
                        )
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: kIsWeb 
                            ? Image.network(_imageFile!.path, fit: BoxFit.cover)
                            : Image.file(File(_imageFile!.path), fit: BoxFit.cover),
                        ),
                  ),
                ),
                
                const SizedBox(height: 20),
                TextField(controller: _noteController, decoration: const InputDecoration(labelText: "Doa atau Note", border: OutlineInputBorder())),
                const SizedBox(height: 30),
                
               
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: _isFormFull() ? _submitData : null, 
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _isFormFull() ? Colors.blue : Colors.grey,
                    ),
                    child: const Text("KIRIM DONASI", style: TextStyle(color: Colors.white)),
                  ),
                ),
              ],
            ),
          ),
    );
  }
}