import 'package:insurance_seguradora/core/services/auth_service.dart';
import 'package:insurance_seguradora/core/widgets/custom_drawer.dart';
import 'package:insurance_seguradora/core/widgets/quote_card.dart';
import 'package:insurance_seguradora/domain/viewmodels/session_viewmodel.dart';
import 'package:insurance_seguradora/presenter/pages/home/home_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create:
          (_) => HomeViewModel(
            session: context.read<SessionViewModel>(),
            authService: context.read<AuthService>(),
          ),
      child: Consumer<HomeViewModel>(
        builder: (context, viewModel, child) {
          final user = viewModel.session.currentUser;

          return Scaffold(
            appBar: AppBar(
              title: const Text('Home'),
              actions: [
                IconButton(
                  onPressed: () {
                    viewModel.logout(context);
                  },
                  icon: const Icon(Icons.logout),
                ),
              ],
            ),
            drawer: CustomDrawer(
              userName: user != null ? 'Olá, ${user.name}' : "Olá, ",
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Olá, ${user!.name}!',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Cotar e contratar
                    const Text(
                      'Cotar e Contratar',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 12),
                    GridView.count(
                      crossAxisCount: 2,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      mainAxisSpacing: 12,
                      crossAxisSpacing: 12,
                      childAspectRatio: 1,
                      children: [
                        QuoteCard(
                          title: 'Automóvel',
                          icon: Icons.directions_car,
                          onTap: () {},
                        ),
                        QuoteCard(
                          title: 'Residência',
                          icon: Icons.home,
                          onTap: () {},
                        ),
                        QuoteCard(
                          title: 'Vida',
                          icon: Icons.favorite,
                          onTap: () {},
                        ),
                        QuoteCard(
                          title: 'Acidentes Pessoais',
                          icon: Icons.health_and_safety,
                          onTap: () {},
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Minha Família',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        TextButton.icon(
                          onPressed: () {

                          },
                          icon: const Icon(Icons.add),
                          label: const Text('Adicionar'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Nenhum membro adicionado.',
                      style: TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(height: 32),

                    // Contratados
                    const Text(
                      'Contratados',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Center(
                        child: Text(
                          'Você ainda não possui seguros contratados.',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
