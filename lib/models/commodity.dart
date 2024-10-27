class CommodityModel {
  List<Records>? records;

  CommodityModel({this.records});

  CommodityModel.fromJson(Map<String, dynamic> json) {
    if (json['records'] != null) {
      records = <Records>[];
      json['records'].forEach((v) {
        records!.add(Records.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (records != null) {
      data['records'] = records!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Records {
  String? state;
  String? district;
  String? market;
  String? commodity;
  String? variety;
  String? grade;
  String? arrivalDate;
  String? minPrice;
  String? maxPrice;
  String? modalPrice;

  Records(
      {this.state,
      this.district,
      this.market,
      this.commodity,
      this.variety,
      this.grade,
      this.arrivalDate,
      this.minPrice,
      this.maxPrice,
      this.modalPrice});

  Records.fromJson(Map<String, dynamic> json) {
    state = json['state'];
    district = json['district'];
    market = json['market'];
    commodity = json['commodity'];
    variety = json['variety'];
    grade = json['grade'];
    arrivalDate = json['arrival_date'];
    minPrice = json['min_price'];
    maxPrice = json['max_price'];
    modalPrice = json['modal_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['state'] = state;
    data['district'] = district;
    data['market'] = market;
    data['commodity'] = commodity;
    data['variety'] = variety;
    data['grade'] = grade;
    data['arrival_date'] = arrivalDate;
    data['min_price'] = minPrice;
    data['max_price'] = maxPrice;
    data['modal_price'] = modalPrice;
    return data;
  }
}
