//
//  AppCoordinator.swift
//  Sipider_Web
//
//  Created by Muhammet Emre Kemancı on 6.05.2025.
//

import UIKit

class AppCoordinator: Coordinator{
    var navigationController: UINavigationController
    private let window: UIWindow
    init(navigationController: UINavigationController,window: UIWindow) {
        self.navigationController = navigationController
        self.window = window
    }
    func start() {
        
    }
    
    
}
