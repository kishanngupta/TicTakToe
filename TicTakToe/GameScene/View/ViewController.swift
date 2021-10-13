//
//  ViewController.swift
//  TicTakToe
//
//  Created by mac on 12/10/21.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    
    var viewModel: TicTacToeVM!

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = TicTacToeVM(delegate: self)
    }

    @IBAction func buttonTapped(sender: UIButton) {
        if sender.title(for: .normal) != "-" {
            return
        }
        let btnTextValue = viewModel.updateBoard(tag: sender.tag)
        sender.setTitle(btnTextValue, for: .normal)
        viewModel.updateState()
    }

    @IBAction func btnResetTapped(sender: UIButton) {
        viewModel.resetBoard()
        for i in 1...9 {
            let btn = self.view.viewWithTag(i) as! UIButton
            btn.setTitle("-", for: .normal)
        }
        viewModel.updateState()
    }
}

extension ViewController: ViewModelProtocol {
    func showAlert(status:String){
    
        let alert = UIAlertController(title: "TIC TAC Toe Game", message: status, preferredStyle: UIAlertController.Style.alert)

        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            self.btnResetTapped(sender: UIButton())
        }))

        self.present(alert, animated: true, completion: nil)
    }}

