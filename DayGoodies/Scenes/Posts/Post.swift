//
//  Post.swift
//  DayGoodies
//
//  Created by troquer on 9/29/19.
//  Copyright © 2019 zourz. All rights reserved.
//

import Foundation

struct Post: Decodable, Identifiable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
    var isFavorite: Bool? = false
    var isNew: Bool? = true
}
