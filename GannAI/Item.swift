//
//  Item.swift
//  GannAI
//
//  Created by Kang Peng on 2025/4/27.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
