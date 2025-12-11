import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DonationScreen extends StatefulWidget {
  const DonationScreen({super.key});

  @override
  State<DonationScreen> createState() => _DonationScreenState();
}

class _DonationScreenState extends State<DonationScreen> {
  int _selectedPaymentMethod = 1;

  @override
  Widget build(BuildContext context) {
    // Cek lebar layar untuk responsivitas (Desktop vs Mobile)
    final bool isWideScreen = MediaQuery.of(context).size.width > 800;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black87),
        title: Text("Donasi", style: GoogleFonts.inter(color: Colors.black87, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        child: Column(
          children: [
            // --- HEADER ---
            Text(
              "Salurkan Bantuan Anda, Wujudkan Perubahan",
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(fontSize: 28, fontWeight: FontWeight.bold, color: const Color(0xFF212121)),
            ),
            const SizedBox(height: 12),
            Text(
              "Setiap donasi Anda adalah harapan baru bagi mereka yang terdampak bencana. Mari\nbersama kita bangun kembali.",
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(color: Colors.grey[600], fontSize: 14, height: 1.5),
            ),
            const SizedBox(height: 40),

            // --- KONTEN UTAMA (Form Kiri - Info Kanan) ---
            isWideScreen 
            ? Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(flex: 5, child: _buildFormSection()), // Kiri (Lebih lebar)
                  const SizedBox(width: 40),
                  Expanded(flex: 4, child: _buildInfoSection()), // Kanan
                ],
              )
            : Column( // Tumpuk vertikal jika layar kecil
                children: [
                  _buildFormSection(),
                  const SizedBox(height: 40),
                  _buildInfoSection(),
                ],
              ),
          ],
        ),
      ),
    );
  }

  // === BAGIAN FORMULIR (KIRI) ===
  Widget _buildFormSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Formulir Donasi Anda", style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        Text("Pilih jenis donasi dan lengkapi detail Anda untuk membantu sesama.", style: GoogleFonts.inter(color: Colors.grey[600], fontSize: 13)),
        const SizedBox(height: 24),

        // Baris Nama & Email
        Row(
          children: [
            Expanded(child: _buildInputField("Nama Lengkap", "Masukkan nama lengkap Anda")),
            const SizedBox(width: 16),
            Expanded(child: _buildInputField("Email", "Masukkan alamat email Anda")),
          ],
        ),
        const SizedBox(height: 20),

        // Jumlah Donasi
        _buildInputField("Jumlah Donasi", "Rp 100.000", isNumber: true),
        const SizedBox(height: 24),

        // Metode Pembayaran
        Text("Metode Pembayaran", style: GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: 14)),
        const SizedBox(height: 12),
        _buildRadioItem(1, "Transfer Bank (BCA, Mandiri, BRI)", Icons.account_balance),
        if(_selectedPaymentMethod == 1)
          Padding(
            padding: const EdgeInsets.only(left: 32, bottom: 12),
            child: Text("NO REK: 133192153919", style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.blue[800])),
          ),
        _buildRadioItem(2, "E-Wallet (GoPay, OVO, Dana)", Icons.account_balance_wallet),
        _buildRadioItem(3, "Kartu Kredit/Debit", Icons.credit_card),
        
        const SizedBox(height: 24),

        // Tombol Upload Bukti
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Text("Bukti pembayaran", style: GoogleFonts.inter(color: Colors.grey[600], fontSize: 14)),
          ),
        ),

        const SizedBox(height: 30),

        // Tombol Submit Biru Besar
        SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            onPressed: () {
               ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Terima kasih! Donasi berhasil.")));
               Navigator.popUntil(context, ModalRoute.withName('/home'));
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF2196F3),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              elevation: 0,
            ),
            child: Text("Donasikan Sekarang", style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
          ),
        )
      ],
    );
  }

  // === BAGIAN INFO (KANAN) ===
  Widget _buildInfoSection() {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: const Color(0xFFF9FAFB), // Abu-abu sangat muda persis gambar
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Mengapa Berdonasi ke TanganKebaikan?", style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 24),
          _buildInfoItem(Icons.verified_user_outlined, "Transparansi Penuh", "Setiap rupiah donasi Anda dapat dilacak dan dilaporkan dengan jelas."),
          _buildInfoItem(Icons.shield_outlined, "Keamanan Terjamin", "Sistem pembayaran yang aman dan terpercaya untuk ketenangan Anda."),
          _buildInfoItem(Icons.people_outline, "Jangkauan Luas", "Membantu korban di berbagai wilayah bencana di seluruh Indonesia."),
          _buildInfoItem(Icons.timer_outlined, "Respon Cepat", "Donasi Anda memungkinkan kami bertindak cepat saat bencana melanda."),
          _buildInfoItem(Icons.track_changes_outlined, "Dampak Nyata", "Wujudkan perubahan positif secara langsung pada komunitas yang membutuhkan."),
        ],
      ),
    );
  }

  // --- WIDGET KECIL (HELPER) ---

  Widget _buildInputField(String label, String hint, {bool isNumber = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: GoogleFonts.inter(fontWeight: FontWeight.w600, fontSize: 13, color: Colors.black87)),
        const SizedBox(height: 8),
        TextFormField(
          keyboardType: isNumber ? TextInputType.number : TextInputType.text,
          style: GoogleFonts.inter(fontSize: 14),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: GoogleFonts.inter(color: Colors.grey[400], fontSize: 14),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: Colors.grey.shade300)),
            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: Colors.grey.shade300)),
          ),
        ),
      ],
    );
  }

  Widget _buildRadioItem(int val, String label, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: () => setState(() => _selectedPaymentMethod = val),
        child: Row(
          children: [
            Radio(
              value: val, 
              groupValue: _selectedPaymentMethod, 
              onChanged: (v) => setState(() => _selectedPaymentMethod = v!),
              activeColor: Colors.blue,
            ),
            Icon(icon, size: 20, color: Colors.grey[700]),
            const SizedBox(width: 10),
            Text(label, style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w500)),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoItem(IconData icon, String title, String desc) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.blue, size: 24),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.black87)),
                const SizedBox(height: 4),
                Text(desc, style: GoogleFonts.inter(fontSize: 13, color: Colors.grey[600], height: 1.4)),
              ],
            ),
          )
        ],
      ),
    );
  }
}