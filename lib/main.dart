import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'services/encryption_service.dart';
import 'services/storage_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final storageService = StorageService();

  if (!kIsWeb) {
    await storageService.init();
  } else {
    print('A aplicação está rodando na Web. O path_provider não é suportado.');
  }

  runApp(MyApp(storageService: storageService));
}

class MyApp extends StatelessWidget {
  final StorageService storageService;

  MyApp({required this.storageService});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Secure Password Manager',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PasswordManagerScreen(storageService: storageService),
    );
  }
}

class PasswordManagerScreen extends StatefulWidget {
  final StorageService storageService;

  PasswordManagerScreen({required this.storageService});

  @override
  _PasswordManagerScreenState createState() => _PasswordManagerScreenState();
}

class _PasswordManagerScreenState extends State<PasswordManagerScreen> {
  final encryptionService = EncryptionService();
  final passwordController = TextEditingController();
  final List<Map<String, String?>> passwordList = [];

  @override
  void initState() {
    super.initState();
    loadPasswords();
  }

  Future<void> loadPasswords() async {
    final keys = widget.storageService.getKeys();
    for (var key in keys) {
      final encryptedPassword = await widget.storageService.getPassword(key);
      if (encryptedPassword != null) {
        passwordList.add({'key': key, 'password': encryptedPassword});
      }
    }
    setState(() {});
  }

  String generateStrongPassword({int length = 12}) {
    const String lower = 'abcdefghijklmnopqrstuvwxyz';
    const String upper = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    const String numbers = '0123456789';
    const String symbols = '!@#\$%^&*()_+-=[]{}|;:,.<>?';

    const String allCharacters = lower + upper + numbers + symbols;
    final Random random = Random.secure();

    String password = lower[random.nextInt(lower.length)] +
        upper[random.nextInt(upper.length)] +
        numbers[random.nextInt(numbers.length)] +
        symbols[random.nextInt(symbols.length)];

    for (int i = 4; i < length; i++) {
      password += allCharacters[random.nextInt(allCharacters.length)];
    }

    return _shuffleString(password);
  }

  String _shuffleString(String input) {
    final Random random = Random();
    List<String> charList = input.split('');
    charList.shuffle(random);
    return charList.join('');
  }

  void savePassword() async {
    final encryptedPassword =
        encryptionService.encryptPassword(passwordController.text);
    final key = DateTime.now()
        .millisecondsSinceEpoch
        .toString(); // Chave única baseada no timestamp
    await widget.storageService.savePassword(key, encryptedPassword);
    passwordList.add({'key': key, 'password': encryptedPassword});
    passwordController.clear();
    setState(() {});
  }

  void deletePassword(String key) async {
    await widget.storageService.deletePassword(key);
    passwordList.removeWhere((item) => item['key'] == key);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gerenciador de senhas'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: 'Digite a senha'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: savePassword,
              child: Text('Salvar Senha'),
            ),
            ElevatedButton(
              onPressed: () {
                final strongPassword = generateStrongPassword();
                passwordController.text = strongPassword;
              },
              child: Text('Gerar Senha Forte'),
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: passwordList.length,
                itemBuilder: (context, index) {
                  final item = passwordList[index];
                  return ListTile(
                    title: Text(item['key'] ?? ''),
                    subtitle: Text(item['password'] ?? ''),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.visibility),
                          onPressed: () {
                            final decryptedPassword = encryptionService
                                .decryptPassword(item['password']!);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text('Senha: $decryptedPassword')),
                            );
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () => deletePassword(item['key']!),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
