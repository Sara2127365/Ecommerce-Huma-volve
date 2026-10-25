import 'package:ecommerce_app_huma_volve/features/home/domain/entities/home_category_entity.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/entities/home_product_entity.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/use_case/get_categories_use_case.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/use_case/get_products_use_case.dart';
import 'package:ecommerce_app_huma_volve/features/home/presentation/veiw_model/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<HomeState> {
  final GetCategoriesUseCase getCategoriesUseCase;
  final GetProductsUseCase getProductsUseCase;
  final int limit = 10;
  int offset = 0;
  bool isLoadingMore = false;
  bool hasMore = true;
  int? selectedCategory;
  final List<HomeProductEntity> _products = [];

  HomeCubit({
    required this.getCategoriesUseCase,
    required this.getProductsUseCase,
  }) : super(HomeInitial());

  Future<void> loadHomeData() async {
    emit(CategoriesLoading());

    final categoriesResult = await getCategoriesUseCase.invoke();
    // List<HomeCategoryEntity> categories = [];
    int id = 0;
    categoriesResult.fold(
      (failure) {
        emit(CategoriesError(failure.failureMessage));
        return null;
      },
      (categoriesResult) {
        id = categoriesResult.first.id;
        print('List of Data : ${categoriesResult.first.id}');
        emit(CategoriesSuccess(categoriesResult));
      },
    );

    await getProductsByCategoriesId(id);
  }

  Future<void> getProductsByCategoriesId(int id) async {
     _products.clear();
    emit(ProductsLoading());
    hasMore = true;
   

    final result = await getProductsUseCase.invoke(
      id,
      limit: limit,
      offset: offset,
    );

    result.fold(
      (failure) {
        emit(ProductsError(failure.failureMessage));
      },
      (products) {
      
        _products.addAll(products);
        offset = products.length;
        if (products.length < limit) {
          hasMore = false;
        }
        selectedCategory = id;
        emit(ProductsSuccess(List.from(_products)));
      },
    );
  }

  Future<void> loadMoreProducts() async {
    if (isLoadingMore || !hasMore) {
      isLoadingMore = true;
      emit(ProductsLoading());
      final result = await getProductsUseCase.invoke(
        selectedCategory,
        limit: limit,
        offset: offset,
      );
      result.fold(
        (failure) {
          emit(ProductIsLoadingError(errorMessage: failure.failureMessage));
        },
        (newProducts) {
          _products.addAll(newProducts);
          offset += newProducts.length;
          if (newProducts.length < limit) {
            hasMore = false;
          }
          emit(ProductsSuccess(List.from(_products)));
        },
      );
    }
  }
}
