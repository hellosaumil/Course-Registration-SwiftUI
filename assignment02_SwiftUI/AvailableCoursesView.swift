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
    
    
    private func enrollStudent(courseToEnroll: CourseInfo) -> some View {
        
        if !self.userData.currentStudent.courses.contains(courseToEnroll) {
            
            print("Enrolled in \(courseToEnroll.courseNumber)")
            self.userData.currentStudent.courses.append(courseToEnroll)
            
        } else {
            print("\tStudent already enrolled in \(courseToEnroll.courseNumber)...")
        }
        
        return Image(systemName: "checkmark.circle.fill")
            .foregroundColor(Color.yellow)
            .scaleEffect(1.45)
    }
    
    private func unenrollStudent(courseToEnroll: CourseInfo) -> some View {
        
        if self.userData.currentStudent.courses.contains(courseToEnroll) {
            print("Unenrolled from \(courseToEnroll.courseNumber)")
            
            let courseIndex = self.userData.currentStudent.courses.firstIndex{ $0.id == courseToEnroll.id }
            
            self.userData.currentStudent.courses.remove(at: courseIndex!)
            
        } else {
            print("\tStudent wasn't enrolled in \(courseToEnroll.courseNumber)...")
        }
        
        return Image(systemName: "checkmark.circle")
            .foregroundColor(Color.gray.opacity(0.5))
            .scaleEffect(1.15)
    }
    
    var body: some View {
        
        NavigationView {
            
            if userData.availableCourses.count == 0 {
                ScrollView {
                    Spacer()
                    Divider()
                    
                    Text("No Courses Available")
                        .font(.system(.body, design: .monospaced))
                        .offset(y: 30)
                }
                .navigationBarTitle("No Courses")
                
            } else {
                
                List{
                    ForEach(userData.availableCourses, id: \.self) { course in
                        Button(action: {self.userData.isCourseSelected[course]?.toggle()}) {
                            HStack(alignment: .center, spacing: 2) {
                                
                                if self.userData.isCourseSelected[course]! {
                                    
                                    self.enrollStudent(courseToEnroll: course)
                                    
                                } else {
                                    
                                    self.unenrollStudent(courseToEnroll: course)
                                    
                                }
                                CourseInfoView(courseInformation: course)
                            }
                            .padding(.leading, 16)
                        }
                    }
                }
                .navigationBarTitle(Text("Available Courses"))
            }
        }
        .navigationViewStyle(DefaultNavigationViewStyle())
    }
}

struct AvailableCoursesView_Previews: PreviewProvider {
    
    static var previews: some View {
        
        AvailableCoursesView()
            .environmentObject(UserData())
    }
}
