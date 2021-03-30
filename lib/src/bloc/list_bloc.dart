import 'package:rxdart/rxdart.dart';
import 'package:simple_list_app/src/model/category_model.dart';
import 'package:simple_list_app/src/model/list_model.dart';
import 'package:simple_list_app/src/provider/list_provider.dart';

class ListBloc {
  final _listProvider = new ListProvider();

  final _listController = new BehaviorSubject<List<ListModel>>();
  Stream<List<ListModel>> get listStream => _listController.stream;

  void getListByCategory(CategoryModel category) async {
    final categories = await _listProvider.getListByCategory(category);
    _listController.sink.add(categories);
  }

  void deleteList(idList) async {
    await _listProvider.deleteList(idList);
  }

  void createList(ListModel list, CategoryModel category) async {
    await _listProvider.createList(list);
    getListByCategory(category);
  }

  void updateList(ListModel list, CategoryModel category) async {
    await _listProvider.updateList(list);
    getListByCategory(category);
  }

  dispose() {
    _listController?.close();
  }
}
