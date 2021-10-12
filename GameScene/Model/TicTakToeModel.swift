//
//  TicTakToeModel.swift
//  TicTakToe
//
//  Created by mac on 12/10/21.
//

import Foundation

class TicTakToeModel {
    
    var board = [[Int]](repeating: [Int](repeating: 0, count: 3), count: 3)
    
    let winningBoard = [
        [[1,1,1],[0,0,0],[0,0,0]],
        [[0,0,0],[1,1,1],[0,0,0]],
        [[0,0,0],[0,0,0],[1,1,1]],

        [[1,0,0],[1,0,0], [1,0,0]],
        [[0,1,0],[0,1,0], [0,1,0]],
        [[0,0,1],[0,0,1], [0,0,1]],

        [[1,0,0],[0,1,0], [0,0,1]],
        [[0,0,1],[0,1,0], [1,0,0]],
        ]
}
