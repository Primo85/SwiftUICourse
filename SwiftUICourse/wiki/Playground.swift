import Foundation

struct Playground {
    
    func start() {
        print("start")
        do {
//            let details = try await getDetails()
        }
    }
    
    private func startConc(completion: () -> Void) {
        print("start conc")
        
    }
    
    private func getDetails() async -> String {
        sleep(4)
        return "some details"
    }
}
