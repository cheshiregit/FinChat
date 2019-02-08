//
//  ViewController.swift
//  FinChat
//
//  Created by Roman Nordshtrem on 07/02/2019.
//  Copyright © 2019 Роман Нордштрем. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        logging()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        logging()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        logging()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        logging()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        logging()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        logging()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        logging()
    }

}

extension UIViewController {
    func logging(_ function: String = #function) {
        guard
            let appDelegate = UIApplication.shared.delegate as? AppDelegate,
            appDelegate.loggingOn
            else {
                return
        }
        print(function)
    }
}
