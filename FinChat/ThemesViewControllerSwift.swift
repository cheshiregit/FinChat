//
//  ThemesViewController.swift
//  FinChat
//
//  Created by Roman Nordshtrem on 06/03/2019.
//  Copyright © 2019 Роман Нордштрем. All rights reserved.
//

import UIKit

typealias themesClosure = (_ color: UIColor) -> (Void)

class ThemesViewControllerSwift: UIViewController {
    
    var model: Themes?
    var themesClosure: themesClosure?

    override func viewDidLoad() {
        super.viewDidLoad()
        model = Themes()
    }
    
    func changeColor(_ color: UIColor?) {
        guard let color = color else { return }
        view.backgroundColor = color
        themesClosure?(color)
        let navigationBarAppearace = UINavigationBar.appearance()
        navigationBarAppearace.barTintColor = color
        UserDefaults.standard.setColor(color: color, forKey: "Theme")
    }

}
