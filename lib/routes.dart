import 'package:go_router/go_router.dart';
import 'package:mobile_app/add.dart';
import 'package:mobile_app/edit.dart';
import 'package:mobile_app/home.dart';

final GoRouter router = GoRouter(
  routes: <GoRoute>[
    GoRoute(path: '/', builder: (context, state) => Home()),
    GoRoute(path: '/add', builder: (context, state) => AddDetails()),
    GoRoute(
      path: '/edit/:id',
      builder: (context, state) {
        final id = state.pathParameters['id']!;
        return EditDetails(id: id);
      },
    ),
  ],
);
