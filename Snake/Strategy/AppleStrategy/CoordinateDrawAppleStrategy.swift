//
//  CoordinateDrawAppleStrategy.swift
//  Snake
//
//  Created by Mikhail Chudaev on 05.01.2022.
//  Copyright © 2022 Pinspb. All rights reserved.
//

import UIKit

class CoordinateDrawAppleStrategy: AppleStrategy {
    
    private let positions = [
        CGPoint(x: 210, y: 200),
        CGPoint(x: 20, y: 30),
        CGPoint(x: 340, y: 210),
        CGPoint(x: 40, y: 200),
        CGPoint(x: 50, y: 120),
        CGPoint(x: 40, y: 20),
        CGPoint(x: 230, y: 220),
        CGPoint(x: 40, y: 80),
        CGPoint(x: 120, y: 320),
        CGPoint(x: 110, y: 110)
    ]
    
    private var lastIndex = -1
    
    func createApple(in rect: CGRect) -> [Apple] {
        lastIndex += 1
        
        if lastIndex >= positions.count {
            lastIndex = 0
        }
        
        let position = positions[lastIndex]
        let apple = Apple(position: position)
        
        return [apple]
    }

}
