import 'package:flutter/material.dart';
import 'package:testkey/cache/api_service.dart';
import 'package:testkey/cache/connectivity_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ApiService _apiService = ApiService();
  final ConnectivityService _connectivityService = ConnectivityService();

  List<dynamic> _posts = [];
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    _loadPosts();
    super.initState();
  }

  Future<void> _loadPosts() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });
    try {
      final isConnected = await _connectivityService.isConnected();

      if (isConnected) {
        await Future.delayed(const Duration(seconds: 3));
        final posts = await _apiService.fetchPosts(refresh: true);
        setState(() {
          _posts = posts;
        });
      } else {
        final cachePosts = await _apiService.fetchPosts(refresh: false);
        if (cachePosts.isNotEmpty) {
          setState(() {
            _posts = cachePosts;
          });
        } else {
          setState(() {
            _errorMessage = 'Invalid cache';
          });
        }
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'No data and connection';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Cache Example'),
        ),
        body: _isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : _errorMessage != null
                ? Center(
                    child: Text(
                      _errorMessage!,
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.red),
                    ),
                  )
                : ListView.builder(
                    itemCount: _posts.length,
                    itemBuilder: (context, index) {
                      final post = _posts[index];
                      return ListTile(
                        title: Text(post['title']),
                        subtitle: Text(post['body']),
                      );
                    },
                  ));
  }
}
