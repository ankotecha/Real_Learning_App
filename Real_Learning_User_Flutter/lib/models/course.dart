import 'package:firebase_database/firebase_database.dart';

class Course {

  String courseName;
  String courseDescription;
  String courseImage;
  String courseOverView;
  Course( {this.courseName, this.courseDescription, this.courseImage});
}/*

  Course.fromSnapshot(DataSnapshot snapshot) :
  
        courseName = snapshot.value["courseName"],
        courseDescription = snapshot.value["courseDescription"],
        courseImage = snapshot.value["courseImage"];

  toJson() {
    return {
      "courseName": courseName,
      "courseDescription": courseDescription,
      "courseImage": courseImage,
    };
  }


static List<Course> allCourse()
{
  var lstOfCourse = new List<Course>();

  lstOfCourse.add(new Course(courseName:"CAT 2020",courseDescription: "CAT (Common Admission Test) is the premier all India management entrance exam conducted by IIMs. Last year 2,04,267 students competed for 1550+ seats making it the most competitive exam in the country. The IIMs are the premier management institutes in India established by an act of Parliament.",courseImage: "cat.png"));
   lstOfCourse.add(new Course(courseName:"GATE 2021",courseDescription: "To get IIT if you missed a chance at B.tech you can go through M.tech and for that GATE is compulsary.",courseImage: "cat.png"));
  return lstOfCourse;
}
}*/
