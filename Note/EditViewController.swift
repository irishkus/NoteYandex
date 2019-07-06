//
//  EditViewController.swift
//  Note
//
//  Created by Ирина Соловьева on 22/06/2019.
//  Copyright © 2019 Ирина Соловьева. All rights reserved.
//

import UIKit

class EditViewController: UIViewController {
    
    var color: UIColor = UIColor.init(red: CGFloat(0.423529), green: CGFloat(0.435294), blue: CGFloat(0.996078), alpha: 1)
    var goalCenter = CGPoint()
    let choiseView = ChoiceColorView(frame: CGRect(x: 55, y: 0, width: 20, height: 20))
    
    @IBOutlet weak var textNote: UITextView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var bottomStackViewConstraint: NSLayoutConstraint!
    @IBOutlet weak var heightDatePicker: NSLayoutConstraint!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var pickerColorView: UIView!
    @IBOutlet weak var greenColorView: UIView!
    @IBOutlet weak var redColorView: UIView!
    @IBOutlet weak var whiteColorView: UIView!
    
    @IBAction func tapWhiteView(_ sender: UITapGestureRecognizer) {
        choiseView.removeFromSuperview()
        whiteColorView.addSubview(choiseView)
    }
    @IBAction func tapGreeView(_ sender: UITapGestureRecognizer) {
        choiseView.removeFromSuperview()
        greenColorView.addSubview(choiseView)
    }
    @IBAction func tapRedView(_ sender: UITapGestureRecognizer) {
        choiseView.removeFromSuperview()
        redColorView.addSubview(choiseView)
    }
    @IBAction func switchDate(_ sender: UISwitch) {
        if sender.isOn {
            bottomStackViewConstraint.constant = 370
            datePicker.alpha = 1
            heightDatePicker.constant = 100
        } else {
            bottomStackViewConstraint.constant = 500
            datePicker.alpha = 0
            heightDatePicker.constant = 0
        }
    }
    @IBAction func longPressPickerView(_ sender1: UILongPressGestureRecognizer) {
       performSegue(withIdentifier: "picker", sender: self)
    }
    @IBAction func unwindToEdit(_ sender: UIStoryboardSegue) {
        pickerColorView.backgroundColor = color
        choiseView.removeFromSuperview()
        pickerColorView.addSubview(choiseView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerColorView.layer.borderWidth = 1
        pickerColorView.layer.borderColor = UIColor.black.cgColor
        pickerColorView.backgroundColor = UIColor(patternImage: UIImage(named: "76")!) 
        greenColorView.layer.borderWidth = 1
        greenColorView.layer.borderColor = UIColor.black.cgColor
        redColorView.layer.borderWidth = 1
        redColorView.layer.borderColor = UIColor.black.cgColor
        whiteColorView.layer.borderWidth = 1
        whiteColorView.layer.borderColor = UIColor.black.cgColor
        heightDatePicker.constant = 0
        bottomStackViewConstraint.constant = 500
        choiseView.backgroundColor = UIColor.clear
        whiteColorView.addSubview(choiseView)
        textNote.isScrollEnabled = false
//        let note = Note(uid: "567357234582yrfhgdfuyawt4", title: "Тест1", content: "ворапшгы]впщдлояврапшы]вдплмьиявшгкпвялыомчтоипршгяырашомта ворапшягварпловми ваияшвгрпшыявгрпмлт", color: .red, importance: .important, selfDestructionDate: nil)
//        let file = FileNotebook()
//        file.add(note)
//        let note2 = Note(title: "tring", content: "djbgajsdhgfjsk", importance: .unimportant)
//        file.add(note2)
//        file.remove(with: "567357234582yrfhgdfuyawt4")
//        file.saveToFile()
//        file.loadFromFile()
    }
 
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        guard let distinationVC = segue.destination as? PickerViewController else {return}
//        distinationVC.color = color
//        distinationVC.goalCenter = goalCenter
//    }
    
    @objc func keyboardWasShown(notification: Notification) {
        // Получаем размер клавиатуры
        let info = notification.userInfo! as NSDictionary
        let kbSize = (info.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue).cgRectValue.size
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: kbSize.height+60, right: 0.0)
        
        // Добавляем отступ внизу UIScrollView, равный размеру клавиатуры
        self.scrollView?.contentInset = contentInsets
        scrollView?.scrollIndicatorInsets = contentInsets
    }
    
    //Когда клавиатура исчезает
    @objc func keyboardWillBeHidden(notification: Notification) {
        // Устанавливаем отступ внизу UIScrollView, равный 0
        let contentInsets = UIEdgeInsets.zero
        scrollView?.contentInset = contentInsets
        scrollView?.scrollIndicatorInsets = contentInsets
    }
    
    @objc func hideKeyboard() {
        self.scrollView?.endEditing(true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Подписываемся на два уведомления: одно приходит при появлении клавиатуры
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWasShown), name: UIResponder.keyboardWillShowNotification, object: nil)
        // Второе -- когда она пропадает
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillBeHidden(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }

}

