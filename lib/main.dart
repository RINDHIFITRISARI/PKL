import 'package:contoh/admin.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'Home.dart';
import 'register.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://spjdbxrtidsyqfjbocqk.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InNwamRieHJ0aWRzeXFmamJvY3FrIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTA0MDQyOTcsImV4cCI6MjAyNTk4MDI5N30.3FPicSbCvJzWEImz5W7byknO5YF_on80rnUuyqJNXI0',
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  bool isObscure = true;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  login() async {
    try {
      await Supabase.instance.client.auth.signInWithPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      if (!mounted) return;

      final user = Supabase.instance.client.auth.currentUser;

      if (user != null) {
        if (user.role == 'admin') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AdminDashboard()),
          );
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen()),
          );
        }
      }
    } on AuthException catch (e) {
      print(e);
      // Handle kesalahan autentikasi di sini
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network(
                'https://gvp.co.id/2021/Image/gvp.png',
              ),
              const SizedBox(height: 10),
              const Text(
                "Login",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "Mohon Masukan Email dan Password Anda",
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 13,
                ),
              ),
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(labelText: "Email"),
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: passwordController,
                obscureText: isObscure,
                decoration: InputDecoration(
                  labelText: 'Password',
                  suffixIcon: IconButton(
                    icon: Icon(
                      isObscure ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        isObscure = !isObscure;
                      });
                    },
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Email atau password tidak sesuai. Silakan coba lagi!!";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    login();
                  }
                },
                child: const SizedBox(
                  width: double.infinity,
                  child: Center(child: Text("Login")),
                ),
              ),
              SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Tidak punya akun?",
                    style: TextStyle(color: Colors.black26, fontSize: 16),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RegisterPage(),
                        ),
                      );
                    },
                    child: Text(
                      "Daftar Sekarang",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
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
