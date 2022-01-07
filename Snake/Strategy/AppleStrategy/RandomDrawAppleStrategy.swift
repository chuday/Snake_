//
//  RandomDrawAppleStrategy.swift
//  Snake
//
//  Created by Mikhail Chudaev on 05.01.2022.
//  Copyright © 2022 Pinspb. All rights reserved.
//

import UIKit

class RandomDrawAppleStrategy: AppleStrategy {
    func createApple(in rect: CGRect) -> [Apple] {
        let randomX = CGFloat(arc4random_uniform(UInt32(rect.maxX) - 5))
        let randomY = CGFloat(arc4random_uniform(UInt32(rect.maxY) - 5))
        
        let apple = Apple(position: CGPoint(x: randomX, y: randomY))
        
        return [apple]
    }
    
}
