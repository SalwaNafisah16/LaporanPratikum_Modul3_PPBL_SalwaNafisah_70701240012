
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/favorit_model.dart';
import '../navigation/app_routes.dart';

class HalamanWarga extends StatelessWidget {
  const HalamanWarga({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const CircleAvatar(
          radius: 45,
          child: Icon(
            Icons.person,
            size: 45,
          ),
        ),
        const SizedBox(height: 16),
        const Center(
          child: Text(
            'Salwa Nafisah',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const Center(
          child: Text('NIK: 162526262623352442'),
        ),
        const SizedBox(height: 24),

        // Menu Riwayat Laporan yang sudah ada
        Card(
          child: ListTile(
            leading: const Icon(Icons.history),
            title: const Text('Riwayat Laporan'),
            subtitle: const Text(
              'Lihat riwayat laporan warga',
            ),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Navigator.pushNamed(
                context,
                AppRoutes.riwayat,
              );
            },
          ),
        ),

        const SizedBox(height: 24),

        // Bagian Layanan Favorit
        const Text(
          'Layanan Favorit',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),

        Consumer<FavoritModel>(
          builder: (context, favoritModel, child) {
            final daftarFavorit =
                favoritModel.layananFavorit.toList();

            if (daftarFavorit.isEmpty) {
              return const Card(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Text(
                    'Belum ada layanan favorit.',
                  ),
                ),
              );
            }

            return Column(
              children: daftarFavorit.map((namaLayanan) {
                return Card(
                  child: ListTile(
                    leading: const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    title: Text(namaLayanan),
                    trailing: IconButton(
                      tooltip: 'Hapus dari favorit',
                      icon: const Icon(
                        Icons.delete_outline,
                      ),
                      onPressed: () {
                        favoritModel.batalTandai(
                          namaLayanan,
                        );
                      },
                    ),
                  ),
                );
              }).toList(),
            );
          },
        ),
      ],
    );
  }
}
