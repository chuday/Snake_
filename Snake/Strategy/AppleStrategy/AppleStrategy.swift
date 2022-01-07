//
//  AppleStrategy.swift
//  Snake
//
//  Created by Mikhail Chudaev on 05.01.2022.
//  Copyright © 2022 Pinspb. All rights reserved.
//

import UIKit

protocol AppleStrategy: AnyObject {
    func createApple(in rect: CGRect) -> [Apple]
}
