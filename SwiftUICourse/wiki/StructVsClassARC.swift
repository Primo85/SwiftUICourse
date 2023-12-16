/*
 common:
 - methods properties subscripts extensions protocols
 class:
 - reference type
 - inheritance typeCasting deinit afc
 struct:
 - value type
 - one free init
 */

import Foundation

class Person {
    let name: String
    
    init(name: String) {
        print("init \(name)")
        self.name = name
        getCount()
    }
    
    deinit {
        print("deinit \(name)")
        getCount()
    }
    
    func getCount() {
        print(name, "references:", CFGetRetainCount(self))
    }
}

var extRef1: Person?
var extRef2: Person?
var extRef3: Person?


func ACRProcess() {
    var object: Person = Person(name: "Clark")
    let nObj = Person(name: "NIL")
    
    var ref1: Person = nObj
    var ref2: Person = nObj
    var ref3: Person = nObj
    
    ref1 = object
    object.getCount()
    ref2 = object
    object.getCount()
//    ref3 = object
//    object.getCount()
//    ref2 = nObj
//    object.getCount()
//    extRef1 = object
//    object.getCount()
//    object = nObj
//    ref1?.getCount()
    
    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
        ref1.getCount()
        cleanExtRefs()
    }
}

func cleanExtRefs() {
    extRef1 = nil
    extRef2 = nil
    extRef3 = nil
}

class HTMLElement {
    let name: String
    let text: String?
    
    lazy var asHTML: () -> String = { [weak self] in
        guard let self = self else { return "" }
        if let text = self.text {
            return "<\(self.name)>\(text)</\(self.name)>"
        } else {
            return "<\(self.name) />"
        }
    }


    init(name: String, text: String? = nil) {
        self.name = name
        self.text = text
    }
}
