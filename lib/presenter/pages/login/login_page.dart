import 'package:insurance_seguradora/core/constants/assets_constants.dart';
import 'package:insurance_seguradora/core/services/auth_service.dart';
import 'package:insurance_seguradora/presenter/pages/login/login_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LoginViewModel(context.read<AuthService>()),
      child: Consumer<LoginViewModel>(
        builder: (context, viewModel, child) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Login'),
              automaticallyImplyLeading: false,
            ),
            body: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  SvgPicture.asset(
                    AssetsConstants.pathLogo,
                    width: 120,
                    height: 120,
                  ),
                  TextField(
                    controller: emailController,
                    decoration: InputDecoration(labelText: 'Email'),
                  ),
                  TextField(
                    controller: passwordController,
                    decoration: InputDecoration(labelText: 'Senha'),
                    obscureText: true,
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          viewModel.goToRegisterPage(context: context);
                        },
                        child: Text('Esqueci a senha'),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  if (viewModel.errorMessage != null)
                    Text(
                      viewModel.errorMessage!,
                      style: TextStyle(color: Colors.red),
                    ),
                  if (viewModel.isLoading)
                    CircularProgressIndicator()
                  else
                    Column(
                      children: [
                        ElevatedButton(
                          onPressed: () async {
                            await viewModel.login(
                              email: emailController.text,
                              password: passwordController.text,
                              context: context,
                            );
                          },
                          child: Text('Entrar'),
                        ),
                      ],
                    ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Text("Ainda não possui cadastro?"),
                      TextButton(
                        onPressed: () {
                          viewModel.goToRegisterPage(context: context);
                        },
                        child: Text('Cadastre-se'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Text('Siga-nos nas nossas redes sociais'),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        AssetsConstants.pathFacebook,
                        width: 40,
                        height: 40,
                      ),
                      const SizedBox(height: 16),
                      SvgPicture.asset(
                        AssetsConstants.pathInstagram,
                        width: 40,
                        height: 40,
                      ),
                      const SizedBox(height: 16),
                      SvgPicture.asset(
                        AssetsConstants.pathLinkedin,
                        width: 40,
                        height: 40,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
