//
//  NoteExtensions.swift
//  Note
//
//  Created by Ирина Соловьева on 23/06/2019.
//  Copyright © 2019 Ирина Соловьева. All rights reserved.
//

import Foundation
import UIKit

extension Note {
    static func parse(json: [String: Any]) -> Note? {
        guard let uid = json["uid"] as? String,
            let title = json["title"] as? String,
            let content = json["content"] as? String,
            let destructionDate = json["selfDestructionDate"] as? String?
        else {return nil}
        let customColor: UIColor
        if let color = json["color"] as? [String: CGFloat],
            let red = color["red"],
            let green = color["green"],
            let blue = color["blue"],
            let alpha = color["alpha"] {
            customColor = UIColor(red: red, green: green, blue: blue,
                                      alpha: alpha)
        } else {
            customColor = UIColor.white
        }
        let fmt = DateFormatter()
        fmt.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let selfDestructionDate: Date?
        if let destructionDate = destructionDate {
            selfDestructionDate = fmt.date(from: destructionDate)
        } else {
            selfDestructionDate = nil
        }
        if let importanceString = json["importance"] as? String, let importance = Importance(rawValue: importanceString) {
            let note = Note.init(uid: uid, title: title, content: content, color: customColor, importance: importance, selfDestructionDate: selfDestructionDate)
            return note
        }
            else {
            let importance = Importance.ordinary
            let note = Note.init(uid: uid, title: title, content: content, color: customColor, importance: importance, selfDestructionDate: selfDestructionDate)
            return note
        }
    }
    
    var json: [String: Any] {
        var json: [String: Any] = [:]
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        json["uid"] = uid
        json["title"] = title
        json["content"] = content
        if importance != .ordinary {
            json["importance"] = importance.rawValue
        }
        if color != .white {
            color.getRed(&r, green: &g, blue: &b, alpha: &a)
            var dictionary: [String: CGFloat] = [:]
            dictionary["red"] = r
            dictionary["green"] = g
            dictionary["blue"] = b
            dictionary["alpha"] = a
            json["color"] = dictionary
        }
        if let destructionDate = selfDestructionDate {
            let fmt = DateFormatter()
            fmt.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let str = fmt.string(from: destructionDate)
            json["selfDestructionDate"] = str
        } else {
            json["selfDestructionDate"] = nil
        }
        return json
    }
}
