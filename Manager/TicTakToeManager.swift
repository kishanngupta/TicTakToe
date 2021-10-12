//
//  ViewController.swift
//  TicTakToe
//
//  Created by mac on 12/10/21.
//
import Firebase

enum GameState : String {
    case xTern = "X turn"
    case oTern = "O turn"
    case draw = "Game Draw"
    case xWin = "X wins"
    case oWin = "O wins"
}

class TicTacToeManager {
    private var ref: DatabaseReference!
    private var board: [[Int]]!
    private var winningBoard: [[[Int]]]!
    
    init(board: [[Int]], winningBoard: [[[Int]]]) {
        ref = Database.database().reference()
        self.board = board
        self.winningBoard = winningBoard
        // Observer added on Object creation
        firebaseObserver()
    }
    
    deinit {
        // Observer removed in destructor
        ref.removeValue()
        ref.removeAllObservers()
    }
    
    private func firebaseObserver() {

        ref.getData { error, snapshot in
            guard error == nil else {
                print(error?.localizedDescription as Any)
                return;
            }
            
            if let player = snapshot.value as? String {
                //let index = snapshot.key (position selected over the board)
                
                //TODO:- Parsing data and update the board variable and call checkStatus function will automatically do the rest of the work
            }
        }
    }
    
    func resetBoard() {
        board = [[Int]](repeating: [Int](repeating: 0, count: 3), count: 3)
        //removing data from firebase
        self.ref.removeValue()
    }
    
    func updateBoard(tag: Int,btnBoardValue: Int) {
        
        let firstIndex = (tag-1)/3
        let secondIndex = (tag-1)%3
        board[firstIndex][secondIndex] = btnBoardValue
        // Data updated over the firebase
        let firstRow = self.ref.child("\(firstIndex)")
        firstRow.child("\(secondIndex)").setValue( btnBoardValue)
    }

    func checkStatus() -> GameState {
        if checkForWinner(val: 1) { // x
            return .xWin
        } else if checkForWinner(val: 2) { // O
            return .oWin
        } else {
            var xCount = 0, oCount = 0, dotCount = 0
            for i in 0..<3 {
                for j in 0..<3 {
                    switch board[i][j] {
                    case 1: // x
                        xCount += 1
                    case 2: // O
                        oCount += 1
                    default:
                        dotCount += 1
                    }
                }
            }

            if dotCount == 0 {
                return .draw
            } else if xCount > oCount {
                return .oTern
            } else {
                return .xTern
            }
        }
    }

    private func checkForWinner(val: Int) -> Bool {
        var counter = 0
        for wBoard in winningBoard {
            counter = 0
            for i in 0..<3 {
                for j in 0..<3 {
                    if wBoard[i][j] == 1 {
                        if board[i][j] == val {
                            counter += 1
                        }
                    }
                }
            }
            if (counter == 3) {
                return true
            }
        }
        return false
    }

}
