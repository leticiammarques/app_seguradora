import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  final String userName;
  final String? avatarUrl;

  const CustomDrawer({super.key, required this.userName, this.avatarUrl});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(userName),
            accountEmail: null,
            currentAccountPicture: CircleAvatar(
              backgroundImage: avatarUrl != null ? NetworkImage(avatarUrl!) : null,
            ),
            decoration: BoxDecoration(color: Colors.blue),
          ),
          Expanded(
            child: ListView(
              children: [
                _DrawerItem(
                  title: 'Home / Seguros',
                  icon: Icons.home,
                  actionItem: () {},
                ),
                _DrawerItem(
                  title: 'Minhas Contratações',
                  icon: Icons.assignment_turned_in,
                  actionItem: () {},
                ),
                _DrawerItem(
                  title: 'Meus Sinistros',
                  icon: Icons.report,
                  actionItem: () {},
                ),
                _DrawerItem(
                  title: 'Minha Família',
                  icon: Icons.family_restroom,
                  actionItem: () {},
                ),
                _DrawerItem(
                  title: 'Meus Bens',
                  icon: Icons.house,
                  actionItem: () {},
                ),
                _DrawerItem(
                  title: 'Pagamentos',
                  icon: Icons.payment,
                  actionItem: () {},
                ),
                _DrawerItem(
                  title: 'Coberturas',
                  icon: Icons.verified_user,
                  actionItem: () {},
                ),
                _DrawerItem(
                  title: 'Validar Boleto',
                  icon: Icons.qr_code,
                  actionItem: () {},
                ),
                _DrawerItem(
                  title: 'Telefones Importantes',
                  icon: Icons.phone,
                  actionItem: () {},
                ),
                _DrawerItem(
                  title: 'Configurações',
                  icon: Icons.settings,
                  actionItem: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DrawerItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final Function() actionItem;

  _DrawerItem({
    required this.title,
    required this.icon,
    required this.actionItem,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: () {
        actionItem();
        Navigator.pop(context);
      },
    );
  }
}
