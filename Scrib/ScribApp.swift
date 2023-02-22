//
//  Text_EditorApp.swift
//  Text Editor
//
//  Created by Graham Hall on 2/19/23.
//

import SwiftUI

@main
struct Text_EditorApp: App {
    var body: some Scene {
        DocumentGroup(newDocument: TextFile()) { file in
            ContentView(document: file.$document)
        }
    }
}
