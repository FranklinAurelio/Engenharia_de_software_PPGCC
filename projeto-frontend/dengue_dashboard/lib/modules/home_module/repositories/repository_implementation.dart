import 'package:dartz/dartz.dart';
import 'package:dengue_dashboard/core/erros/exceptions.dart';
import 'package:dengue_dashboard/core/erros/failures.dart';
import 'package:dengue_dashboard/modules/home_module/data/filter_dengue_model.dart';
import 'package:dengue_dashboard/modules/home_module/data/input_filter.dart';
import 'package:dengue_dashboard/modules/home_module/datasources/datasource_interface.dart';
import 'package:dengue_dashboard/modules/home_module/repositories/repository_interface.dart';

class CustomerRepositoryImplementation implements ICustomerRepository {
  final ICustomerDatasource datasource;

  CustomerRepositoryImplementation(this.datasource);

  @override
  Future<Either<Failure, FilterDengue>> forecast(InputFilter params) async {
    try {
      final result = await datasource.forecast(params);
      return Right(result);
    } on ServerException {
      return Left(ServerFailure());
    } on BadRequestException {
      return Left(ServerFailure());
    } on NoAuthorizationException {
      return Left(ServerFailure());
    }
  }
}
