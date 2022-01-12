import 'package:chat_app/global/enviroment.dart';
import 'package:chat_app/models/mensajes_response.dart';
import 'package:chat_app/models/usuario.dart';
import 'package:chat_app/services/auth_service.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class ChatService with ChangeNotifier{

  Usuario? usuarioPara;

  Future<List<Mensaje>> getChat(String usuarioID) async {

    var url = Uri.parse('${Enviroment.apiUrl}/mensajes/$usuarioID');
    final resp = await http.get(url, headers: {
      'Content-Type' : 'application/json',
      'x-token' : await AuthService.getToken() ?? ''
    });

    final mensajeResponse = mensajesResponseFromJson(resp.body);

    return mensajeResponse.mensajes;

  }

}
