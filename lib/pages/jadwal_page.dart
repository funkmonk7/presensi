import 'package:flutter/material.dart';

class JadwalPage extends StatefulWidget {
  const JadwalPage({Key? key}) : super(key: key);

  @override
  State<JadwalPage> createState() => _JadwalPageState();
}

class _JadwalPageState extends State<JadwalPage> {
  // daftar hari
  final List<String> hariList = ["Senin", "Selasa", "Rabu", "Kamis", "Jumat"];

  // hari yang sedang aktif
  String hariAktif = "Senin";

  // data jadwal lengkap per hari
  final Map<String, List<Map<String, String>>> jadwalMap = {
    "Senin": [
      {
        "mataPelajaran": "Matematika",
        "tipe": "MK TEORI",
        "kelas": "A",
        "sks": "3",
        "jamMulai": "07.00",
        "jamSelesai": "08.30",
        "ruang": "Lab 1"
      },
      {
        "mataPelajaran": "Fisika",
        "tipe": "MK PRAKTIK",
        "kelas": "B",
        "sks": "3",
        "jamMulai": "09.00",
        "jamSelesai": "10.30",
        "ruang": "Lab 2"
      },
    ],
    "Selasa": [
      {
        "mataPelajaran": "Biologi",
        "tipe": "MK TEORI",
        "kelas": "C",
        "sks": "3",
        "jamMulai": "08.00",
        "jamSelesai": "09.30",
        "ruang": "Lab 3"
      },
      {
        "mataPelajaran": "Sejarah",
        "tipe": "MK TEORI",
        "kelas": "A",
        "sks": "2",
        "jamMulai": "10.00",
        "jamSelesai": "11.30",
        "ruang": "Kelas A"
      },
    ],
    "Rabu": [
      {
        "mataPelajaran": "Agama",
        "tipe": "MK TEORI",
        "kelas": "B",
        "sks": "2",
        "jamMulai": "07.00",
        "jamSelesai": "08.30",
        "ruang": "Kelas B"
      },
      {
        "mataPelajaran": "Bahasa Inggris",
        "tipe": "MK TEORI",
        "kelas": "C",
        "sks": "3",
        "jamMulai": "09.00",
        "jamSelesai": "10.30",
        "ruang": "Kelas C"
      },
    ],
    "Kamis": [
      {
        "mataPelajaran": "Olahraga",
        "tipe": "MK PRAKTIK",
        "kelas": "A",
        "sks": "1",
        "jamMulai": "08.00",
        "jamSelesai": "09.30",
        "ruang": "Lapangan"
      },
      {
        "mataPelajaran": "Seni Budaya",
        "tipe": "MK TEORI",
        "kelas": "B",
        "sks": "2",
        "jamMulai": "10.00",
        "jamSelesai": "11.30",
        "ruang": "Kelas D"
      },
    ],
    "Jumat": [
      {
        "mataPelajaran": "Prakarya",
        "tipe": "MK PRAKTIK",
        "kelas": "C",
        "sks": "2",
        "jamMulai": "07.00",
        "jamSelesai": "08.30",
        "ruang": "Lab 5"
      },
      {
        "mataPelajaran": "Informatika",
        "tipe": "MK PRAKTIK",
        "kelas": "A",
        "sks": "3",
        "jamMulai": "09.00",
        "jamSelesai": "10.30",
        "ruang": "Lab Komputer"
      },
    ],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              const Text(
                "Semua Jadwal Kuliah",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
              ),
              const SizedBox(height: 12),

              // Bar hari
              Container(
                padding: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.indigo.shade50,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: hariList.map((hari) {
                    bool aktif = hari == hariAktif;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          hariAktif = hari;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: aktif ? Colors.indigo : Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: const Color.fromARGB(255, 215, 215, 215)),
                        ),
                        child: Text(
                          hari,
                          style: TextStyle(
                            color: aktif ? Colors.white : Colors.indigo,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),

              const SizedBox(height: 16),

              // Isi jadwal sesuai hari aktif
              Expanded(
                child: ListView.builder(
                  itemCount: jadwalMap[hariAktif]?.length ?? 0,
                  itemBuilder: (context, index) {
                    var data = jadwalMap[hariAktif]![index];

                    String tipe = data["tipe"] ?? "MK TEORI";
                    Color tipeColor = tipe == "MK PRAKTIK"
                        ? Colors.pink
                        : Colors.blue;

                    return Container(
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
                          // Label tipe MK
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: tipeColor.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              tipe,
                              style: TextStyle(
                                color: tipeColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          // Nama mata kuliah
                          Text(
                            data["mataPelajaran"]!,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 4),
                          // Kelas, SKS, ruang
                          Text(
                            "${data["kelas"]} • ${data["sks"]} SKS • ${data["ruang"]}",
                            style: const TextStyle(
                              color: Colors.black54,
                              fontSize: 13,
                            ),
                          ),
                          const SizedBox(height: 12),
                          // Jam mulai → jam selesai
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 12,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade100,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  data["jamMulai"]!,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Icon(Icons.arrow_forward, color: tipeColor),
                                Text(
                                  data["jamSelesai"]!,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
