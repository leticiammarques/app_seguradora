import 'package:insurance_seguradora/core/services/auth_service.dart';
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
              automaticallyImplyLeading: false,
              actions: [
                IconButton(
                  onPressed: () {
                    viewModel.logout(context);
                  },
                  icon: const Icon(Icons.logout),
                ),
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child:
                  user == null
                      ? const Center(child: CircularProgressIndicator())
                      : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Olá, ${user.name}',
                            style: const TextStyle(fontSize: 22),
                          ),
                          const SizedBox(height: 10),
                          Text('Email: ${user.email}'),
                          Text('Telefone: ${user.phone}'),
                        ],
                      ),
            ),
          );
        },
      ),
    );
  }
}
