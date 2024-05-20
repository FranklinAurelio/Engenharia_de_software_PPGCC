import 'package:dengue_dashboard/modules/home_module/data/filter_dengue_model.dart';
import 'package:dengue_dashboard/modules/home_module/data/input_filter.dart';
import 'package:dengue_dashboard/modules/home_module/datasources/datasource_implementation.dart';
import 'package:dengue_dashboard/modules/home_module/datasources/datasource_interface.dart';
import 'package:dengue_dashboard/modules/home_module/repositories/repository_implementation.dart';
import 'package:dengue_dashboard/modules/home_module/repositories/repository_interface.dart';
import 'package:dengue_dashboard/shared/dio_http_service.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomeController {
  late ICustomerDatasource _dataSource;
  late ICustomerRepository _customerRepository;

  HomeController() {
    _dataSource = CustomerDatasourceImplementation(
        httpClient: Modular.get<DioHttpService>());
    _customerRepository = CustomerRepositoryImplementation(_dataSource);
  }

  Future<FilterDengue?> forecast(InputFilter params) async {
    final result = await _customerRepository.forecast(params);
    if (result.isRight()) {
      return result.toOption().toNullable()!;
    }
    return null;
  }
}
