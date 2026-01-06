import 'package:flutter/material.dart';

// Diubah menjadi StatefulWidget
class CustomTextField extends StatefulWidget {
  final String label;
  final String hintText;
  final bool isPassword;
  final bool isValid;
  final TextEditingController? controller;
  // Properti suffixIcon dan suffixIconColor tidak lagi digunakan secara langsung 
  // karena logika ikon sudah dihandle di dalam state.

  const CustomTextField({
    super.key,
    required this.label,
    required this.hintText,
    this.isPassword = false,
    this.isValid = false,
    this.controller,
    // Menghapus properti suffixIcon dan suffixIconColor dari constructor 
    // jika Anda tidak ingin menggunakannya lagi. Jika tetap ingin, biarkan saja,
    // tetapi kita tidak menggunakannya untuk logika mata.
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  // Variabel untuk melacak apakah teks harus disembunyikan (hanya relevan untuk password)
  late bool _isObscure;

  @override
  void initState() {
    super.initState();
    // Inisialisasi: Sembunyikan teks jika isPassword adalah true
    _isObscure = widget.isPassword;
  }

  // Fungsi yang dipanggil saat tombol ikon mata diklik
  void _toggleObscureText() {
    setState(() {
      _isObscure = !_isObscure;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Penentuan Ikon Suffix
    Widget? activeSuffixIcon;

    if (widget.isPassword) {
      // Jika ini adalah field password, gunakan IconButton untuk fitur toggle
      activeSuffixIcon = IconButton(
        icon: Icon(
          // Ganti ikon berdasarkan status _isObscure
          _isObscure ? Icons.visibility_off_outlined : Icons.visibility_outlined,
          color: Colors.grey,
        ),
        onPressed: _toggleObscureText, // Panggil fungsi toggle
      );
    } else if (widget.isValid) {
      // Jika bukan password dan valid, tampilkan ikon checklist (sesuai logika lama)
      activeSuffixIcon = const Icon(Icons.check_circle, color: Colors.green);
    } else {
      activeSuffixIcon = null;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: widget.controller,
          // Gunakan status _isObscure yang bisa berubah
          obscureText: _isObscure, 
          decoration: InputDecoration(
            hintText: widget.hintText,
            contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Color(0xFFE0E0E0), width: 1.0),
              borderRadius: BorderRadius.circular(12.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.blue, width: 2.0),
              borderRadius: BorderRadius.circular(12.0),
            ),
            filled: true,
            fillColor: const Color(0xFFF5F5F5),
            suffixIcon: activeSuffixIcon,
          ),
        ),
      ],
    );
  }
}