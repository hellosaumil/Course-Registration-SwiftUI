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
    
    var body: some View {
        
        NavigationView {
            
            VStack {
                
                // MARK: Check if No Valid Student Info Present
                if self.userData.currentStudent.studentName == "" &&
                    self.userData.currentStudent.studentEmail == "@" &&
                    self.userData.currentStudent.studentRedID == 0
                {
                    NewUserLandingView()
                        .environmentObject(self.userData)
                }
                    
                else {
                    
                    // MARK: Display Student Info
                    VStack {
                        StudentInfoView()
                            .environmentObject(self.userData)
                            .padding()
                        
                        VStack(alignment: .leading) {
                            Text("3D Tap for More Info")
                                .font(.system(.callout, design: .rounded))
                                .foregroundColor(Color.blue)
                                //                            .frame(height: 40)
                                
                                .contextMenu {
                                    Text("Name: \(self.userData.currentStudent.studentName)")
                                    Text(String(format:"Red ID: %09d", self.userData.currentStudent.studentRedID))
                                    Text("Email: \(self.userData.currentStudent.studentEmail)")
                            }
                        }.frame(alignment: .leading)
                        
                        Divider()
                        
                        // MARK: Check if No Enrolled Courses
                        if self.userData.currentStudent.courses.count == 0 {
                            Spacer()
                            
                            ShowFooter(headlineMsg: "Click Here to Add Courses", subHeadilneMsg: "No Courses Registered")
                                .environmentObject(self.userData)
                            
                        } else {
                            
                            // MARK: Display List of Enrolled Courses
                            ShowCourses()
                                .environmentObject(self.userData)
                            
                            ShowFooter(headlineMsg: "Update Courses", subHeadilneMsg: "3D Tap on Course for More Info")
                                .environmentObject(self.userData)
                        }
                    }
                    .padding(4)
                }
            }
            .navigationBarTitle(Text("My Registration"))
        }
        .navigationViewStyle(DoubleColumnNavigationViewStyle())
    }
}


struct EnrolledCoursesView_Previews: PreviewProvider {
    
    static var previews: some View {
        EnrolledCoursesView()
            .environmentObject(UserData())
            .previewDevice(PreviewDevice(rawValue: "iPhone XS"))
            .previewDisplayName("iPhone XS")
    }
}

struct ShowFooter: View {
    
    @EnvironmentObject var userDataObj: UserData
    @State var headlineMsg:String
    @State var subHeadilneMsg:String
    
    var body: some View {
        VStack {
            Divider().padding(.bottom, 24)
            
            NavigationLink(destination:
                AvailableCoursesView()
                    .environmentObject(self.userDataObj)
            ) {
                Text(headlineMsg)
                    .font(.headline)
            }
            .padding(.bottom, 4)
            
            Text(subHeadilneMsg)
                .font(.system(.subheadline, design: .monospaced))
        }
    }
}

struct ShowCourses: View {
    
    @EnvironmentObject var userDataObj: UserData
    
    var body: some View {
        List {
            ForEach(self.userDataObj.currentStudent.courses, id: \.self) {course in
                CourseInfoView(courseInformation: course)
            }
        }
    }
}

struct NewUserLandingView: View {
    
    @EnvironmentObject var userDataObj: UserData
    @State var showingModal = false
    
    var body: some View {
        
        Group {
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
                    .environmentObject(self.userDataObj)
            }
        }
    }
}
