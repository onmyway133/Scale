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

// MARK: NSURL
extension NSURL {
    func parentDirectory() -> NSURL {
        return self.URLByDeletingLastPathComponent!
    }

    func append(pathComponent: String) -> NSURL {
        return self.URLByAppendingPathComponent(pathComponent)
    }

    var correctPath: String {
        return path ?? ""
    }
}

// MARK: String
extension String {
    func substring(range: NSRange) -> String {
        return (self as NSString).substringWithRange(range)
    }

    func split(separator: String) -> [String] {
        return (self as NSString).componentsSeparatedByString(separator)
    }

    func remove(string: String) -> String {
        return (self as NSString).stringByReplacingOccurrencesOfString(string, withString: "")
    }
}

// MARK: NSRegularExpression
extension NSRegularExpression {
    class func find(pattern: String, string: String) throws -> [String] {
        let regex = try NSRegularExpression(pattern: pattern, options: [.CaseInsensitive])
        let results = regex.matchesInString(string, options: [], range: NSMakeRange(0, string.characters.count))

        return results.flatMap { result in
                    return result.range
                }.flatMap { range in
                    return string.substring(range)
                }
    }
}

// MARK: Path
func currentDirectory() -> NSURL {
    return NSURL(fileURLWithPath: NSFileManager.defaultManager().currentDirectoryPath)
}

func definitionPath() -> NSURL {
    return currentDirectory().parentDirectory().append("Definitions")
}

func defFileNames() throws -> [String] {
    return try NSFileManager.defaultManager().contentsOfDirectoryAtPath(definitionPath().correctPath).filter {
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
    var units = [String: String]()
    var defaultScale = ""

    init() {

    }

    var enumName: String {
        return name + "Unit"
    }
}

// ACTION
func action() throws {
    let templatePath = definitionPath().append("Template.t").correctPath
    let template = try read(templatePath)

    let outputPath = currentDirectory().parentDirectory().append("Output")

    for defFileName in try defFileNames() {
        let defPath = definitionPath().append(defFileName).correctPath

        let def = try read(defPath)
        let definition = try parse(def)

        let result = apply(template, definition: definition)
        let resultPath = outputPath.append(definition.name + ".swift")

        try write(resultPath.correctPath, content: result)
    }
}

// MARK: Parse
func parse(def: String) throws -> Definition {
    let definition = Definition()

    definition.name = try {
        guard let match = try NSRegularExpression.find("enum\\s\\w+Unit", string: def).first else {
            return ""
        }

        return match.remove("Unit").split(" ").last ?? ""
    }()

    definition.units = try {
        var units = [String: String]()

        try NSRegularExpression.find("case.+", string: def).forEach { match in
            let trim = match.remove("case").remove(" ").split("=")

            units[trim.first ?? ""] = trim.last ?? ""
        }

        return units
    }()


    definition.defaultScale = try {
        guard let match = try NSRegularExpression.find("\\w+.rawValue", string: def).first else {
            return ""
        }

        return match.split(".").first ?? ""
    }()

    return definition
}

func apply(template: String, definition: Definition) -> String {
    return ""
}

// MAIN
try action()