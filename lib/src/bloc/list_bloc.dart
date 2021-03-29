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

  void createList(ListModel list) async {
    await _listProvider.createList(list);
    // getListByCategory();
  }

  void updateList(ListModel list) async {
    await _listProvider.updateList(list);
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
    _listController?.close();
  }
}
