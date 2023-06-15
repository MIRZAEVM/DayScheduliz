//
//  AddTaskView.swift
//  DayScheduliz
//
//  Created by Mirzabek on 15/06/23.
//

import SwiftUI

struct AddTaskView: View {
    
    // MARK: - PROPERTIES
    
    @Environment(\.managedObjectContext) var managedObjectContext
    @Environment(\.presentationMode) var presentationMode
    
    @State private var name: String = ""
    @State private var priority : String = "Normal"
    let priorities = ["High","Normal","Low"]
    
    @State private var errorShwoing: Bool = false
    @State private var errorTitle: String = ""
    @State private var errorMessage: String = ""

    //THEME
    @ObservedObject var theme = ThemeSettings()
    var themes: [Theme] = themeData
   
    //MARK: - BODY
    var body: some View {
        
        NavigationView{
            
            VStack{
                
                VStack(alignment: .leading, spacing: 20){
                    
                    TextField("Todo", text: $name)
                        .padding()
                        .background(Color(UIColor.tertiarySystemFill))
                        .cornerRadius(20)
                        .font(.system(size:15, weight: .bold, design: .default))
                    
                    
                    Picker("Priority",selection: $priority){
                        ForEach (priorities, id: \.self){
                            Text($0)
                        }
                    }
                    .pickerStyle(.wheel)
                  
                    
                    //MARK: - SaveButton
                    Button(action: {

                        if self.name != ""{
                            
                            let todo = DayScheduliz(context: self.managedObjectContext)
                            todo.name = self.name
                            todo.priority = self.priority
                            
                            do{
                                try self.managedObjectContext.save()// saving to data storage
                            
                            }catch{
                                print(error)
                            }
                            
                        }else{
                            self.errorShwoing = true
                            self.errorTitle = "Invalid Name"
                            self.errorMessage = "Make sure to enter something for the new todo item"
                            return
                        }
                        self.presentationMode.wrappedValue.dismiss()
                        
                    }, label: {
                        HStack{
                            Spacer()
                            Text("Save")
                                .frame(width: 200,height: 20)
                                .padding()
                            // .frame(minWidth: 0,maxWidth: .infinity)
                                .background(themes[self.theme.themeSettings].themeColor)// flexible color changer code
                                .cornerRadius(20)
                                .foregroundColor(.white)
                            Spacer()
                        }
                    })
                }//VSATCK ENDS
                .padding(.horizontal)
                .padding(.vertical,30)
                Spacer()
            }
            
            .navigationBarTitle("New Task", displayMode: .inline)
            .navigationBarItems(trailing:
                Button(action: {
                self.presentationMode.wrappedValue.dismiss()
            }, label: {
                Image(systemName: "xmark")
            })
            )
            .alert(isPresented: $errorShwoing){
                Alert(title: Text(errorTitle),message: Text(errorMessage),dismissButton: .default(Text("OK")))
            }
        }// End Navigation
        .accentColor(themes[self.theme.themeSettings].themeColor)
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct AddTaskView_Previews: PreviewProvider {
    static var previews: some View {
        AddTaskView()
    }
}
