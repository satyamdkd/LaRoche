import 'package:laroch/const/common_lib.dart';
import '../../../utils/widgets/textfield.dart';

class TrackOrder extends StatefulWidget {
  const TrackOrder({super.key});

  @override
  State<TrackOrder> createState() => _TrackOrderState();
}

class _TrackOrderState extends State<TrackOrder> {
  @override
  void initState() {
    super.initState();
    ///fetchData();
  }

  List<MyModel> myTextMode = [];
  List<Model> myTextModeTwo = [];

  fetchData() async {
    for (int i = 0; i < 3; i++) {
      myTextMode.add(MyModel.initMyController());
    }

    for (int i = 0; i < 2; i++) {
      myTextModeTwo.add(Model(
          myModel: MyModel.initMyController(),
          subModel: MySubModel.initMyController()));
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body:  SafeArea(
        child: Padding(
          padding: EdgeInsets.all(12.0),
          child: Column(
            children: [
              // ...List.generate(
              //     myTextMode.length, (index) => buildsRow(myTextMode, index)),
              // SizedBox(
              //   height: 30.h,
              // ),
              // SizedBox(
              //   height: 100.h,
              // ),
              // ...List.generate(myTextModeTwo.length,
              //     (index) => buildsRow(myTextModeTwo, index)),
              // SizedBox(
              //   height: 30.h,
              // ),
              // OutlinedButton(
              //     onPressed: () {
              //       myTextModeTwo
              //           .add(Model(myModel: MyModel.initMyController()));
              //       debugPrint(myTextModeTwo[2].myModel.name.text);
              //     },
              //     child: Text(
              //       "add item in list two",
              //       style: theme.textTheme.bodyMedium
              //           ?.copyWith(color: appColors.red),
              //     )),
              // OutlinedButton(
              //     onPressed: () {
              //       debugPrint(myTextMode[2].name.text);
              //     },
              //     child: Text(
              //       "Get Data",
              //       style: theme.textTheme.bodyMedium
              //           ?.copyWith(color: appColors.red),
              //     ))
            ],
          ),
        ),
      ),
    );
  }

  buildsRow(list, index) {
    return Row(
      children: [
        Expanded(
          child: AppTextFormField(
            labelText: "Full Name",
            controller: list[index].myModel.name,
          ),
        ),
        SizedBox(
          width: 10.w,
        ),
        Expanded(
          child: AppTextFormField(
            labelText: "Description",
            controller: list[index].myModel.description,
          ),
        ),
      ],
    );
  }
}

class Model {
  late MyModel myModel;
  MySubModel? subModel;

  Model({required this.myModel, this.subModel});
}

class MyModel {
  late TextEditingController name;
  late TextEditingController description;

  MyModel.initMyController() {
    name = TextEditingController();
    description = TextEditingController();
  }
}

class MySubModel {
  late TextEditingController name;
  late TextEditingController description;

  MySubModel.initMyController() {
    name = TextEditingController();
    description = TextEditingController();
  }
}
