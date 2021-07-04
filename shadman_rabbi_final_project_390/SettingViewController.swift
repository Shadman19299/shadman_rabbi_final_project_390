//
//  SettingViewController.swift
//  shadman_rabbi_final_project_390
//
//  Created by Shadman UR Rabbi on 7/3/21.
//

import UIKit

class SettingViewController: UIViewController {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var dvc = DataViewController()
    private let sortcat = ["ITtag", "Founded Location", "Supposed Location", "Device Type"]
    private let colcat = [ "Founded Location", "Supposed Location", "Date Registered", "Device Type"]
    @IBOutlet weak var col1: UILabel!
    @IBOutlet weak var col1pickervw: UIPickerView!
    @IBOutlet weak var col2: UILabel!
    @IBOutlet weak var col2pickervw: UIPickerView!
    
    @IBOutlet weak var sortlbl: UILabel!
    
    @IBOutlet weak var sortpick: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        col2pickervw.dataSource = self
        col2pickervw.delegate = self
        sortpick.dataSource = self
        sortpick.delegate = self
        col1pickervw.dataSource = self
        col1pickervw.delegate = self
        // Do any additional setup after loading the view.
        
        col1pickervw.tag = 1
        col2pickervw.tag = 2
        sortpick.tag = 3
    }
    
    @IBAction func ResettheDatabase(_ sender: Any) {
        appDelegate.clearAllCoreData()
    }
    

}

extension SettingViewController: UIPickerViewDelegate, UIPickerViewDataSource{
   
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView.tag {
        case 1:
            return colcat.count
        case 2:
            return colcat.count
        case 3:
            return sortcat.count
        default:
            return 1
        }
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView.tag {
        case 1:
            return colcat[row]
        case 2:
            return colcat[row]
        case 3:
            return sortcat[row]
        default:
            return "Data Not Found"
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView.tag {
        case 1:
            let column1 = colcat[row]
            switch column1 {
            case "Found location":
                UserDefaults.standard.setValue(1, forKey: "col1")
            case "Supposed location":
                UserDefaults.standard.setValue(2, forKey: "col1")
            case "Device Type":
                UserDefaults.standard.setValue(3, forKey: "col1")
            case "Date Registered":
                UserDefaults.standard.setValue(4, forKey: "col1")
            default:
                UserDefaults.standard.setValue(1, forKey: "col1")
                
            }
            
        case 2:
            let column2 = colcat[row]
            switch column2 {
            case "Found location":
                UserDefaults.standard.setValue(1, forKey: "col2")
            case "Supposed location":
                UserDefaults.standard.setValue(2, forKey: "col2")
            case "Device Type":
                UserDefaults.standard.setValue(3, forKey: "col2")
            case "Date Registered":
                UserDefaults.standard.setValue(4, forKey: "col2")
            default: UserDefaults.standard.setValue(1, forKey: "col2")
                
            }
        case 3:
            let sort = sortcat[row]
            switch sort {
            case "Found location":
                UserDefaults.standard.setValue(1, forKey: "sort")
            case "Supposed location":
                UserDefaults.standard.setValue(2, forKey: "sort")
            case "Device Type":
                UserDefaults.standard.setValue(3, forKey: "sort")
            case "ITtag":
                UserDefaults.standard.setValue(4, forKey: "sort")
            default: break
                
            }
        default:
            return 
        }
        
        return
    }
}
