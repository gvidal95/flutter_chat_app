import 'package:chat_app/pages/login_page.dart';
import 'package:chat_app/pages/usuarios_page.dart';
import 'package:chat_app/services/auth_service.dart';
import 'package:chat_app/services/socket_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: checkLoginState(context),
        builder: (context, snapshot){
          return  const Center(
            child: Text('Espere...'),
          );
        },
   
      ),
    );
  }

  Future checkLoginState(BuildContext context) async{
    final authService = Provider.of<AuthService>(context, listen: false);
    final socketService = Provider.of<SocketService>(context, listen: false);
    final autenticado = await authService.isLoggedIn();

    if(autenticado){
      socketService.connect();
      // Navigator.pushReplacementNamed(context, 'usuarios');
      
      //Eliminar la animacion de la pantalla usuarios al cambiar de pagina
      Navigator.pushReplacement(context, PageRouteBuilder(
        pageBuilder: (_,__,___) => const UsuariosPage()
      ));
    }else{
      // Navigator.pushReplacementNamed(context, 'login');
       Navigator.pushReplacement(context, PageRouteBuilder(
        pageBuilder: (_,__,___) => const LoginPage()
      ));
    }
  }
}