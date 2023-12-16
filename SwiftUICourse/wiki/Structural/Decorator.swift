import Foundation

protocol Component {
    func operation() -> String
}

struct SomeComponent: Component {
    func operation() -> String { return "comp." }
}

class Decorator: Component {
    private let component: Component
    
    init(component: Component) { self.component = component }
    
    func operation() -> String { component.operation() }
}

class DecoratorA: Decorator {
    override func operation() -> String { "A " + super.operation() }
}

class DecoratorB: Decorator {
    override func operation() -> String { "B " + super.operation() }
}

class DecoratorC: Decorator {
    override func operation() -> String { "C " + super.operation() }
}

/*
 PLUSY:
 
- Można rozszerzać zachowanie obiektu bez tworzenia podklasy.
 
- Można dodawać lub usuwać obowiązki obiektu w trakcie działania programu.
 
- Możliwe jest łączenie wielu zachowań poprzez nałożenie wielu dekoratorów na obiekt.
 
- Zasada pojedynczej odpowiedzialności. Można podzielić klasę monolityczną,
 która implementuje wiele wariantów zachowań, na mniejsze klasy.
 
 MINUSY:
 
- Zabranie jednej konkretnej nakładki ze środka stosu nakładek jest trudne.
 
- Trudno jest zaimplementować dekorator w taki sposób, aby jego zachowanie nie zależało od kolejności ułożenia nakładek na stosie.
 
- Kod wstępnie konfigurujący warstwy może wyglądać brzydko.
 
 */
