import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../widgets/bottom_navbar.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController npmController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isLoading = false;

  Future<void> loginMahasiswa() async {
    setState(() => isLoading = true);

    String npm = npmController.text.trim();
    String password = passwordController.text.trim();

    if (npm.isEmpty || password.isEmpty) {
      showDialogMessage('Kolom tidak boleh kosong');
      setState(() => isLoading = false);
      return;
    }

    try {
      // 🔍 Cari user berdasarkan field 'npm'
      QuerySnapshot snapshot = await FirebaseFirestore.instance
    .collection('presensi')
    .doc('121212')
    .collection('users')
    .where('npm', isEqualTo: npm)
    .limit(1)
    .get();

      if (snapshot.docs.isEmpty) {
        showDialogMessage('NPM tidak ditemukan');
      } else {
        var userData = snapshot.docs.first.data() as Map<String, dynamic>;
        if (userData['password'] == password) {
          // ✅ Login sukses
          showDialogMessage('Login berhasil, selamat datang ${userData['nama']}!');

          // ⏳ Delay sebentar biar user lihat pesan, lalu pindah halaman
          Future.delayed(const Duration(seconds: 1), () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => BottomNavBar(
                  userName: userData['nama'],
                  userNpm: userData['npm'],
                ),
              ),
            );
          });
        } else {
          showDialogMessage('Kata sandi salah');
        }
      }
    } catch (e) {
      showDialogMessage('Terjadi kesalahan: $e');
    }

    setState(() => isLoading = false);
  }

  void showDialogMessage(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Informasi'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'PORTAL MAHASISWA',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                  ),
                ),
                const SizedBox(height: 50),
                TextField(
                  controller: npmController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Nomor Pokok Mahasiswa',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    prefixIcon: const Icon(Icons.badge_outlined),
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Kata Sandi',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    prefixIcon: const Icon(Icons.lock_outline),
                  ),
                ),
                const SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: isLoading ? null : loginMahasiswa,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.indigo,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text(
                            'Masuk Portal',
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                  ),
                ),
                const SizedBox(height: 15),
                GestureDetector(
                  onTap: () {
                    showDialogMessage("Hubungi admin untuk reset kata sandi.");
                  },
                  child: const Text(
                    'Lupa Kata Sandi? Bantuan Masuk',
                    style: TextStyle(color: Colors.blueAccent),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
