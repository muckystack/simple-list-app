import 'package:rxdart/rxdart.dart';
import 'package:simple_list_app/src/model/category_model.dart';
import 'package:simple_list_app/src/model/list_model.dart';
import 'package:simple_list_app/src/provider/list_provider.dart';

class ListBloc {
  final _listProvider = new ListProvider();

  final _listController = new BehaviorSubject<List<ListModel>>();
  Stream<List<ListModel>> get listStream => _listController.stream;

  void reset() async {
    _listController.sink.add(null);
  }
  
  Future<bool> getListByCategory(CategoryModel category) async {
    final categories = await _listProvider.getListByCategory(category);
    _listController.sink.add(categories);
    return true;
  }

  Future<bool> deleteList(idList, CategoryModel category) async {
    await _listProvider.deleteList(idList);
    return await getListByCategory(category);
  }

  Future<bool> createList(ListModel list, CategoryModel category) async {
    await _listProvider.createList(list);
    return await getListByCategory(category);
  }

  Future<bool> updateList(ListModel list, CategoryModel category) async {
    await _listProvider.updateList(list);
    return await getListByCategory(category);
  }

  dispose() {
    _listController?.close();
  }
}
