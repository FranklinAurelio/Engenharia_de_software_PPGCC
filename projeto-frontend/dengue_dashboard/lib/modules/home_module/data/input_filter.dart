class InputFilter {
  String? genero;
  String? faixaEtaria;
  String? uf;
  String? regiao;

  InputFilter({this.genero, this.faixaEtaria, this.uf, this.regiao});

  InputFilter.fromJson(Map<String, dynamic> json) {
    genero = json['genero'];
    faixaEtaria = json['faixa_etaria'];
    uf = json['uf'];
    regiao = json['regiao'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['genero'] = genero;
    data['faixa_etaria'] = faixaEtaria;
    data['uf'] = uf;
    data['regiao'] = regiao;
    return data;
  }
}
