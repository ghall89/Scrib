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
    @State private var fontSize = 14.0
    
    var body: some View {
        HStack {
            
            
            if preview == false {
              
              TextEditor(text: $document.text).font(.system(size: fontSize).monospaced()).disableAutocorrection(false)
                
            } else if preview == true {
                Markdown(content: $document.text).markdownStyle(
                    MarkdownStyle(
                      padding: 10
                    )
                )
            }
        }
        .toolbar {
          
          Menu {
            ForEach(10..<30, id: \.self) { size in
              Button(action: {
                fontSize = CGFloat(size)
              }) {
                Text("\(size)")
                  .font(.system(size: CGFloat(size)))
              }
            }
          } label: {
            Label("Font Size", systemImage: "textformat.size")
          }
          
            
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
