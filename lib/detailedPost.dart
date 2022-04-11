part of menuoc;

class DetailedPost extends StatelessWidget {
  const DetailedPost(this.index, this.item, {Key? key}) : super(key: key);

  final int index;
  final Post item;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(item.title),
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
                          child: Text(
                            item.content,
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
