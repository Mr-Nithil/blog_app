import 'package:blog_app/config/env/env.dart';
import 'package:blog_app/core/cubits/app_user/app_user_cubit.dart';
import 'package:blog_app/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:blog_app/features/auth/data/repository/auth_repository_impl.dart';
import 'package:blog_app/features/auth/domain/repository/auth_repository.dart';
import 'package:blog_app/features/auth/domain/usecases/current_user.dart';
import 'package:blog_app/features/auth/domain/usecases/user_login.dart';
import 'package:blog_app/features/auth/domain/usecases/user_signup.dart';
import 'package:blog_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog_app/features/blog/data/Repository/blog_repository_impl.dart';
import 'package:blog_app/features/blog/data/datasources/blog_remote_data_source.dart';
import 'package:blog_app/features/blog/domain/Repository/blog_repository.dart';
import 'package:blog_app/features/blog/domain/usecases/get_all_blogs.dart';
import 'package:blog_app/features/blog/domain/usecases/upload_blog.dart';
import 'package:blog_app/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  await dotenv.load(fileName: '.env');
  final supabase = await Supabase.initialize(
    url: Env.url,
    anonKey: Env.anonKey,
  );

  serviceLocator.registerLazySingleton(() => supabase.client);

  serviceLocator.registerLazySingleton(() => AppUserCubit());

  _initAuth();
  _initBlog();
}

void _initAuth() {
  serviceLocator.registerFactory<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(supabaseClient: serviceLocator()),
  );

  serviceLocator.registerFactory<AuthRepository>(
    () => AuthRepositoryImpl(authRemoteDataSource: serviceLocator()),
  );

  serviceLocator.registerFactory(
    () => UserSignup(authRepository: serviceLocator()),
  );

  serviceLocator.registerFactory(
    () => UserLogin(authRepository: serviceLocator()),
  );

  serviceLocator.registerFactory(
    () => CurrentUser(authRepository: serviceLocator()),
  );

  serviceLocator.registerLazySingleton(
    () => AuthBloc(
      userSignup: serviceLocator(),
      userLogin: serviceLocator(),
      currentUser: serviceLocator(),
      appUserCubit: serviceLocator(),
    ),
  );
}

void _initBlog() {
  serviceLocator.registerFactory<BlogRemoteDataSource>(
    () => BlogRemoteDataSourceImpl(supabaseClient: serviceLocator()),
  );

  serviceLocator.registerFactory<BlogRepository>(
    () => BlogRepositoryImpl(blogRemoteDataSource: serviceLocator()),
  );

  serviceLocator.registerFactory(
    () => UploadBlog(blogRepository: serviceLocator()),
  );

  serviceLocator.registerFactory(
    () => GetAllBlogs(blogRepository: serviceLocator()),
  );

  serviceLocator.registerLazySingleton(
    () => BlogBloc(uploadBlog: serviceLocator(), getAllBlogs: serviceLocator()),
  );
}
