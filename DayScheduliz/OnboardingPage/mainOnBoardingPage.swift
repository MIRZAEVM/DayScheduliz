//
//  mainOnBoardingPage.swift
//  DayScheduliz
//
//  Created by Mirzabek on 07/06/23.
//

import SwiftUI

struct mainOnBoardingPage: View {
    //MARK: - PROPERTIES
    
    @AppStorage("_shouldOnboardShowing") var shouldOnboardShowing: Bool = true
    
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @FetchRequest(entity: DayScheduliz.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \DayScheduliz.name, ascending: true)]) var todos: FetchedResults<DayScheduliz>//printing the tasks
    

    
    @State private var showingAddTodoView: Bool = false
    @State private var animatingButton: Bool = false
    @State private var showingSettingsView:Bool = false
    
    //Theme
    @ObservedObject var theme = ThemeSettings()
    var themes: [Theme] = themeData
    
    var body: some View {
        NavigationView{
            ZStack{
                List{
                    ForEach(self.todos,id: \.self) { todo in
                        HStack{
                            
                            Circle()
                                .frame(width: 12, height: 12, alignment: .center)
                                .foregroundColor(self.colorize(priority: todo.priority ?? "Normal"))
                            
                            Text(todo.name ?? "Unknown")
                                .fontWeight(.semibold)
                            
                            Spacer()
                            
                            Text(todo.priority ?? "Unknown" )
                                .font(.footnote)
                                .foregroundColor(Color(UIColor.systemGray2))
                                .padding(3)
                                .frame(minWidth: 62)
                                .overlay(
                                    Capsule().stroke(Color(UIColor.systemGray2),lineWidth: 0.75)
                                )
                        }//hstack
                    }//foreach ends
                    .onDelete(perform: deleteTask)
                }
                .navigationBarTitle("Tasks",displayMode: .inline)
                //Button
                .navigationBarItems(
                    leading: EditButton().accentColor(themes[self.theme.themeSettings].themeColor),
                    trailing:
                        Button(action: {
                            self.showingSettingsView.toggle()
                        }, label: {
                            Image(systemName: "gearshape")
                                .imageScale(.large)
                        })
                        .accentColor(themes[self.theme.themeSettings].themeColor)
                        .sheet(isPresented: $showingSettingsView){
                            SettingsView()
                            
                        }
                )
                //MARK: - No todo Items
                
                if todos.count == 0{
                    EmptyListView()
                }
            }//Zstack
            .sheet(isPresented: $showingAddTodoView){
                AddTaskView().environment(\.managedObjectContext, self.managedObjectContext)
                    .presentationDetents([.height(400)])
                    .presentationDragIndicator(.hidden)
            }
            .overlay(
                ZStack{
                    Group{
                        Circle()
                            .fill(themes[self.theme.themeSettings].themeColor)
                            .opacity(self.animatingButton ? 0.2 : 0)
                            .scaleEffect(self.animatingButton ? 1 : 0)
                            .frame(width: 68, height: 68, alignment: .center)
                        
                        Circle()
                            .fill(themes[self.theme.themeSettings].themeColor)
                            .opacity(self.animatingButton ? 0.15 : 0)
                            .scaleEffect(self.animatingButton ? 1 : 0)
                            .frame(width: 88, height: 88, alignment: .center)
                    }// background of the button
                    .animation(.easeIn(duration: 2).repeatForever(autoreverses: true))
                    
                    Button(action: {
                        self.showingAddTodoView.toggle()
                    }, label: {
                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .background(Circle().fill(Color("ColorBase")))
                            .frame(width: 48, height: 48, alignment: .center)
                    })
                    .accentColor(themes[self.theme.themeSettings].themeColor)
                    .onAppear(perform: {
                        self.animatingButton.toggle()
                    })// animating button runs
                    
                }//zstack
                    .padding(.bottom,15)
                    .padding(.trailing,15)
                ,alignment: .bottomTrailing
            )//CIRCLE ANIMATING BUTTON
        }
        .fullScreenCover(isPresented:  $shouldOnboardShowing, content: {
            onboardingPage(shouldOnboardShowing: $shouldOnboardShowing)
        })
    }
    //MARK: - Functions
    private func deleteTask(at offsets: IndexSet){
        
        for index in offsets{
            let todo = todos[index]
            managedObjectContext.delete(todo)
            
            do {
                try managedObjectContext.save()

            }catch{
                print(error)
            }
        }
    }
    
    private func colorize(priority: String) -> Color{
        switch priority{
        case "High":
            return.red
        case "Normal":
            return.green
        case "Low":
            return.yellow
        default:
            return.gray
        }
    }
}
    //MARK: - PREVIEW
struct mainOnBoardingPage_Previews: PreviewProvider {
    static var previews: some View {
        mainOnBoardingPage()
    }
}



