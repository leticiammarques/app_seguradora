import 'package:insurance_seguradora/app/app_routes.dart';
import 'package:insurance_seguradora/core/constants/assets_constants.dart';
import 'package:insurance_seguradora/core/services/auth_service.dart';
import 'package:insurance_seguradora/core/utils/utils.dart';
import 'package:insurance_seguradora/domain/viewmodels/session_viewmodel.dart';
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
              backgroundColor: Colors.blue,
              automaticallyImplyLeading: false,
            ),
            body: Padding(
              padding: EdgeInsets.all(16),
              child: SingleChildScrollView(
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
                    SizedBox(height: 16),
                    TextField(
                      controller: passwordController,
                      decoration: InputDecoration(
                        labelText: 'Senha',
                        suffixIcon: IconButton(
                          icon: Icon(
                            viewModel.obscurePassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                          onPressed: viewModel.toggleObscurePassword,
                        ),
                      ),
                      obscureText: viewModel.obscurePassword,
                    ),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(
                              context,
                              AppRoutes.register,
                            );
                          },
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                            minimumSize: Size(0, 0),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          child: Text(
                            'Esqueci a senha',
                            style: TextStyle(
                              color: Colors.blue,
                              decoration: TextDecoration.underline,
                            ),
                          ),
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
                              if (viewModel.user != null) {
                                Provider.of<SessionViewModel>(
                                  context,
                                  listen: false,
                                ).setUser(viewModel.user!);
                                Navigator.pushReplacementNamed(
                                  context,
                                  AppRoutes.home,
                                );
                              }
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
                          onPressed: () async {
                            Navigator.pushReplacementNamed(
                              context,
                              AppRoutes.register,
                            );
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
                        GestureDetector(
                          onTap: () {
                            UrlHelper.launchLink(
                              "https://web.facebook.com/TokioMarineSeguradora?_rdc=1&_rdr#",
                            );
                          },
                          child: SvgPicture.asset(
                            AssetsConstants.pathFacebook,
                            width: 40,
                            height: 40,
                          ),
                        ),
                        const SizedBox(height: 16),
                        GestureDetector(
                          onTap: () {
                            UrlHelper.launchLink(
                              "https://www.instagram.com/tokiomarineseguradora/",
                            );
                          },
                          child: SvgPicture.asset(
                            AssetsConstants.pathInstagram,
                            width: 40,
                            height: 40,
                          ),
                        ),
                        const SizedBox(height: 16),
                        GestureDetector(
                          onTap: () {
                            UrlHelper.launchLink(
                              "https://www.linkedin.com/company/tokio-marine-seguradora-s-a/?originalSubdomain=br",
                            );
                          },
                          child: SvgPicture.asset(
                            AssetsConstants.pathLinkedin,
                            width: 40,
                            height: 40,
                          ),
                        ),
                      ],
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
