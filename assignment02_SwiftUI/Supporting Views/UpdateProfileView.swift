//
//  UpdateProfileView.swift
//  assignment02_SwiftUI
//
//  Created by Saumil Shah on 9/30/19.
//  Copyright © 2019 Saumil Shah. All rights reserved.
//

import SwiftUI

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

struct UpdateProfileView: View {
    
    @EnvironmentObject var userData: UserData
    @Binding var showingModal:Bool
    
    @State private var showingAlert = false
    
    
    private func endEditing(_ force: Bool) {
        UIApplication.shared.endEditing()
    }
    
    func userInput(keyboard keyboardDataType: UIKeyboardType = .default, _ txt_msg:String="Enter your text message:", _ tf_msg:String="Placeholder Message", _ tfTextBinding:Binding<String>) -> some View {
        
        HStack {
            Text(txt_msg)
                .font(.headline)
            TextField(tf_msg, text: tfTextBinding){
                self.endEditing(true)
            }
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .font(.system(.body, design: .monospaced))
            .truncationMode(.middle)
            .keyboardType(keyboardDataType)
            
        }.padding(8)
    }
    
    struct Background<Content: View>: View {
        private var content: Content
        init(@ViewBuilder content: @escaping () -> Content) {
            self.content = content()
        }
        
        var body: some View {
            Color
                .white
                .overlay(content)
        }
    }
    
    
    var body: some View {
        
        Background {
            VStack {
                Text("Student Profile")
                    .bold()
                    .font(.system(.title, design: .monospaced))
                
                VStack(alignment: .center) {
                    
                    self.userInput(keyboard: .namePhonePad, "Name:", "Your full name", self.$userData.currentStudent.studentName)
                    self.userInput(keyboard: .emailAddress, "Email:", "Your @sdsu.edu email", self.$userData.currentStudent.studentEmail)
                    self.userInput(keyboard: .phonePad, "Red ID:", "Your 9-digit Red ID", self.$userData.currentStudent.studentRedID)
                    
                }
                    
                .alert(isPresented: self.$showingAlert) {
                    Alert(title: Text("Important message"), message: Text("Wear sunscreen"), dismissButton: .default(Text("Got it!")))
                }
                
                Button(action: {
                    print("Update Profile Tapped!")
                    
                    
                    if let studentInfoChanged = StudentInfo( self.userData.currentStudent.studentName, self.userData.currentStudent.studentEmail, self.userData.currentStudent.studentRedID,
                        self.userData.currentStudent.courses) {
                        
                        self.userData.currentStudent = studentInfoChanged
                        
//                        do {
//                            let UpdatedStudentInfo = StudentInfoStructure(self.userData.currentStudent.studentName, self.userData.currentStudent.studentEmail, self.userData.currentStudent.studentRedID,
//                                                                          self.userData.currentStudent.courses)
//
//                            try save("studentData.json", data: UpdatedStudentInfo)
//
//                            print("Data Saved.\n")
//
//                        } catch {
//
//                            print("\tCan't Save Data...\(error)\n")
//                        }
                        
                    } else {
                        self.showingAlert = true
                    }
                    
                    self.showingModal = false
                    
                }) {
                    Text("Update")
                        .fontWeight(.semibold)
                        .font(.system(size: 20))
                        .padding()
                        .frame(maxWidth: 300)
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .cornerRadius(14)
                }
                .offset(y: 16)
            }
            .padding(16)
            .offset(y: 40)
            Spacer()
            
        }.onTapGesture {
            self.endEditing(true)
        }
        
    }
    
}

//struct UpdateProfileView_Previews: PreviewProvider {
//    
//    @State static var stateVar = false
//    
//    static var previews: some View {
//        UpdateProfileView(showingModal: $stateVar)
//            .environmentObject(UserData())
//    }
//}
