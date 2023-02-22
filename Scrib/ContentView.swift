//
//  ContentView.swift
//  Text Editor
//
//  Created by Graham Hall on 2/19/23.
//

import SwiftUI
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

    @State private var selectedTab = 0
    

    
    var body: some View {
        HStack {
            
            
            if selectedTab == 0 {
            
                                    TextEditor(text: $document.text).font(.custom("Monaco", size: 14))
                     
               
            } else if selectedTab == 1 {
                Text("Second View")
            }
        }
        .toolbar {
            
                Button(action: {
                    // Action for "Delete" button
                }) {
                    Label("Delete", systemImage: "eye")
                }
               
            
        }
    }
    
}


//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
