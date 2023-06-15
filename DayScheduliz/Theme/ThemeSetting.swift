//
//  ThemeSetting.swift
//  DayScheduliz
//
//  Created by Mirzabek on 15/06/23.
//

import SwiftUI

//MARK: - Theme CLass

class ThemeSettings: ObservableObject{
    @Published var themeSettings: Int = UserDefaults.standard.integer(forKey: "Theme"){
        didSet{
            UserDefaults.standard.set(self.themeSettings, forKey: "Theme")
        }
    }
}
