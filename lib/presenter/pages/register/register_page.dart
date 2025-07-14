import 'package:insurance_seguradora/app/app_routes.dart';
import 'package:insurance_seguradora/core/services/auth_service.dart';
import 'package:insurance_seguradora/presenter/pages/register/register_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatelessWidget {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneController = TextEditingController();

  RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => RegisterViewModel(context.read<AuthService>()),
      child: Consumer<RegisterViewModel> (
          builder: (context, viewModel, child) {
            return Scaffold(
              appBar: AppBar(
                title: const Text('Cadastro'),
                automaticallyImplyLeading: false,
              ),
              body: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    TextField(
                      controller: nameController,
                      decoration: const InputDecoration(labelText: 'Nome'),
                    ),
                    TextField(
                      controller: emailController,
                      decoration: const InputDecoration(labelText: 'Email'),
                    ),
                    TextField(
                      controller: phoneController,
                      decoration: const InputDecoration(labelText: 'Telefone'),
                    ),
                    TextField(
                      controller: passwordController,
                      decoration: const InputDecoration(labelText: 'Senha'),
                      obscureText: true,
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        viewModel.register(
                          name: nameController.text.trim(),
                          email: emailController.text.trim(),
                          password: passwordController.text.trim(),
                          phone: phoneController.text.trim(),
                          context: context,
                        );
                      },
                      child: const Text('Cadastrar'),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Text("Já tem uma conta?"),
                        TextButton(onPressed: (){
                          Navigator.pushReplacementNamed(
                            context,
                            AppRoutes.login,
                          );
                        }, child: Text('Faça Login'),),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }
      ),
    );
  }
}