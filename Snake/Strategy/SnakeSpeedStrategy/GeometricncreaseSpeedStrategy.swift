//
//  GeometricncreaseSpeedStrategy.swift
//  Snake
//
//  Created by Mikhail Chudaev on 05.01.2022.
//  Copyright © 2022 Pinspb. All rights reserved.
//

import Foundation

class GeometricIncreaseSpeedStrategy: SnakeSpeedStrategy {
    var snake: Snake?
    var maxSpeed: Double?
    
    private let speedCoefficient = 1.1
    
    func increaseSpeed() {
        guard let snake = snake else { return }
        snake.moveSpeed.value *= speedCoefficient
        
        if let maxSpeed = maxSpeed {
            if snake.moveSpeed.value > maxSpeed {
                snake.moveSpeed.value = maxSpeed
            }
        }
    }
}
