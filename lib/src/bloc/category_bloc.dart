import 'package:rxdart/rxdart.dart';
import 'package:simple_list_app/src/model/category_model.dart';
import 'package:simple_list_app/src/provider/category_provider.dart';

class CategoryBloc {
  final _categoryProvider = new CategoryProvider();

  final _categoryController = new BehaviorSubject<List<CategoryModel>>();
  Stream<List<CategoryModel>> get categoriesStream =>
      _categoryController.stream;

  void getCategory() async {
    final categories = await _categoryProvider.getCategory();
    _categoryController.sink.add(categories);
  }

  void deleteCategory(idCategory) async {
    await _categoryProvider.deleteCategory(idCategory);
  }

  void createCategory(CategoryModel category) async {
    await _categoryProvider.createCategory(category);
    getCategory();
  }

  void updateCategory(CategoryModel category) async {
    await _categoryProvider.updateCategory(category);
    getCategory();
  }

  dispose() {
    _categoryController?.close();
  }
}
