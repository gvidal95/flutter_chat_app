import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/models/usuario.dart';

import 'package:chat_app/global/enviroment.dart';
import 'package:chat_app/models/login_response.dart';


class AuthService with ChangeNotifier{
  
  Usuario? usuario;
  bool _autenticando = false;

  // Create storage
  final _storage = new FlutterSecureStorage();

  bool get autenticando => _autenticando;
  set autenticando(bool valor){
    _autenticando = valor;
    notifyListeners();
  }

  //Getter del token de forma statica
  static Future<String?> getToken() async {
    const _storage = FlutterSecureStorage();
    final token = await _storage.read(key: 'token');
    return token;
  }

  static void deleteToken() async {
    const _storage = FlutterSecureStorage();
    await _storage.delete(key: 'token');
  }

   Future<bool> login (String email, String password) async {

    autenticando = true;
    
    final data = {
      "email": email,
      "password": password
    };

    var url = Uri.parse('${Enviroment.apiUrl}/login');

    final resp = await http.post(url,
      body: jsonEncode(data) ,
      headers: {
        'Content-type' : 'application/json',
      } 
    );

    print(resp.body);
    
    autenticando = false;

    if(resp.statusCode == 200){
      final loginReponse = loginResponseFromJson(resp.body);
      usuario = loginReponse.usuario!;

      await _guardarToken(loginReponse.token!);

      return true;
    }else{
      return false;
    }


  }

  Future register (String nombre ,String email, String password) async{
    autenticando = true;
    
    final data = {
      "nombre": nombre,
      "email": email,
      "password": password
    };

    var url = Uri.parse('${Enviroment.apiUrl}/login/new');

    final resp = await http.post(url,
      body: jsonEncode(data) ,
      headers: {
        'Content-type' : 'application/json',
      } 
    );

    print("Registro de usuario");
    print(resp.body);
    
    autenticando = false;

    if(resp.statusCode == 200){
      final loginReponse = loginResponseFromJson(resp.body);
      usuario = loginReponse.usuario!;

      await _guardarToken(loginReponse.token!);

      return true;
    }else{
      final respBody = jsonDecode(resp.body);
      return respBody['msg'];
    }

  }

  Future<bool> isLoggedIn() async {
    
    final token = await _storage.read(key: 'token');
    print("token");
    print(token);
    if(token == null) return false;

    // Verificar Token
    var url = Uri.parse('${Enviroment.apiUrl}/login/renew');

    final resp = await http.get(url,
      headers: {
        'Content-type' : 'application/json',
        'x-token' : token,
      } 
    );

    print("Renew Token");
    print(resp.body);

    if(resp.statusCode == 200){
      final loginReponse = loginResponseFromJson(resp.body);
      usuario = loginReponse.usuario!;

      await _guardarToken(loginReponse.token!);

      return true;
    }else{
      logout();
      return false;
    }


  }

  Future _guardarToken(String token) async {
    return await _storage.write(key: 'token', value: token);
  }

  Future logout() async {
    await _storage.delete(key: 'token');
  }

  
}