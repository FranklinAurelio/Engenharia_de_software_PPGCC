import 'dart:convert';
import 'package:dengue_dashboard/core/erros/exceptions.dart';
import 'package:dengue_dashboard/core/http_client_interface.dart';
import 'package:dengue_dashboard/modules/home_module/data/filter_dengue_model.dart';
import 'package:dengue_dashboard/modules/home_module/data/input_filter.dart';
import 'package:dengue_dashboard/modules/home_module/datasources/datasource_interface.dart';
import 'package:flutter_modular/flutter_modular.dart';

class CustomerDatasourceImplementation implements ICustomerDatasource {
  final IHttpClient httpClient;

  CustomerDatasourceImplementation({required this.httpClient});

  @override
  Future<FilterDengue> forecast(InputFilter params) async {
    try {
      final response = await httpClient.post(
          'https://ew4n1xndv4.execute-api.us-east-1.amazonaws.com/dev/',
          data: {
            "genero": "F",
            "faixa_etaria": "Adultos",
            "uf": "São Paulo",
            "regiao": "Sudeste"
          },
          headers: {
            "content-type": "application/json"
          });

      if (response.statusCode == 200 || response.statusCode == 201) {
        return FilterDengue.fromJson(response.data);
      } else if (response.statusCode == 400) {
        throw BadRequestException();
      } else if (response.statusCode == 401 || response.statusCode == 403) {
        throw NoAuthorizationException();
      } else {
        throw ServerException();
      }
    } catch (e) {
      Modular.to.pushNamed('/');
      throw ServerException();
    }
  }
}
