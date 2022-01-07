//
//  SnakeSpeedStrategy.swift
//  Snake
//
//  Created by Mikhail Chudaev on 05.01.2022.
//  Copyright © 2022 Pinspb. All rights reserved.
//

import Foundation

protocol SnakeSpeedStrategy: AnyObject {
    var snake: Snake? { get set }
    var maxSpeed: Double? { get set }
    
    func increaseSpeed()
}
