//
//  Script.swift
//  Pods
//
//  Created by Khoa Pham on 1/6/16.
//  Copyright © 2016 Fantageek. All rights reserved.
//

/*
HOW TO RUN THIS SCRIPT

Way 1
xcrun swift Script.swift

Way 2
Declare #!/usr/bin/env xcrun swift -i at the top of the file
*/


import Foundation

// MARK: Path
extension NSURL {
    func parentDirectory() -> NSURL {
        return self.URLByDeletingLastPathComponent!
    }

    func append(pathComponent: String) -> NSURL {
        return self.URLByAppendingPathComponent(pathComponent)
    }
}

func currentDirectory() -> NSURL {
    return NSURL(fileURLWithPath: NSFileManager.defaultManager().currentDirectoryPath)
}

func definitionPath() -> NSURL {
    return currentDirectory().parentDirectory().append("Definitions")
}

func defFilePaths() throws -> [String] {
    return try NSFileManager.defaultManager().contentsOfDirectoryAtPath(definitionPath().absoluteString).filter {
        return $0.containsString(".def")
    }
}

// READ
func read(filePath: String) throws -> String {
    return try String(contentsOfFile: filePath)
}

// WRITE
func write(filePath: String, content: String) throws {
    try content.writeToFile(filePath, atomically: false, encoding: NSUTF8StringEncoding)
}

// DATA
class Definition {
    var name = ""
    var units = [String]()

    init() {

    }

    var enumName: String {
        return name + "Unit"
    }
}

// ACTION
func action() throws {
    let templatePath = definitionPath().append("Template.t").absoluteString
    let template = try read(templatePath)

    let outputPath = currentDirectory().parentDirectory().append("Output")

    for defPath in try defFilePaths() {
        let def = try read(defPath)
        let definition = parse(def)

        let result = apply(template, definition: definition)
        let resultPath = outputPath.append(definition.name + ".swift")

        try write(resultPath.absoluteString, content: result)
    }
}

func parse(def: String) -> Definition {
    let definition = Definition()

    return definition
}

func apply(template: String, definition: Definition) -> String {
    return ""
}

// MAIN
//try action()