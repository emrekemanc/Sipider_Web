//
//  UserModel.swift
//  Sipider_Web
//
//  Created by Muhammet Emre Kemancı on 5.05.2025.
//

import Foundation

struct UserModel: Codable{
    let id: String
    let user_name: String
    let email: String
    let post_count: Int
    let created_at: Date
    let last_activity: Date
}
