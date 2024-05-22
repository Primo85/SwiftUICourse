import XCTest
import Combine
@testable import SwiftUICourse

final class TicTacToeViewModelTests: XCTestCase {
    
    private let viewModel: TicTacToeViewModel = {
        let players: [Player] = [Player(name: "Player1"),
                                 Player(name: "Player2")]
        return TicTacToeViewModel(players: players)
    }()
    
    func test_win_in_5() {
        viewModel.click(on: "00")
        XCTAssertNil(viewModel.result.value)
        XCTAssertNil(viewModel.line)
        
        viewModel.click(on: "00")
        XCTAssertNil(viewModel.result.value)
        XCTAssertNil(viewModel.line)
        
        viewModel.click(on: "01")
        XCTAssertNil(viewModel.result.value)
        XCTAssertNil(viewModel.line)
        
        viewModel.click(on: "10")
        XCTAssertNil(viewModel.result.value)
        XCTAssertNil(viewModel.line)
        
        viewModel.click(on: "11")
        XCTAssertNil(viewModel.result.value)
        XCTAssertNil(viewModel.line)
        
        viewModel.click(on: "20")
        XCTAssertNotNil(viewModel.result.value)
        XCTAssertNotNil(viewModel.line)
        
        XCTAssertEqual(viewModel.result.value, .victory("Player1"))
        XCTAssertEqual(viewModel.line, TicTacToeLineType.y(0.0))
    }
    
    func test_win_in_6() {
        viewModel.click(on: "00")
        XCTAssertNil(viewModel.result.value)
        XCTAssertNil(viewModel.line)
        
        viewModel.click(on: "01")
        XCTAssertNil(viewModel.result.value)
        XCTAssertNil(viewModel.line)
        
        viewModel.click(on: "10")
        XCTAssertNil(viewModel.result.value)
        XCTAssertNil(viewModel.line)
        
        viewModel.click(on: "11")
        XCTAssertNil(viewModel.result.value)
        XCTAssertNil(viewModel.line)
        
        viewModel.click(on: "22")
        XCTAssertNil(viewModel.result.value)
        XCTAssertNil(viewModel.line)
        
        viewModel.click(on: "21")
        XCTAssertNotNil(viewModel.result.value)
        XCTAssertNotNil(viewModel.line)
        
        XCTAssertEqual(viewModel.result.value, .victory("Player2"))
        XCTAssertEqual(viewModel.line, TicTacToeLineType.y(1.0))
    }
}
