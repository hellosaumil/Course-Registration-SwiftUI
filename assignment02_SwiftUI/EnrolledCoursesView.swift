//
//  EnrolledCoursesView.swift
//  assignment02_SwiftUI
//
//  Created by Saumil Shah on 9/29/19.
//  Copyright © 2019 Saumil Shah. All rights reserved.
//

import SwiftUI


struct EnrolledCoursesView: View {
    
    @EnvironmentObject var userData: UserData
    @State var showingModal = false
    
    public var profileIcon: some View {
        Image(systemName: "person.crop.circle")
            .scaleEffect(1.6)
            .accessibility(label: Text("User Profile"))
    }
    
    var body: some View {
        
        NavigationView {
            
            VStack {
                
//                if userData.currentStudent.studentName == "" ||
//                    userData.currentStudent.studentRedID.count != 9 ||
//                    !userData.currentStudent.studentEmail.contains("@")
                    
                if userData.currentStudent.studentName == "" &&
                userData.currentStudent.studentEmail == "@"
                {
                    
                    VStack{
                        Text("No Student Record Found")
                            .font(.system(.body, design: .monospaced))
                            .padding(.top, 16)
                            .padding(.bottom, 8)
                        
                        Button(action: {
                            self.showingModal.toggle()
                        }) {
                            HStack {
                                profileIcon
                                    .padding(.trailing, 8)
                                Text("Create a New Student Profile")
                            }
                        }
                        .sheet(isPresented: $showingModal) {
                            UpdateProfileView(showingModal: self.$showingModal)
                                .environmentObject(self.userData)
                        }
                    }
                    
                }
                    
                else {
                    
                    VStack {
                        StudentInfoView()
                            .environmentObject(self.userData)
                        
                        Divider()
                        
                        if userData.currentStudent.courses.count == 0 {
                            Spacer()
                            
                            VStack {
                                Divider().padding(.bottom, 16)
                                
                                Text("No Courses Enrolled")
                                    .font(.system(.body, design: .monospaced))
                                    .padding(.bottom, 4)
                                
                                NavigationLink(destination:
                                    AvailableCoursesView()
                                        .environmentObject(self.userData)
                                ) {
                                    Text("Click Here to Add Courses")
                                        .font(.headline)
                                }
                            }
                            .padding(.bottom, 16)
                            
                        } else {
                            
                            List {
                                
                                ForEach(userData.currentStudent.courses, id: \.self) {course in
                                    
                                    
                                    CourseInfoView(courseInformation: course)
                                    
                                    //                                    Text("\(course.courseNumber)")
                                }
                            }
                            
                            NavigationLink(destination:
                                AvailableCoursesView()
                                    .environmentObject(self.userData)
                            ) {
                                Text("Update Courses")
                                    .font(.headline)
                            }
                        }
                    }
                    
                }
            }
            .navigationBarTitle(Text("Enrolled Classes"))
            
        }
        .navigationViewStyle(DefaultNavigationViewStyle())
    }
}


struct EnrolledCoursesView_Previews: PreviewProvider {
    static var previews: some View {
        EnrolledCoursesView()
            .environmentObject(UserData())
    }
}
