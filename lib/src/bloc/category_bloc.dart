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
    final _category = await _categoryProvider.createCategory(category);
    getCategory();
  }

  void updateCategory(CategoryModel category) async {
    await _categoryProvider.updateCategory(category);
  }

  // void agregarProductos(ProductoModel producto) async {

  //   _cargandoController.sink.add(true);
  //   await _productosProvider.crearProducto(producto);
  //   _cargandoController.sink.add(false);

  // }

  // Future<String> subirFoto(File foto) async {

  //   _cargandoController.sink.add(true);
  //   final fotoUrl = await _productosProvider.subirImagen(foto);
  //   _cargandoController.sink.add(false);

  //   return fotoUrl;

  // }

  // void editarProductos(ProductoModel producto) async {

  //   _cargandoController.sink.add(true);
  //   await _productosProvider.editarProducto(producto);
  //   _cargandoController.sink.add(false);

  // }

  // void borrarProducto(String id) async {

  //   await _productosProvider.borrarProducto(id);

  // }

  dispose() {
    // _productosController?.close();
    // _cargandoController?.close();
    _categoryController?.close();
  }
}
