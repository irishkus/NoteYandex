//
//  FileNotebook.swift
//  Note
//
//  Created by Ирина Соловьева on 23/06/2019.
//  Copyright © 2019 Ирина Соловьева. All rights reserved.
//

import Foundation
import UIKit

class FileNotebook {
    public private(set) var notes: [Note] = []
    var notesDict = [String: Any]()

    public func add(_ note: Note) {
//        DDLog.add(DDTTYLogger(),with:.info)
//        DDLogInfo("Добавлена заметка")
        notes.append(note)
    }

    public func remove(with uid: String) {
        for note in 0...notes.count-1 {
            if notes[note].uid == uid {
                notes.remove(at: note)
               // DDLogInfo("Заметка удалена")
                break
            }
        }
    }

    public func saveToFile() {
        guard let cachesPath = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else {return}
        var isDir: ObjCBool = false
        let file = "notes.txt"
        var allNotesData = Data()
        for note in notes {
            notesDict[note.uid] = note.json
        }
        do {
            allNotesData = try JSONSerialization.data(withJSONObject: notesDict, options: [])
        }  catch {
            print(error.localizedDescription)
        }
        let fileURL = cachesPath.appendingPathComponent(file)
        if FileManager.default.fileExists(atPath: fileURL.path, isDirectory: &isDir),
            isDir.boolValue {
            do {
                try allNotesData.write(to: fileURL.absoluteURL, options: [])
            } catch {
                print(error.localizedDescription)
            }
        } else {
            FileManager.default.createFile(atPath: fileURL.path, contents: allNotesData, attributes: nil)
        }
    }

    public func loadFromFile() {
        guard let cachesPath = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else {return}
        let file = "notes.txt"
        let fileURL = cachesPath.appendingPathComponent(file)
        do {
            guard let data = FileManager.default.contents(atPath: fileURL.path) else {return}
            notesDict = try JSONSerialization.jsonObject(with: data, options: []) as! [String : Any]
            notes = []
            notesDict.forEach { (arg0) in
                let (_, value) = arg0
                guard let valueDict = value as? [String : Any] else {return}
                guard let parseNote = Note.parse(json: valueDict) else {return}
                notes.append(parseNote)
            }
        } catch {
            print(error)
        }
    }
}


