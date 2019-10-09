//
//  AvailableCoursesView.swift
//  assignment02_SwiftUI
//
//  Created by Saumil Shah on 10/4/19.
//  Copyright © 2019 Saumil Shah. All rights reserved.
//

import SwiftUI

struct AvailableCoursesView: View {
    
    @EnvironmentObject var userData: UserData
    @State var navTitle: navTitleType = .NoCourses
    
    var body: some View {
        
        Group {
            
            // MARK: Display a List of Available Courses
            List{
                ForEach(self.userData.availableCourses, id: \.self) { course in
                    
                    Button(action: {self.userData.isCourseSelected[course]?.toggle()}) {

                        HStack(alignment: .center) {

                            if (self.userData.isCourseSelected[course] ?? false) {
                                self.enrollStudent(courseToEnroll: course)
                            } else {
                                self.unenrollStudent(unenrollFromCourse: course)
                            }
                            Spacer().frame(width: 24)

                            CourseInfoView(courseInformation: course)

                        }
                        .padding(8)
                    }
                }
            }
            .onAppear(perform: {self.updateNavTitle()})
        }
        .navigationBarTitle(Text(self.navTitle.rawValue), displayMode: .inline)
        .onDisappear(perform:{ let _ = storeUpdatedUser(self.userData) })
    }
    
    private func updateNavTitle() {
        
        if self.userData.availableCourses.count == 0 {
            self.navTitle = navTitleType.NoCourses
        } else {
            self.navTitle = navTitleType.AvailableCourses
        }
    }
    
    private func enrollStudent(courseToEnroll: CourseInfo) -> some View {
        
        if !self.userData.currentStudent.courses.contains(courseToEnroll) {
            
            print("Enrolled in \(courseToEnroll.courseNumber)")
            self.userData.currentStudent.courses.append(courseToEnroll)
            
        } else {
            //            print("\tStudent already enrolled in \(courseToEnroll.courseNumber)...")
        }
        
        return Image(systemName: "checkmark.circle.fill")
            .foregroundColor(Color.yellow)
            .scaleEffect(1.8)
            .animation(.easeInOut)
    }
    
    private func unenrollStudent(unenrollFromCourse: CourseInfo) -> some View {
        
        if self.userData.currentStudent.courses.contains(unenrollFromCourse) {
            print("Unenrolled from \(unenrollFromCourse.courseNumber)")
            
            let courseIndex = self.userData.currentStudent.courses.firstIndex{ $0.courseNumber == unenrollFromCourse.courseNumber }
            
            self.userData.currentStudent.courses.remove(at: courseIndex!)
            
        } else {
//                        print("\tStudent wasn't enrolled in \(courseToEnroll.courseNumber)...")
        }
        
        return Image(systemName: "checkmark.circle")
            .foregroundColor(Color.gray.opacity(0.5))
            .scaleEffect(1.4)
            .animation(.easeInOut)
    }
    
}

struct AvailableCoursesView_Previews: PreviewProvider {
    
    static var previews: some View {
        
        AvailableCoursesView(navTitle: .NoCourses)
            .environmentObject(UserData())
            .previewDevice(PreviewDevice(rawValue: "iPhone XS"))
            .previewDisplayName("iPhone XS")
    }
}


/// Enum for Possible Navigation Titles based on Number of Courses
/// Conforms to String
///
/// - Cases:
///   - NoCourses: "No Courses"
///   - AvailableCourses: "Available Courses"
///
enum navTitleType:String {
    case NoCourses = "No Courses", AvailableCourses = "Available Courses"
}
