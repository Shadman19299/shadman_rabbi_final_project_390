//
//  InputViewController.swift
//  shadman_rabbi_final_project_390
//
//  Created by Shadman UR Rabbi on 7/3/21.
//

import UIKit

class InputViewController: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var ittagelbl: UILabel!
    @IBOutlet weak var flocationtxt: UITextField!
    @IBOutlet weak var slocationtxt: UITextField!
    @IBOutlet weak var devicetyptxt: UITextField!
    @IBOutlet weak var datepicker: UIDatePicker!
    
    var tagfinal = ""
    var date = Date()
    var datavc = DataViewController()
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ittagelbl.text = tagfinal
        datepicker.datePickerMode = .date

    }
    
    @IBAction func save(_ sender: Any) {
        let ittag = tagfinal
        let flocation = flocationtxt.text ?? ""
        let slocation = slocationtxt.text ?? ""
        let dtype = devicetyptxt.text ?? ""
        let date = datepicker.date
        
        appDelegate.createAssets(ittag: ittag, flocation: flocation, slocation: slocation, devictype: dtype, datereg: date)

    }

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
   
}

