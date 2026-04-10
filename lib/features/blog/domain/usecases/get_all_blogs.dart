import 'package:blog_app/core/error/failure.dart';
import 'package:blog_app/core/usecase/usecase.dart';
import 'package:blog_app/features/blog/domain/Repository/blog_repository.dart';
import 'package:blog_app/features/blog/domain/entities/blog.dart';
import 'package:fpdart/fpdart.dart';

class GetAllBlogs implements UseCase<List<Blog>, NoParams> {
  final BlogRepository blogRepository;
  GetAllBlogs({required this.blogRepository});
  @override
  Future<Either<Failure, List<Blog>>> call(NoParams params) {
    return blogRepository.getAllBlogs();
  }
}
