import 'package:go_router/go_router.dart';
import 'package:mobile_app/page/data%20add%20edit/add.dart';
import 'package:mobile_app/page/data%20add%20edit/edit.dart';
import 'package:mobile_app/page/home%20page/home.dart';
import 'package:mobile_app/page/login%20page/login.dart';

final GoRouter router = GoRouter(
  routes: <GoRoute>[
    GoRoute(path: '/', builder: (context, state) => const LoginPage()),
    GoRoute(path: '/home', builder: (context, state) => Home()),
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
