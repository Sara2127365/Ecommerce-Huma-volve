
import 'package:ecommerce_app_huma_volve/features/home/domain/use_case/get_categories_use_case.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/use_case/get_products_use_case.dart';
import 'package:ecommerce_app_huma_volve/features/home/presentation/veiw_model/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<HomeState> {
  final GetCategoriesUseCase getCategoriesUseCase;
  final GetProductsUseCase getProductsUseCase;

  HomeCubit({
    required this.getCategoriesUseCase,
    required this.getProductsUseCase,
  }) : super(HomeInitial());

  Future<void> loadHomeData() async {
    emit(CategoriesLoading());

    final categoriesResult = await getCategoriesUseCase.invoke();

    final categoryId = categoriesResult.fold<int?>(
      (failure) {
        emit(CategoriesError(failure.failureMessage));
        return null;
      },
      (categories) {
        if (categories.isEmpty) {
          emit(CategoriesError('No categories found'));
          return null;
        }

        emit(CategoriesSuccess(categories));
        return categories.first.id;
      },
    );

    if (categoryId == null) return;

    emit(ProductsLoading());

    final productsResult = await getProductsUseCase.invoke(categoryId);

    productsResult.fold(
      (failure) {
        emit(ProductsError(failure.failureMessage));
      },
      (products) {
        emit(ProductsSuccess(products));
      },
    );
  }

  Future<void> getProductsByCategoriesId(int id) async {
    emit(ProductsLoading());

    final productsResult = await getProductsUseCase.invoke(id);

    productsResult.fold(
      (failure) {
        emit(ProductsError(failure.failureMessage));
      },
      (products) {
        emit(ProductsSuccess(products));
      },
    );
  }
}
