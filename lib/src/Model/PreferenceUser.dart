import 'package:shared_preferences/shared_preferences.dart';

class PreferensUser 
{
      static final PreferensUser _instancia = new PreferensUser._internal();

      factory PreferensUser() {
        return _instancia;
      }

      PreferensUser._internal();

      SharedPreferences _prefs;

      initPrefs() async {
        this._prefs = await SharedPreferences.getInstance();
      }
      // GET y SET del Genero
      get genero {
        return _prefs.getInt('genero') ?? 1;
      }

      set genero( int value ) {
        _prefs.setInt('genero', value);
      }

      get celular {
        return _prefs.getInt('celular') ?? 0;
      }

      set celular( int value ) {
        _prefs.setInt('celular', value);
      }

    get imei {
        return _prefs.getInt('imei') ?? 1;
      }

      set imei( int value ) {
        _prefs.setInt('imei', value);
      }

      // GET y SET del _colorSecundario
      get ci {
        return _prefs.getString('ci') ?? 'unknow';
      }

      set ci( String value ) {
        _prefs.setString('ci', value);
      }

      // GET y SET del correo
      get correoElectronico {
        return _prefs.getString('correo') ?? '-1';
      }

      set correoElectronico( String value ) {
        _prefs.setString('correo', value);
      }

 // GET y SET del correo
      get correoGmail {
        return _prefs.getString('correoGmail') ?? '-1';
      }

      set correoGmail( String value ) {
        _prefs.setString('correoGmail', value);
      }

      // GET y SET del nombreUsuario
      get nombreUsuario {
        return _prefs.getString('nombreUsuario') ?? 'unknow';
      }

      set nombreUsuario( String value ) {
        _prefs.setString('nombreUsuario', value);
      }

       get token {
      return _prefs.getString('token') ?? '';
    }

    set token( String value ) {
      _prefs.setString('token', value);
    }
    

    // GET y SET de la última página
    get ultimaPagina {
      return _prefs.getString('ultimaPagina') ?? 'login';
    }

    set ultimaPagina( String value ) {
      _prefs.setString('ultimaPagina', value);
    }

    get avatarImagen {
      return _prefs.getString('avatarImagen') ?? 'https://image.freepik.com/vector-gratis/perfil-avatar-hombre-icono-redondo_24640-14046.jpg';
    }

    set avatarImagen( String value ) {
      _prefs.setString('avatarImagen', value);
    }

}


