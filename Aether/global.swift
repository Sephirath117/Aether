//
//  File.swift
//  Aether
//
class Main {
    var name:String
    var myQs:[String]
    var answers:[String]
    var question:String
    init(name:String) {
        self.name = name
        self.myQs = [String]()
        self.answers = [String]()
        self.question = ""
    }
}
var mainInstance = Main(name:"My Global Class")