//
//  GameSingleton.swift
//  Snake
//
//  Created by Mikhail Chudaev on 04.01.2022.
//  Copyright © 2022 Pinspb. All rights reserved.
//

import Foundation

class GameSingleton {
    
    private let caretaker = RecordsCaretaker()
    static let shared = GameSingleton()
    
    private(set) var records: [Record] {
        didSet {
            caretaker.saveRecords(records: records)
        }
    }
    
    private init() {
        records = caretaker.loadRecords() ?? []
    }
    
    func addRecord(record: Record) {
        records.append(record)
    }
    
    func clearRecords() {
        records.removeAll()
    }
    
}
