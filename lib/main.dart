import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// ==================== NC1: SÁNG / TỐI ====================

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _mode = ThemeMode.light;

  void _changeTheme() {
    setState(() {
      _mode = _mode == ThemeMode.light
          ? ThemeMode.dark
          : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'F1_231a290086',
      debugShowCheckedModeBanner: false,

      // Giao diện sáng
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.indigo,
        ),
      ),

      // Giao diện tối
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.indigo,
          brightness: Brightness.dark,
        ),
      ),

      // Chọn giao diện hiện tại
      themeMode: _mode,

      home: ProfilePage(
        onChangeTheme: _changeTheme,
      ),
    );
  }
}

// ==================== PROFILE PAGE ====================

class ProfilePage extends StatefulWidget {
  const ProfilePage({
    super.key,
    required this.onChangeTheme,
  });

  final VoidCallback onChangeTheme;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int _likes = 0;

  // ==================== NC2: KỸ NĂNG ====================

  final List<String> _skills = [
    'Java',
    'Dart',
    'SQL',
    'Git',
    'UI/UX',
  ];

  final Set<String> _selectedSkills = {};

  void _toggleSkill(String skill) {
    setState(() {
      if (_selectedSkills.contains(skill)) {
        _selectedSkills.remove(skill);
      } else {
        _selectedSkills.add(skill);
      }
    });
  }

  // ==================== LIKE ====================

  void _increase() {
    setState(() {
      _likes++;
    });
  }

  void _decrease() {
    setState(() {
      if (_likes > 0) {
        _likes--;
      }
    });
  }

  void _reset() {
    setState(() {
      _likes = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    final likeColor =
        _likes >= 10 ? Colors.red : scheme.primary;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lab F1 – 231A290086'),
        backgroundColor: scheme.primaryContainer,

        // ==================== NC1 ====================
        actions: [
          IconButton(
            onPressed: widget.onChangeTheme,
            icon: Icon(
              Theme.of(context).brightness == Brightness.light
                  ? Icons.dark_mode
                  : Icons.light_mode,
            ),
            tooltip: 'Đổi giao diện',
          ),
        ],
      ),

      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),

          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [

              // ==================== HỒ SƠ ====================

              const ProfileCard(
                name: 'Nguyễn Công Hòa',
                studentId: '231A290086',
                className: 'Lớp CNTT – LTDD',
              ),

              const SizedBox(height: 20),

              // ==================== NC2 ====================

              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Kỹ năng',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(height: 10),

              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: _skills.map((skill) {
                  return FilterChip(
                    label: Text(skill),
                    selected: _selectedSkills.contains(skill),
                    onSelected: (_) {
                      _toggleSkill(skill);
                    },
                  );
                }).toList(),
              ),

              const SizedBox(height: 12),

              Text(
                'Đã chọn: ${_selectedSkills.length} kỹ năng',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 24),

              // ==================== LIKE ====================

              Text(
                'Lượt thích: $_likes',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: likeColor,
                ),
              ),

              const SizedBox(height: 16),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  IconButton.filledTonal(
                    onPressed: _decrease,
                    icon: const Icon(Icons.remove),
                  ),

                  const SizedBox(width: 12),

                  FilledButton.icon(
                    onPressed: _increase,
                    icon: const Icon(Icons.favorite),
                    label: const Text('Thích'),
                  ),

                  const SizedBox(width: 12),

                  IconButton.outlined(
                    onPressed: _reset,
                    icon: const Icon(Icons.refresh),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ==================== PROFILE CARD ====================

class ProfileCard extends StatelessWidget {
  const ProfileCard({
    super.key,
    required this.name,
    required this.studentId,
    required this.className,
  });

  final String name;
  final String studentId;
  final String className;

  @override
  Widget build(BuildContext context) {
    final initial =
        name.trim().split(' ').last.substring(0, 1);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [

            CircleAvatar(
              radius: 40,
              child: Text(
                initial,
                style: const TextStyle(
                  fontSize: 32,
                ),
              ),
            ),

            const SizedBox(height: 12),

            Text(
              name,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge,
            ),

            Text('MSSV: $studentId'),

            Text(className),
          ],
        ),
      ),
    );
  }
}