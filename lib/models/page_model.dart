import 'package:embesys_ctrl/models/modules_model.dart';

class PageModel {
  String title;
  bool isSelected;
  List<ModulesModel> modules;

  PageModel(this.title, this.isSelected, this.modules);
}
