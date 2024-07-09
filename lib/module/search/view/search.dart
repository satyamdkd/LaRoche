import 'package:laroch/const/common_lib.dart';
import 'package:laroch/module/details/view/details.dart';
import '../bloc/search_bloc.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  TextEditingController search = TextEditingController();
  @override
  SearchListController searchController = SearchListController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              margin: EdgeInsets.symmetric(horizontal: 15.w),
              decoration: BoxDecoration(
                  color: appColors.red.withOpacity(0.07),
                  borderRadius: BorderRadius.circular(5.r)),
              child: TextField(
                controller: search,
                onChanged: (value) {
                  Future.delayed(
                    Duration.zero,
                    () {
                      if (search.text.length > 3) {
                        searchController.search(
                          context,
                          parameters: {"search": search.text},
                          callBack: () => setState(() {}),
                        );
                      }
                    },
                  );
                },
                maxLines: 1,
                decoration: const InputDecoration(
                  hintText: 'Search',
                  border: InputBorder.none,
                  suffixIcon: Icon(Icons.search),
                  focusedBorder: InputBorder.none,
                ),
              ),
            ),
            if (searchController.isLoading)
              LinearProgressIndicator(
                color: appColors.red,
                backgroundColor: appColors.white,
              ),
            (searchController.searchModel?.data != null)
                ? Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.w),
                    child: Container(
                      height: MediaQuery.of(context).size.height - 150,
                      margin: EdgeInsets.only(top: 10.w),
                      padding: EdgeInsets.all(16.w),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF3F7F6),
                        borderRadius: BorderRadius.circular(2.r),
                      ),
                      child: SingleChildScrollView(
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: searchController.searchModel!.data!.length,
                          itemBuilder: (BuildContext context, int index) {
                            return SizedBox(
                              height: 70,
                              child: Column(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => Details(
                                            productId:
                                                '${searchController.searchModel!.data![index].id}',
                                          ),
                                        ),
                                      );
                                    },
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: 60.w,
                                          width: 60.w,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: NetworkImage(
                                                searchController
                                                        .searchModel!
                                                        .data![index]
                                                        .imagePath ??
                                                    "",
                                              ),
                                              fit: BoxFit.cover,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(12.r),
                                          ),
                                        ),
                                        SizedBox(width: 16.w),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                searchController.searchModel!
                                                        .data![index].name ??
                                                    "",
                                                maxLines: 2,
                                                style: const TextStyle(
                                                    color: Colors.black),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  if (index !=
                                      searchController
                                              .searchModel!.data!.length -
                                          1)
                                    const Divider(),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  )
                : Container(
                    height: 2.h,
                  )
          ],
        ),
      ),
    );
  }
}
