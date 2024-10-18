class ApiUrl {
  static const String baseUrl = 'http://responsi.webwizards.my.id/api/pariwisata';

  static const String registrasi = 'http://responsi.webwizards.my.id/api/registrasi';
  static const String login = 'http://responsi.webwizards.my.id/api/login';
  
  static const String listTransportasi = baseUrl + '/transportasi';
  static const String createTransportasi = baseUrl + '/transportasi';

  static String showTransportasi(int id) {
    return baseUrl + '/transportasi/' + id.toString();
  }

  static String updateTransportasi(int id) {
    return baseUrl + '/transportasi/' + id.toString() + '/update';
  }

  static String deleteTransportasi(int id) {
    return baseUrl + '/transportasi/' + id.toString() + '/delete';
  }

}
