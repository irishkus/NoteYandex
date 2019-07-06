//
//  GoalView.swift
//  Note
//
//  Created by Ирина Соловьева on 03/07/2019.
//  Copyright © 2019 Ирина Соловьева. All rights reserved.
//

import UIKit

class GoalView: UIView {

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        guard let context = UIGraphicsGetCurrentContext() else { return }
        context.setStrokeColor(UIColor.black.cgColor)
        context.move(to: CGPoint(x: 21, y: 11))
        context.addArc(center: CGPoint(x: 11, y: 11), radius: 6, startAngle: CGFloat(0), endAngle: CGFloat(Double.pi/2), clockwise: false)
        context.addLine(to: CGPoint(x: 11, y: 21))
        context.addLine(to: CGPoint(x: 11, y: 17))
        context.addArc(center: CGPoint(x: 11, y: 11), radius: 6, startAngle: CGFloat(Double.pi/2), endAngle: CGFloat(Double.pi), clockwise: false)
        context.addLine(to: CGPoint(x: 1, y: 11))
        context.addLine(to: CGPoint(x: 5, y: 11))
        context.addArc(center: CGPoint(x: 11, y: 11), radius: 6, startAngle: CGFloat(Double.pi), endAngle: CGFloat(3*Double.pi/2), clockwise: false)
        context.addLine(to: CGPoint(x: 11, y: 1))
        context.addLine(to: CGPoint(x: 11, y: 5))
        context.addArc(center: CGPoint(x: 11, y: 11), radius: 6, startAngle: CGFloat(3*Double.pi/2), endAngle: CGFloat(Double.pi*2), clockwise: false)
        context.closePath()
        context.strokePath()

    }

}
