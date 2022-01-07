//
//  CollisionCategories.swift
//  Snake
//
//  Created by Evgeny Kireev on 02/02/2019.
//  Copyright © 2019 Pinspb. All rights reserved.
//

import Foundation

struct CollisionCategories {
    static let Snake: UInt32     = 0x1 << 0
    static let SnakeHead: UInt32 = 0x1 << 1
    static let Apple: UInt32     = 0x1 << 2
    static let EdgeBody: UInt32  = 0x1 << 3
}
