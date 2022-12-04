import 'package:dawu_start_from_homescreen/models/Contest.dart';

import '../models/ContestInfo.dart';

class ContestListApi {
  static Contest dummyItem = Contest(
      id: -1,
      thumbnail: "",
      title: "",
      subtitle: "",
      contestInfo: ContestInfo(
          description: "",
          field: "",
          minPeople: -1,
          maxPeople: -1,
          activityStartPeriod: DateTime(1970),
          activityDuePeriod: DateTime(1970),
          registerStartPeriod: DateTime(1970),
          registerDuePeriod: DateTime(1970)));

  static List<Contest> contests = [
    Contest(
        id: 1,
        thumbnail:
            "https://scene7.samsclub.com/is/image/samsclub/0008687619434_B?wid=400&hei=400",
        title: "대학생 프로그래밍 경진대회",
        subtitle: "백엔드 모바일",
        contestInfo: ContestInfo(
            description: "창의적 아이디어를 활용한 앱 개발 경진대회 참여자를 모집합니다.",
            field: "백엔드 모바일",
            minPeople: 2,
            maxPeople: 4,
            activityStartPeriod: DateTime(2022, 11, 22),
            activityDuePeriod: DateTime(2022, 11, 30),
            registerStartPeriod: DateTime(2022, 11, 9, 0, 0),
            registerDuePeriod: DateTime(2022, 11, 11, 23, 59))),
  ];

  static int getContestListCount() {
    return contests.length;
  }

  static List<Contest> getContestList() {
    return contests;
  }

  static void addContest(Contest contest) {
    contests.add(contest);
  }

  static Contest getContest(int idx) {
    if (idx > contests.length) {
      return dummyItem;
    }
    return contests[idx];
  }
}
