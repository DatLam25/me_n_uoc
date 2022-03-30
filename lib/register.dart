part of menuoc;

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            }, //To Home Page
          ),
        ),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Text(
                "Registration",
                style: TextStyle(fontSize: 40, color: Colors.pink),
              ),
              const SizedBox(height: 20),
              const TextField(

                  decoration: InputDecoration(
                hintText: "Username",
                border: OutlineInputBorder(),
              )),
              const SizedBox(height: 10),
              const TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: "Password",
                    border: OutlineInputBorder(),
                  )),
              const SizedBox(height: 10),
              const TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: "Password confirm",
                    border: OutlineInputBorder(),
                  )),
              const SizedBox(height: 20),
              SizedBox(
                width: 200,
                child: TextButton(
                    style: TextButton.styleFrom(
                        textStyle: const TextStyle(fontSize: 20),
                        backgroundColor: Colors.black,
                        fixedSize: Size.infinite),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      "Submit",
                      style: TextStyle(fontSize: 30, color: Colors.white),
                    )),
              ),
            ],
          ),
        ));
  }
}
