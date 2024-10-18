import 'dart:convert';
import '/helpers/api.dart';
import '/helpers/api_url.dart';
import '/model/transportasi.dart';

class TransportasiBloc {
  static Future<List<Transportasi>> getTransportasis() async {
    String apiUrl = ApiUrl.listTransportasi;
    var response = await Api().get(apiUrl);
    var jsonObj = json.decode(response.body);
    List<dynamic> listTransportasi = (jsonObj as Map<String, dynamic>)['data'];
    List<Transportasi> transportasis = [];
    for (int i = 0; i < listTransportasi.length; i++) {
      transportasis.add(Transportasi.fromJson(listTransportasi[i]));
    }
    return transportasis;
  }

  static Future addTransportasi({Transportasi? transportasi}) async {
    String apiUrl = ApiUrl.createTransportasi;
    var body = {
      "vehicle": transportasi!.vehicle,
      "company": transportasi.company,
      "capacity": transportasi.capacity
    };
    
    var response = await Api().post(apiUrl, body);
    var jsonObj = json.decode(response.body);
    return jsonObj['status'];
  }

  static Future updateTransportasi({required Transportasi transportasi}) async {
    String apiUrl = ApiUrl.updateTransportasi(transportasi.id!);
    print(apiUrl);

    var body = {
      "vehicle": transportasi.vehicle,
      "company": transportasi.company,
      "capacity": transportasi.capacity
    };
    print("Body : $body");
    var response = await Api().put(apiUrl, jsonEncode(body));
    var jsonObj = json.decode(response.body);
    return jsonObj['status'];
  }

  static Future<bool> deleteTransportasi({int? id}) async {
    String apiUrl = ApiUrl.deleteTransportasi(id!);

    var response = await Api().delete(apiUrl);
    var jsonObj = json.decode(response.body);
    return (jsonObj as Map<String, dynamic>)['data'];
  }
}
