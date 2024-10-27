class PolyStatsModel {
  double? std;
  double? p25;
  int? num;
  double? min;
  double? max;
  double? median;
  double? p75;
  double? mean;

  PolyStatsModel(
      {this.std,
      this.p25,
      this.num,
      this.min,
      this.max,
      this.median,
      this.p75,
      this.mean});

  PolyStatsModel.fromJson(Map<String, dynamic> json) {
    std = json['std'];
    p25 = json['p25'];
    num = json['num'];
    min = json['min'];
    max = json['max'];
    median = json['median'];
    p75 = json['p75'];
    mean = json['mean'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['std'] = std;
    data['p25'] = p25;
    data['num'] = num;
    data['min'] = min;
    data['max'] = max;
    data['median'] = median;
    data['p75'] = p75;
    data['mean'] = mean;
    return data;
  }
}
