
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/favorit_model.dart';

class HalamanLayanan extends StatefulWidget {
  const HalamanLayanan({super.key});

  @override
  State<HalamanLayanan> createState() =>
      _HalamanLayananState();
}

class _HalamanLayananState extends State<HalamanLayanan> {
  final List<Map<String, String>> perizinan = [
    {
      'nama': 'Izin Usaha',
      'dinas': 'Dinas Penanaman Modal',
      'jam': '08.00 - 15.00',
      'keterangan': 'Pengajuan izin usaha bagi warga.',
    },
    {
      'nama': 'Izin Bangunan',
      'dinas': 'Dinas Tata Kota',
      'jam': '08.00 - 15.00',
      'keterangan': 'Pengurusan izin pembangunan bangunan.',
    },
    {
      'nama': 'Izin Reklame',
      'dinas': 'Dinas Perizinan',
      'jam': '08.00 - 14.00',
      'keterangan': 'Pengajuan izin pemasangan reklame.',
    },
  ];

  final List<Map<String, String>> kesehatan = [
    {
      'nama': 'Pendaftaran Puskesmas',
      'dinas': 'Dinas Kesehatan',
      'jam': '07.30 - 14.00',
      'keterangan': 'Pendaftaran layanan kesehatan.',
    },
    {
      'nama': 'Vaksinasi',
      'dinas': 'Dinas Kesehatan',
      'jam': '08.00 - 13.00',
      'keterangan': 'Informasi dan pendaftaran vaksinasi.',
    },
    {
      'nama': 'Layanan Ambulans',
      'dinas': 'Dinas Kesehatan',
      'jam': '24 Jam',
      'keterangan': 'Permintaan layanan ambulans.',
    },
  ];

  final List<Map<String, String>> transportasi = [
    {
      'nama': 'Kartu Transportasi',
      'dinas': 'Dinas Perhubungan',
      'jam': '08.00 - 15.00',
      'keterangan': 'Pendaftaran kartu transportasi warga.',
    },
    {
      'nama': 'Informasi Rute',
      'dinas': 'Dinas Perhubungan',
      'jam': '24 Jam',
      'keterangan': 'Informasi rute transportasi kota.',
    },
    {
      'nama': 'Pengaduan Transportasi',
      'dinas': 'Dinas Perhubungan',
      'jam': '24 Jam',
      'keterangan': 'Pelaporan masalah transportasi.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final favoritModel = context.watch<FavoritModel>();

    return DefaultTabController(
      length: 3,
      child: Column(
        children: [
          const TabBar(
            tabs: [
              Tab(text: 'Perizinan'),
              Tab(text: 'Kesehatan'),
              Tab(text: 'Transportasi'),
            ],
          ),
          Expanded(
            child: TabBarView(
              children: [
                _daftarLayanan(perizinan, favoritModel),
                _daftarLayanan(kesehatan, favoritModel),
                _daftarLayanan(transportasi, favoritModel),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _daftarLayanan(
    List<Map<String, String>> layanan,
    FavoritModel favoritModel,
  ) {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: layanan.length,
      separatorBuilder: (context, index) =>
          const SizedBox(height: 8),
      itemBuilder: (context, index) {
        final item = layanan[index];
        final namaLayanan = item['nama']!;
        final isFavorit =
            favoritModel.isFavorit(namaLayanan);

        return Card(
          child: ListTile(
            leading: const Icon(
              Icons.miscellaneous_services,
              color: Colors.indigo,
            ),
            title: Text(namaLayanan),
            subtitle: Text(item['dinas']!),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  tooltip: isFavorit
                      ? 'Hapus dari favorit'
                      : 'Tambahkan ke favorit',
                  icon: Icon(
                    isFavorit
                        ? Icons.star
                        : Icons.star_border,
                    color: isFavorit
                        ? Colors.amber
                        : Colors.grey,
                  ),
                  onPressed: () {
                    final model =
                        context.read<FavoritModel>();

                    if (isFavorit) {
                      model.batalTandai(namaLayanan);
                    } else {
                      model.tandai(namaLayanan);
                    }
                  },
                ),
                const Icon(Icons.chevron_right),
              ],
            ),
            onTap: () async {
              final hasil = await Navigator.pushNamed(
                context,
                '/detail-layanan',
                arguments: item,
              );

              if (!mounted) return;

              if (hasil is String) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(hasil)),
                );
              }
            },
          ),
        );
      },
    );
  }
}
