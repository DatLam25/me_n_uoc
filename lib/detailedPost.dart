part of menuoc;

class DetailedPost extends StatelessWidget {
  DetailedPost(this.index);

  final int index;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Title"),
      ),
      body: Column(
            children: <Widget>[
              Expanded(
                    child: ListView(
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.all(5),
                          color: Colors.pink[50],
                          alignment: Alignment.topLeft,
                          child: const Text(
                            "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Cursus vitae congue mauris rhoncus aenean vel elit scelerisque. Risus feugiat in ante metus dictum at. Sed euismod nisi porta lorem. Ullamcorper sit amet risus nullam eget felis eget. Vel quam elementum pulvinar etiam non quam. Blandit turpis cursus in hac. Volutpat blandit aliquam etiam erat velit scelerisque in dictum. Neque sodales ut etiam sit. Ultricies integer quis auctor elit sed.",
                            style: TextStyle(fontSize: 25),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          padding: const EdgeInsets.all(5),
                          color: Colors.blueGrey[100],
                          alignment: Alignment.topLeft,
                          child: const Text(
                            "Comment",
                            style: TextStyle(fontSize: 25),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          padding: const EdgeInsets.all(5),
                          color: Colors.blueGrey[100],
                          alignment: Alignment.topLeft,
                          child: const Text(
                            "Comment",
                            style: TextStyle(fontSize: 25),
                          ),
                        ),
                      ],
                    ),
              ),
              Container(
                  padding: const EdgeInsets.symmetric(vertical: 2.0),
                  child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                    // First child is enter comment text input
                    Expanded(
                      child: TextFormField(
                        autocorrect: true,
                        decoration: const InputDecoration(
                          hintText: "Comment",
                          border: OutlineInputBorder(
                            // borderRadius:
                            //     BorderRadius.all(Radius.zero(5.0)),
                              borderSide: BorderSide(color: Colors.black)),
                        ),
                      ),
                    ),
                    // Second child is button
                    IconButton(
                      icon: const Icon(Icons.send),
                      color: Colors.black,
                      iconSize: 20.0,
                      onPressed: () {},
                    )
                  ])),
            ],
        ),
    );
  }
}
