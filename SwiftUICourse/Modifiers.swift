import SwiftUI

extension View {
    func backgroundGradient(colors: [Color]? = nil) -> some View {
        modifier(BackgroundGradient(colors: colors))
    }
    func transparentBackground() -> some View {
        modifier(TransparentBackground())
    }
    func onAnimationCompleted<Value: VectorArithmetic>(for value: Value, completion: @escaping () -> Void) -> ModifiedContent<Self, AnimationCompletionObserverModifier<Value>> {
        return modifier(AnimationCompletionObserverModifier(observedValue: value, completion: completion))
    } // TODO: read this modifier
    
    /// Applies the given transform if the given condition evaluates to `true`.
    /// - Parameters:
    ///   - condition: The condition to evaluate.
    ///   - transform: The transform to apply to the source `View`.
    /// - Returns: Either the original `View` or the modified `View` if the condition is `true`.
    @ViewBuilder func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
}

struct BackgroundGradient: ViewModifier {
    
    @Environment(\.colorScheme) var colorScheme
    
    let colors: [Color]?
    
    init(colors: [Color]?) {
        self.colors = colors
    }
    
    private var defaultColors: [Color] {
        colorScheme == .dark ? [.black, .blue] : [.orange, .yellow]
    }
    
    func body(content: Content) -> some View {
        content
            .background(LinearGradient(colors: colors ?? defaultColors,
                                       startPoint: .topLeading,
                                       endPoint: .bottomTrailing))
    }
}

struct TransparentBackground: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .background(Color.appTransparent)
    }
}

struct AnimationCompletionObserverModifier<Value>: AnimatableModifier where Value: VectorArithmetic {

    /// While animating, SwiftUI changes the old input value to the new target value using this property. This value is set to the old value until the animation completes.
    var animatableData: Value {
        didSet {
            notifyCompletionIfFinished()
        }
    }

    /// The target value for which we're observing. This value is directly set once the animation starts. During animation, `animatableData` will hold the oldValue and is only updated to the target value once the animation completes.
    private var targetValue: Value

    /// The completion callback which is called once the animation completes.
    private var completion: () -> Void

    init(observedValue: Value, completion: @escaping () -> Void) {
        self.completion = completion
        self.animatableData = observedValue
        targetValue = observedValue
    }

    /// Verifies whether the current animation is finished and calls the completion callback if true.
    private func notifyCompletionIfFinished() {
        guard animatableData == targetValue else { return }

        /// Dispatching is needed to take the next runloop for the completion callback.
        /// This prevents errors like "Modifying state during view update, this will cause undefined behavior."
        DispatchQueue.main.async {
            self.completion()
        }
    }

    func body(content: Content) -> some View {
        /// We're not really modifying the view so we can directly return the original input value.
        return content
    }
}


extension Color {
    static let appTransparent = Color(white: 0.5, opacity: 0.2)
    static let appDarkTransparent = Color(white: 0.2, opacity: 0.2)
}
