import 'dart:io';

import 'package:blog_app/core/error/failure.dart';
import 'package:blog_app/core/usecase/usecase.dart';
import 'package:blog_app/features/blog/domain/Repository/blog_repository.dart';
import 'package:blog_app/features/blog/domain/entities/blog.dart';
import 'package:fpdart/fpdart.dart';

class UploadBlog implements UseCase<Blog, UploadBlogParams> {
  final BlogRepository blogRepository;

  UploadBlog({required this.blogRepository});

  @override
  Future<Either<Failure, Blog>> call(UploadBlogParams params) async {
    return await blogRepository.uploadBlog(
      image: params.image,
      title: params.title,
      content: params.content,
      posterId: params.posterId,
      topics: params.topics,
    );
  }
}

class UploadBlogParams {
  final File image;
  final String title;
  final String content;
  final String posterId;
  final List<String> topics;
  UploadBlogParams({
    required this.image,
    required this.title,
    required this.content,
    required this.posterId,
    required this.topics,
  });
}
