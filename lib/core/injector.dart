import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Injector extends StatefulWidget {
  const Injector({super.key, required this.child});
  final Widget child;

  @override
  // ignore: library_private_types_in_public_api
  _InjectorState createState() => _InjectorState();
}

class _InjectorState extends State<Injector> {
  @override
  Widget build(BuildContext context) {
    return ProviderScope(child: widget.child);
  }
}
