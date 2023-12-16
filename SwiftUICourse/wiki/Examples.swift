import Foundation

// TODO: @frozen
// TODO: @autoclosure @escaping

protocol Animal {
    var name: String { get }
}

protocol SoundAble {
    func makeSound()
}

struct Dog: Animal, SoundAble {
    var name: String = "Azor"
    func makeSound() { print("hau") }
}

protocol NoisedAnimalProtocol: Animal, SoundAble { }

struct Cat: NoisedAnimalProtocol {
    var name: String = "Kitty"
    func makeSound() { print("miau") }
}

struct Fish: Animal {
    var name: String = "Vanda"
}

typealias Name = String
typealias Point = (x: Int, y: Int)
typealias NoisedAnimal = Animal & SoundAble
typealias Completion = () -> Void
typealias CompletionHandler<T> = (T) -> Void

struct Place {
    let name: String
    let point: Point
}

struct Student: Hashable {
    let id = UUID().uuidString
    @Capitalized var name: String
}

struct Example {
    
    let noiseAnimals: [NoisedAnimal] = [Dog(), Cat()] // but not Fish()
    
    
    let place = Place(name: "xxx", point: (3,5))
    
    let point: Point  = (2,3)
    var point_x: Int { point.x }
    
    let point2 = Point(3,4)
    var point2_y: Int { point2.y }
    
    let point3 = (5,6)
    var point3_x: Int { point3.0 }
    
    let point4: (lat: Int, lon: Int) = (5,6)
    var point4_y: Int { point4.lon}
    
    func doSomething(completion: Completion) {
        completion()
    }
    
    func doSomething(handler: CompletionHandler<Int>) {
        let x = 7
        handler(x)
    }
    
    static let setOfStudents: Set = [Student(name: "john"), Student(name: "william"), Student(name: "kate"), Student(name: "Kate")]
}



class A {
    static func staticMethod() { }
    class func classMethod() { }
    class func classMethod2() { }
    final class func finalClassMethod() { }
    
    static var x: Int = 0
//    class var y: Int = 0 doesnt support
    
    static var name: String { "aaa" }
    class var type: String { "aaa" }
}

class B: A {
//    override static func staticMethod() { } // cannot
    override class func classMethod() { super.classMethod() }
    override final class func classMethod2() { super.classMethod2() }
    // override class func finalClassMethod() { super.classMethod() }
    
//    override static var x = 1
    
//    override static var name: String { "bbb" }
    override final class var type: String { "bbb" }
}

class C: B {
    override class func classMethod() { super.classMethod() }
//    override class func classMethod2() { super.classMethod2() }
    
//    override class var type: String { "ccc" }
}

// open: you can subclass and override
// public: you can NOT subclass and override

public class SomePublicClass {                  // explicitly public class
    public var somePublicProperty = 0            // explicitly public class member
    var someInternalProperty = 0                 // implicitly internal class member
    fileprivate func someFilePrivateMethod() {}  // explicitly file-private class member
    private func somePrivateMethod() {}          // explicitly private class member
}


class SomeInternalClass {                       // implicitly internal class
    var someInternalProperty = 0                 // implicitly internal class member
    fileprivate func someFilePrivateMethod() {}  // explicitly file-private class member
    private func somePrivateMethod() {}          // explicitly private class member
}


fileprivate class SomeFilePrivateClass {        // explicitly file-private class
    func someFilePrivateMethod() {}              // implicitly file-private class member
    private func somePrivateMethod() {}          // explicitly private class member
}


private class SomePrivateClass {                // explicitly private class
    func somePrivateMethod() {}                  // implicitly private class member
}

class AA {
    var x: Int
    private var y: Int
    let pi: Double = 3.14
    
    init(x: Int, y: Int) {
        self.x = x
        self.y = y
    }
}

class BB: AA {
    var z: Int
    
    override init(x: Int, y: Int) {
        z = 5
        super.init(x: x, y: y)
    }
    
    init(x: Int, y: Int, z: Int) {
        self.z = z
        super.init(x: x, y: y)
    }
    
    convenience init() {
        self.init(x: 3, y: 4)
    }
    
    override var x: Int {
        get {  return z }
        set {  z = newValue }
    }
    
    func fff() throws {
    }
}

let b = BB(x: 3, y: 3)
let bb = BB()

struct SomeError: Error {
    let description: String
}
