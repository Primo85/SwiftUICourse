import SwiftUI
import Combine

final class MemoTestViewModel: ObservableObject {
    
    private let gameSet: [Int] = [3,3,3,4,4,4,5,5,5,6]
    private let player: Player
    
    @Published private(set) var table: [MemoCell] = []
    @Published private(set) var failures: String = ""
    @Published private(set) var succesess: String = ""
    @Published var isSummaryPresented: Bool = false
    
    let size = CurrentValueSubject<Int, Never>(3)
    private let isUserInteractionEnabled = CurrentValueSubject<Bool, Never>(false)
    private let setIndex = CurrentValueSubject<Int, Never>(0)
    let failureCounter = CurrentValueSubject<Int, Never>(0)
    let successCounter = CurrentValueSubject<Int, Never>(0)
    let result = CurrentValueSubject<GameResult?, Never>(nil)
    
    private var subjects = Set<AnyCancellable>()
    
    init(player: Player) {
        self.player = player
        bind()
    }
    
    private func bind() {
        size
            .dropFirst()
            .sink { [weak self] in  self?.setTable($0) }
            .store(in: &subjects)
        
        size
            .map { _ in false }
            .assign(to: \.value, on: isUserInteractionEnabled)
            .store(in: &subjects)
        
        size
            .delay(for: 2, scheduler: RunLoop.main)
            .map { _ in true }
            .assign(to: \.value, on: isUserInteractionEnabled)
            .store(in: &subjects)
        
        size
            .delay(for: 3, scheduler: RunLoop.main)
            .sink { [weak self] _ in self?.coverAll() }
            .store(in: &subjects)
        
        failureCounter
            .map { "F: \($0)" }
            .assign(to: &$failures)
        
        successCounter
            .map { "S: \($0)" }
            .assign(to: &$succesess)
        
        failureCounter
            .combineLatest(successCounter)
            .map { _ in false }
            .assign(to: \.value, on: isUserInteractionEnabled)
            .store(in: &subjects)
        
        failureCounter
            .combineLatest(successCounter, result)
            .filter { !($0 == 0 && $1 == 0) && $2 == nil }
            .delay(for: 1, scheduler: RunLoop.main)
            .sink { [weak self] _ in
                print("combine counters")
                self?.setIndex.value++
            }
            .store(in: &subjects)
        
        setIndex
            .filter { [weak self] in $0 < self?.gameSet.count ?? 0 }
            .map { [weak self] in self?.gameSet[$0] ?? 2 }
            .assign(to: \.value, on: size)
            .store(in: &subjects)
        
        setIndex
            .sink { [weak self] in
                if $0 == self?.gameSet.count {
                    self?.result.send(.victory(self?.player.name ?? ""))
                }
            }
            .store(in: &subjects)
        
        result
            .map { $0 != nil }
            .filter { $0 }
            .delay(for: 0.5, scheduler: RunLoop.main)
            .assign(to: &$isSummaryPresented)
    }
    
    func click(on id: String) {
        guard isUserInteractionEnabled.value,
              let i = table.firstIndex(where: { $0.id == id }) else { return }
        table[i].state = .discover
        if table[i].content == .empty {
            table[i].content = .failed
            failureCounter.value++
            showSolution()
        } else {
            var solidCounter = 0
            table.forEach { if $0.content == .solid { solidCounter++ } }
            var resolvedCounter = 0
            table.forEach { if $0.content == .solid && $0.state == .discover { resolvedCounter++ } }
            print(solidCounter, resolvedCounter)
            if solidCounter == resolvedCounter {
                successCounter.value++
                showSolution()
            }
        }
    }
    
    private func setTable(_ n: Int) {
        print("set Table")
        var table: [MemoCell] = []
        for _ in 0..<n*n { table.append(MemoCell(state: .discover)) }
        self.table = table
    }
    
    private func coverAll() {
        for i in 0..<table.count {
            table[i].state = .cover
        }
    }
    
    private func showSolution() {
        for i in 0..<self.table.count {
            self.table[i].resolved = true
            self.table[i].state = .discover
        }
    }
    
    func reset() {
        print("rest")
        failureCounter.value = 0
        successCounter.value = 0
        result.send(nil)
        setIndex.value = 0
    }
}

struct MemoCell: Identifiable {
    let id: String = UUID().uuidString
    fileprivate var content: MemoContent = [.solid, .empty].randomElement()!
    fileprivate var state: MemoState
    fileprivate(set) var resolved: Bool = false
    
    var visibleContent: MemoContent {
        switch state {
            case .cover:
                    .empty
            case .discover:
                content
        }
    }
}

enum MemoContent {
    case solid
    case empty
    case failed
}

enum MemoState {
    case cover
    case discover
}

struct MemoTestResult {
    let fal: Int
    let suc: Int
}
