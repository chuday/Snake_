//
//  GameSceneFacade.swift
//  Snake
//
//  Created by Mikhail Chudaev on 05.01.2022.
//  Copyright © 2022 Pinspb. All rights reserved.
//

import UIKit
import SpriteKit

class GameSceneFacade {
    init(view: UIView, scene: GameScene) {
        scene.scaleMode = .resizeFill
        guard let skView = view as? SKView else { return }
        skView.showsFPS = true
        skView.showsNodeCount = true
        skView.ignoresSiblingOrder = true
        skView.presentScene(scene)
    }
}
