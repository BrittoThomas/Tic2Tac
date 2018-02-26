//
//  ViewController.swift
//  Tic2Tac
//
//  Created by apple on 23/01/18.
//  Copyright © 2018 apple. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //1- cross, 2- circle
    var activePlayer = 1
    var buttonStates = Array.init(repeating: 0, count: 9)
    @IBOutlet weak var labelGameMode: UILabel!
    @IBOutlet weak var buttonPlayAgain: UIButton!
    @IBOutlet weak var mainStackView: UIStackView!
    @IBOutlet weak var labelYourScore: UILabel!
    @IBOutlet weak var labelComputerScore: UILabel!
    var remainingButtonArray:[TicTacButton] = []
    var yourScore:Int = UserDefaults.standard.integer(forKey: "YourScore"){
        didSet{
            labelYourScore.text = "\(self.yourScore)"
            UserDefaults.standard.set(self.yourScore, forKey: "YourScore")
            UserDefaults.standard.synchronize()
        }
    }
    
    var computerScore:Int = UserDefaults.standard.integer(forKey: "ComputerScore"){
        didSet{
            labelComputerScore.text = "\(self.computerScore)"
            UserDefaults.standard.set(self.computerScore, forKey: "ComputerScore")
            UserDefaults.standard.synchronize()
        }
    }
    
    var winningCombinations = [
                                [0,1,2],
                                [3,4,5],
                                [6,7,8],
                                [0,3,6],
                                [1,4,7],
                                [2,5,8],
                                [0,4,8],
                                [2,4,6]
                                ]
    @IBOutlet var buttonCells: [TicTacButton]!
    @IBOutlet weak var labelGameStatus: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        yourScore = UserDefaults.standard.integer(forKey: "YourScore")
        computerScore = UserDefaults.standard.integer(forKey: "ComputerScore")
        
        self.resetTicTac()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        switch AppDelegate.shared.gameMode {
        case .easy:
            self.labelGameMode.text = "Easy Mode"
        case .medium:
            self.labelGameMode.text = "Medium Mode"
        case .hard:
            self.labelGameMode.text = "Hard Mode"
        }
    }

    func resetTicTac() {
        self.mainStackView.isUserInteractionEnabled = true
        buttonPlayAgain.isHidden = true
        buttonStates = Array.init(repeating: 0, count: 9)
        
        
        if arc4random_uniform(2) == 0 {
            activePlayer = 1
            labelGameStatus.text = "Your turn"
        }else{
            activePlayer = 2
            labelGameStatus.text = "Compter turn"
            self.computerTurn()
        }
        
        for buttonCell in self.buttonCells {
            buttonCell.clear()
            buttonCell.setImage(nil, for: .normal)
        }
    }
    
    @IBAction func buttonActionCell(_ sender: TicTacButton) {
        
        print("Sender tag : \(sender.tag)")
        
        if buttonStates[(sender.tag - 1)] != 0 {
            return
        }
        
        if activePlayer == 1 {
            //sender.setImage(UIImage.init(named: "cross"), for: .normal)
            sender.setImage(nil, for: .normal)
            sender.drawCross()
            buttonStates[(sender.tag - 1)] = activePlayer
            activePlayer = 2
            labelGameStatus.text = "Computer turn"
        }else {
            //sender.setImage(UIImage.init(named: "circle"), for: .normal)
            sender.setImage(nil, for: .normal)
            sender.drawCircle()
            buttonStates[(sender.tag - 1)] = activePlayer
            activePlayer = 1
            labelGameStatus.text = "Your turn"
        }
        
        for combination in winningCombinations {
            if buttonStates[combination[0]] != 0 &&
                buttonStates[combination[0]] == buttonStates[combination[1]] &&
                buttonStates[combination[1]] == buttonStates[combination[2]] {
                
                if (buttonStates[combination[0]] == 1) {
                    labelGameStatus.text = "You win"
                    self.yourScore += 1
                    
                }else {
                    labelGameStatus.text = "Computer win"
                    self.computerScore += 1
                }
                buttonPlayAgain.isHidden = false
                self.mainStackView.isUserInteractionEnabled = false
                return
            }
        }
        
        var gameState:Bool = false
        for i in buttonStates {
            if i == 0 {
                gameState = true
                break
            }
        }
        if gameState == false {
            labelGameStatus.text = "It is a draw!"
            buttonPlayAgain.isHidden = false
            self.mainStackView.isUserInteractionEnabled = false
            return
        }
        
        if activePlayer == 2 {
            self.computerTurn()
        }
    }

    func computerTurn() {
        self.mainStackView.isUserInteractionEnabled = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            DispatchQueue.main.async {
                self.mainStackView.isUserInteractionEnabled = true
                self.remainingButtonArray = []
                for (index,state) in self.buttonStates.enumerated() {
                    if state == 0 {
                        self.remainingButtonArray.append(self.buttonCells[index])
                    }
                }
                
                if self.remainingButtonArray.count != 0{
                    self.buttonActionCell(self.getNextButton() as! TicTacButton)
                }
            }
        }
    }
    
    func getNextButton() -> UIButton {

        if AppDelegate.shared.gameMode == .hard || AppDelegate.shared.gameMode == .medium {
            //Winning
            for remainingbutton in self.remainingButtonArray {
                var array = buttonStates
                array[(remainingbutton.tag - 1)] = 2
                for combination in winningCombinations {
                    if  array[combination[0]] == 2 &&
                        array[combination[0]] == array[combination[1]] &&
                        array[combination[1]] == array[combination[2]] {
                        print("Computer winning click : Index - \(remainingbutton.tag)")
                        return remainingbutton
                    }
                }
            }
        }
        
        if AppDelegate.shared.gameMode == .hard {
            //Blocking
            for remainingbutton in self.remainingButtonArray {
                var array = buttonStates
                array[(remainingbutton.tag - 1)] = 1
                for combination in winningCombinations {
                    if  array[combination[0]] == 1 &&
                        array[combination[0]] == array[combination[1]] &&
                        array[combination[1]] == array[combination[2]]  {
                        print("Computer blocking click : Index - \(remainingbutton.tag)")
                        return remainingbutton
                    }
                }
            }
        }
        
        
        
        
        if AppDelegate.shared.gameMode == .hard {
            //Next to winning
            for remainingbutton in self.remainingButtonArray {
                var array = buttonStates
                array[(remainingbutton.tag - 1)] = 2
                for combination in winningCombinations {
                    if  array[combination[0]] == 2 &&
                        (((array[combination[0]] == array[combination[1]]) && (array[combination[2]] == 0)) ||
                            ((array[combination[1]] == array[combination[2]]) && (array[combination[0]] == 0))) {
                        print("Computer thinking click : Index - \(remainingbutton.tag)")
                        return remainingbutton
                    }
                }
            }
        }
        
        
        
        
        let nextButtonIndex:Int = Int(arc4random_uniform(UInt32(remainingButtonArray.count)))
        print("Computer random click : Index - \(self.remainingButtonArray[nextButtonIndex].tag)")
        return self.remainingButtonArray[nextButtonIndex]
    }

    
    @IBAction func buttonActionPlayAgain(_ sender: Any) {
        resetTicTac()
    }
}

