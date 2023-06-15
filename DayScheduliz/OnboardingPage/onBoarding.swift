//
//  onBoarding.swift
//  DayScheduliz
//
//  Created by Mirzabek on 07/06/23.
//

import Foundation
import SwiftUI


struct CustomColor {
    
    static let myColor1 = Color("red")
    static let myColor2 = Color("blue")
    static let myColor3 = Color("purple")
    
}

//onboarding
struct onboardingPage: View {
    
    //MARK: - PROPERTIES
    @Binding var shouldOnboardShowing: Bool
    @State  var currentTab:Int = 0
   
    var body: some View {
        
        //MARK: - BODY
        ZStack(alignment: .bottomTrailing){
            
            TabView(selection: self.$currentTab){
                
                PageView(shouldOnboardShowing: $shouldOnboardShowing, title: "DayScheduliz", text: "Get inspired, Make a productive day !", imageName: "pic-1",
                         showDismissButton: false
                )
                .tag(0)
                .background(CustomColor.myColor3)
                
                
                PageView(shouldOnboardShowing: $shouldOnboardShowing, title:"CheckList", text: "if you completed your task so you can view the results of your work", imageName: "pic-2"
                         ,
                         showDismissButton: false
                )
                .tag(1)
                .background(CustomColor.myColor2)
                
                
                PageView(shouldOnboardShowing: $shouldOnboardShowing, title: "Add your task",
                         text: "lets start, put your tasks",
                         imageName: "pic-3",
                         showDismissButton:  true
                )
                .tag(2)
                .background(CustomColor.myColor1)
                
                
            }
            .edgesIgnoringSafeArea(.all)
            .tabViewStyle(.page(indexDisplayMode: .never))
            .animation(.easeInOut)
            .transition(.slide)
            
            // Buttons Skip & Next
            HStack{
            
                if currentTab < 2{
                    Button(action: {
                        self.currentTab = 2
                    }, label: {
                        Text("SKIP")
                            .foregroundColor(.white)
                            .shadow(radius: 10)
                            .padding(30)
                    })
                }
                
                Spacer()
                
                if currentTab < 2{
                    Button(action: {
                        self.currentTab += 1
                    }, label: {
                        Text("Next")
                            .foregroundColor(.white)
                            .shadow(radius: 10)
                            .padding(30)
                    })
                }
                
            }
         
        }
    }
}


struct PageView:View{
    
    //MARK: - PROPERTIES
    @Binding var shouldOnboardShowing: Bool
    @State  var currentTab:Int = 0
    let title: String
    let text: String
    let imageName: String
    let showDismissButton: Bool

    var body: some View{
        
        //MARK: - BODY
        VStack(spacing: 5){
            Spacer()
            Image(imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 450, height: 450)
                .padding()
            
            Spacer()
                
                Text(title)
                    .font(.system(size: 50))
                    .foregroundColor(.white)
                    .shadow(radius: 10)
                    .bold()
                    .padding()
                
                Text(text)
                    .foregroundColor(.white)
                    .font(.system(size: 20))
                    .multilineTextAlignment(.center)
                    .padding()
            
            Spacer()
            
            //Get Started Button
            if showDismissButton{
                Button(action: {
                    self.currentTab - 1
                    shouldOnboardShowing.toggle()
                }, label: {
                    HStack{
                        Spacer()
                        Text("Get Started")
                            .foregroundColor(.white)
                            .bold()
                        Spacer()
                    }
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 25).stroke(.white,lineWidth: 2))
                    .frame(width: 150,height: 50)
                   
                })
                
            }
            
        }
    }
}

