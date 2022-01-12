import 'package:chat_app/pages/chat_page.dart';
import 'package:chat_app/pages/loading_page.dart';
import 'package:chat_app/pages/login_page.dart';
import 'package:chat_app/pages/register_page.dart';
import 'package:chat_app/pages/usuarios_page.dart';
import 'package:flutter/cupertino.dart';

final Map<String, WidgetBuilder> appRoutes = {
  'usuarios'  : (_) => const UsuariosPage(),
  'chat'      : (_) => const ChatPage(),
  'login'     : (_) => const LoginPage(),
  'register'  : (_) => const RegisterPage(),
  'loading'   : (_) => const LoadingPage(),
};