import SwiftUI

@main
struct SwiftUICourseApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
//            MainView()
            GamesView()
//            CombineTestView()
//            TestView()
//            HexSaperGameView(player: Player(name: "Przemo"), isPresented: .constant(true))
//            GuitarView()
//            Text("Hello world")
//                .onAppear() {
//                    Playground().start()
//                }
//            Image(systemName: "mountain.2")
//                .resizable()
//                .scaledToFit()
//                .frame(width: 256, height: 256)
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        let configuration = UISceneConfiguration(name: nil, sessionRole: connectingSceneSession.role)
        if connectingSceneSession.role == .windowApplication {
            configuration.delegateClass = SceneDelegate.self
        }
        return configuration
    }
}

class SceneDelegate: NSObject, ObservableObject, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
//    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
//        guard let windowScene = scene as? UIWindowScene else { return }
//        let window = windowScene.keyWindow
////        window?.backgroundColor = .green
//        self.window = window
//    }
}
