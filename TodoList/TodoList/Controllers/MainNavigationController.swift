//
//  MainNavigationController.swift
//  TodoList
//
//  Created by 장일규 on 2022/02/15.
//

import Foundation
import UIKit

class MainNavigationController: UINavigationController {
    override func viewDidLoad() {
        viewControllers = [MainViewController()]
    }
}
