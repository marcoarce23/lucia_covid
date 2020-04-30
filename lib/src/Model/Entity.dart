abstract class Entity {
  fromJson(Map<String, dynamic> json);
  Map<String, dynamic> toJson();
}

class Ciudadano extends Entity {
  int idcovCiudadano;
  int idcovLogin;
  String ciuImei;
  String ciuCorreo;
  String ciuNombre;
  String ciuImagen;
  DateTime ciuFechanacimiento;

  Ciudadano(
      {this.idcovCiudadano = 0,
      this.idcovLogin,
      this.ciuImei,
      this.ciuCorreo,
      this.ciuNombre,
      this.ciuImagen,
      this.ciuFechanacimiento});

  fromJson(Map<String, dynamic> json) => new Ciudadano(
      idcovCiudadano: json["IDCOV_CIUDADANO"],
      idcovLogin: json["IDCOV_LOGIN"],
      ciuImei: json["CIU_IMEI"],
      ciuCorreo: json["CIU_CORREO"],
      ciuNombre: json["CIU_NOMBRE"],
      ciuImagen: json["CIU_IMAGEN"],
      ciuFechanacimiento: json["CIU_FECHANACIMIENTO"]);

  Map<String, dynamic> toJson() => {
        "IDCOV_CIUDADANO": idcovCiudadano,
        "IDCOV_LOGIN": idcovLogin,
        "CIU_IMEI": ciuImei,
        "CIU_CORREO": ciuCorreo,
        "CIU_NOMBRE": ciuNombre,
        "CIU_IMAGEN": ciuImagen,
        "CIU_FECHANACIMIENTO": ciuFechanacimiento
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

class BotonPanico extends Entity {
  int idcovBotonpanico;
  int idcovCiudadano;
  int idaCatalogo;
  String botDetalle;
  int idaPrioridad;
  int botUbicacion;
  String botCordenadalat;
  String botCordenadalon;
  DateTime botFecha;

  BotonPanico({
    this.idcovBotonpanico = 0,
    this.idcovCiudadano,
    this.idaCatalogo,
    this.botDetalle,
    this.idaPrioridad,
    this.botUbicacion,
    this.botCordenadalat,
    this.botCordenadalon,
    this.botFecha,
  });

  fromJson(Map<String, dynamic> json) => new BotonPanico(
      idcovBotonpanico: json["IDCOV_BOTONPANICO"],
      idcovCiudadano: json["IDCOV_CIUDADANO"],
      idaCatalogo: json["IDA_CATALOGO"],
      botDetalle: json["BOT_DETALLE"],
      idaPrioridad: json["IDA_PRIORIDAD"],
      botUbicacion: json["BOT_UBICACION"],
      botCordenadalat: json["BOT_CORDENADALAT"],
      botCordenadalon: json["BOT_CORDENADALON"],
      botFecha: json["BOT_FECHA"]);

  Map<String, dynamic> toJson() => {
        "IDCOV_BOTONPANICO": idcovBotonpanico,
        "IDCOV_CIUDADANO": idcovCiudadano,
        "IDA_CATALOGO": idaCatalogo,
        "BOT_DETALLE": botDetalle,
        "IDA_PRIORIDAD": idaPrioridad,
        "BOT_UBICACION": botUbicacion,
        "BOT_CORDENADALAT": botCordenadalat,
        "BOT_CORDENADALON": botCordenadalon,
        "BOT_FECHA": botFecha
      };
}

class Familiar extends Entity {
  int idcovFamiliar;
  int idcovCiudadano;
  int famAdultosmayores;
  int famAdultos;
  int famAdolescentes;
  int famInfantes;
  int famBebes;
  int famMascotas;

  Familiar({
    this.idcovFamiliar = 0,
    this.idcovCiudadano = 0,
    this.famAdultosmayores = 0,
    this.famAdultos = 0,
    this.famAdolescentes = 0,
    this.famInfantes = 0,
    this.famBebes = 0,
    this.famMascotas = 0,
  });

  fromJson(Map<String, dynamic> json) => new Familiar(
      idcovFamiliar: json["IDCOV_FAMILIAR"],
      idcovCiudadano: json["IDCOV_CIUDADANO"],
      famAdultosmayores: json["FAM_ADULTOSMAYORES"],
      famAdultos: json["FAM_ADULTOS"],
      famAdolescentes: json["FAM_ADOLESCENTES"],
      famInfantes: json["FAM_INFANTES"],
      famBebes: json["FAM_BEBES"],
      famMascotas: json["FAM_MASCOTAS"]);

  Map<String, dynamic> toJson() => {
        "IDCOV_FAMILIAR": idcovFamiliar,
        "IDCOV_CIUDADANO": idcovCiudadano,
        "FAM_ADULTOSMAYORES": famAdultosmayores,
        "FAM_ADULTOS": famAdultos,
        "FAM_ADOLESCENTES": famAdolescentes,
        "FAM_INFANTES": famInfantes,
        "FAM_BEBES": famBebes,
        "FAM_MASCOTAS": famMascotas
      };
}

class Referencia extends Entity {
  int idcovReferencia;
  int idcovCiudadano;
  int idaTiporeferencia;
  String refNombrecompleto;
  String refCi;
  String refTelefono;
  String refCorreo;

  Referencia(
      {this.idcovReferencia = 0,
      this.idcovCiudadano,
      this.idaTiporeferencia,
      this.refNombrecompleto,
      this.refCi,
      this.refTelefono,
      this.refCorreo});

  fromJson(Map<String, dynamic> json) => new Referencia(
      idcovReferencia: json["IDCOV_REFERENCIA"],
      idcovCiudadano: json["IDCOV_CIUDADANO"],
      idaTiporeferencia: json["IDA_TIPOREFERENCIA"],
      refNombrecompleto: json["REF_NOMBRECOMPLETO"],
      refCi: json["REF_CI"],
      refTelefono: json["REF_TELEFONO"],
      refCorreo: json["REF_CORREO"]);

  Map<String, dynamic> toJson() => {
        "IDCOV_REFERENCIA": idcovReferencia,
        "IDCOV_CIUDADANO": idcovCiudadano,
        "IDA_TIPOREFERENCIA": idaTiporeferencia,
        "REF_NOMBRECOMPLETO": refNombrecompleto,
        "REF_CI": refCi,
        "REF_TELEFONO": refTelefono,
        "REF_CORREO": refCorreo
      };
}

class Institucion extends Entity {
  int idcovInstitucion;
  int idaTipoinstitucion;
  String insNombreinstitucion;
  int idaUbicacion;
  int idaEstadocovd;
  DateTime insFechacovid;

  Institucion(
      {this.idcovInstitucion = 0,
      this.idaTipoinstitucion,
      this.insNombreinstitucion,
      this.idaUbicacion,
      this.idaEstadocovd,
      this.insFechacovid});

  fromJson(Map<String, dynamic> json) => new Institucion(
      idcovInstitucion: json["IDCOV_INSTITUCION"],
      idaTipoinstitucion: json["IDA_TIPOINSTITUCION"],
      insNombreinstitucion: json["INS_NOMBREINSTITUCION"],
      idaUbicacion: json["IDA_UBICACION"],
      idaEstadocovd: json["IDA_ESTADOCOVD"],
      insFechacovid: json["INS_FECHACOVID"]);

  Map<String, dynamic> toJson() => {
        "IDCOV_INSTITUCION": idcovInstitucion,
        "IDA_TIPOINSTITUCION": idaTipoinstitucion,
        "INS_NOMBREINSTITUCION": insNombreinstitucion,
        "IDA_UBICACION": idaUbicacion,
        "IDA_ESTADOCOVD": idaEstadocovd,
        "INS_FECHACOVID": insFechacovid
      };
}

class Personal extends Entity {
  int idcovPersonal;
  int idcovInstitucion;
  int idcovLogin;
  int idaTipopersonal;
  String perNombrepersonal;
  String perCorreo;
  String perTelefono;
  int perUbicacion;
  int perAyudacovid;

  Personal(
      {this.idcovPersonal = 0,
      this.idcovInstitucion,
      this.idcovLogin,
      this.idaTipopersonal,
      this.perNombrepersonal,
      this.perCorreo,
      this.perTelefono,
      this.perUbicacion,
      this.perAyudacovid});

  fromJson(Map<String, dynamic> json) => new Personal(
      idcovPersonal: json["IDCOV_PERSONAL"],
      idcovInstitucion: json["IDCOV_INSTITUCION"],
      idcovLogin: json["IDCOV_LOGIN"],
      idaTipopersonal: json["IDA_TIPOPERSONAL"],
      perNombrepersonal: json["PER_NOMBREPERSONAL"],
      perCorreo: json["PER_CORREO"],
      perTelefono: json["PER_TELEFONO"],
      perUbicacion: json["PER_UBICACION"],
      perAyudacovid: json["PER_AYUDACOVID"]);

  Map<String, dynamic> toJson() => {
        "IDCOV_PERSONAL": idcovPersonal,
        "IDCOV_INSTITUCION": idcovInstitucion,
        "IDCOV_LOGIN": idcovLogin,
        "IDA_TIPOPERSONAL": idaTipopersonal,
        "PER_NOMBREPERSONAL": perNombrepersonal,
        "PER_CORREO": perCorreo,
        "PER_TELEFONO": perTelefono,
        "PER_UBICACION": perUbicacion,
        "PER_AYUDACOVID": perAyudacovid
      };
}

class Catalogo extends Entity {
  int idcovCatalogo;
  int idaTipocatalogo;
  String catFuente;
  String catFecha;
  int idaDifusion;
  int idaUbicacion;

  Catalogo(
      {this.idcovCatalogo = 0,
      this.idaTipocatalogo,
      this.catFuente,
      this.catFecha,
      this.idaDifusion,
      this.idaUbicacion});

  fromJson(Map<String, dynamic> json) => new Catalogo(
      idcovCatalogo: json["IDCOV_CATALOGO"],
      idaTipocatalogo: json["IDA_TIPOCATALOGO"],
      catFuente: json["CAT_FUENTE"],
      catFecha: json["CAT_FECHA"],
      idaDifusion: json["IDA_DIFUSION"],
      idaUbicacion: json["IDA_UBICACION"]);

  Map<String, dynamic> toJson() => {
        "IDCOV_CATALOGO": idcovCatalogo,
        "IDA_TIPOCATALOGO": idaTipocatalogo,
        "CAT_FUENTE": catFuente,
        "CAT_FECHA": catFecha,
        "IDA_DIFUSION": idaDifusion,
        "IDA_UBICACION": idaUbicacion,
      };
}

class DetalleCatalogo extends Entity {
  int idcovDetallecatalogo;
  int idcovCatalogo;
  DateTime detFecha;
  String detTitulo;
  String detSubtitulo;
  String detContenido;
  String detImagen;
  int detEstado;

  DetalleCatalogo(
      {this.idcovDetallecatalogo,
      this.idcovCatalogo = 0,
      this.detFecha,
      this.detTitulo,
      this.detSubtitulo,
      this.detContenido,
      this.detImagen,
      this.detEstado});

  fromJson(Map<String, dynamic> json) => new DetalleCatalogo(
      idcovDetallecatalogo: json["IDCOV_DETALLECATALOGO"],
      idcovCatalogo: json["IDCOV_CATALOGO"],
      detFecha: json["DET_FECHA"],
      detTitulo: json["DET_TITULO"],
      detSubtitulo: json["DET_SUBTITULO"],
      detContenido: json["DET_CONTENIDO"],
      detImagen: json["DET_IMAGEN"],
      detEstado: json["DET_ESTADO"]);

  Map<String, dynamic> toJson() => {
        "IDCOV_DETALLECATALOGO": idcovDetallecatalogo,
        "IDCOV_CATALOGO": idcovCatalogo,
        "DET_FECHA": detFecha,
        "DET_TITULO": detTitulo,
        "DET_SUBTITULO": detSubtitulo,
        "DET_CONTENIDO": detContenido,
        "DET_IMAGEN": detImagen,
        "DET_ESTADO": detEstado
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

  TestHistorial(
      {this.idcovTesthistorial = 0,
      this.idcovTest,
      this.hisRespuesta,
      this.hisFecha});

  fromJson(Map<String, dynamic> json) => new TestHistorial(
      idcovTesthistorial: json["IDCOV_TESTHISTORIAL"],
      idcovTest: json["IDCOV_TEST"],
      hisRespuesta: json["HIS_RESPUESTA"],
      hisFecha: json["HIS_FECHA"]);

  Map<String, dynamic> toJson() => {
        "IDCOV_TESTHISTORIAL": idcovTesthistorial,
        "IDCOV_TEST": idcovTest,
        "HIS_RESPUESTA": hisRespuesta,
        "HIS_FECHA": hisFecha
      };
}

class ZonaComunidad extends Entity {
  int idcovZonacomunidad;
  int idcovCiudadano;
  int idaTipozonaComunidad;
  int idaPrioridad;
  String zonLat;
  String zonLon;
  String zonImagen;

  ZonaComunidad(
      {this.idcovZonacomunidad = 0,
      this.idcovCiudadano,
      this.idaTipozonaComunidad,
      this.idaPrioridad,
      this.zonLat,
      this.zonLon,
      this.zonImagen});

  fromJson(Map<String, dynamic> json) => new ZonaComunidad(
      idcovZonacomunidad: json["IDCOV_ZONACOMUNIDAD"],
      idcovCiudadano: json["IDCOV_CIUDADANO"],
      idaTipozonaComunidad: json["IDA_TIPOZONA_COMUNIDAD"],
      idaPrioridad: json["IDA_PRIORIDAD"],
      zonLat: json["ZON_LAT"],
      zonLon: json["ZON_LON"],
      zonImagen: json["ZON_IMAGEN"]);

  Map<String, dynamic> toJson() => {
        "IDCOV_ZONACOMUNIDAD": idcovZonacomunidad,
        "IDCOV_CIUDADANO": idcovCiudadano,
        "IDA_TIPOZONA_COMUNIDAD": idaTipozonaComunidad,
        "IDA_PRIORIDAD": idaPrioridad,
        "ZON_LAT": zonLat,
        "ZON_LON": zonLon,
        "ZON_IMAGEN": zonImagen
      };
}

class ZonaControl extends Entity {
  int id;
  String nombre;
  String ubicacion;

  ZonaControl({this.id = 0, this.nombre, this.ubicacion});

  fromJson(Map<String, dynamic> json) => new ZonaControl(
      id: json["ID"],
      nombre: json["HOS_NOMBRE"],
      ubicacion: json["HOS_UBICACION"]);

  Map<String, dynamic> toJson() =>
      {"ID": id, "HOS_NOMBRE": nombre, "HOS_UBICACION": ubicacion};
}

class ZonaReporte extends Entity {
  int idcovZonareporte;
  int idcovFuncionario;
  int idaTipozonaReporte;
  int idaPrioridad;
  String zonLat;
  String zonLon;
  String zonImagen;

  ZonaReporte(
      {this.idcovZonareporte = 0,
      this.idcovFuncionario,
      this.idaTipozonaReporte,
      this.idaPrioridad,
      this.zonLat,
      this.zonLon,
      this.zonImagen});

  fromJson(Map<String, dynamic> json) => new ZonaReporte(
      idcovZonareporte: json["IDCOV_ZONAREPORTE"],
      idcovFuncionario: json["IDCOV_FUNCIONARIO"],
      idaTipozonaReporte: json["IDA_TIPOZONA_REPORTE"],
      idaPrioridad: json["IDA_PRIORIDAD"],
      zonLat: json["ZON_LAT"],
      zonLon: json["ZON_LON"],
      zonImagen: json["ZON_IMAGEN"]);

  Map<String, dynamic> toJson() => {
        "IDCOV_ZONAREPORTE": idcovZonareporte,
        "IDCOV_FUNCIONARIO": idcovFuncionario,
        "IDA_TIPOZONA_REPORTE": idaTipozonaReporte,
        "IDA_PRIORIDAD": idaPrioridad,
        "ZON_LAT": zonLat,
        "ZON_LON": zonLon,
        "ZON_IMAGEN": zonImagen
      };
}

class Funcionario extends Entity {
  int idcovFuncionario;
  int idcovLogin;
  String funNombre;
  String funCi;
  int idaInstitucion;
  DateTime funFechanacimiento;
  String funTelefono;
  String funCorreo;

  Funcionario(
      {this.idcovFuncionario = 0,
      this.idcovLogin,
      this.funNombre,
      this.funCi,
      this.idaInstitucion,
      this.funFechanacimiento,
      this.funTelefono,
      this.funCorreo});

  fromJson(Map<String, dynamic> json) => new Funcionario(
      idcovFuncionario: json["IDCOV_FUNCIONARIO"],
      idcovLogin: json["IDCOV_LOGIN"],
      funNombre: json["FUN_NOMBRE"],
      funCi: json["FUN_CI"],
      idaInstitucion: json["IDA_INSTITUCION"],
      funFechanacimiento: json["FUN_FECHANACIMIENTO"],
      funTelefono: json["FUN_TELEFONO"],
      funCorreo: json["FUN_CORREO"]);

  Map<String, dynamic> toJson() => {
        "IDCOV_FUNCIONARIO": idcovFuncionario,
        "IDCOV_LOGIN": idcovLogin,
        "FUN_NOMBRE": funNombre,
        "FUN_CI": funCi,
        "IDA_INSTITUCION": idaInstitucion,
        "FUN_FECHANACIMIENTO": funFechanacimiento,
        "FUN_TELEFONO": funTelefono,
        "FUN_CORREO": funCorreo
      };
}

class Alerta extends Entity {
  int id;
  String nombre;
  String ubicacion;

  Alerta({this.id = 0, this.nombre, this.ubicacion});

  fromJson(Map<String, dynamic> json) => new Alerta(
      id: json["ID"],
      nombre: json["HOS_NOMBRE"],
      ubicacion: json["HOS_UBICACION"]);

  Map<String, dynamic> toJson() =>
      {"ID": id, "HOS_NOMBRE": nombre, "HOS_UBICACION": ubicacion};
}

class Login extends Entity {
  int idcovLogin;
  String logUsuario;
  String logContrasenia;
  int logEstado;
  DateTime logFecharegistro;
  int logTipoingreso;

  Login(
      {this.idcovLogin = 0,
      this.logUsuario,
      this.logContrasenia,
      this.logEstado,
      this.logFecharegistro,
      this.logTipoingreso});

  fromJson(Map<String, dynamic> json) => new Login(
      idcovLogin: json["IDCOV_LOGIN"],
      logUsuario: json["LOG_USUARIO"],
      logContrasenia: json["LOG_CONTRASENIA"],
      logEstado: json["LOG_ESTADO"],
      logFecharegistro: json["LOG_FECHAREGISTRO"],
      logTipoingreso: json["LOG_TIPOINGRESO"]);

  Map<String, dynamic> toJson() => {
        "IDCOV_LOGIN": idcovLogin,
        "LOG_USUARIO": logUsuario,
        "LOG_CONTRASENIA": logContrasenia,
        "LOG_ESTADO": logEstado,
        "LOG_FECHAREGISTRO": logFecharegistro,
        "LOG_TIPOINGRESO": logTipoingreso
      };
}

class ProfesionalesAgrupados extends Entity {
  int idInstitucion;
  String profesion;
  int cantidadProfesionales;
  String imagenFondo;

  ProfesionalesAgrupados(
      {this.idInstitucion,
      this.profesion,
      this.cantidadProfesionales,
      this.imagenFondo});

  fromJson(Map<String, dynamic> json) => new ProfesionalesAgrupados(
      idInstitucion: json["idInstitucion"],
      profesion: json["profesion"],
      cantidadProfesionales: json["cantidadProfesionales"],
      imagenFondo: json["imagenFondo"]);

  Map<String, dynamic> toJson() => {
        "idInstitucion": idInstitucion,
        "profesion": profesion,
        "cantidadProfesionales": cantidadProfesionales,
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
  int miembros;

  InstitucionesItems(
      {this.idInstitucion,
      this.nombreInstitucion,
      this.tipoInstitucion,
      this.ubicacion,
      this.ayudaConCovid,
      this.fechaConCovid,
      this.miembros});

  fromJson(Map<String, dynamic> json) => new InstitucionesItems(
      idInstitucion: json["idInstitucion"],
      nombreInstitucion: json["nombreInstitucion"],
      tipoInstitucion: json["tipoInstitucion"],
      ubicacion: json["ubicacion"],
      ayudaConCovid: json["ayudaConCovid"],
      fechaConCovid: json["fechaConCovid"],
      miembros: json["miembros"]);

  Map<String, dynamic> toJson() => {
        "idInstitucion": idInstitucion,
        "nombreInstitucion": nombreInstitucion,
        "tipoInstitucion": tipoInstitucion,
        "ubicacion": ubicacion,
        "ayudaConCovid": ayudaConCovid,
        "fechaConCovid": fechaConCovid,
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
