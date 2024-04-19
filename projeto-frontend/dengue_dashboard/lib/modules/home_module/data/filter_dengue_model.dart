class FilterDengue {
  String? mes;
  int? ano;
  String? genero;
  String? raca;
  int? idade;
  int? dataObito;
  String? regiao;
  String? uf;
  String? municipio;
  int? quatidadeCasos;

  FilterDengue(
      {this.mes,
      this.ano,
      this.genero,
      this.raca,
      this.idade,
      this.dataObito,
      this.regiao,
      this.uf,
      this.municipio,
      this.quatidadeCasos});

  FilterDengue.fromJson(Map<String, dynamic> json) {
    mes = json['mes'];
    ano = json['ano'];
    genero = json['genero'];
    raca = json['raca'];
    idade = json['idade'];
    dataObito = json['dataObito'];
    regiao = json['regiao'];
    uf = json['uf'];
    municipio = json['municipio'];
    quatidadeCasos = json['quatidadeCasos'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['mes'] = mes;
    data['ano'] = ano;
    data['genero'] = genero;
    data['raca'] = raca;
    data['idade'] = idade;
    data['dataObito'] = dataObito;
    data['regiao'] = regiao;
    data['uf'] = uf;
    data['municipio'] = municipio;
    data['quatidadeCasos'] = quatidadeCasos;
    return data;
  }
}
