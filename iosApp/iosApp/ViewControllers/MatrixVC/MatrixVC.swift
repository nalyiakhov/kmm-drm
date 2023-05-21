//
//  MatrixVC.swift
//  iosApp
//
//  Created by Nurgun Nalyiakhov on 21.05.2023.
//  Copyright © 2023 orgName. All rights reserved.
//

import UIKit

class MatrixVC: CustomViewController, UITextFieldDelegate {
    var customView: MatrixView {
        return view as! MatrixView
    }

    weak var aTextField: UITextField! { return customView.aTextField }
    weak var bTextField: UITextField! { return customView.bTextField }
    weak var calculateButton: UIButton! { return customView.calculateButton }

    var matrix: [[Int]] = [[Int]]()
    var rowsCount: Int = 3
    var columnsCount: Int = 3
    var multiplyLimit = 1000

    override func loadView() {
        self.view = MatrixView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        calculateButton.addTarget(self, action: #selector(doCalculate), for: .touchUpInside)
        
        aTextField.delegate = self
        bTextField.delegate = self
        
        aTextField.text = String(rowsCount)
        bTextField.text = String(columnsCount)
        
        aTextField.addTarget(self, action: #selector(self.textFieldFilter), for: .editingChanged)
        bTextField.addTarget(self, action: #selector(self.textFieldFilter), for: .editingChanged)
    }
    
    @objc fileprivate func doCalculate() {
        if let rows = Int(aTextField.text ?? "0"), let colums = Int(bTextField.text ?? "0"), rows > 0, colums > 0 {
            if rows * colums <= multiplyLimit {
                rowsCount = rows
                columnsCount = colums
                
                updateMatrix()
                
                var resultMatrix = matrix
                for i in 0..<rowsCount {
                    for j in 0..<columnsCount {
                        if matrix[i][j] != 1 {
                            let result = isNearFilled(initStep: (i, j), step: (i, j))
                            if result.isFilled {
                                resultMatrix[i][j] = 1
                            } else {
                                resultMatrix[i][j] = getMinDistance(initStep: (i, j), steps: result.nextSteps, distance: 1)
                            }
                        } else {
                            resultMatrix[i][j] = 0
                        }
                    }
                }
                print("result", resultMatrix)
                
                showCustomToast(message: sharedStrings.calculated.localized())
            } else {
                showCustomToast(message: sharedStrings.too_large_a_b.localized(replace: String(multiplyLimit)))
            }
        } else {
            showCustomToast(message: sharedStrings.enter_a_b.localized())
        }
    }
    
    fileprivate func updateMatrix() {
        matrix = [[Int]]()
        for _ in 0..<rowsCount {
            var row: [Int] = []
            for _ in 0..<columnsCount {
                row.append(Int.random(in: 0..<2))
            }
            matrix.append(row)
        }
        print("matrix", matrix)
    }
    
    fileprivate func getMinDistance(initStep: (Int, Int), steps: [(Int, Int)], distance: Int) -> Int {
        var allSteps: [(Int, Int)] = [(Int, Int)]()
        for step in steps {
            let result = isNearFilled(initStep: initStep, step: step)
            if result.isFilled {
                return distance + 1
            } else {
                allSteps.append(contentsOf: result.nextSteps)
            }
        }

        if allSteps.isEmpty {
            return -1
        } else {
            return getMinDistance(initStep: initStep, steps: allSteps, distance: distance + 1)
        }
    }
    
    fileprivate func isNearFilled(initStep: (Int, Int), step: (Int, Int)) -> (nextSteps: [(Int, Int)], isFilled: Bool) {
        let initRow = initStep.0
        let initCol = initStep.1
        let currentRow = step.0
        let currentCol = step.1

        var nextSteps: [(Int, Int)] = [(Int, Int)]()
        if initRow >= currentRow && currentRow - 1 >= 0 {
            if matrix[currentRow - 1][currentCol] == 1 {
                return (nextSteps, true)
            } else {
                nextSteps.append((currentRow - 1, currentCol))
            }
        }
        if initRow <= currentRow && currentRow + 1 < rowsCount {
            if matrix[currentRow + 1][currentCol] == 1 {
                return (nextSteps, true)
            } else {
                nextSteps.append((currentRow + 1, currentCol))
            }
        }
        if initCol >= currentCol && currentCol - 1 >= 0 {
            if matrix[currentRow][currentCol - 1] == 1 {
                return (nextSteps, true)
            } else {
                nextSteps.append((currentRow, currentCol - 1))
            }
        }
        if initCol <= currentCol && currentCol + 1 < columnsCount {
            if matrix[currentRow][currentCol + 1] == 1 {
                return (nextSteps, true)
            } else {
                nextSteps.append((currentRow, currentCol + 1))
            }
        }
        return (nextSteps, false)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let invalidCharacters = CharacterSet(charactersIn: "0123456789").inverted
        return (string.rangeOfCharacter(from: invalidCharacters) == nil)
    }
    
    @objc private func textFieldFilter(_ textField: UITextField) {
        if let text = textField.text, let intText = Int(text) {
            textField.text = "\(intText)"
        } else {
            textField.text = ""
        }
    }
}
