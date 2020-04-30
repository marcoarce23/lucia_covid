import 'Entity.dart';

Future<List<ProfesionalesAgrupados>>
    getListaProfesionalesAgrupadosInstitucion() async {
  List<ProfesionalesAgrupados> vRespuesta = List<ProfesionalesAgrupados>();

  ProfesionalesAgrupados valor1 = ProfesionalesAgrupados();
  valor1.cantidadProfesionales = 200;
  valor1.idInstitucion = 1;
  valor1.imagenFondo = "assets/image/Familial Relationship.png";
  valor1.profesion = "Religioso";

  ProfesionalesAgrupados valor2 = ProfesionalesAgrupados();
  valor2.cantidadProfesionales = 356;
  valor2.idInstitucion = 2;
  valor2.imagenFondo = "assets/image/medical_profesional1.png";
  valor2.profesion = "Psicologos";

  ProfesionalesAgrupados valor3 = ProfesionalesAgrupados();
  valor3.cantidadProfesionales = 356;
  valor3.idInstitucion = 3;
  valor3.imagenFondo = "assets/image/medical_profesional2.png";
  valor3.profesion = "Curas";

  ProfesionalesAgrupados valor4 = ProfesionalesAgrupados();
  valor4.cantidadProfesionales = 34354;
  valor4.idInstitucion = 4;
  valor4.imagenFondo = "assets/image/Familial Relationship.png";
  valor4.profesion = "Paramedicos";

  vRespuesta.add(valor1);
  vRespuesta.add(valor2);
  vRespuesta.add(valor3);
  //vRespuesta.add(valor4);

  //await new Future.delayed(new Duration(seconds: 2));

  print(vRespuesta.length);
  return vRespuesta;
}

Future<List<ProfesionalesDeInstitucion>>
    getListaProfesionalesDeInstitucion() async {
  List<ProfesionalesDeInstitucion> vRespuesta =
      List<ProfesionalesDeInstitucion>();

  ProfesionalesDeInstitucion valor1 = ProfesionalesDeInstitucion();
  valor1.idPersonal = 2;
  valor1.idInstitucion = 1;
  valor1.nombreInstitucion = "Iglesia de cala cala";
  valor1.tipoProfesion = "Cura y parroco";
  valor1.nombreProfesional = "Padre Ismael Santos";
  valor1.correo = "coavchristian@hotmail.com";
  valor1.telefono = "76427275";
  valor1.ayudaConCovid = "1";
  valor1.ci = "6513256";
  valor1.sexo = "M";

  ProfesionalesDeInstitucion valor2 = ProfesionalesDeInstitucion();
  valor2.idPersonal = 3;
  valor2.idInstitucion = 1;
  valor2.nombreInstitucion = "Iglesia de cala cala";
  valor2.tipoProfesion = "Cura";
  valor2.nombreProfesional = "Padre Joaquin Santos";
  valor2.correo = "coavchristian@hotmail.com";
  valor2.telefono = "76427275";
  valor2.ayudaConCovid = "1";
  valor2.ci = "6513256";
  valor2.sexo = "M";

  ProfesionalesDeInstitucion valor3 = ProfesionalesDeInstitucion();
  valor3.idPersonal = 4;
  valor3.idInstitucion = 1;
  valor3.nombreInstitucion = "Iglesia de cala cala";
  valor3.tipoProfesion = "Monja";
  valor3.nombreProfesional = "Sor Rosario";
  valor3.correo = "coavchristian@hotmail.com";
  valor3.telefono = "76427275";
  valor3.ayudaConCovid = "1";
  valor3.ci = "6513256";
  valor3.sexo = "F";

  vRespuesta.add(valor1);
  vRespuesta.add(valor1);
  vRespuesta.add(valor1);
  vRespuesta.add(valor2);

  //await new Future.delayed(new Duration(seconds: 2));

  print(vRespuesta.length);
  return vRespuesta;
}

Future<List<InstitucionesItems>> getInstitucionesItems() async {
  List<InstitucionesItems> lista = new List<InstitucionesItems>();

  InstitucionesItems item1 = new InstitucionesItems();
  item1.idInstitucion = 1;
  item1.nombreInstitucion = "Cala Cala";
  item1.tipoInstitucion = "Religioso";
  item1.ubicacion = "Cochabamba";
  item1.ayudaConCovid = "0";
  item1.fechaConCovid = new DateTime(2020, 1, 30);
  item1.miembros = 50;
  lista.add(item1);

  InstitucionesItems item2 = new InstitucionesItems();
  item2.idInstitucion = 2;
  item2.nombreInstitucion = "San martin de porres";
  item2.tipoInstitucion = "Religioso";
  item2.ubicacion = "Cochabamba";
  item2.ayudaConCovid = "1";
  item2.fechaConCovid = new DateTime(2020, 1, 20);
  item2.miembros = 10;
  lista.add(item2);

  InstitucionesItems item3 = new InstitucionesItems();
  item3.idInstitucion = 3;
  item3.nombreInstitucion = "San Joaquin";
  item3.tipoInstitucion = "Religioso";
  item3.ubicacion = "La paz";
  item3.ayudaConCovid = "1";
  item3.fechaConCovid = new DateTime(2020, 1, 31);
  item3.miembros = 15;
  lista.add(item3);

  InstitucionesItems item4 = new InstitucionesItems();
  item4.idInstitucion = 4;
  item4.nombreInstitucion = "San Joaquin";
  item4.tipoInstitucion = "Religioso";
  item4.ubicacion = "La paz";
  item4.ayudaConCovid = "1";
  item4.fechaConCovid = new DateTime(2020, 1, 31);
  item4.miembros = 15;
  lista.add(item4);

  InstitucionesItems item5 = new InstitucionesItems();
  item5.idInstitucion = 5;
  item5.nombreInstitucion = "San Joaquin";
  item5.tipoInstitucion = "Religioso";
  item5.ubicacion = "La paz";
  item5.ayudaConCovid = "1";
  item5.fechaConCovid = new DateTime(2020, 1, 1);
  item5.miembros = 15;
  lista.add(item5);

  InstitucionesItems item6 = new InstitucionesItems();
  item6.idInstitucion = 6;
  item6.nombreInstitucion = "San Joaquin";
  item6.tipoInstitucion = "Hospital";
  item6.ubicacion = "La paz";
  item6.ayudaConCovid = "1";
  item6.fechaConCovid = new DateTime(2020, 1, 1);
  item6.miembros = 15;
  lista.add(item6);

  return lista;
}

Future<List<MultimediaImagen>> getImagenesMultimedia() async {
  List<MultimediaImagen> lista = new List<MultimediaImagen>();

  MultimediaImagen vImagen1 = new MultimediaImagen();
  vImagen1.idInstitucion = 1;
  vImagen1.titulo = "titulo 1";
  vImagen1.subtitulo = "Subtitulo1";
  vImagen1.url =
      "http://frankenfotos.com/wp-content/uploads/2020/01/msp_1912_1319-1160x774.jpg";
  lista.add(vImagen1);

  MultimediaImagen vImagen2 = new MultimediaImagen();
  vImagen2.idInstitucion = 1;
  vImagen2.titulo = "titulo 2";
  vImagen2.subtitulo = "Subtitulo2";
  vImagen2.url =
      "https://images.pexels.com/photos/1665722/pexels-photo-1665722.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940";
  lista.add(vImagen2);

  MultimediaImagen vImagen3 = new MultimediaImagen();
  vImagen3.idInstitucion = 1;
  vImagen3.titulo = "titulo 3";
  vImagen3.subtitulo = "Subtitulo3";
  vImagen3.url =
      "https://images.pexels.com/photos/2397645/pexels-photo-2397645.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940";
  lista.add(vImagen3);

  MultimediaImagen vImagen4 = new MultimediaImagen();
  vImagen4.idInstitucion = 1;
  vImagen4.titulo = "titulo 4";
  vImagen4.subtitulo = "Subtitulo4";
  vImagen4.url =
      "https://images.pexels.com/photos/3772771/pexels-photo-3772771.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940";
  lista.add(vImagen4);

 MultimediaImagen vImagen5 = new MultimediaImagen();
  vImagen5.idInstitucion = 1;
  vImagen5.titulo = "titulo 4";
  vImagen5.subtitulo = "Subtitulo4";
  vImagen5.url =
      "https://images.pexels.com/photos/3772771/pexels-photo-3772771.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940";
  lista.add(vImagen5);

  MultimediaImagen vImagen6 = new MultimediaImagen();
  vImagen6.idInstitucion = 1;
  vImagen6.titulo = "titulo 3";
  vImagen6.subtitulo = "Subtitulo3";
  vImagen6.url =
      "https://images.pexels.com/photos/2397645/pexels-photo-2397645.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940";
  lista.add(vImagen6);


  return lista;
}




Future<List<MultimediaVideo>> getVideosMultimedia() async {
  List<MultimediaVideo> lista = new List<MultimediaVideo>();

  MultimediaVideo vImagen1 = new MultimediaVideo();
  vImagen1.idInstitucion = 1;
  vImagen1.titulo = "titulo 1";
  vImagen1.subtitulo = "Subtitulo1";
  vImagen1.url =
      "https://www.youtube.com/watch?v=hiOjK992bPU";
  lista.add(vImagen1);

  MultimediaVideo vImagen2 = new MultimediaVideo();
  vImagen2.idInstitucion = 1;
  vImagen2.titulo = "titulo 2";
  vImagen2.subtitulo = "Subtitulo2";
  vImagen2.url =
      "https://www.youtube.com/watch?v=Dji_km6UJvA";
  lista.add(vImagen2);

  MultimediaVideo vImagen3 = new MultimediaVideo();
  vImagen3.idInstitucion = 1;
  vImagen3.titulo = "titulo 3";
  vImagen3.subtitulo = "Subtitulo3";
  vImagen3.url =
      "https://www.youtube.com/watch?v=NeQM1c-XCDc";
  lista.add(vImagen3);

  MultimediaVideo vImagen4 = new MultimediaVideo();
  vImagen4.idInstitucion = 1;
  vImagen4.titulo = "titulo 4";
  vImagen4.subtitulo = "Subtitulo4";
  vImagen4.url =
      "https://www.youtube.com/watch?v=af59U2BRRAU";
  lista.add(vImagen4);

 MultimediaVideo vImagen5 = new MultimediaVideo();
  vImagen5.idInstitucion = 1;
  vImagen5.titulo = "titulo 4";
  vImagen5.subtitulo = "Subtitulo4";
  vImagen5.url =
      "https://www.youtube.com/watch?v=GukNjYQZW8s";
  lista.add(vImagen5);

  MultimediaVideo vImagen6 = new MultimediaVideo();
  vImagen6.idInstitucion = 1;
  vImagen6.titulo = "titulo 3";
  vImagen6.subtitulo = "Subtitulo3";
  vImagen6.url =
      "https://www.youtube.com/watch?v=l3QNCrl6EqQ";
  lista.add(vImagen6);


  return lista;
}
