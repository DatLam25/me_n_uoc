part of menuoc;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const _pageSize = 10;
  List<String> communities = [];
  String currentCommunity = "";

  String loremIpsum =
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Cursus vitae congue mauris rhoncus aenean vel elit scelerisque. Risus feugiat in ante metus dictum at. Sed euismod nisi porta lorem. Ullamcorper sit amet risus nullam eget felis eget. Vel quam elementum pulvinar etiam non quam. Blandit turpis cursus in hac. Volutpat blandit aliquam etiam erat velit scelerisque in dictum. Neque sodales ut etiam sit. Ultricies integer quis auctor elit sed.";

  final PagingController<int, Post> _pagingController =
      PagingController(firstPageKey: 0);

  _communityFetch() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    //TODO: Add fetch community by user
    List<String> newData = List.generate(5, (index) => "Community $index");
    setState(() {
      communities = newData;
      currentCommunity = communities[0];
    });
  }

  Future<void> _pageFetch(int pageKey) async {
    await Future.delayed(const Duration(milliseconds: 1000));
    //TODO: Fetch Post by Communities
    List<Post> newData = pageKey >= 100
        ? []
        : List.generate(
            _pageSize,
            (index) => Post("Title ${index + pageKey}", loremIpsum,
                index + pageKey, "Creator ${index + pageKey}"));

    final isLastPage = newData.length < _pageSize;
    if (isLastPage) {
      _pagingController.appendLastPage(newData);
    } else {
      final nextPageKey = pageKey + newData.length;
      _pagingController.appendPage(newData, nextPageKey);
    }
  }

  Future<void> _refresh() async {
    setState(() {
      _pagingController.refresh();
    });
  }

  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener((pageKey) {
      _pageFetch(pageKey);
    });
    _communityFetch();
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _refresh,
      child: Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
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
              title: globals.currentUser.isAdmin
                  ? const Text(
                      'Admin Home Page',
                      style: TextStyle(color: Colors.pinkAccent),
                    )
                  : const Text(
                      'Home Page',
                      style: TextStyle(color: Colors.pinkAccent),
                    ),
              actions: [
                globals.currentUser.isLoggedIn
                    ? IconButton(
                        onPressed: () {
                          if (globals.currentUser.isAdmin) {
                            Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const AdminPage()))
                                .then((_) => setState(() {}));
                          } else {
                            Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const ProfilePage()))
                                .then((_) => setState(() {}));
                          }
                        },
                        icon: const Icon(Icons.account_circle),
                        color: Colors.pinkAccent,
                      )
                    : IconButton(
                        onPressed: () {
                          Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const LoginPage()))
                              .then((_) => setState(() {}));
                        },
                        icon: const Icon(Icons.login),
                        color: Colors.pinkAccent,
                      ),
              ],
              bottom: AppBar(
                title: communities.isEmpty
                      ? const Center(child: CircularProgressIndicator())
                      : DropdownButtonFormField<String>(
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  const BorderSide(color: Colors.white, width: 2),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            border: OutlineInputBorder(
                              borderSide:
                                  const BorderSide(color: Colors.white, width: 2),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                          ),
                          dropdownColor: Colors.white,
                          value: currentCommunity,
                          icon: const Icon(Icons.arrow_downward),
                          elevation: 16,
                          style: const TextStyle(color: Colors.black),
                          onChanged: (String? newValue) {
                            setState(() {
                              currentCommunity = newValue!;
                              _pagingController.refresh();
                            });
                          },
                          items: communities
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),

              ),
            ),
            PagedSliverList<int, Post>(
                pagingController: _pagingController,
                builderDelegate: PagedChildBuilderDelegate<Post>(
                  itemBuilder: (BuildContext context, Post item, int index) {
                    return Stack(
                      children: <Widget>[
                        Card(
                          child: Column(
                            //mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Container(
                                padding: const EdgeInsets.all(5),
                                color: randomColor(index),
                                height: 35.0,
                                alignment: Alignment.topLeft,
                                child: Text(
                                  item.title,
                                  style: const TextStyle(fontSize: 25),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.all(5),
                                color: randomColor(index),
                                height: 140.0,
                                alignment: Alignment.topLeft,
                                child: Text(
                                  item.content,
                                  style: const TextStyle(fontSize: 25),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Positioned.fill(
                            child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                      return DetailedPost(index, item);
                                    })).then((_) => setState(() {
                                          _pagingController.refresh();
                                        }));
                                  }, //Go to the Specific Post Page
                                )))
                      ],
                    );
                  },
                ))
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const ChatPage()));
          }, //To Chat Page
          tooltip: 'Open Chat',
          child: const Icon(Icons.chat),
          backgroundColor: Colors.pink.shade200,
        ),
      ),
    );
  }
}
