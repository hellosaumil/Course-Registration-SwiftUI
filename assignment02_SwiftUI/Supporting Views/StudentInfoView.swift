//
//  StudentInfoView.swift
//  assignment02_SwiftUI
//
//  Created by Saumil Shah on 9/30/19.
//  Copyright © 2019 Saumil Shah. All rights reserved.
//

import SwiftUI
import UIKit

public var profileIcon: some View {
    Image(systemName: "person.crop.circle.fill")
    .font(.largeTitle)

}

struct StudentInfoView: View {
    
    @EnvironmentObject var userData: UserData
    @State var showingModal = false
    @State var showPopover: Bool = false
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 2) {
            
            HStack(alignment: .center, spacing: 2) {
                
                if self.userData.currentStudent.studentName != "" {
                    Text(self.userData.currentStudent.studentName)
                        .bold()
                        .font(.system(.title, design: .serif))
                        .truncationMode(.middle)
                        .lineLimit(1)
                        
                        .frame(alignment: .leading)
                        .padding(.all, 0)
                    
                } else {
                    Text("No Record")
                        .bold()
                        .font(.system(.title, design: .serif))
                }
                
                Spacer()
                
                Button(action: {self.showingModal.toggle()})
                {profileIcon}
                    .sheet(isPresented: $showingModal) {
                        UpdateProfileView(showingModal: self.$showingModal)
                            .environmentObject(self.userData)
                }.padding(.top, 16).padding(.trailing, 16)
            }
            
            //            Divider()
            
            VStack(alignment: .leading, spacing: 2) {
                
                
                if self.userData.currentStudent.studentRedID != 0 {
                    
                    Text(String(format:"Red ID: %09d", self.userData.currentStudent.studentRedID))
                        .font(.system(.body, design: .monospaced))
                        .bold()
                    
                }
                else {
                    Text("Red ID: No Record")
                        .font(.system(.body, design: .monospaced))
                        .bold()
                }
                
                if self.userData.currentStudent.studentEmail != "@" {
                    Text("Email: \(self.userData.currentStudent.studentEmail)")
                        .font(.system(.body, design: .rounded))
                        .truncationMode(.middle)
                        .lineLimit(1)
                        .frame(maxWidth: .infinity,  alignment: .leading)
                    
                    
                } else {
                    Text("Email: No Record")
                        .font(.system(.body, design: .rounded))
                }
                
                //                    Spacer()
                
            }
            
        }
    }
    
}

let sampleStudent = StudentInfo("Saumil Shah","sshah1612@sdsu.edu", 823191571, [someCourse])

struct StudentInfoView_Previews: PreviewProvider {
    static var previews: some View {
        StudentInfoView()
            .environmentObject(UserData())
            .previewDevice(PreviewDevice(rawValue: "iPhone XS"))
            .previewDisplayName("iPhone XS")
    }
}
