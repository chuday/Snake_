//
//  GameViewController.swift
//  Snake
//
//  Created by Evgeny Kireev on 02/02/2019.
//  Copyright © 2019 Pinspb. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

/*
protocol GameViewControllerDelegate: AnyObject {
    func didEndGame(with result: Int)
}
 */

final class GameViewController: UIViewController {
    
    // MARK: - Life cycle
    
//    weak var gameVCDelegate: GameViewControllerDelegate?
    
    @IBOutlet weak var speedLabel: UILabel!
    var onGameEnd: ((Int) -> Void)?
    
    var difficulty: Difficulty = .medium
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let scene = GameScene(size: view.bounds.size,
                              appleStrategy: createAppleStrategy(),
                              speedStrategy: setSnakeSpeedStrategy()
                              )
//        scene.gameSceneDelegate = self
        scene.onGameEnd = { [weak self] (result) in
            guard let self = self else { return }
            
            self.onGameEnd?(result)
            self.dismiss(animated: true, completion: nil)
        }
       
        let _ = GameSceneFacade(view: view, scene: scene)
        
        scene.snake?.moveSpeed.addObserver(self, options: [.initial, .new], closure: { [weak self] (moveSpeed, _) in
            guard let self = self else { return }
            
            self.speedLabel.text = "Скорость змеи: \(moveSpeed)"
            
        })
    }
    
    // MARK: - UIViewController
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    private func createAppleStrategy() -> AppleStrategy {
        switch difficulty {
        case .easy:
            return CoordinateDrawAppleStrategy()
        case .medium, .hard, .nightmare:
            return RandomDrawAppleStrategy()
        }
    }
    
    private func setSnakeSpeedStrategy() -> SnakeSpeedStrategy {
        switch difficulty {
        case .easy:
            return NotIncreaseSpeedStrategy()
        case .medium, .hard:
            return ArithmeticIncreaseSpeedStrategy()
        case .nightmare:
            return GeometricIncreaseSpeedStrategy()
        }
    }
}

/*
extension GameViewController: GameSceneDelegate {
    func didEndGame(with result: Int) {
        gameVCDelegate?.didEndGame(with: result)
        dismiss(animated: true, completion: nil)
    }
}
 */
