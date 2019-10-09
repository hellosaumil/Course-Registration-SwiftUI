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
    
    @State private var showingAlert:Bool = false
    @State private var showingDataSaveAlert:Bool = false
    @State private var showingDataSaveAlertMessage:String = ""
    
    
    @State private var studentNameField:String = ""
    @State private var studentEmailField:String = ""
    @State private var studentRedIDField:String = ""
    
    private func endEditing(_ force: Bool) {
        UIApplication.shared.endEditing()
    }
    
    private struct Background<Content: View>: View {
        private var content: Content
        init(@ViewBuilder content: @escaping () -> Content) {
            self.content = content()
        }
        
        var body: some View {
            content
        }
    }
    
    private var invalidDataEntryAlert: Alert {
        
        return Alert(
            title: Text("Invalid Entry"),
            message: Text("Please enter a valid 9-digit Red ID and @sdsu.edu email address"),
            dismissButton: .cancel(
                Text("Dismiss"),
                action: {self.showingAlert = false}
            ))
    }
    
    private func dataSaveAlert(errMsg:String) -> Alert {
        
        return Alert(
            title: Text("Cant' Save Data"),
            message: Text(errMsg),
            dismissButton: .cancel(
                Text("Dismiss"),
                action: {self.showingDataSaveAlert = false}
            ))
    }
    
    private func userInput(keyboard keyboardDataType: UIKeyboardType = .default, _ txt_msg:String="Enter your text message:", _ tf_msg:String="Placeholder Message", _ tfTextBinding:Binding<String>) -> some View {
        
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
    
    private func intializeMenuOnAppear() {
        
        self.studentNameField = self.userData.currentStudent.studentName
        
        self.studentEmailField = self.userData.currentStudent.studentEmail == "@" ? "" : userData.currentStudent.studentEmail
        
        self.studentRedIDField = self.userData.currentStudent.studentRedID == 0 ? "" : String(format:"%09d", self.userData.currentStudent.studentRedID)
    }
    
    private func displayMenu() -> some View {
        
        return VStack(alignment: .center) {
            self.userInput(keyboard: .namePhonePad, "Name:", "Your full name", self.$studentNameField)
            
            self.userInput(keyboard: .emailAddress, "Email:", "Your @sdsu.edu email", self.$studentEmailField)
            
            self.userInput(keyboard: .phonePad, "Red ID:", "Your 9-digit Red ID", self.$studentRedIDField)
            
        }.onAppear {
            self.intializeMenuOnAppear()
        }
    }
    
    var body: some View {
        
        Background {
            
            ScrollView {
                
                VStack {
                    Text("Student Profile")
                        .bold()
                        .font(.system(.largeTitle, design: .default))
                    
                    self.displayMenu()
                    
                    Spacer()
                    
                    Button(action: {
                        print("Update Profile Tapped!")
                        
                        if self.userData.currentStudent.updateBasicStudentInfo(self.studentNameField, self.studentEmailField, Int(self.studentRedIDField) ?? -1) {
                            
                            if !storeUpdatedUser(self.userData) {

                                self.showingDataSaveAlert.toggle()
                            } else {
                                self.showingModal = false
                            }
                            
                            self.showingModal = false
                            
                        } else {
                            print("\nInvalid Data Entered.\n")
                            self.showingAlert.toggle()
                        }
                        
                    }) {
                        Text("Update")
                            .fontWeight(.semibold)
                            .font(.system(.body))
                            
                            .padding()
                            .frame(width: UIScreen.main.bounds.width * 0.84)
                            .foregroundColor(.white)
                            .background(Color.blue)
                            .cornerRadius(14)
                    }
                    .offset(y: 16)
                }
            }
            .alert(isPresented: self.$showingAlert, content: { self.invalidDataEntryAlert })
            .padding(16)
            .offset(y: 40)
            Spacer()
            
        }
//        .alert(isPresented: self.$showingDataSaveAlert, content: { self.dataSaveAlert(errMsg: self.showingDataSaveAlertMessage) })
        .onTapGesture {
            self.endEditing(true)
        }
    }
}

//struct UpdateProfileView_Previews: PreviewProvider {
//    @State static var stateVar = true
//
//    static var previews: some View {
//        UpdateProfileView(showingModal: self.$stateVar)
//            .environmentObject(UserData())
//            .previewDevice(PreviewDevice(rawValue: "iPhone XS"))
//            .previewDisplayName("iPhone XS")
//    }
//}
