class WorkModel {
  Location? location;
  String? sId;
  String? title;
  String? phone;
  String? district;
  String? price;
  num? iV;

  WorkModel(
      {this.location,
      this.sId,
      this.title,
      this.phone,
      this.district,
      this.price,
      this.iV});

  WorkModel.fromJson(Map<String, dynamic> json) {
    location = json['location'] != null
        ? Location.fromJson(json['location'])
        : Location(
            type: 'Point',
            coordinates: [0.0, 0.0],
          );
    sId = json['_id'];
    title = json['title'];
    phone = json['phone'];
    district = json['district'];
    price = json['price'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (location != null) {
      data['location'] = location!.toJson();
    }
    data['_id'] = sId;
    data['title'] = title;
    data['phone'] = phone;
    data['district'] = district;
    data['price'] = price;
    data['__v'] = iV;
    return data;
  }
}

class Location {
  String? type;
  List<num>? coordinates;

  Location({this.type, this.coordinates});

  Location.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    coordinates = json['coordinates'].cast<double>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['coordinates'] = coordinates;
    return data;
  }
}
