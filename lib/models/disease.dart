class DiseaseModel {
  double? accuracy;
  String? img;
  String? name;
  String? soln;

  DiseaseModel({this.accuracy, this.img, this.name, this.soln});

  DiseaseModel.fromJson(Map<String, dynamic> json) {
    accuracy = json['accuracy'];
    img = json['img'];
    name = json['name'];
    soln = json['soln'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['accuracy'] = accuracy;
    data['img'] = img;
    data['name'] = name;
    data['soln'] = soln;
    return data;
  }
}
