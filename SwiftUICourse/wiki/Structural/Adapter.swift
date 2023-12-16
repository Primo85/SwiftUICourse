import Foundation

protocol Target {
    func operation() -> String
}

class IncompatibleClass {
    func incompatibleOperation() -> Int { return 7 }
}

// MARK: method 1:

class Adapter: Target {
    private let source: IncompatibleClass
    
    init(source: IncompatibleClass) { self.source = source }
    
    func operation() -> String { "\(source.incompatibleOperation())" }
}

// MARK: method 2:

extension IncompatibleClass: Target {
    func operation() -> String { "\(self.incompatibleOperation())"}
}

/*
 PLUSY:
 
- Zasada pojedynczej odpowiedzialności. Można oddzielić interfejs lub kod
 konwertujący dane od głównej logiki biznesowej programu.
 
- Zasada otwarte/zamknięte. Można wprowadzać do programu nowe typy adapterów
 bez psucia istniejącego kodu klienckiego, o ile będzie on korzystał z adapterów
 poprzez interfejs kliencki.
 
 MINUSY:
 
- Ogólna złożoność kodu zwiększa się, ponieważ trzeba wprowadzić zestaw nowych interfejsów i klas.
 Czasem łatwiej zmienić klasę udostępniającą jakąś potrzebną usługę, aby pasowała do reszty kodu.

 */
