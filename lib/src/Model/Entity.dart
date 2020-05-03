abstract class Entity {
  fromJson(Map<String, dynamic> json);
  Map<String, dynamic> toJson();
}

class BotonPanico extends Entity {
  int idcovBotonpanico;
  int idaCatalogo;
  String botDetalle;
  int idaPrioridad;
  String botCordenadalat;
  String botCordenadalon;
  DateTime botFecha;
  int idaEstadoSolicitud;
  String botTelefono;
  String usuario;


  BotonPanico({
    this.idcovBotonpanico = 0,
    this.idaCatalogo,
    this.botDetalle,
    this.idaPrioridad,
    this.botCordenadalat,
    this.botCordenadalon,
    this.botFecha,
    this.idaEstadoSolicitud,
    this.botTelefono,
    this.usuario
  });

  fromJson(Map<String, dynamic> json) => new BotonPanico(
      idcovBotonpanico: json["IDCOV_BOTONPANICO"],
       idaCatalogo: json["IDA_CATALOGO"],
      botDetalle: json["BOT_DETALLE"],
      idaPrioridad: json["IDA_PRIORIDAD"],
       botCordenadalat: json["BOT_CORDENADALAT"],
      botCordenadalon: json["BOT_CORDENADALON"],
      botFecha: json["BOT_FECHA"],
      idaEstadoSolicitud: json["IDA_ESTADOSOLICITUD"],
      botTelefono: json["BOT_TELEFONO"],
      usuario: json["USUARIO"]
        
  );

  Map<String, dynamic> toJson() => {
        "IDCOV_BOTONPANICO": idcovBotonpanico,
        "IDA_CATALOGO": idaCatalogo,
        "BOT_DETALLE": botDetalle,
        "IDA_PRIORIDAD": idaPrioridad,
        "BOT_CORDENADALAT": botCordenadalat,
        "BOT_CORDENADALON": botCordenadalon,
        "BOT_FECHA": botFecha,
        "IDA_ESTADOSOLICITUD": idaEstadoSolicitud,
        "BOT_TELEFONO": botTelefono,
        "USUARIO": usuario
      };
}

class Catalogo extends Entity {
  int idcovCatalogo;
  int idaTipocatalogo;
  String catFuente;
  String catFecha;
  int idaDifusion;
  int idaUbicacion;
  String usuario;

  Catalogo(
      {this.idcovCatalogo = 0,
      this.idaTipocatalogo,
      this.catFuente,
      this.catFecha,
      this.idaDifusion,
      this.idaUbicacion,
      this.usuario});

  fromJson(Map<String, dynamic> json) => new Catalogo(
      idcovCatalogo: json["IDCOV_CATALOGO"],
      idaTipocatalogo: json["IDA_TIPOCATALOGO"],
      catFuente: json["CAT_FUENTE"],
      catFecha: json["CAT_FECHA"],
      idaDifusion: json["IDA_DIFUSION"],
      idaUbicacion: json["IDA_UBICACION"],
      usuario: json["USUARIO"],
      );

  Map<String, dynamic> toJson() => {
        "IDCOV_CATALOGO": idcovCatalogo,
        "IDA_TIPOCATALOGO": idaTipocatalogo,
        "CAT_FUENTE": catFuente,
        "CAT_FECHA": catFecha,
        "IDA_DIFUSION": idaDifusion,
        "IDA_UBICACION": idaUbicacion,
         "USUARIO": usuario,
      };
}

class DetalleCatalogo extends Entity {
  int idcovDetallecatalogo;
  int idcovCatalogo;
  DateTime detFecha;
  DateTime detFechaInicio;
  DateTime detFechaFin;
  String detTitulo;
  String detSubtitulo;
  String detContenido;
  String detImagen;
  String detDocumento;
  int detEstado;
  String usuario;


  DetalleCatalogo(
      {this.idcovDetallecatalogo,
      this.idcovCatalogo = 0,
      this.detFecha,
      this.detFechaInicio,
      this.detFechaFin,
      this.detTitulo,
      this.detSubtitulo,
      this.detContenido,
      this.detImagen,
      this.detDocumento,
      this.detEstado,
      this.usuario});

  fromJson(Map<String, dynamic> json) => new DetalleCatalogo(
      idcovDetallecatalogo: json["IDCOV_DETALLECATALOGO"],
      idcovCatalogo: json["IDCOV_CATALOGO"],
      detFecha: json["DET_FECHA"],
      detFechaInicio: json["DET_FECHAINICIO"],
      detFechaFin: json["DET_FECHAFIN"],
      detTitulo: json["DET_TITULO"],
      detSubtitulo: json["DET_SUBTITULO"],
      detContenido: json["DET_CONTENIDO"],
      detImagen: json["DET_IMAGEN"],
      detDocumento: json["DET_DOCUMENTO"],
      detEstado: json["DET_ESTADO"],
      usuario: json["USUARIO"],
  );

  Map<String, dynamic> toJson() => {
        "IDCOV_DETALLECATALOGO": idcovDetallecatalogo,
        "IDCOV_CATALOGO": idcovCatalogo,
        "DET_FECHA": detFecha,
        "DET_FECHAINICIO": detFechaInicio,
        "DET_FECHAFIN": detFechaFin,
        "DET_TITULO": detTitulo,
        "DET_SUBTITULO": detSubtitulo,
        "DET_CONTENIDO": detContenido,
        "DET_IMAGEN": detImagen,
        "DET_DOCUMENTO": detDocumento,
        "DET_ESTADO": detEstado,
        "USUARIO": usuario
      };
}

class Multimedia extends Entity {
  int idcovMultimedia;
  int idaCategoria;
  int idaCovInstitucion;
  String mulTitulo;
  String mulResumen;
  DateTime detFechaInicio;
  DateTime detFechaFin;
  String mulEnlace;
  String usuario;

  Multimedia(
      {this.idcovMultimedia,
      this.idaCategoria = 0,
      this.idaCovInstitucion,
      this.mulTitulo,
      this.mulResumen,
      this.detFechaInicio,
      this.detFechaFin,
      this.mulEnlace,
      this.usuario});

  fromJson(Map<String, dynamic> json) => new Multimedia(
      idcovMultimedia: json["IDCOV_MULTIMEDIA"],
      idaCategoria: json["IDA_CATEGORIA"],
      idaCovInstitucion: json["IDCOV_INSTITUCION"],
      mulTitulo: json["MUL_TITULO"],
      mulResumen: json["MUL_RESUMEN"],
      detFechaInicio: json["MUL_FECHAINICIO"],
      detFechaFin: json["MUL_FECHAFIN"],
      mulEnlace: json["MUL_ENLACE"],
      usuario: json["USUARIO"],
  );

  Map<String, dynamic> toJson() => {
        "IDCOV_MULTIMEDIA": idcovMultimedia,
        "IDA_CATEGORIA": idaCategoria,
        "IDCOV_INSTITUCION": idaCovInstitucion,
        "MUL_TITULO": mulTitulo,
        "MUL_RESUMEN": mulResumen,
        "MUL_FECHAINICIO": detFechaInicio,
        "MUL_FECHAFIN": detFechaFin,
        "MUL_ENLACE": mulEnlace,
        "USUARIO": usuario
      };
}

class Hospital extends Entity {
  int id;
  String nombre;
  String ubicacion;

  Hospital({this.id = 0, this.nombre, this.ubicacion});

  fromJson(Map<String, dynamic> json) => new Hospital(
      id: json["ID"],
      nombre: json["HOS_NOMBRE"],
      ubicacion: json["HOS_UBICACION"]);

  Map<String, dynamic> toJson() =>
      {"ID": id, "HOS_NOMBRE": nombre, "HOS_UBICACION": ubicacion};
}




class Institucion extends Entity {
  int idInstitucion;
  String token;
  String nombreInstitucion;
  String tipoInstitucion;
  String ubicacion;
  String direccion;
  double insLat;
  double insLng;
  int idaEstadoCovid;
  DateTime fechaConCovid;
  String telefono;
  String perFacebbok;
String perTwitter;
String perPaginaWeb;
String perYouTube;
String perCorreoElectronico;
String perInformacionComp;
String foto;
int perLunes;
int perMartes;
int perMiercoles;
int perJueves;
int perViernes;
int perSabado;
int perDomingo;
String perLunesH;
String perMartesH;
String perMiercolesH;
String perJuevesH;
String perViernesH;
String perSabadoH;
String perDomingoH;
String usuario;


  Institucion({
      this.idInstitucion,
  this.token,
  this.nombreInstitucion,
  this.tipoInstitucion,
  this.ubicacion,
  this.direccion,
  this.insLat,
  this.insLng,
  this.idaEstadoCovid,
  this.fechaConCovid,
  this.telefono,
  this.perFacebbok,
this.perTwitter,
this.perPaginaWeb,
this.perYouTube,
this.perCorreoElectronico,
this.perInformacionComp,
this.foto,
this.perLunes,
this.perMartes,
this.perMiercoles,
this.perJueves,
this.perViernes,
this.perSabado,
this.perDomingo,
this.perLunesH,
this.perMartesH,
this.perMiercolesH,
this.perJuevesH,
this.perViernesH,
this.perSabadoH,
this.perDomingoH,
this.usuario,});

  fromJson(Map<String, dynamic> json) => new Institucion(
      idInstitucion: json["IDCOV_INSTITUCION"],
      token: json["INS_TOKEN"],
      tipoInstitucion: json["IDA_TIPOINSTITUCION"],
      nombreInstitucion: json["INS_NOMBREINSTITUCION"],
      ubicacion: json["IDA_UBICACION"],
      direccion: json["INS_DIRECCION"],
      insLat: json["INS_LAT"],
      insLng: json["INS_LNG"],
      idaEstadoCovid: json["IDA_ESTADOCOVD"],
      fechaConCovid: json["INS_FECHACOVID"],
      telefono: json["INS_TELEFONO"],
      perFacebbok: json["INS_CUENTACEBOOK"],
      perTwitter: json["INS_CUENTATWITTER"],
      perPaginaWeb: json["INS_PAGINAWEB"],
       perYouTube: json["INS_CUENTAYOUTUBE"],
        perCorreoElectronico: json["INS_CORREOINSTITUCIONAL"],
      perInformacionComp: json["INS_INFORMACIONCOMPLEMENTARIA"],
      foto: json["INS_FOTO"],
      perLunes: json["PER_LUNES"],
      perMartes: json["PER_MARTES"],
      perMiercoles: json["PER_MIERCOLES"],
      perJueves: json["PER_JUEVES"],
      perViernes: json["PER_VIERNES"],
      perSabado: json["PER_SABADO"],
      perDomingo: json["PER_DOMINGO"],
       perLunesH: json["PER_LUNES_HORARIO"],
      perMartesH: json["PER_MARTES_HORARIO"],
      perMiercolesH: json["PER_MIERCOLES_HORARIO"],
      perJuevesH: json["PER_JUEVES_HORARIO"],
      perViernesH: json["PER_VIERNES_HORARIO"],
      perSabadoH: json["PER_SABADO_HORARIO"],
      perDomingoH: json["PER_DOMINGO_HORARIO"],
       usuario: json["USUARIO"]
    
      );

  Map<String, dynamic> toJson() => {
        "IDCOV_INSTITUCION": idInstitucion,
        "INS_TOKEN": token,
"IDA_TIPOINSTITUCION": tipoInstitucion,
        "INS_NOMBREINSTITUCION": nombreInstitucion,
        "IDA_UBICACION": ubicacion,
        "INS_DIRECCION": direccion,
        "INS_LAT": insLat,
        "INS_LNG": insLng,
        "IDA_ESTADOCOVD": idaEstadoCovid,
        "INS_FECHACOVID": fechaConCovid,
         "INS_TELEFONO": telefono,
        "INS_CUENTACEBOOK": perFacebbok,
        "INS_CUENTATWITTER": perTwitter,
        "INS_PAGINAWEB": perPaginaWeb,
"INS_CUENTAYOUTUBE": perYouTube,
"INS_CORREOINSTITUCIONAL": perCorreoElectronico,
        "PER_INFORMACIONCOMPLEMENTARIA": perInformacionComp,

        "INS_FOTO": foto,
        "INS_LUNES": perLunes,
        "INS__MARTES": perMartes,
        "INS_MIERCOLES": perMiercoles,
        "INS_JUEVES": perJueves,
        "INS_VIERNES": perViernes,
        "INS_SABADO": perSabado,
        "INS_DOMINGO": perDomingo,
         "INS_LUNES_HORARIO": perLunesH,
        "INS__MARTES_HORARIO": perMartesH,
        "INS_MIERCOLES_HORARIO": perMiercolesH,
        "INS_JUEVES_HORARIO": perJuevesH,
        "INS_VIERNES_HORARIO": perViernesH,
        "INS_SABADO_HORARIO": perSabadoH,
        "INS_DOMINGO_HORARIO": perDomingoH,
        "USUARIO": usuario
      };
}

class Voluntary extends Entity {
  int idcovPersonal;
  int idcovInstitucion;
  int idcovLogin;
  int idaTipopersonal;
  String perNombrepersonal;
  String perApellido;
  String perCorreo;
  String perTelefono;
  int perAyudacovid;

String perCI;
int idaExtension;
int idaSexo;
String perInformacionComplementaria;
String perFacebbok;
String perTwitter;
String perPaginaWeb;
int perLunes;
int perMartes;
int perMiercoles;
int perJueves;
int perViernes;
int perSabado;
int perDomingo;
String usuario;

  Voluntary(
      {this.idcovPersonal = 0,
      this.idcovInstitucion,
      this.idcovLogin,
      this.idaTipopersonal,
      this.perNombrepersonal,
      this.perApellido,
      this.perCorreo,
      this.perTelefono,
      this.perAyudacovid,
      
      this.perCI,
this.idaExtension,
this.idaSexo,
this.perInformacionComplementaria,
this.perFacebbok,
this.perTwitter,
this.perPaginaWeb,
this.perLunes,
this.perMartes,
this.perMiercoles,
this.perJueves,
this.perViernes,
this.perSabado,
this.perDomingo,
this.usuario
      
      });

  fromJson(Map<String, dynamic> json) => new Voluntary(
      idcovPersonal: json["IDCOV_PERSONAL"],
      idcovInstitucion: json["IDCOV_INSTITUCION"],
      idcovLogin: json["IDCOV_LOGIN"],
      idaTipopersonal: json["IDA_TIPOPERSONAL"],
      perNombrepersonal: json["PER_NOMBREPERSONAL"],
      perApellido: json["PER_APELLIDO"],
      perCorreo: json["PER_CORREO"],
      perTelefono: json["PER_TELEFONO"],
      perAyudacovid: json["PER_AYUDACOVID"],
      perCI: json["PER_CI"],
      idaExtension: json["IDA_EXTENCIONCI"],
      idaSexo: json["IDA_SEXO"],
      perInformacionComplementaria: json["PER_INFORMACIONCOMPLEMENTARIA"],
      perFacebbok: json["PER_CUENTAFACEBOOK"],
      perTwitter: json["PER_CUENTATWITTER"],
      perPaginaWeb: json["PER_PAGINAWEB"],
      perLunes: json["PER_LUNES"],
      perMartes: json["PER_MARTES"],
      perMiercoles: json["PER_MIERCOLES"],
      perJueves: json["PER_JUEVES"],
      perViernes: json["PER_VIERNES"],
      perSabado: json["PER_SABADO"],
      perDomingo: json["PER_DOMINGO"],
       usuario: json["USUARIO"]
       
      );

  Map<String, dynamic> toJson() => {
        "IDCOV_PERSONAL": idcovPersonal,
        "IDCOV_INSTITUCION": idcovInstitucion,
        "IDCOV_LOGIN": idcovLogin,
        "IDA_TIPOPERSONAL": idaTipopersonal,
        "PER_NOMBREPERSONAL": perNombrepersonal,
        "PER_APELLIDO" : perApellido,
        "PER_CORREO": perCorreo,
        "PER_TELEFONO": perTelefono,
        "PER_AYUDACOVID": perAyudacovid,
        "PER_CI": perCI,
        "IDA_EXTENCIONCI": idaExtension,
        "IDA_SEXO": idaSexo,
        "PER_INFORMACIONCOMPLEMENTARIA": perInformacionComplementaria,
        "PER_CUENTAFACEBOOK": perFacebbok,
        "PER_CUENTATWITTER": perTwitter,
        "PER_PAGINAWEB": perPaginaWeb,
        "PER_LUNES": perLunes,
        "PER_MARTES": perMartes,
        "PER_LUNES": perAyudacovid,
        "PER_MIERCOLES": perMiercoles,
        "PER_JUEVES": perJueves,
        "PER_VIERNES": perViernes,
        "PER_SABADO": perSabado,
        "PER_DOMINGO": perDomingo,
        "USUARIO": usuario
      };
}
class RegistroAmigo extends Entity {
  int idcovRegistroAmigo;
  String regPersona;
  String regTelefono;
  String regUbicacion;
  String regTipoAPoyo;
  String regPrioridad;
  String usuario;

  RegistroAmigo(
      {this.idcovRegistroAmigo = 0,
      this.regPersona,
      this.regTelefono,
      this.regUbicacion,
      this.regTipoAPoyo,
      this.regPrioridad,
      this.usuario
      });

  fromJson(Map<String, dynamic> json) => new RegistroAmigo(
      idcovRegistroAmigo: json["IDCOV_REGISTRAAMIGO"],
      regPersona: json["REG_PERSONA"],
      regTelefono: json["REG_TELEFONO"],
      regUbicacion: json["REG_UBICACION"],
      regTipoAPoyo: json["IDA_TIPOAPOYO"],
      regPrioridad: json["REG_PRIORIDAD"],
      usuario: json["USUARIO"],
      );

  Map<String, dynamic> toJson() => {
        "IDCOV_REGISTRAAMIGO": idcovRegistroAmigo,
        "REG_PERSONA": regPersona,
        "REG_TELEFONO": regTelefono,
        "REG_UBICACION": regUbicacion,
        "IDA_TIPOAPOYO": regTipoAPoyo,
        "REG_PRIORIDAD": regPrioridad,
        "USUARIO": usuario,

      };
}

class Evento extends Entity {
  int idcovRegistroAmigo;
  String regPersona;
  String regTelefono;
  String regUbicacion;
  String regTipoAPoyo;
  String regPrioridad;
  String usuario;

  Evento(
      {this.idcovRegistroAmigo = 0,
      this.regPersona,
      this.regTelefono,
      this.regUbicacion,
      this.regTipoAPoyo,
      this.regPrioridad,
      this.usuario
      });

  fromJson(Map<String, dynamic> json) => new Evento(
      idcovRegistroAmigo: json["IDCOV_REGISTRAAMIGO"],
      regPersona: json["REG_PERSONA"],
      regTelefono: json["REG_TELEFONO"],
      regUbicacion: json["REG_UBICACION"],
      regTipoAPoyo: json["IDA_TIPOAPOYO"],
      regPrioridad: json["REG_PRIORIDAD"],
      usuario: json["USUARIO"],
      );

  Map<String, dynamic> toJson() => {
        "IDCOV_REGISTRAAMIGO": idcovRegistroAmigo,
        "REG_PERSONA": regPersona,
        "REG_TELEFONO": regTelefono,
        "REG_UBICACION": regUbicacion,
        "IDA_TIPOAPOYO": regTipoAPoyo,
        "REG_PRIORIDAD": regPrioridad,
        "USUARIO": usuario,

      };
}


class Test extends Entity {
  int idcovTest;
  int idcovCiudadano;
  int idaVersion;
  String tesPregunta;

  Test(
      {this.idcovTest = 0,
      this.idcovCiudadano,
      this.idaVersion,
      this.tesPregunta});

  fromJson(Map<String, dynamic> json) => new Test(
      idcovTest: json["IDCOV_TEST"],
      idcovCiudadano: json["IDCOV_CIUDADANO"],
      idaVersion: json["IDA_VERSION"],
      tesPregunta: json["TES_PREGUNTA"]);

  Map<String, dynamic> toJson() => {
        "IDCOV_TEST": idcovTest,
        "IDCOV_CIUDADANO": idcovCiudadano,
        "IDA_VERSION": idaVersion,
        "TES_PREGUNTA": tesPregunta
      };
}

class TestHistorial extends Entity {
  int idcovTesthistorial;
  int idcovTest;
  String hisRespuesta;
  DateTime hisFecha;
  String usuario;

  TestHistorial(
      {this.idcovTesthistorial = 0,
      this.idcovTest,
      this.hisRespuesta,
      this.hisFecha,
      this.usuario});

  fromJson(Map<String, dynamic> json) => new TestHistorial(
      idcovTesthistorial: json["IDCOV_TESTHISTORIAL"],
      idcovTest: json["IDCOV_TEST"],
      hisRespuesta: json["HIS_RESPUESTA"],
      hisFecha: json["HIS_FECHA"],
      usuario: json["USUARIO"]);

  Map<String, dynamic> toJson() => {
        "IDCOV_TESTHISTORIAL": idcovTesthistorial,
        "IDCOV_TEST": idcovTest,
        "HIS_RESPUESTA": hisRespuesta,
        "HIS_FECHA": hisFecha,
         "USUARIO": usuario
      };
}

class Login extends Entity {
  int idcovLogin;
  String logUsuario;
  String logContrasenia;
  int logEstado;
  DateTime logFecharegistro;
  int logTipoingreso;
  String usuario;

  Login(
      {this.idcovLogin = 0,
      this.logUsuario,
      this.logContrasenia,
      this.logEstado,
      this.logFecharegistro,
      this.logTipoingreso,
      this.usuario});

  fromJson(Map<String, dynamic> json) => new Login(
      idcovLogin: json["IDCOV_LOGIN"],
      logUsuario: json["LOG_USUARIO"],
      logContrasenia: json["LOG_CONTRASENIA"],
      logEstado: json["LOG_ESTADO"],
      logFecharegistro: json["LOG_FECHAREGISTRO"],
      logTipoingreso: json["LOG_TIPOINGRESO"],
      usuario: json["USUARIO"],
      );

  Map<String, dynamic> toJson() => {
        "IDCOV_LOGIN": idcovLogin,
        "LOG_USUARIO": logUsuario,
        "LOG_CONTRASENIA": logContrasenia,
        "LOG_ESTADO": logEstado,
        "LOG_FECHAREGISTRO": logFecharegistro,
        "LOG_TIPOINGRESO": logTipoingreso,
        "USUARIO": usuario
      };
}

class ProfesionalesAgrupados extends Entity {
  int idInstitucion;
  String profesion;
  int cantidadProfesionales;
  String imagenFondo;
  String descripcion;

  ProfesionalesAgrupados(
      {this.idInstitucion,
      this.profesion,
      this.cantidadProfesionales,
      this.descripcion,
      this.imagenFondo});

  fromJson(Map<String, dynamic> json) => new ProfesionalesAgrupados(
      idInstitucion: json["idInstitucion"],
      profesion: json["profesion"],
      cantidadProfesionales: json["cantidadProfesionales"],
      descripcion: json["descripcion"],
      imagenFondo: json["imagenFondo"]);

  Map<String, dynamic> toJson() => {
        "idInstitucion": idInstitucion,
        "profesion": profesion,
        "cantidadProfesionales": cantidadProfesionales,
        "descripcion": descripcion,
        "imagenFondo": imagenFondo
      };
}

class ProfesionalesDeInstitucion extends Entity {
  int idPersonal;
  int idInstitucion;
  String nombreInstitucion;
  String tipoProfesion;
  String nombreProfesional;
  String correo;
  String telefono;
  String ayudaConCovid;
  String ci;
  String sexo;

  ProfesionalesDeInstitucion(
      {this.idPersonal,
      this.idInstitucion,
      this.nombreInstitucion,
      this.tipoProfesion,
      this.nombreProfesional,
      this.correo,
      this.telefono,
      this.ayudaConCovid,
      this.ci,
      this.sexo});

  fromJson(Map<String, dynamic> json) => new ProfesionalesDeInstitucion(
      idPersonal: json["idPersonal"],
      nombreInstitucion: json["nombreInstitucion"],
      tipoProfesion: json["tipoProfesion"],
      nombreProfesional: json["nombreProfesional"],
      ayudaConCovid: json["ayudaConCovid"],
      ci: json["ci"],
      idInstitucion: json["idInstitucion"],
      sexo: json["sexo"]);

  Map<String, dynamic> toJson() => {
        "idPersonal": idPersonal,
        "nombreInstitucion": nombreInstitucion,
        "tipoProfesion": tipoProfesion,
        "nombreProfesional": nombreProfesional,
        "ayudaConCovid": ayudaConCovid,
        "ci": ci,
        "idInstitucion": idInstitucion,
        "sexo": sexo
      };
}

class InstitucionesItems extends Entity {
  int idInstitucion;
  String nombreInstitucion;
  String tipoInstitucion;
  String ubicacion;
  String ayudaConCovid;
  DateTime fechaConCovid;
  String url;
  int miembros;

  InstitucionesItems(
      {this.idInstitucion,
      this.nombreInstitucion,
      this.tipoInstitucion,
      this.ubicacion,
      this.ayudaConCovid,
      this.fechaConCovid,
      this.url,
      this.miembros});

  fromJson(Map<String, dynamic> json) => new InstitucionesItems(
      idInstitucion: json["idInstitucion"],
      nombreInstitucion: json["nombreInstitucion"],
      tipoInstitucion: json["tipoInstitucion"],
      ubicacion: json["ubicacion"],
      ayudaConCovid: json["ayudaConCovid"],
      fechaConCovid: json["fechaConCovid"],
      url: json["url"],
      miembros: json["miembros"]);

  Map<String, dynamic> toJson() => {
        "idInstitucion": idInstitucion,
        "nombreInstitucion": nombreInstitucion,
        "tipoInstitucion": tipoInstitucion,
        "ubicacion": ubicacion,
        "ayudaConCovid": ayudaConCovid,
        "fechaConCovid": fechaConCovid,
        "url": url,
        "miembros": miembros
      };
}

class MultimediaImagen extends Entity {
  int idInstitucion;
  String titulo;
  String subtitulo;
  String url;

  MultimediaImagen({this.idInstitucion, this.titulo, this.subtitulo, this.url});

  fromJson(Map<String, dynamic> json) => new MultimediaImagen(
      idInstitucion: json["idInstitucion"],
      titulo: json["titulo"],
      subtitulo: json["subtitulo"],
      url: json["url"]);

  Map<String, dynamic> toJson() => {
        "idInstitucion": idInstitucion,
        "titulo": titulo,
        "subtitulo": subtitulo,
        "url": url
      };
}

class MultimediaVideo extends Entity {
  int idInstitucion;
  String titulo;
  String subtitulo;
  String url;

  MultimediaVideo({this.idInstitucion, this.titulo, this.subtitulo, this.url});

  fromJson(Map<String, dynamic> json) => new MultimediaVideo(
      idInstitucion: json["idInstitucion"],
      titulo: json["titulo"],
      subtitulo: json["subtitulo"],
      url: json["url"]);

  Map<String, dynamic> toJson() => {
        "idInstitucion": idInstitucion,
        "titulo": titulo,
        "subtitulo": subtitulo,
        "url": url
      };
}
