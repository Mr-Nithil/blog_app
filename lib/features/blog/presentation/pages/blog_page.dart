import 'package:blog_app/core/utils/show_snackbar.dart';
import 'package:blog_app/core/cubits/app_user/app_user_cubit.dart';
import 'package:blog_app/core/cubits/theme/theme_cubit.dart';
import 'package:blog_app/core/widgets/app_brand.dart';
import 'package:blog_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog_app/features/auth/presentation/pages/login_page.dart';
import 'package:blog_app/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:blog_app/features/blog/presentation/pages/add_blog_page.dart';
import 'package:blog_app/features/blog/presentation/widgets/blog_card.dart';
import 'package:blog_app/features/blog/presentation/widgets/blog_card_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum _BlogPageMenuAction { toggleTheme, signOut }

class BlogPage extends StatefulWidget {
  static rout() => MaterialPageRoute(builder: (context) => BlogPage());
  const BlogPage({super.key});

  @override
  State<BlogPage> createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
  Future<void> _openAddBlogPage() async {
    await Navigator.push(context, AddBlogPage.route());
    if (!mounted) return;
    context.read<BlogBloc>().add(BlogGetAll());
  }

  @override
  void initState() {
    super.initState();
    context.read<BlogBloc>().add(BlogGetAll());
  }

  @override
  Widget build(BuildContext context) {
    final appUserState = context.watch<AppUserCubit>().state;
    final userName = appUserState is AppUserLoggedIn
        ? appUserState.user.name
        : 'Blog User';
    final userEmail = appUserState is AppUserLoggedIn
        ? appUserState.user.email
        : 'user@example.com';

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthFailure) {
          showSnackBar(context, state.message);
        } else if (state is AuthSignOutSuccess) {
          Navigator.pushAndRemoveUntil(
            context,
            LoginPage.route(),
            (route) => false,
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const AppBrand(compact: true),
          actions: [
            BlocBuilder<ThemeCubit, ThemeMode>(
              builder: (context, mode) {
                final isDark =
                    mode == ThemeMode.dark ||
                    (mode == ThemeMode.system &&
                        Theme.of(context).brightness == Brightness.dark);

                return PopupMenuButton<_BlogPageMenuAction>(
                  tooltip: 'Open menu',
                  icon: const Icon(Icons.menu_rounded),
                  position: PopupMenuPosition.under,
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                    side: BorderSide(
                      color: Theme.of(context).colorScheme.outline,
                    ),
                  ),
                  constraints: const BoxConstraints(
                    minWidth: 240,
                    maxWidth: 240,
                  ),
                  color: Theme.of(context).colorScheme.surface,
                  onSelected: (value) {
                    if (value == _BlogPageMenuAction.toggleTheme) {
                      context.read<ThemeCubit>().toggleTheme();
                    }

                    if (value == _BlogPageMenuAction.signOut) {
                      context.read<AuthBloc>().add(AuthSignOut());
                    }
                  },
                  itemBuilder: (context) => [
                    PopupMenuItem<_BlogPageMenuAction>(
                      enabled: false,
                      height: 124,
                      padding: const EdgeInsets.fromLTRB(14, 12, 14, 6),
                      child: SizedBox(
                        width: double.infinity,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              radius: 24,
                              backgroundColor: Theme.of(
                                context,
                              ).colorScheme.primaryContainer,
                              foregroundColor: Theme.of(
                                context,
                              ).colorScheme.primary,
                              child: const Icon(Icons.person_rounded, size: 24),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              userName,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              userEmail,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const PopupMenuDivider(),
                    PopupMenuItem<_BlogPageMenuAction>(
                      height: 44,
                      value: _BlogPageMenuAction.toggleTheme,
                      child: ListTile(
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                        minLeadingWidth: 0,
                        leading: Icon(
                          isDark
                              ? Icons.light_mode_rounded
                              : Icons.dark_mode_rounded,
                          size: 20,
                        ),
                        title: Text(
                          isDark
                              ? 'Switch to light mode'
                              : 'Switch to dark mode',
                        ),
                      ),
                    ),
                    PopupMenuItem<_BlogPageMenuAction>(
                      height: 44,
                      value: _BlogPageMenuAction.signOut,
                      child: const ListTile(
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                        minLeadingWidth: 0,
                        leading: Icon(Icons.logout_rounded, size: 20),
                        title: Text('Sign out'),
                      ),
                    ),
                  ],
                );
              },
            ),
            const SizedBox(width: 8),
          ],
        ),
        body: BlocConsumer<BlogBloc, BlogState>(
          listener: (context, state) {
            if (state is BlogFailure) {
              showSnackBar(context, state.message);
            }
          },
          builder: (context, state) {
            if (state is BlogInitial || state is BlogLoading) {
              return ListView.builder(
                padding: const EdgeInsets.only(top: 12),
                itemCount: 5,
                itemBuilder: (context, index) {
                  return const BlogCardShimmer();
                },
              );
            }
            if (state is BlogDisplaySuccess) {
              if (state.blogs.isEmpty) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.article_outlined,
                          size: 56,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No blogs yet',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Create the first post to start the feed.',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(
                                color: Theme.of(
                                  context,
                                ).textTheme.bodySmall?.color,
                              ),
                        ),
                      ],
                    ),
                  ),
                );
              }
              return RefreshIndicator(
                color: Theme.of(context).colorScheme.primary,
                onRefresh: () async {
                  context.read<BlogBloc>().add(BlogGetAll());
                },
                child: ListView.builder(
                  padding: const EdgeInsets.only(top: 12),
                  itemCount: state.blogs.length,
                  itemBuilder: (context, index) {
                    final blog = state.blogs[index];
                    return BlogCard(blog: blog);
                  },
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(right: 16),
          child: FloatingActionButton(
            tooltip: 'Create blog',
            onPressed: _openAddBlogPage,
            backgroundColor: Theme.of(context).colorScheme.primary,
            foregroundColor: Theme.of(context).colorScheme.onPrimary,
            child: const Icon(Icons.add_rounded),
          ),
        ),
      ),
    );
  }
}
