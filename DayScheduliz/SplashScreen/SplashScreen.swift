//
//  SplashScreen.swift
//  DayScheduliz
//
//  Created by Mirzabek on 10/06/23.
//

import SwiftUI

struct SplashScreen: View {
    
    //MARK: - PROPERTIES
    @State private var isActive = false
    @State private var size = 0.8
    @State private var opacity = 0.5
    
    var body: some View {
        //MARK: - BODY
        if isActive {
         //  ContentView()
            mainOnBoardingPage()
            
        }else{
            VStack{
                VStack{
                    Image("appTheme")
                        .resizable()
                        .frame(width: 150,height: 150)
                        .foregroundColor(.red)
                        .cornerRadius(20)
                }
                .scaleEffect(size)
                .opacity(opacity)
                .onAppear{
                    withAnimation(.easeIn(duration: 2.2)){
                        self.size = 0.9
                        self.opacity = 1.0
                    }
                }
            }
            .onAppear{
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0){
                    withAnimation{
                        self.isActive = true
                    }
                   
                }
            }
        }
    }
}
//MARK: - PREVIEW
struct SplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreen()
    }
}
