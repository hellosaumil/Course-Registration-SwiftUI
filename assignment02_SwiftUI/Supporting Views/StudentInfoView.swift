//
//  StudentInfoView.swift
//  assignment02_SwiftUI
//
//  Created by Saumil Shah on 9/30/19.
//  Copyright © 2019 Saumil Shah. All rights reserved.
//

import SwiftUI
import UIKit

struct StudentInfoView: View {
    
    @EnvironmentObject var userData: UserData
    @State var showingModal = false
    
    public var profileIcon: some View {
        Image(systemName: "person.crop.circle")
            .scaleEffect(1.6)
            .accessibility(label: Text("User Profile"))
    }
    
    var body: some View {
        
        HStack(alignment:.top, spacing: 2) {
            
            VStack(alignment: .leading, spacing: 2) {
                
                if userData.currentStudent.studentName != "" {
                    Text(userData.currentStudent.studentName)
                        .bold()
                        .font(.system(.title, design: .monospaced))
                        .truncationMode(.middle)
                        .lineLimit(1)
                        
                        .frame(maxWidth: .infinity,  alignment: .leading)
                        .padding(.all, 0)
                    
                } else {
                    Text("No Record")
                        .bold()
                        .font(.system(.title, design: .monospaced))
                }
                
                Divider()
                
                VStack(alignment: .leading, spacing: 2) {
                    
                    
                    if userData.currentStudent.studentRedID != "" {
                        
                        Text("Red ID: \(userData.currentStudent.studentRedID)")
                            .font(.system(.body, design: .monospaced))
                            .bold()
                        
                    }
                    else {
                        Text("Red ID: No Record")
                            .font(.system(.body, design: .monospaced))
                            .bold()
                    }
                    
                    if userData.currentStudent.studentEmail != "@" {
                        Text("Email: \(userData.currentStudent.studentEmail)")
                            .font(.system(.body))
                        
                    } else {
                        Text("Email: No Record")
                            .font(.system(.body))
                    }
                    
                    //                    Spacer()
                    
                }
            }
            
            Button(action: {
                self.showingModal.toggle()
            })
            {
                profileIcon
                Text("Update Profile")
            }
            .sheet(isPresented: $showingModal) {
                UpdateProfileView(showingModal: self.$showingModal)
                    .environmentObject(self.userData)
            }
            .padding(.top, 24)
        }
        .padding(.all, 16)
        
    }
}

let sampleStudent = StudentInfo("Saumil Shah","sshah1612@sdsu.edu", "823191571", [someCourse])

struct StudentInfoView_Previews: PreviewProvider {
    
    static var previews: some View {
        
        StudentInfoView()
            .environmentObject(UserData())
    }
}
