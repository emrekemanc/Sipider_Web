//
//  Coordinator.swift
//  Sipider_Web
//
//  Created by Muhammet Emre Kemancı on 6.05.2025.
//

import UIKit
protocol Coordinator{
    var navigationController: UINavigationController{get set}
    func start()
}
