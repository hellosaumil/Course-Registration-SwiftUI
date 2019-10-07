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
                
                // MARK: Check if No Valid Student Info Present
                if self.userData.currentStudent.studentName == "" &&
                    self.userData.currentStudent.studentEmail == "@"
                {
                    
                    VStack(alignment: .center) {
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
                                    Text("Red ID: \(self.userData.currentStudent.studentRedID)")
                                    Text("Email: \(self.userData.currentStudent.studentEmail)")
                            }
                        }.frame(alignment: .leading)
                        
                        
                        
                        Divider()
                        
                        
                        // MARK: Check if No Enrolled Courses
                        if self.userData.currentStudent.courses.count == 0 {
                            Spacer()
                            
                            VStack {
                                Divider().padding(.bottom, 16)
                                NavigationLink(destination:
                                    AvailableCoursesView()
                                        .environmentObject(self.userData)
                                ) {
                                    Text("Click Here to Add Courses")
                                        .font(.headline)
                                    
                                }.padding(.bottom, 4)
                                
                                Text("No Courses Registered")
                                    .font(.system(.subheadline, design: .monospaced))
                                
                            }
                            
                        } else {
                            
                            // MARK: Display List of Enrolled Courses
                            List {
                                
                                ForEach(self.userData.currentStudent.courses, id: \.self) {course in
                                    
                                    CourseInfoView(courseInformation: course)
                                }
                            }
                            
                            VStack {
                                
                                Divider().padding(.bottom, 32)
                                
                                NavigationLink(destination:
                                    AvailableCoursesView()
                                        .environmentObject(self.userData)
                                ) {
                                    Text("Update Courses")
                                        .font(.headline)
                                }
                                .padding(.bottom, 4)
                                
                                Text("3D Tap on Course for More Info")
                                    .font(.system(.subheadline, design: .monospaced))
                                
                            }
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
        //            .previewDevice(PreviewDevice(rawValue: "iPhone XS"))
        //            .previewDisplayName("iPhone XS")
    }
}
