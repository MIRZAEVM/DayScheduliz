//
//  SettingsView.swift
//  DayScheduliz
//
//  Created by Mirzabek on 15/06/23.
//

import SwiftUI

struct SettingsView: View {
    //MARK: - PROPERTIES
    @Environment(\.presentationMode) var presentationMode
  
    
    // THEME
    let themes: [Theme] = themeData
    @ObservedObject var theme = ThemeSettings()
    @State private var isThemeChanged:Bool = false
    
    //MARK: - BODY
    var body: some View {
        
        NavigationView{
            
            VStack(alignment: .center, spacing: 20){
                
                Spacer()
                List{
                    
                    Section(header:
                                HStack{
                        Text("Choose the app Theme")
                        Image(systemName: "circle.fill")
                            .resizable()
                            .frame(width: 10, height: 10)
                            .foregroundColor(themes[self.theme.themeSettings].themeColor)
                        
                    }
                    ){
                        ForEach(themes, id: \.id){ item in
                            Button(action: {
                                self.theme.themeSettings = item.id
                                UserDefaults.standard.set(self.theme.themeSettings, forKey: "Theme")
                                self.isThemeChanged.toggle()
                            }, label: {
                                HStack{
                                    Image(systemName: "circle.fill")
                                        .foregroundColor(item.themeColor)
                                    
                                    
                                    Text(item.themeName)
                                }
                            })//button
                            .accentColor(Color.primary )
                        }
                    }
                    .padding(.vertical,3)
                    .alert(isPresented: $isThemeChanged){
                        Alert(
                            title: Text("SUCESS !"),
                            message: Text("App icon has been changed to \(themes[self.theme.themeSettings].themeName).Now close and restart it"),
                            dismissButton: .default(Text("OK")))
                    }//ALERT
                    
                    
                    Section(header: Text("About the Application")){
                        FormRowStaticView(icon: "gear", firstText: "Application", secondText:"DayScheduliz")
                        
                        FormRowStaticView(icon: "checkmark.seal", firstText: "Compatibility", secondText: "Iphone, Ipad")
                        
                        FormRowStaticView(icon: "keyboard", firstText: "Developer", secondText: "Mirzabek, Mirzayev")
                        
                        
                        FormRowStaticView(icon: "flag", firstText: "Version", secondText: "2.1.1")
                    }
                    .padding(.vertical,3)
                }
                
                Text("DEVELOPED BY MIRZABEK ")
                    .font(.footnote)
                    .padding(.top,6)
                    .padding(.bottom,8)
                    .foregroundColor(.secondary)
            }// vstack ends
            .padding(.top,30)
            
            .navigationBarItems(trailing:
                                    
                                    Button(action: {
                self.presentationMode.wrappedValue.dismiss()
            }, label: {
                Image(systemName: "xmark")
            }))
            
            .navigationBarTitle("Setting",displayMode: .inline)
            .background(Color("ColorBackground"))
            .edgesIgnoringSafeArea(.all)
            
        }// nasvigation ends
        .accentColor(themes[self.theme.themeSettings].themeColor)
        .navigationViewStyle(StackNavigationViewStyle())
    }
}
//MARK: - PREVIEW
struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
