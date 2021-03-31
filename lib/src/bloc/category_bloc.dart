import 'package:rxdart/rxdart.dart';
import 'package:simple_list_app/src/model/category_model.dart';
import 'package:simple_list_app/src/provider/category_provider.dart';

class CategoryBloc {
  final _categoryProvider = new CategoryProvider();

  final _categoryController = new BehaviorSubject<List<CategoryModel>>();
  Stream<List<CategoryModel>> get categoriesStream =>
      _categoryController.stream;

  Future<bool> getCategory() async {
    final categories = await _categoryProvider.getCategory();
    _categoryController.sink.add(categories);
    return true;
  }

  Future<bool> deleteCategory(idCategory) async {
    await _categoryProvider.deleteCategory(idCategory);
    return await getCategory();
  }

  Future<bool> createCategory(CategoryModel category) async {
    await _categoryProvider.createCategory(category);
    return await getCategory();
  }

  Future<bool> updateCategory(CategoryModel category) async {
    await _categoryProvider.updateCategory(category);
    return await getCategory();
  }

  dispose() {
    _categoryController?.close();
  }
}
