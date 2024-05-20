import 'package:dartz/dartz.dart';
import 'package:dengue_dashboard/core/erros/failures.dart';
import 'package:dengue_dashboard/modules/home_module/data/filter_dengue_model.dart';
import 'package:dengue_dashboard/modules/home_module/data/input_filter.dart';

abstract class ICustomerRepository {
  Future<Either<Failure, FilterDengue>> forecast(InputFilter params);
}
