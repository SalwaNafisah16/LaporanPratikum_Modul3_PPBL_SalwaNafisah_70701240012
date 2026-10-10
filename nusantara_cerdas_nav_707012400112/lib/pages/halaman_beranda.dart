import 'package:flutter/material.dart';

class HalamanBeranda extends StatelessWidget {
  const HalamanBeranda({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text(
          'Nusantara Cerdas',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Layanan digital untuk mendukung kebutuhan warga Kota Nusantara.',
        ),
        const SizedBox(height: 24),

        _pilar(
          Icons.location_city,
          'Smart Governance',
          'Tata kelola pemerintahan yang terintegrasi.',
        ),
        _pilar(
          Icons.business,
          'Smart Economy',
          'Mendukung pertumbuhan ekonomi masyarakat.',
        ),
        _pilar(
          Icons.people,
          'Smart Society',
          'Meningkatkan partisipasi dan kualitas masyarakat.',
        ),
        _pilar(
          Icons.eco,
          'Smart Environment',
          'Mendukung lingkungan kota yang berkelanjutan.',
        ),
        _pilar(
          Icons.directions_car,
          'Smart Mobility',
          'Meningkatkan kemudahan mobilitas warga.',
        ),
        _pilar(
          Icons.health_and_safety,
          'Smart Living',
          'Meningkatkan kualitas hidup masyarakat.',
        ),
      ],
    );
  }

  Widget _pilar(
    IconData icon,
    String judul,
    String keterangan,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Icon(
          icon,
          color: Colors.indigo,
        ),
        title: Text(judul),
        subtitle: Text(keterangan),
      ),
    );
  }
} 