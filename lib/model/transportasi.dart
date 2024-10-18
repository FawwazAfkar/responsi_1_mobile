class Transportasi {
  int? id;
  String? vehicle;
  String? company;
  int? capacity;
  Transportasi({this.id, this.vehicle, this.company,this.capacity});
  factory Transportasi.fromJson(Map<String, dynamic> obj) {
    return Transportasi(
        id: obj['id'],
        vehicle: obj['vehicle'],
        company: obj['company'],
        capacity: obj['capacity']);
  }
}