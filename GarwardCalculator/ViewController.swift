//
//  ViewController.swift
//  GarwardCalculator
//
//  Created by Alex Skigenok on 07.04.17.
//  Copyright © 2017 AlexAlexAlex. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var display: UILabel!
    
    var userIsTyping = false
    
    @IBAction func tuochDigit(sender: UIButton) {
        let diget = sender.currentTitle!                                // То что написано на кнопке
        
        if userIsTyping{
            let textCurrentlyInDisplay = display.text!                 //берет цыфры на дисплеи
            display.text = textCurrentlyInDisplay + diget              //цыфры на дисплеи + цыфра на которую нажал
        } else {                                                        //сначало заходит в этот блок
            display!.text = diget
            userIsTyping = true
            
        }
    }
    
    var displayValue: Double{
        get{
            return Double(display.text!)!
        }
        set {
            display.text! = String(newValue)
        }
    }
    
    private var brain = CalculatorBrain()
    
    @IBAction func performOperation(sender: UIButton) {
        
        if userIsTyping{
            brain.setOperand(displayValue)
            userIsTyping = false
        }
        
        
        if let mathematicalSymbol = sender.currentTitle{
            brain.performOperation(mathematicalSymbol)
            
        }
        
        if let result = brain.resolt{
            displayValue = result
        }
    }
    
    
}

