import 'package:dengue_dashboard/modules/home_module/data/filter_dengue_model.dart';
import 'package:dengue_dashboard/modules/home_module/data/input_filter.dart';

abstract class ICustomerDatasource {
  Future<FilterDengue> forecast(InputFilter params);
}
