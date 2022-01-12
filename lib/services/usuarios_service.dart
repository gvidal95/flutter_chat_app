
import 'package:chat_app/models/usuarios_response.dart';
import 'package:http/http.dart' as http;
import 'package:chat_app/global/enviroment.dart';
import 'package:chat_app/services/auth_service.dart';
import 'package:chat_app/models/usuario.dart';

class UsuariosService{

  Future<List<Usuario>> getUsuarios() async {
    try {
      var url = Uri.parse('${Enviroment.apiUrl}/usuarios');
      final token =  await AuthService.getToken() ?? '';

      final resp = await http.get(url, headers: {
        'Content-type' : 'application/json',
        'x-token' : token,
      });

      final usuariosResponse = usuariosResponseFromJson(resp.body);

      return usuariosResponse.usuarios;

    } catch (e) {
      print(e);
      return [];
    }
  }

}