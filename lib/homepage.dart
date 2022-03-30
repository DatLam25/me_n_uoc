part of menuoc;


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {


    const loremIpsum =
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Cursus vitae congue mauris rhoncus aenean vel elit scelerisque. Risus feugiat in ante metus dictum at. Sed euismod nisi porta lorem. Ullamcorper sit amet risus nullam eget felis eget. Vel quam elementum pulvinar etiam non quam. Blandit turpis cursus in hac. Volutpat blandit aliquam etiam erat velit scelerisque in dictum. Neque sodales ut etiam sit. Ultricies integer quis auctor elit sed.";

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            leading: IconButton(
              icon: SvgPicture.asset(
                logoAsset,
                semanticsLabel: "Me&UofC",
              ),
              onPressed: () {}, //To Home Page
            ),
            floating: true,
            pinned: true,
            snap: false,
            centerTitle: true,
            title: const Text(
              'Home Page',
              style: TextStyle(color: Colors.pinkAccent),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.login),
                color: Colors.pinkAccent,
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const LoginPage())
                  );
                }, //To Login
              )
            ],
            bottom: AppBar(
              title: Container(
                width: MediaQuery.of(context).size.width,
                height: 40,
                color: Colors.white,
                child: const Center(
                    child: Text(
                      "Dashboard Header",
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    )),
              ),
            ),
          ),
          SliverList(
            //itemExtent: 200.0,
              delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                  return Stack(
                    children: <Widget>[
                      Card(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Container(
                              padding: const EdgeInsets.all(5),
                              color: Colors.pink[50],
                              height: 35.0,
                              alignment: Alignment.topLeft,
                              child: Text(
                                'Title $index',
                                style: const TextStyle(fontSize: 25),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(5),
                              color: Colors.pink[50],
                              height: 140.0,
                              alignment: Alignment.topLeft,
                              child: const Text(
                                loremIpsum,
                                style: TextStyle(fontSize: 25),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned.fill(
                          child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () {}, //Go to the Specific Post Page
                              )
                          )
                      )
                    ],
                  );
                },
                childCount: 20,
              ))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const ChatPage()));
        }, //To Chat Page
        tooltip: 'Open Chat',
        child: const Icon(Icons.chat),
        backgroundColor: Colors.pink.shade200,
      ),
    );
  }
}