//
//  EmptyListView.swift
//  DayScheduliz
//
//  Created by Mirzabek on 15/06/23.
//

import SwiftUI

struct EmptyListView: View {
    
    //MARK: - PROPERTIES
    @State private var isAnimated: Bool = false
     //NACHGROUND IMAGE
     let images: [String] = [
         "illustration-no1",
         "illustration-no2",
         "illustration-no3"
     ]
     //SENTENCES
     let tips:[String] = [
         "USE YOUR TIME EFFECTIVELY",
         "SLOW AND STEADY WINS THE RACE ",
         "KEEP IT SHORT AND SWEET",
         "PUT HARD TASKS FIRST",
         "REWARD YOURSELF AFTET WORK",
         "COLLCET TASKS AHEAD OF TIME",
         "EACH NIGHT SCHEDULE FOR TOMORROW"
     ]
     
     //Theme
     @ObservedObject var theme = ThemeSettings()
     var themes:[Theme] = themeData
     
     
     //MARK: - Body
    var body: some View {
        ZStack{
            VStack(alignment: .center,spacing: 20){
                Image("\(images.randomElement() ?? self.images[0])")
                    .renderingMode(.template)
                //randoming elements
                    .resizable()
                    .scaledToFit()
                    .frame(minWidth:256, idealWidth:  280, maxWidth: 360, minHeight: 256, idealHeight: 280,maxHeight: 360, alignment: .center)
                    .layoutPriority(1)
                    .foregroundColor(themes[self.theme.themeSettings].themeColor)
                //text
                Text("\(tips.randomElement() ?? self.tips[0])")
                    .layoutPriority(0.5)
                    .font(.system(.headline, design: .rounded))
                    .foregroundColor(themes[self.theme.themeSettings].themeColor)
        }//Vstack
            .padding(.horizontal)
            .opacity(isAnimated ? 1 : 0)
            .offset(y: isAnimated ? 0 : -50)
            .animation(.easeOut(duration: 1.5))
            .onAppear(perform: {
                self.isAnimated.toggle()
            })
        }//zstack
        
        .frame(minWidth: 0,maxWidth: .infinity,minHeight: 0,maxHeight: .infinity)
        .background(Color("ColorBase"))
        .edgesIgnoringSafeArea(.all)
    }
}
//MARK: - PREVIEW
struct EmptyListView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyListView()
    }
}
