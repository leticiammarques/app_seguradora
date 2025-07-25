import 'package:insurance_seguradora/app/app_routes.dart';
import 'package:insurance_seguradora/core/services/auth_service.dart';
import 'package:insurance_seguradora/core/widgets/custom_drawer.dart';
import 'package:insurance_seguradora/core/widgets/quote_card.dart';
import 'package:insurance_seguradora/domain/viewmodels/session_viewmodel.dart';
import 'package:insurance_seguradora/presenter/components/webview_page.dart';
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
          final firstName = user?.name?.trim().split(' ').first ?? "Usuário";
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.blue,
              actions: [
                IconButton(
                  onPressed: () async {
                    await viewModel.logout(context);
                    if (!viewModel.isLoading) {
                      Provider.of<SessionViewModel>(
                        context,
                        listen: false,
                      ).clearUser();
                      Navigator.pushReplacementNamed(context, AppRoutes.login);
                    }
                  },
                  icon: const Icon(Icons.logout),
                ),
              ],
            ),
            drawer: CustomDrawer(
              userName: 'Olá, $firstName!',
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user != null ? 'Olá, $firstName!' : "Olá, Usuário!",
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
                    // GridView.count(
                    //   crossAxisCount: 2,
                    //   shrinkWrap: true,
                    //   physics: const NeverScrollableScrollPhysics(),
                    //   mainAxisSpacing: 12,
                    //   crossAxisSpacing: 12,
                    //   childAspectRatio: 1,
                    //   children: [
                    //     QuoteCard(
                    //       title: 'Automóvel',
                    //       icon: Icons.directions_car,
                    //       onTap: () {
                    //         Navigator.of(context).push(
                    //           MaterialPageRoute(
                    //             builder: (_) => WebViewPage(
                    //               url: 'https://www.tokiomarine.com.br/',
                    //               title: 'Cotação de Automóvel',
                    //             ),
                    //           ),
                    //         );
                    //       },
                    //     ),
                    //     QuoteCard(
                    //       title: 'Residência',
                    //       icon: Icons.home,
                    //       onTap: () {},
                    //     ),
                    //     QuoteCard(
                    //       title: 'Vida',
                    //       icon: Icons.favorite,
                    //       onTap: () {},
                    //     ),
                    //     QuoteCard(
                    //       title: 'Acidentes Pessoais',
                    //       icon: Icons.health_and_safety,
                    //       onTap: () {},
                    //     ),
                    //   ],
                    // ),
                    LayoutBuilder(
                      builder: (context, constraints) {
                        // Define o tamanho máximo que cada item pode ocupar
                        double maxCrossAxisExtent = constraints.maxWidth < 600 ? 200 : 250;

                        return GridView.builder(
                          itemCount: 4,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: maxCrossAxisExtent,
                            mainAxisSpacing: 12,
                            crossAxisSpacing: 12,
                            childAspectRatio: 1,
                          ),
                          itemBuilder: (context, index) {
                            final items = [
                              {
                                'title': 'Automóvel',
                                'icon': Icons.directions_car,
                                'onTap': () => Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (_) => WebViewPage(
                                      url: 'https://www.tokiomarine.com.br/',
                                      title: 'Cotação de Automóvel',
                                    ),
                                  ),
                                ),
                              },
                              {
                                'title': 'Residência',
                                'icon': Icons.home,
                                'onTap': () {},
                              },
                              {
                                'title': 'Vida',
                                'icon': Icons.favorite,
                                'onTap': () {},
                              },
                              {
                                'title': 'Acidentes Pessoais',
                                'icon': Icons.health_and_safety,
                                'onTap': () {},
                              },
                            ];

                            final item = items[index];

                            return QuoteCard(
                              title: item['title'] as String,
                              icon: item['icon'] as IconData,
                              onTap: item['onTap'] as VoidCallback,
                            );
                          },
                        );
                      },
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
                          onPressed: () {},
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
