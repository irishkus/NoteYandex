//
//  Note.swift
//  Note
//
//  Created by Ирина Соловьева on 22/06/2019.
//  Copyright © 2019 Ирина Соловьева. All rights reserved.
//

import Foundation
import UIKit

enum Importance: String {
    case important = "Важная"
    case ordinary = "Обычная"
    case unimportant = "Неважная"
}

struct Note {
    let uid: String
    let title: String
    let content: String
    let color: UIColor
    let importance: Importance
    let selfDestructionDate: Date?
    
    init(uid: String = UUID().uuidString, title: String, content: String, color: UIColor = .white, importance: Importance, selfDestructionDate: Date? = nil) {
        self.title = title
        self.content = content
        self.importance = importance
        self.color = color
        self.uid = uid
        self.selfDestructionDate = selfDestructionDate
    }

}
