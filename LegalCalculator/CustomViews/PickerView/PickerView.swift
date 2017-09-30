/*
 
 * AMERICA ONLINE CONFIDENTIAL INFORMATION
 
 *
 
 * Copyright (c) 2016 AOL Inc
 
 *
 
 * All Rights Reserved.  Unauthorized reproduction, transmission, or
 
 * distribution of this software is a violation of applicable laws.
 
 */

import Foundation
import UIKit

private let fontSize: CGFloat = 18.0

final class PickerView: UIPickerView {
    
    //MARK: Private Properties
    fileprivate var components = [String]()
    fileprivate var selectedRow = 0
    
    fileprivate var regularColor = UIColor.white
    
    //MARK: Internal Methods
    func setComponents(_ components: [String], selectedRow: Int) {
        self.components = components
        self.selectedRow = selectedRow
        
        reloadAllComponents()
        selectRow(selectedRow, inComponent: 0, animated: false)
    }
    
    func setTextColor(color: UIColor){
        regularColor = color
    }
    
    //MARK: Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setup()
    }
}

private extension PickerView {
    
    func setup() {
        backgroundColor = UIColor.clear
        dataSource = self
        delegate = self
    }
}

extension PickerView: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return components.count
    }
}

extension PickerView: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let pickerLabel = UILabel()
        pickerLabel.textColor = regularColor
        pickerLabel.text = components[row].capitalized
//        pickerLabel.font = UIFont.systemFont
        pickerLabel.textAlignment = NSTextAlignment.center
        return pickerLabel
    }
}
