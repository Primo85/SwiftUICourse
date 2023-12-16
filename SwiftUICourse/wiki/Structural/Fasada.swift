import Foundation

protocol ClientInterface {
    func operation()
}

struct Fasada: ClientInterface {
    private let subSystem1: Any
    private let subSystem2: Any
    private let subSystem3: Any
    
    func operation() {
        // some code using sub systems
    }
}

/*
 PLUSY:
 
- Można odizolować kod od złożoności podsystemu.
 
 MINUSY:
 
 - Fasada może stać się boskim obiektem sprzężonym ze wszystkimi klasami aplikacji.
 
 */
