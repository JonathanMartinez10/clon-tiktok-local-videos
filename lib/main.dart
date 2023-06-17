import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toktik/infrastructure/datasources/local_video_data_source_impl.dart';
import 'package:toktik/infrastructure/repositories/video_posts_repository_impl.dart';
import 'package:toktik/presentation/providers/discover_providers.dart';

import 'config/theme/app_theme.dart';
import 'presentation/screens/discover/discover_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    final videoPostRepository = VideoPostsRepositoryImpl(
      videosDatasource: LocalVideoDatasourceImpl(),
    );

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          lazy: false,
          create: (_) => DiscoverProvider(videoRepository: videoPostRepository)..loadNextPage()
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme().getTheme(),
        title: 'TokTik',
        home: const DiscoverScreen(),
      ),
    );
  }
}