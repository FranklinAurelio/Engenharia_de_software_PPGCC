class FilterDengue {
  List<Forecast>? forecast;

  FilterDengue({this.forecast});

  FilterDengue.fromJson(Map<String, dynamic> json) {
    if (json['forecast'] != null) {
      forecast = <Forecast>[];
      json['forecast'].forEach((v) {
        forecast!.add(Forecast.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (forecast != null) {
      data['forecast'] = forecast!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Forecast {
  int? pacientes;
  String? data;

  Forecast({this.pacientes, this.data});

  Forecast.fromJson(Map<String, dynamic> json) {
    pacientes = json['pacientes'];
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['pacientes'] = pacientes;
    data['data'] = this.data;
    return data;
  }
}
