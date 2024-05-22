import SwiftUI
import Combine

typealias Size = (x: Int, y: Int)

final class SudokuViewModel: ObservableObject {
    
    let size: Size
    let rowSize: Int
    let ratio: Double
    let player: Player
    
    @Published private(set) var cells: [Sudoku] = []
    @Published var fails: Int = 0
    @Published var successes: Int = 0
    @Published var status: String = "?"
    @Published var isSummaryPresented: Bool = false
    let result = CurrentValueSubject<GameResult?, Never>(nil)
    
    private var subjects = Set<AnyCancellable>()
    
    private var selectedID: String?
    
    init(size: Size, player: Player) {
        self.size = size
        self.rowSize = size.x * size.y
        self.ratio = Double(size.y)/Double(size.x)
        self.player = player
        setCells()
        bind()
    }
    
    private func bind() {
        result
            .map { $0 != nil }
            .filter { $0 }
            .delay(for: 1, scheduler: RunLoop.main)
            .assign(to: &$isSummaryPresented)
        
        result
//            .compactMap { $0 }
            .sink { [weak self] in
                if case .victory(_) = $0 {
                    self?.successes++
                    self?.status = String.winEmoji
                } else if case .defeat = $0 {
                    self?.fails++
                    self?.status = String.lossEmoji
                } else {
                    self?.status = "?"
                }
            }
            .store(in: &subjects)
        
//        result
//            .
    }
    
    private func setCells() {
        var tab: [Sudoku] = []
        for x in 0..<rowSize {
            for y in 0..<rowSize {
                let z = "\(x/size.x)\(y/size.y)"
                tab.append(Sudoku(x: x, y: y, z: z))
            }
        }
        cells = tab
    }
    
    func reset() {
        setCells()
        result.value = nil
    }
    
    func click(on id: String?) {
        if let i = cells.firstIndex(where: { $0.id == selectedID} ) {
            cells[i].isSelected = false
        }
        selectedID = id
        guard let j = cells.firstIndex(where: { $0.id == selectedID} ) else { return }
        cells[j].isSelected = true
        print("selected id: \(id ?? "nil") x: \(cells[j].x) y: \(cells[j].y) z: \(cells[j].z) ")
    }
    
    func sendValue(_ value: Int?) {
//        guard result.value == nil else { return }
        guard let i = cells.firstIndex(where: { $0.id == selectedID} ) else { return }
        cells[i].value = value
        guard let value = value else { return }
        let x = cells[i].x
        let y = cells[i].y
        let z = cells[i].z
        if cells.contains(where: { $0.x == x && $0.value == value && $0.id != selectedID })
            || cells.contains(where: { $0.y == y && $0.value == value && $0.id != selectedID })
            || cells.contains(where: { $0.z == z && $0.value == value && $0.id != selectedID }) {
            result.send(.defeat)
        } else if !cells.contains(where: { $0.value == nil }) {
            result.send(.victory(player: player.name))
        } else {
            result.send(nil)
        }
    }
}

struct Sudoku: Identifiable {
    let id: String = UUID().uuidString
    let x: Int
    let y: Int
    let z: String
    var isSelected: Bool = false
    var value: Int?
    var display: String { String(value) ?? " " }
}
