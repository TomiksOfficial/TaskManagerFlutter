import 'package:flutter/material.dart';
import '../viewmodels/fun_viewmodel.dart';
import '../widgets/custom_drawer.dart';

class FunScreen extends StatefulWidget {
  const FunScreen({super.key});

  @override
  State<FunScreen> createState() => _FunScreenState();
}

class _FunScreenState extends State<FunScreen> {
  final FunViewModel _viewModel = FunViewModel();

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Шутка')),
      drawer: CustomDrawer(),
      body: AnimatedBuilder(
        animation: _viewModel,
        builder: (context, _) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Card(
                  margin: EdgeInsets.all(24),
                  elevation: 4,
                  child: Padding(
                    padding: EdgeInsets.all(24),
                    child: _viewModel.isLoading
                        ? CircularProgressIndicator()
                        : Text(
                            _viewModel.currentQuote,
                            style: TextStyle(fontSize: 18),
                            textAlign: TextAlign.center,
                          ),
                  ),
                ),
                SizedBox(height: 16),
                ElevatedButton.icon(
                  onPressed: _viewModel.isLoading
                      ? null
                      : () {
                          _viewModel.fetchJoke();
                        },
                  icon: Icon(Icons.refresh),
                  label: Text('Обновить'),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
