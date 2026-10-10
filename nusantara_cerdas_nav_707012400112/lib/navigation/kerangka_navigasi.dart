import 'package:flutter/material.dart';

import '../pages/halaman_beranda.dart';
import '../pages/halaman_layanan.dart';
import '../pages/halaman_warga.dart';
import 'app_routes.dart';

class KerangkaNavigasi extends StatefulWidget {
  const KerangkaNavigasi({super.key});

  @override
  State<KerangkaNavigasi> createState() =>
      _KerangkaNavigasiState();
}

class _KerangkaNavigasiState
    extends State<KerangkaNavigasi> {
  int _indeksTerpilih = 0;

  final List<Widget> _halaman = const [
    HalamanBeranda(),
    HalamanLayanan(),
    HalamanWarga(),
  ];

  final List<String> _judul = const [
    'Beranda',
    'Layanan',
    'Warga',
  ];

  void _pilihTujuan(int indeks) {
    setState(() {
      _indeksTerpilih = indeks;
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool layarLebar =
            constraints.maxWidth >= 600;

        return Scaffold(
          appBar: AppBar(
            title: Text(_judul[_indeksTerpilih]),
          ),

          drawer: _buatDrawer(),

          body: layarLebar
              ? Row(
                  children: [
                    NavigationRail(
                      selectedIndex: _indeksTerpilih,
                      onDestinationSelected:
                          _pilihTujuan,
                      extended: true,
                      destinations: const [
                        NavigationRailDestination(
                          icon: Icon(Icons.home_outlined),
                          selectedIcon:
                              Icon(Icons.home),
                          label: Text('Beranda'),
                        ),
                        NavigationRailDestination(
                          icon: Icon(
                            Icons.miscellaneous_services_outlined,
                          ),
                          selectedIcon: Icon(
                            Icons.miscellaneous_services,
                          ),
                          label: Text('Layanan'),
                        ),
                        NavigationRailDestination(
                          icon:
                              Icon(Icons.person_outline),
                          selectedIcon:
                              Icon(Icons.person),
                          label: Text('Warga'),
                        ),
                      ],
                    ),
                    const VerticalDivider(
                      width: 1,
                    ),
                    Expanded(
                      child:
                          _halaman[_indeksTerpilih],
                    ),
                  ],
                )
              : _halaman[_indeksTerpilih],

          bottomNavigationBar: layarLebar
              ? null
              : NavigationBar(
                  selectedIndex: _indeksTerpilih,
                  onDestinationSelected:
                      _pilihTujuan,
                  destinations: const [
                    NavigationDestination(
                      icon:
                          Icon(Icons.home_outlined),
                      selectedIcon:
                          Icon(Icons.home),
                      label: 'Beranda',
                    ),
                    NavigationDestination(
                      icon: Icon(
                        Icons
                            .miscellaneous_services_outlined,
                      ),
                      selectedIcon: Icon(
                        Icons.miscellaneous_services,
                      ),
                      label: 'Layanan',
                    ),
                    NavigationDestination(
                      icon:
                          Icon(Icons.person_outline),
                      selectedIcon:
                          Icon(Icons.person),
                      label: 'Warga',
                    ),
                  ],
                ),
        );
      },
    );
  }

  Widget _buatDrawer() {
    return NavigationDrawer(
      selectedIndex: _indeksTerpilih,
      onDestinationSelected: (indeks) {
        _pilihTujuan(indeks);
        Navigator.pop(context);
      },
      children: [
        const UserAccountsDrawerHeader(
          accountName: Text('Warga Nusantara'),
          accountEmail:
              Text('warga@nusantara.go.id'),
          currentAccountPicture: CircleAvatar(
            child: Icon(Icons.person),
          ),
        ),

        const Padding(
          padding:
              EdgeInsets.fromLTRB(28, 16, 16, 10),
          child: Text('Layanan Utama'),
        ),

        const NavigationDrawerDestination(
          icon: Icon(Icons.home_outlined),
          selectedIcon: Icon(Icons.home),
          label: Text('Beranda'),
        ),

        const NavigationDrawerDestination(
          icon: Icon(
            Icons.miscellaneous_services_outlined,
          ),
          selectedIcon: Icon(
            Icons.miscellaneous_services,
          ),
          label: Text('Layanan'),
        ),

        const NavigationDrawerDestination(
          icon: Icon(Icons.person_outline),
          selectedIcon: Icon(Icons.person),
          label: Text('Warga'),
        ),

        const Divider(
          indent: 28,
          endIndent: 28,
        ),

        ListTile(
          leading:
              const Icon(Icons.settings_outlined),
          title: const Text('Pengaturan Kota'),
          onTap: () {
            Navigator.pop(context);
            Navigator.pushNamed(
              context,
              AppRoutes.pengaturan,
            );
          },
        ),

        ListTile(
          leading: const Icon(Icons.info_outline),
          title: const Text('Tentang Aplikasi'),
          onTap: () {
            Navigator.pop(context);
            Navigator.pushNamed(
              context,
              AppRoutes.tentang,
            );
          },
        ),

        ListTile(
          leading: const Icon(Icons.logout),
          title: const Text('Keluar'),
          onTap: () {
            Navigator.pop(context);
            Navigator.pushNamed(
              context,
              AppRoutes.keluar,
            );
          },
        ),
      ],
    );
  }
}