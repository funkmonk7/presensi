import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Data menu grid
    final List<Map<String, dynamic>> menuItems = [
      {"label": "Akademik", "icon": Icons.bar_chart_outlined, "color": Colors.blue},
      {"label": "Kegiatan", "icon": Icons.layers_outlined, "color": Colors.purple},
      {"label": "Aktivitas", "icon": Icons.calendar_today_outlined, "color": Colors.orange},
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF2F5FF),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            // 👤 PROFIL (ambil dari Firebase)
            StreamBuilder<DocumentSnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('presensi')
                  .doc('121212')
                  .collection('users')
                  .doc('12345')
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (!snapshot.hasData || !snapshot.data!.exists) {
                  return const ListTile(
                    leading: CircleAvatar(
                      radius: 25,
                      backgroundImage: AssetImage('lib/assets/images/profile.jpg'),
                    ),
                    title: Text("Data tidak ditemukan",
                        style: TextStyle(color: Colors.black)),
                    subtitle: Text("Periksa database Firestore kamu",
                        style: TextStyle(color: Colors.black54)),
                  );
                }

                var data = snapshot.data!.data() as Map<String, dynamic>;

                return ListTile(
                  leading: CircleAvatar(
                    radius: 25,
                    backgroundImage: NetworkImage(
                      data['ImageURL'] ??
                          'https://cdn-icons-png.flaticon.com/512/3135/3135715.png',
                    ),
                  ),
                  title: Text(
                    data['nama'] ?? 'Tanpa Nama',
                    style: const TextStyle(color: Colors.black),
                  ),
                  subtitle: Text(
                    "${data['npm'] ?? '-'} • INFORMATIKA",
                    style: const TextStyle(color: Colors.black54),
                  ),
                );
              },
            ),

            const SizedBox(height: 16),

            // 📸 Slider foto
            SizedBox(
              height: 180,
              child: PageView(
                children: List.generate(3, (index) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      'lib/assets/images/wisuda1.jpg',
                      fit: BoxFit.cover,
                    ),
                  );
                }),
              ),
            ),
            const SizedBox(height: 20),

            // 🔳 Grid menu
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: menuItems.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                childAspectRatio: 1,
              ),
              itemBuilder: (context, index) {
                final item = menuItems[index];
                return Container(
                  decoration: BoxDecoration(
                    color: item["color"].withOpacity(0.2),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(item["icon"], color: item["color"], size: 30),
                      const SizedBox(height: 8),
                      Text(
                        item["label"],
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),

            const SizedBox(height: 20),

            // 📅 Jadwal Hari Ini
            const Text(
              'Jadwal Hari Ini',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            // 🕒 Contoh jadwal
            Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.blue.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text(
                      "MK TEORI",
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Mobile & Web Service (RPL)",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    "A • 3 SKS • Lab 1",
                    style: TextStyle(color: Colors.black54, fontSize: 13),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text("07.00",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                        Icon(Icons.arrow_forward, color: Colors.blue),
                        Text("09.30",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
