//
//  MatrixVC.swift
//  iosApp
//
//  Created by Nurgun Nalyiakhov on 21.05.2023.
//  Copyright © 2023 orgName. All rights reserved.
//

import UIKit

class MatrixVC: CustomViewController {
    var customView: MatrixView {
        return view as! MatrixView
    }

    weak var calculateButton: UIButton! { return customView.calculateButton }
    
    var matrix: [[Int]] = [[1,0,1],
                           [0,1,0],
                           [0,0,0]]

    override func loadView() {
        self.view = MatrixView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        calculateButton.addTarget(self, action: #selector(doCalculate), for: .touchUpInside)
    }
    
    @objc fileprivate func doCalculate() {
        var resultMatrix = matrix
        for i in 0..<matrix.count {
            let column = matrix[i]
            for j in 0..<column.count {
                let item = column[j]
                if matrix[i][j] != 1 {
                    let result = isFilled(i, j)
                    if result.filled {
                        resultMatrix[i][j] = 1
                    } else {
                        resultMatrix[i][j] = getMinDistance(steps: result.nextSteps, distance: 1)
                    }
                } else {
                    resultMatrix[i][j] = 0
                }
            }
        }
        
        print(resultMatrix)
    }
    
    fileprivate func getMinDistance(steps: [(Int, Int)], distance: Int) -> Int {
        var allSteps: [(Int, Int)] = [(Int, Int)]()
        for step in steps {
            let result = isFilled(step.0, step.1)
            if result.filled {
                return distance + 1
            } else {
                allSteps.append(contentsOf: result.nextSteps)
            }
        }
        return getMinDistance(steps: allSteps, distance: distance + 1)
    }
    
    fileprivate func isFilled(_ i: Int, _ j: Int) -> (nextSteps: [(Int, Int)], filled: Bool) {
        let maxRow = matrix.count
        let maxColumn = matrix.count > 0 ? matrix[0].count : 0
        var nextSteps: [(Int, Int)] = [(Int, Int)]()
        if i - 1 >= 0 {
            if matrix[i - 1][j] == 1 {
                return (nextSteps, true)
            } else {
                nextSteps.append((i - 1, j))
            }
        } else if i + 1 <= maxRow {
            if matrix[i + 1][j] == 1 {
                return (nextSteps, true)
            } else {
                nextSteps.append((i + 1, j))
            }
        } else if j - 1 >= 0 {
            if matrix[i][j - 1] == 1 {
                return (nextSteps, true)
            } else {
                nextSteps.append((i, j - 1))
            }
        } else if j + 1 <= maxColumn {
            if matrix[i][j + 1] == 1 {
                return (nextSteps, true)
            } else {
                nextSteps.append((i, j + 1))
            }
        }
        return (nextSteps, false)
    }
}
