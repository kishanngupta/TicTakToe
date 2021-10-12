//
//  TicTakToeVM.swift
//  TicTakToe
//
//  Created by mac on 12/10/21.
//

import Foundation

protocol ViewModelProtocol {
    func showAlert(status:String)
}

class TicTacToeVM {
    private var ticTakToeModel = TicTakToeModel()
    private var ticTacToeManager: TicTacToeManager!
    var delegate: ViewModelProtocol!
    
    init(delegate: ViewModelProtocol) {
        ticTacToeManager = TicTacToeManager(board: ticTakToeModel.board,
                                            winningBoard: ticTakToeModel.winningBoard)
        self.delegate = delegate
    }
    
    private func checkStatus() -> GameState {
        return ticTacToeManager.checkStatus()
    }
    
    func resetBoard() {
        ticTacToeManager.resetBoard()
    }
    
    func updateBoard(tag: Int) -> String {
        var btnTextValue: String
        var btnBoardValue: Int
        switch checkStatus() {
        case .xTern:
            btnTextValue = "X"
            btnBoardValue = 1
        case .oTern:
            btnTextValue = "O"
            btnBoardValue = 2
        default:
            btnTextValue = "-"
            btnBoardValue = 0
        }
        ticTacToeManager.updateBoard(tag: tag,btnBoardValue: btnBoardValue)
        return btnTextValue
    }
    
    func updateState() {
        print(checkStatus().rawValue)
        if  checkStatus().rawValue == "O wins"{
            self.delegate.showAlert(status: "Congrats O win!")
        } else if checkStatus().rawValue == "X wins" {
            self.delegate.showAlert(status: "Congrats X win!")
        } else if checkStatus().rawValue == "Game Draw"{
            self.delegate.showAlert(status: "OOP! Game Draw!")
        }
    }
}
