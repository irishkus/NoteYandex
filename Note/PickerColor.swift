//
//  PickerColor.swift
//  Note
//
//  Created by Ирина Соловьева on 06/07/2019.
//  Copyright © 2019 Ирина Соловьева. All rights reserved.
//

import UIKit

@IBDesignable
class PickerColor: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func setupViews() {
        let xibView = loadViewFromXib()
        xibView.frame = self.bounds
        xibView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(xibView)
    }
    
    private func loadViewFromXib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName:  "GameControlView", bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first! as! UIView
    }
    
    let image = UIImage(named: "map-brightness")!
    var alphaColor = CGFloat(1)
    var color = UIColor()
    var goalCenter = CGPoint()
    
    @IBOutlet weak var goalView: GoalView!
    @IBOutlet weak var selectHexColorView: UIView!
    @IBOutlet weak var selectColorView: UIView!
    @IBOutlet weak var hexLabel: UILabel!
    @IBOutlet weak var viewPicker: UIView!
    @IBOutlet weak var slider: UISlider!
    
    @IBAction func sliderBrightness(_ sender: UISlider) {
        alphaColor = CGFloat(sender.value)
        viewPicker.alpha = alphaColor
        selectColorView.alpha = alphaColor
    }
    
    @IBAction func panPicker(_ sender: UIPanGestureRecognizer) {
        color = image.getPixelColor(pos: sender.location(in: viewPicker))
        selectColorView.backgroundColor = color.withAlphaComponent(alpha)
        hexLabel.text = color.hexString
        goalCenter = sender.location(in: viewPicker)
        goalView.center = CGPoint(x: sender.location(in: viewPicker).x, y: sender.location(in: viewPicker).y+4)
    }
    
    @IBAction func tapPicker(_ sender: UITapGestureRecognizer) {
        color = image.getPixelColor(pos: sender.location(in: viewPicker))
        selectColorView.backgroundColor = color.withAlphaComponent(alpha)
        hexLabel.text = color.hexString
        goalCenter = sender.location(in: viewPicker)
        goalView.center = CGPoint(x: sender.location(in: viewPicker).x, y: sender.location(in: viewPicker).y+4)
    }
    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        createUI()
//    }
    
    func createUI() {
        viewPicker.backgroundColor = UIColor(patternImage: image)
        selectHexColorView.layer.borderColor = UIColor.black.cgColor
        selectHexColorView.layer.borderWidth = 1
        selectColorView.layer.borderColor = UIColor.black.cgColor
        selectColorView.layer.borderWidth = 1
        selectColorView.backgroundColor = color
        hexLabel.text = color.hexString
        selectHexColorView.layer.cornerRadius = 5
        selectHexColorView.layer.masksToBounds = true
        viewPicker.layer.borderColor = UIColor.black.cgColor
        viewPicker.layer.borderWidth = 1
        if goalCenter == CGPoint(x: 0.0, y: 0.0) {
            goalView.center = CGPoint(x: viewPicker.bounds.midX, y: viewPicker.bounds.midY+4)
        }else {
            goalView.center = CGPoint(x: goalCenter.x, y: goalCenter.y+4)
        }
        alpha = color.alphaComponent
        slider.value = Float(alpha)
        viewPicker.alpha = alpha
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        guard let distinationVC = segue.destination as? EditViewController else {return}
//        distinationVC.color = color.withAlphaComponent(alpha)
//        distinationVC.goalCenter = goalCenter
//    }
}


extension UIImage {
    func getPixelColor(pos: CGPoint) -> UIColor {
        let pixelData = self.cgImage!.dataProvider!.data
        let data: UnsafePointer<UInt8> = CFDataGetBytePtr(pixelData)
        let pixelInfo: Int = ((Int(self.size.width) * Int(pos.y)) + Int(pos.x)) * 4
        let r = CGFloat(data[pixelInfo]) / CGFloat(255.0)
        let g = CGFloat(data[pixelInfo+1]) / CGFloat(255.0)
        let b = CGFloat(data[pixelInfo+2]) / CGFloat(255.0)
        let a = CGFloat(data[pixelInfo+3]) / CGFloat(255.0)
        return UIColor(red: r, green: g, blue: b, alpha: a)
    }
}

extension UIColor {
    var hexString: String {
        let colorRef = cgColor.components
        let r = colorRef?[0] ?? 0
        let g = colorRef?[1] ?? 0
        let b = ((colorRef?.count ?? 0) > 2 ? colorRef?[2] : g) ?? 0
        let a = cgColor.alpha
        
        var color = String(
            format: "#%02lX%02lX%02lX",
            lroundf(Float(r * 255)),
            lroundf(Float(g * 255)),
            lroundf(Float(b * 255))
        )
        
        if a < 1 {
            color += String(format: "%02lX", lroundf(Float(a)))
        }
        return color
    }
    var alphaComponent: CGFloat {
        var alpha: CGFloat = 0.0
        getRed(nil, green: nil, blue: nil, alpha: &alpha)
        
        return alpha
    }
}

