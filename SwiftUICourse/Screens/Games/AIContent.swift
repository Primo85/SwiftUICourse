import Foundation
import SwiftUI

import SwiftUI

struct AIContentView: View {
    @State private var board = Array(repeating: Array(repeating: "", count: 3), count: 3)
    @State private var currentPlayer = "X"
    @State private var isGameOver = false
    @State private var winningCells: Set<Cell> = []
    @State private var winningPlayer = ""
    
    var body: some View {
        VStack {
            ForEach(0..<3) { row in
                HStack {
                    ForEach(0..<3) { col in
                        Button(action: {
                            if board[row][col].isEmpty && !isGameOver {
                                board[row][col] = currentPlayer
                                currentPlayer = currentPlayer == "X" ? "O" : "X"
                                checkForWin()
                            }
                        }) {
                            Text(board[row][col])
                                .font(.largeTitle)
                                .frame(width: 100, height: 100)
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                                .overlay(winningCells.contains(Cell(row: row, col: col)) ? lineAnimation : nil)
                        }
                    }
                }
            }
        }
        .padding()
        .background(Color.white)
        .alert(isPresented: $isGameOver) {
                    Alert(title: Text("Game Over"), message: Text("Player \(winningPlayer) wins!"), dismissButton: .default(Text("Play Again"), action: {
                        resetGame()
                    }))
                }
    }
    
    private func resetGame() {
            board = Array(repeating: Array(repeating: "", count: 3), count: 3)
            currentPlayer = "X"
            isGameOver = false
            winningPlayer = ""
        }
    
    private func checkForWin() {
        let winningCombinations: [[Cell]] = [
            [Cell(row: 0, col: 0), Cell(row: 0, col: 1), Cell(row: 0, col: 2)],
            [Cell(row: 1, col: 0), Cell(row: 1, col: 1), Cell(row: 1, col: 2)],
            [Cell(row: 2, col: 0), Cell(row: 2, col: 1), Cell(row: 2, col: 2)],
            [Cell(row: 0, col: 0), Cell(row: 1, col: 0), Cell(row: 2, col: 0)],
            [Cell(row: 0, col: 1), Cell(row: 1, col: 1), Cell(row: 2, col: 1)],
            [Cell(row: 0, col: 2), Cell(row: 1, col: 2), Cell(row: 2, col: 2)],
            [Cell(row: 0, col: 0), Cell(row: 1, col: 1), Cell(row: 2, col: 2)],
            [Cell(row: 2, col: 0), Cell(row: 1, col: 1), Cell(row: 0, col: 2)]
        ]
        
        for combination in winningCombinations {
            let cell1 = combination[0]
            let cell2 = combination[1]
            let cell3 = combination[2]
            
            if board[cell1.row][cell1.col] == currentPlayer &&
                board[cell2.row][cell2.col] == currentPlayer &&
                board[cell3.row][cell3.col] == currentPlayer {
                isGameOver = true
                winningPlayer = currentPlayer
                winningCells = Set(combination)
            }
        }
    }
    
    private var lineAnimation: some View {
        GeometryReader { geometry in
            Path { path in
                let cellSize = geometry.size.width / 3
                let startX = cellSize / 2
                let startY = cellSize / 2
                
                let firstCell = winningCells.first!
                let endX = startX + (cellSize * CGFloat(firstCell.col))
                let endY = startY + (cellSize * CGFloat(firstCell.row))
                
                path.move(to: CGPoint(x: startX, y: startY))
                path.addLine(to: CGPoint(x: endX, y: endY))
            }
            .stroke(Color.red, lineWidth: 8)
            .animation(.linear(duration: 0.5))
        }
    }
}

struct Cell: Hashable {
    let row: Int
    let col: Int
}
