//
//  ChoiceColorView.swift
//  Note
//
//  Created by Ирина Соловьева on 04/07/2019.
//  Copyright © 2019 Ирина Соловьева. All rights reserved.
//

import UIKit

class ChoiceColorView: UIView {

    override func draw(_ rect: CGRect) {
        let path = UIBezierPath(arcCenter: CGPoint(x: 10, y:10), radius: 8, startAngle: 0, endAngle: CGFloat(Double.pi*2), clockwise: true)
        UIColor.black.setStroke()
        path.close()
        path.stroke()
        let pathChoice = UIBezierPath()
        pathChoice.move(to: CGPoint(x: 15, y: 5))
        pathChoice.addLine(to: CGPoint(x: 10, y: 16))
        pathChoice.addLine(to: CGPoint(x: 5, y: 10))
        pathChoice.addLine(to: CGPoint(x: 10, y: 16))
        pathChoice.addLine(to: CGPoint(x: 15, y: 5))
        pathChoice.close()
        pathChoice.stroke()
    }
}
