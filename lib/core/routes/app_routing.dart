
import 'package:ecommerce_app_huma_volve/features/details/screens/product_details_screen.dart';
import 'package:ecommerce_app_huma_volve/features/splash/screens/splash_screen.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/entities/home_product_entity.dart';
import 'package:go_router/go_router.dart';

final appRouting = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) =>  SplashScreen(productId:0 ),
    ),
    GoRoute(
      path: '/products/:id',
      builder: (context, state) {
        final product = state.extra as HomeProductEntity;
        final productId = int.parse(state.pathParameters['id']!);


        return ProductDetailsScreen(product: product, productId: productId,);
      },
    ),
  ],
);
