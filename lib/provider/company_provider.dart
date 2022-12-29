import 'package:flutter/cupertino.dart';
import 'package:perfumaria/data/company_dummy.dart';
import 'package:perfumaria/models/company_model.dart';

class CompanyProvider with ChangeNotifier {
  List<CompanyModel> get _items => companyDummy;
  List<CompanyModel> get items => [..._items];
  List<CompanyModel> get itemsFilter =>
      [const CompanyModel(id: "0", name: "Todos", imageUrl: "..."), ..._items];
  CompanyModel? selectedCompany;
  String? value;

  int get itemsCount {
    return _items.length;
  }

  void setSelectedCompany(CompanyModel value) {
    selectedCompany = value;
    notifyListeners();
  }
}
