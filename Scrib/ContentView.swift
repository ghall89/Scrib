//
//  ContentView.swift
//  Text Editor
//
//  Created by Graham Hall on 2/19/23.
//

import SwiftUI
import Markdown
import UniformTypeIdentifiers

struct TextFile: FileDocument{

    static var readableContentTypes = [UTType.plainText]
    
    var text = ""
    
    init(initialText: String = "") {
        text = initialText
    }
    
    init(configuration: ReadConfiguration) throws {
        if let data = configuration.file.regularFileContents {
            text = String(decoding: data, as: UTF8.self)
        } else {
            throw CocoaError(.fileReadCorruptFile)
        }
    }
    
    func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
        let data = Data(text.utf8)
        return FileWrapper(regularFileWithContents: data)
    }
}

struct ContentView: View {
    @Binding var document: TextFile

    @State private var preview = false
    
    var body: some View {
        HStack {
            
            
            if preview == false {
                TextEditor(text: $document.text).font(.custom("Monaco", size: 14))
            } else if preview == true {
                Markdown(content: $document.text).markdownStyle(
                    MarkdownStyle(
                      padding: 10
                    )
                )
            }
        }
        .toolbar {
            
                Button(action: {
                    preview = !preview
                }) {
                    Label("Toggle Preview", systemImage: "eye")
                }
               
            
        }
    }
    
}


//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
