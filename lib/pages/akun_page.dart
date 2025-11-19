import 'package:flutter/material.dart';

class AkunPage extends StatelessWidget {
  final String userName;
  final String userNpm;

  const AkunPage({
    super.key,
    required this.userName,
    required this.userNpm,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profil Mahasiswa
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                leading: const CircleAvatar(
                  radius: 25,
                  backgroundImage: AssetImage('lib/assets/images/profile.jpg'),
                ),
                title: Text(
                  userName,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(userNpm),
                trailing: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.green.shade100,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text(
                    'AKTIF',
                    style: TextStyle(color: Colors.green, fontSize: 12),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Dosen Pembimbing Akademik
            const Text(
              'DOSEN PEMBIMBING AKADEMIK',
              style: TextStyle(fontSize: 12, color: Colors.black54),
            ),
            const SizedBox(height: 8),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  const ListTile(
                    leading: Icon(Icons.person_outline),
                    title: Text('Muharor Nur Solihin'),
                  ),
                  const Divider(height: 1),
                  const ListTile(
                    leading: Icon(Icons.email_outlined),
                    title: Text('muharornursolihin@gmail.com'),
                  ),
                  const Divider(height: 1),
                  const ListTile(
                    leading: Icon(Icons.phone_outlined),
                    title: Text('08227186934'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Keluar Akun
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                leading: const Icon(Icons.logout_outlined),
                title: const Text('Keluar Akun'),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {
                  // aksi logout
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
