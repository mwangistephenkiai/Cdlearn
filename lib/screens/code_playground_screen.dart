import 'package:flutter/material.dart';
import 'package:flutter_highlight/flutter_highlight.dart';
import 'package:flutter_highlight/themes/atom-one-dark.dart';

class CodePlaygroundScreen extends StatefulWidget {
  const CodePlaygroundScreen({super.key});

  @override
  State<CodePlaygroundScreen> createState() => _CodePlaygroundScreenState();
}

class _CodePlaygroundScreenState extends State<CodePlaygroundScreen> {
  final TextEditingController _controller = TextEditingController();
  String _language = 'javascript';

  final Map<String, String> _examples = {
    'html': '''<!DOCTYPE html>
<html>
<body>
  <h1>Hello World</h1>
  <p>Welcome to HTML!</p>
</body>
</html>''',
    'javascript': '''function greet(name) {
  return `Hello, \${name}!`;
}

console.log(greet("Developer"));''',
    'php': '''<?php
function greet($name) {
    return "Hello, " . $name . "!";
}

echo greet("Developer");
?>''',
  };

  @override
  void initState() {
    super.initState();
    _controller.text = _examples[_language]!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Code Playground')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: SegmentedButton<String>(
              segments: const [
                ButtonSegment(value: 'html', label: Text('HTML')),
                ButtonSegment(value: 'javascript', label: Text('JS')),
                ButtonSegment(value: 'php', label: Text('PHP')),
              ],
              selected: {_language},
              onSelectionChanged: (set) {
                setState(() {
                  _language = set.first;
                  _controller.text = _examples[_language]!;
                });
              },
            ),
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                controller: _controller,
                maxLines: null,
                expands: true,
                style: const TextStyle(fontFamily: 'monospace', fontSize: 13),
                decoration: InputDecoration(
                  hintText: 'Write your code here...',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  filled: true,
                ),
                onChanged: (_) => setState(() {}),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(16),
            child: Row(
              children: [Icon(Icons.preview, size: 20), SizedBox(width: 8), Text('Preview', style: TextStyle(fontWeight: FontWeight.bold))],
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              decoration: BoxDecoration(color: const Color(0xFF282C34), borderRadius: BorderRadius.circular(12)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: HighlightView(
                    _controller.text,
                    language: _language == 'html' ? 'xml' : _language,
                    theme: atomOneDarkTheme,
                    textStyle: const TextStyle(fontFamily: 'monospace', fontSize: 13),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
