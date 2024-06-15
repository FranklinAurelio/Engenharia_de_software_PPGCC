class FilterDengue {
  int? statusCode;
  Headers? headers;
  List<Body>? body;

  FilterDengue({this.statusCode, this.headers, this.body});

  FilterDengue.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    headers =
        json['headers'] != null ? Headers.fromJson(json['headers']) : null;
    if (json['body'] != null) {
      body = <Body>[];
      json['body'].forEach((v) {
        body!.add(Body.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['statusCode'] = statusCode;
    if (headers != null) {
      data['headers'] = headers!.toJson();
    }
    if (body != null) {
      data['body'] = body!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Headers {
  String? contentType;

  Headers({this.contentType});

  Headers.fromJson(Map<String, dynamic> json) {
    contentType = json['content-type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['content-type'] = contentType;
    return data;
  }
}

class Body {
  List<Forecast>? forecast;

  Body({this.forecast});

  Body.fromJson(Map<String, dynamic> json) {
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
  String? mesAno;
  double? previsaoCasos;
  double? previsaoMinima;
  double? previsaoMaxima;

  Forecast(
      {this.mesAno,
      this.previsaoCasos,
      this.previsaoMinima,
      this.previsaoMaxima});

  Forecast.fromJson(Map<String, dynamic> json) {
    mesAno = json['MesAno'];
    previsaoCasos = json['PrevisaoCasos'];
    previsaoMinima = json['PrevisaoMinima'];
    previsaoMaxima = json['PrevisaoMaxima'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['MesAno'] = mesAno;
    data['PrevisaoCasos'] = previsaoCasos;
    data['PrevisaoMinima'] = previsaoMinima;
    data['PrevisaoMaxima'] = previsaoMaxima;
    return data;
  }
}
