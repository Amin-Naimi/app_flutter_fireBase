import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dsi32_flutter_project/config/go_router_config.dart';
import 'package:dsi32_flutter_project/core/network/network_info.dart';
import 'package:dsi32_flutter_project/features/products/data/datasources/product_remote_data_source.dart';
import 'package:dsi32_flutter_project/features/products/data/repositories/product_repository_impl.dart';
import 'package:dsi32_flutter_project/features/products/domain/repositories/product_repository.dart';
import 'package:dsi32_flutter_project/features/products/domain/usecases/add_product.dart';
import 'package:dsi32_flutter_project/features/products/domain/usecases/delete_product.dart';
import 'package:dsi32_flutter_project/features/products/domain/usecases/get_all_products.dart';
import 'package:dsi32_flutter_project/features/products/domain/usecases/update_product.dart';
import 'package:dsi32_flutter_project/features/products/presentation/blocs/addUpdateDeleteBloc/add_update_delete_product_bloc.dart';
import 'package:dsi32_flutter_project/features/products/presentation/blocs/productBloc/product_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'core/firebase/firebase_service.dart';
import 'features/auth/data/datasources/user_data_source.dart';
import 'features/auth/data/repositories/user_repository_impl.dart';
import 'features/auth/domain/repositories/user_repository.dart';
import 'features/auth/domain/usecases/register_user.dart';
import 'features/auth/domain/usecases/sign_in_user.dart';
import 'features/auth/domain/usecases/sign_out_user.dart';
import 'features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'features/auth/presentation/bloc/user_manager/user_manager_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
//! Features - posts

// Bloc

  sl.registerFactory(() => ProductBloc(getAllProducts: sl()));
  sl.registerFactory(() => AddUpdateDeleteProductBloc(addProductUsecase: sl(), deleteProductUsecase: sl(), updateProductUsecase: sl()));

   sl.registerLazySingleton(() => AuthBloc(
        signInUserUseCase: sl(),
        signOutUserUseCase: sl(),
      ));      

  sl.registerLazySingleton(() => UserManagerBloc(registerUserUseCase: sl()));

// Usecases

  sl.registerLazySingleton(() => GetAllProductsUsecase(sl()));
  sl.registerLazySingleton(() => AddProductUsecase(sl()));
  sl.registerLazySingleton(() => DeleteProductUsecase(sl()));
  sl.registerLazySingleton(() => UpdateProductUsecase(sl()));

  //auth
  sl.registerLazySingleton(() => RegisterUserUseCase(sl()));
  sl.registerLazySingleton(() => SignInUserUseCase(sl()));
  sl.registerLazySingleton(() => SignOutUserUseCase(sl()));


// Repository
  sl.registerLazySingleton<ProductsRepository>(() => ProductsRepositoryImpl(
      remoteDataSource: sl(), networkInfo: sl()));

        sl.registerLazySingleton<UserRepository>(
      () => UserRepositoryImpl(userDataSource: sl(), networkInfo: sl()));

// Datasources
  sl.registerLazySingleton<UserDataSource>(
      () => UserDataSourceImpl(firebaseService: sl()));

  sl.registerLazySingleton<ProductRemoteDataSource>(
      () => ProductRemoteDataSourceImpl(firestore: sl()));
//! Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

//! External
  final firebaseFireStore =  FirebaseFirestore.instance;
  sl.registerLazySingleton(() => firebaseFireStore);
  sl.registerLazySingleton(() => InternetConnectionChecker());

 sl.registerLazySingleton(() => AppRouter(sl()));

   final firebaseService = await FirebaseService.init();
  sl.registerLazySingleton(() => firebaseService);

}
