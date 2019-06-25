import 'package:get_it/get_it.dart';
import '../model/app_model.dart';

GetIt locator = GetIt();

void setupLocator() {
  locator.registerSingleton<AppModel>(new AppModelImplementation());
}
