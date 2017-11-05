//
//  SwitchControl.swift
//  BookShelf
//
//  Created by Andrea Altea on 04/11/17.
//  Copyright © 2017 Studiout. All rights reserved.
//

import UIKit

@IBDesignable
class SwitchControl: UIControl {

    @IBInspectable var statuses: Array<String> = [] {
        didSet {
            self.selectedStatus = 0
        }
    }
    var selectedStatus: Int = 0 {
        
        didSet {
            guard self.selectedStatus < statuses.count else {
                self.selectedLabel.text = nil
                return
            }
            
            self.selectedLabel.text = self.statuses[selectedStatus]
            self.hidePicker()
            self.sendActions(for: .valueChanged)
        }
    }

    weak var selectedLabel: UILabel!
    weak var disclosureImageView: UIImageView!
    weak var picker: UIPickerView?
    
    var bottomLabelConstraint: NSLayoutConstraint!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupUI()
    }
    
    private func setupUI() {
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(label)
        self.selectedLabel = label
        
        let imageView = UIImageView(image: #imageLiteral(resourceName: "expand"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(imageView)
        self.disclosureImageView = imageView
        
        let viewsDictionary:Dictionary<String, UIView> = ["label": label, "image": imageView]
        let hConstraints = NSLayoutConstraint.constraints(withVisualFormat: "|-8-[label]-8-[image]-8-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewsDictionary)
        let vConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|-8-[label]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewsDictionary)
        label.centerYAnchor.constraint(equalTo: imageView.centerYAnchor).isActive = true
        let bottomConstraint = self.bottomAnchor.constraint(equalTo: label.bottomAnchor, constant: 8)
        self.addConstraints(hConstraints)
        self.addConstraints(vConstraints)
        self.addConstraint(bottomConstraint)
        self.bottomLabelConstraint = bottomConstraint
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(switchPicker(sender:)))
        self.addGestureRecognizer(gesture)
    }
    
    func showPicker() {
        UIView.animate(withDuration: 0.2) {
            
            self.bottomLabelConstraint?.isActive = false
            
            let picker = UIPickerView()
            picker.dataSource = self
            picker.delegate = self
            picker.selectRow(self.selectedStatus, inComponent: 0, animated: false)
            picker.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(picker)
            
            let viewDictionary: Dictionary<String, UIView> = ["label": self.selectedLabel, "picker": picker]
            let hConstraints = NSLayoutConstraint.constraints(withVisualFormat: "|-0-[picker]-0-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDictionary)
            let vConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:[label]-8-[picker]-0-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDictionary)
            
            self.addConstraints(vConstraints)
            self.addConstraints(hConstraints)
            self.picker = picker
        }
    }
    
    func hidePicker() {
        
        UIView.animate(withDuration: 0.2) {

            guard let picker = self.picker else {
                return
            }
            picker.removeFromSuperview()
            self.bottomLabelConstraint?.isActive = true
        }
    }
    
    @objc private func switchPicker(sender: Any?) {
        
        guard let picker = self.picker else {
            self.showPicker()
            return
        }
        
        self.hidePicker()
    }
    
}

extension SwitchControl: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.statuses.count
    }
}

extension SwitchControl: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.statuses[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.selectedStatus = row
    }
}
