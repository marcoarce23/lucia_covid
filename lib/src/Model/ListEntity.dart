import 'Entity.dart';

Future<List<ProfesionalesAgrupados>>
    getListaProfesionalesAgrupadosInstitucion() async {
  List<ProfesionalesAgrupados> vRespuesta = List<ProfesionalesAgrupados>();

  ProfesionalesAgrupados valor1 = ProfesionalesAgrupados();
  valor1.cantidadProfesionales = 200;
  valor1.idInstitucion = 1;
  valor1.imagenFondo = "assets/image/Familial Relationship.png";
  valor1.descripcion =
      "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).";
  valor1.profesion = "Religioso";

  ProfesionalesAgrupados valor2 = ProfesionalesAgrupados();
  valor2.cantidadProfesionales = 356;
  valor2.idInstitucion = 2;
  valor2.imagenFondo = "assets/image/medical_profesional1.png";
  valor2.descripcion =
      "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).";
  valor2.profesion = "Psicologos";

  ProfesionalesAgrupados valor3 = ProfesionalesAgrupados();
  valor3.cantidadProfesionales = 356;
  valor3.idInstitucion = 3;
  valor3.imagenFondo = "assets/image/medical_profesional2.png";
  valor3.descripcion =
      "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).";
  valor3.profesion = "Curas";

  ProfesionalesAgrupados valor4 = ProfesionalesAgrupados();
  valor4.cantidadProfesionales = 34354;
  valor4.idInstitucion = 4;
  valor4.imagenFondo = "assets/image/Familial Relationship.png";
  valor4.descripcion =
      "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).";
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
  item1.nombreInstitucion = "Cala";
  item1.tipoInstitucion = "Reloso";
  item1.ubicacion = "Cochaba";
  item1.ayudaConCovid = "0";
  item1.fechaConCovid = "30/01/2020";
  item1.miembros = 50;
  item1.url =
      "https://drive.google.com/file/d/1SKri16i8UJPBUFhD2VTaB-zowqUrUexQ/view";
  lista.add(item1);

  InstitucionesItems item2 = new InstitucionesItems();
  item2.idInstitucion = 2;
  item2.nombreInstitucion = "San martin de porres";
  item2.tipoInstitucion = "Religioso";
  item2.ubicacion = "Cochabamba";
  item2.ayudaConCovid = "1";
  item2.fechaConCovid ="20/01/2020" ;
  item2.miembros = 10;
  item2.url =
      "https://upload.wikimedia.org/wikipedia/commons/thumb/5/5d/Iglesia_Santa_Ana_De_Cala_CalaFachada.jpg/450px-Iglesia_Santa_Ana_De_Cala_CalaFachada.jpg";
  lista.add(item2);

  InstitucionesItems item3 = new InstitucionesItems();
  item3.idInstitucion = 3;
  item3.nombreInstitucion = "San Joaquin";
  item3.tipoInstitucion = "Religioso";
  item3.ubicacion = "La paz";
  item3.ayudaConCovid = "1";
  item3.fechaConCovid ="31/01/2020";
  item3.miembros = 15;
  item3.url =
      "https://upload.wikimedia.org/wikipedia/commons/thumb/5/5d/Iglesia_Santa_Ana_De_Cala_CalaFachada.jpg/450px-Iglesia_Santa_Ana_De_Cala_CalaFachada.jpg";
  lista.add(item3);

  InstitucionesItems item4 = new InstitucionesItems();
  item4.idInstitucion = 4;
  item4.nombreInstitucion = "San Joaquin";
  item4.tipoInstitucion = "Religioso";
  item4.ubicacion = "La paz";
  item4.ayudaConCovid = "1";
  item4.fechaConCovid ="31/01/2020";
  item4.miembros = 15;
  item4.url =
      "https://upload.wikimedia.org/wikipedia/commons/thumb/5/5d/Iglesia_Santa_Ana_De_Cala_CalaFachada.jpg/450px-Iglesia_Santa_Ana_De_Cala_CalaFachada.jpg";
  lista.add(item4);


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
  vImagen1.url = "https://www.youtube.com/watch?v=hiOjK992bPU";
  lista.add(vImagen1);

  MultimediaVideo vImagen2 = new MultimediaVideo();
  vImagen2.idInstitucion = 1;
  vImagen2.titulo = "titulo 2";
  vImagen2.subtitulo = "Subtitulo2";
  vImagen2.url = "https://www.youtube.com/watch?v=Dji_km6UJvA";
  lista.add(vImagen2);

  MultimediaVideo vImagen3 = new MultimediaVideo();
  vImagen3.idInstitucion = 1;
  vImagen3.titulo = "titulo 3";
  vImagen3.subtitulo = "Subtitulo3";
  vImagen3.url = "https://www.youtube.com/watch?v=NeQM1c-XCDc";
  lista.add(vImagen3);

  MultimediaVideo vImagen4 = new MultimediaVideo();
  vImagen4.idInstitucion = 1;
  vImagen4.titulo = "titulo 4";
  vImagen4.subtitulo = "Subtitulo4";
  vImagen4.url = "https://www.youtube.com/watch?v=af59U2BRRAU";
  lista.add(vImagen4);

  MultimediaVideo vImagen5 = new MultimediaVideo();
  vImagen5.idInstitucion = 1;
  vImagen5.titulo = "titulo 4";
  vImagen5.subtitulo = "Subtitulo4";
  vImagen5.url = "https://www.youtube.com/watch?v=GukNjYQZW8s";
  lista.add(vImagen5);

  MultimediaVideo vImagen6 = new MultimediaVideo();
  vImagen6.idInstitucion = 1;
  vImagen6.titulo = "titulo 3";
  vImagen6.subtitulo = "Subtitulo3";
  vImagen6.url = "https://www.youtube.com/watch?v=l3QNCrl6EqQ";
  lista.add(vImagen6);

  return lista;
}


Future<List<MultimediaDocumentos>> getDocumentosMultimedia() async {
  List<MultimediaDocumentos> lista = new List<MultimediaDocumentos>();

  MultimediaDocumentos vImagen1 = new MultimediaDocumentos();
  vImagen1.idInstitucion = 1;
  vImagen1.titulo = "titulo 1";
  vImagen1.subtitulo = "Subtitulo1";
  vImagen1.url = "https://www.portalfarma.com/Profesionales/campanaspf/Asesoramiento-salud-publica/infeccion-coronavirus-2019-nCoV/Documents/Informe-tecnico-Coronavirus.pdf";
  lista.add(vImagen1);

  MultimediaDocumentos vImagen2 = new MultimediaDocumentos();
  vImagen2.idInstitucion = 1;
  vImagen2.titulo = "titulo 2";
  vImagen2.subtitulo = "Subtitulo2";
  vImagen2.url = "https://www.portalfarma.com/Profesionales/campanaspf/Asesoramiento-salud-publica/infeccion-coronavirus-2019-nCoV/Documents/Informacion-poblacion-general-Coronavirus.pdf";
  lista.add(vImagen2);

  MultimediaDocumentos vImagen3 = new MultimediaDocumentos();
  vImagen3.idInstitucion = 1;
  vImagen3.titulo = "titulo 3";
  vImagen3.subtitulo = "Subtitulo3";
  vImagen3.url = "https://www.mscbs.gob.es/profesionales/saludPublica/ccayes/alertasActual/nCov-China/documentos/20200224.Preguntas_respuestas_COVID-19.pdf";
  lista.add(vImagen3);

  MultimediaDocumentos vImagen4 = new MultimediaDocumentos();
  vImagen4.idInstitucion = 1;
  vImagen4.titulo = "titulo 4";
  vImagen4.subtitulo = "Subtitulo4";
  vImagen4.url = "https://www.mscbs.gob.es/profesionales/saludPublica/ccayes/alertasActual/nCov-China/documentos/20200224.Preguntas_respuestas_COVID-19.pdf";
  lista.add(vImagen4);


  return lista;
}

/*
Future<List<EventosItem>> getEventos() async {
  List<EventosItem> lista = new List<EventosItem>();

  EventosItem item1 =  new EventosItem();
  item1.institucion = "San Martin de porres";
  item1.voluntario = "";
  item1.titulo = "titulo1";
  item1.url="https://images.pexels.com/photos/531880/pexels-photo-531880.jpeg?auto=compress&cs=tinysrgb&h=350";
  item1.objetivo = "objetivo1";
  item1.fechaYhora = DateTime.now().add(Duration(days: -1) );
  lista.add(item1);

  EventosItem item2 = new EventosItem();
  item2.institucion = "Santa Ana de cala cala";
  item2.voluntario = "";
  item2.titulo = "titulo2";
  item2.objetivo = "objetivo2";
  item2.url="https://images.pexels.com/photos/262438/pexels-photo-262438.jpeg?auto=compress&cs=tinysrgb&h=350";
  item2.fechaYhora =DateTime.now().add(Duration(days: -2) );
  lista.add(item2);

  EventosItem item3 = new EventosItem();
  item3.institucion = "Don Bosco";
  item3.voluntario = "";
  item3.titulo = "titulo3";
  item3.objetivo = "objetivo3";
  item3.url="https://images.pexels.com/photos/865002/pexels-photo-865002.jpeg?auto=compress&cs=tinysrgb&h=350";
  item3.fechaYhora = DateTime.now().add(Duration(days: -3) );
  lista.add(item3);

  EventosItem item4= new EventosItem();
  item4.institucion = "SAR Bolivia";
  item4.voluntario = "";
  item4.titulo = "titulo4";
  item4.objetivo = "objetivo4";
  item4.url="https://images.pexels.com/photos/39397/dart-target-aim-arrow-39397.jpeg?auto=compress&cs=tinysrgb&h=350";
  item4.fechaYhora =DateTime.now().add(Duration(days: -4) );
  lista.add(item4);

  EventosItem item5 = new EventosItem();
  item5.institucion = "Parroquia";
  item5.voluntario = "";
  item5.titulo = "titulo5";
  item5.objetivo = "objetivo5";
  item5.url="https://images.pexels.com/photos/531880/pexels-photo-531880.jpeg?auto=compress&cs=tinysrgb&h=350";
  item5.fechaYhora =DateTime.now().add(Duration(days: -5) );
  lista.add(item5);

  EventosItem item6 = new EventosItem();
  item6.institucion = "Dejame Ayudarte";
  item6.voluntario = "Ximena";
  item6.titulo = "titulo6";
  item6.objetivo = "objetivo6";
  item6.url="https://images.pexels.com/photos/865002/pexels-photo-865002.jpeg?auto=compress&cs=tinysrgb&h=350";
  item6.fechaYhora = DateTime.now().add(Duration(days: -5) );
  lista.add(item6);

  return   lista;
}
*/
