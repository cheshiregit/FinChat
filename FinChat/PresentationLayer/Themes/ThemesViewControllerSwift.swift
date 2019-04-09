//
//  ThemesViewController.swift
//  FinChat
//
//  Created by Roman Nordshtrem on 06/03/2019.
//  Copyright © 2019 Роман Нордштрем. All rights reserved.
//

import UIKit

typealias ThemesClosure = (_ color: UIColor) -> Void

class ThemesViewControllerSwift: UIViewController {

    var model = ThemesSwift()
    var themesClosure: ThemesClosure?

    @IBAction func closeButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func theme1Button(_ sender: Any) {
        changeColor(model.theme1)
    }

    @IBAction func theme2Button(_ sender: Any) {
        changeColor(model.theme2)
    }

    @IBAction func theme3Button(_ sender: Any) {
        changeColor(model.theme3)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        model = ThemesSwift()
        self.view.backgroundColor = UserDefaults.standard.colorForKey(key: "Theme")
    }

    func changeColor(_ color: UIColor?) {
        guard let color = color else { return }
        view.backgroundColor = color
        themesClosure?(color)
        UINavigationBar.appearance().barTintColor = color
        let globalQueue = DispatchQueue.global(qos: .utility)
        globalQueue.async {
            print("themes with GCD")
            UserDefaults.standard.setColor(color: color, forKey: "Theme")
        }
        UserDefaults.standard.setColor(color: color, forKey: "Theme")
        // костыль для мгновенного обновления navigation bar нашел на stackoverflow
        // https://stackoverflow.com/questions/15024037/updating-navigation-bar-after-a-change-using-uiappearance
        for window in UIApplication.shared.windows {
            for view in window.subviews {
                view.removeFromSuperview()
                window.addSubview(view)
            }
        }
    }

}
