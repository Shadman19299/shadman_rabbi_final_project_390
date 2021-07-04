//
//  ViewController.swift
//  shadman_rabbi_final_project_390
//
//  Created by Shadman UR Rabbi on 7/2/21.
//

import UIKit

class DataViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var tblview: UITableView!
    //let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
//   tableView: UITableView = {
//        let table = UITableView()
//        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell" )
//
//        return table
//    }()
    
    
    var assetlist = [Assets]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "cell", bundle: nil)
        tblview.register(nib, forCellReuseIdentifier: "cell")
        self.tblview.delegate = self
        self.tblview.dataSource = self
        self.update()
        
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblview.dequeueReusableCell(withIdentifier: "cell") as! cell
        let task = assetlist[indexPath.row]
        
        //Column 0 is Always Ittag
        cell.ittaglbl.text = task.ittag
        cell.Slocationlbl.text = task.supposedlocation
        cell.Flocationlbl.text = task.foundlocation
        print(cell.Slocationlbl.text ?? "")
        
        print("Print the default value for Column 1: ",UserDefaults.standard.integer(forKey: "col1"))
        

        
        // Column 1 Label
        if ((UserDefaults.standard.integer(forKey: "col1")) == 1) {
            cell.Slocationlbl.text = task.foundlocation
        }else if ((UserDefaults.standard.integer(forKey: "col1")) == 2){
            cell.Slocationlbl.text = task.supposedlocation
        }else if ((UserDefaults.standard.integer(forKey: "col1")) == 3){
            cell.Slocationlbl.text = task.devicetype
        }else if ((UserDefaults.standard.integer(forKey: "col1")) == 4){
            let datereg1 = task.dateregisterd!
            let dateformatter = DateFormatter()
            let datereg = dateformatter.string(from: datereg1)
            cell.Slocationlbl.text = datereg
        }else {
            cell.Slocationlbl.text = task.foundlocation
        }
        // Column 2 label
        
        print("Print the default value for Column 2: ",UserDefaults.standard.integer(forKey: "col2"))
        if ((UserDefaults.standard.integer(forKey: "col2")) == 1) {
            cell.Flocationlbl.text = task.foundlocation
        }else if ((UserDefaults.standard.integer(forKey: "col2")) == 2){
            cell.Flocationlbl.text = task.supposedlocation
        }else if ((UserDefaults.standard.integer(forKey: "col2")) == 3){
            cell.Flocationlbl.text = task.devicetype
        }else if ((UserDefaults.standard.integer(forKey: "col2")) == 4){
            let datereg1 = task.dateregisterd!
            let dateformatter = DateFormatter()
            let datereg = dateformatter.string(from: datereg1)
            cell.Flocationlbl.text = datereg
        }else {
            cell.Flocationlbl.text = task.supposedlocation
        }
 
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return assetlist.count
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let ast = assetlist[indexPath.row]
        let ittagstr = ast.ittag ?? ""
        let flocationstr = ast.foundlocation ?? ""
        let slocationstr = ast.supposedlocation ?? ""
        let dtypestr = ast.devicetype ?? ""
        let datestr = ast.dateregisterd
        
        let message = "Asset Tag: \(ittagstr)\n The location asset was found: \(flocationstr)\n The location asset was supposed to be: \(slocationstr)\n Asset's device type: \(dtypestr)\n The date of register: \(datestr ?? Date())\n"
        
        let dialog = UIAlertController(title: "Asset Information", message: message, preferredStyle: .alert)
        
        let cancel = UIAlertAction(title: "OK", style: .cancel)
        
        dialog.addAction(cancel)
        self.present(dialog, animated: true, completion: nil)
    
    }
    
    
    //updates
    func update() {
        print("Print the default value for sort 1: ",UserDefaults.standard.integer(forKey: "sort"))
        if ((UserDefaults.standard.integer(forKey: "sort")) == 1) {
            assetlist = appDelegate.fetchAsset()
            assetlist.sort(by: {($0.foundlocation ?? "")<($1.foundlocation ?? "")})
            tblview.reloadData()
        } else if ((UserDefaults.standard.integer(forKey: "sort")) == 2) {
                assetlist = appDelegate.fetchAsset()
                assetlist.sort(by: {($0.supposedlocation ?? "")<($1.supposedlocation ?? "")})
                tblview.reloadData()
        } else if ((UserDefaults.standard.integer(forKey: "sort")) == 3) {
            assetlist = appDelegate.fetchAsset()
            assetlist.sort(by: {($0.devicetype ?? "")<($1.devicetype ?? "")})
            tblview.reloadData()
        }else if ((UserDefaults.standard.integer(forKey: "sort")) == 4) {
            assetlist = appDelegate.fetchAsset()
            assetlist.sort(by: {($0.ittag ?? "")<($1.ittag ?? "")})
            tblview.reloadData()
        }

    }
    
    
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        update()
    }
    

}







//core Data getall, add, delete, //

//    func getallassets() {
//        do {
//            assetlist = try context.fetch(Assets.fetchRequest())
//            DispatchQueue.main.async {
//                self.tableView.reloadData()
//            }
//        } catch  {
//            print(Error.self)
//        }
//    }
//
//    func createAssets(ittag: String, flocation:String, slocation:String, devictype:String, datereg:Date) {
//        let newasset = Assets(context: context)
//        newasset.ittag = ittag
//        newasset.foundlocation = flocation
//        newasset.supposedlocation = slocation
//        newasset.devicetype = devictype
//        newasset.dateregisterd = datereg
//
//        do {
//            try context.save()
//            getallassets()
//        } catch  {
//            print(error)
//        }
//    }
//
//    func deleteassets(asset: Assets) {
//        context.delete(asset)
//        getallassets()
//
//        do {
//            try context.save()
//        } catch  {
//            print(error)
//        }
//    }
//
//    func updateflocation(asset: Assets, newlocation: String) {
//        asset.foundlocation = newlocation
//        getallassets()
//        do {
//            try context.save()
//        } catch  {
//            print(error)
//        }
//    }
//
//    func updateslocation(asset: Assets, newlocation: String) {
//        asset.supposedlocation = newlocation
//        getallassets()
//        do {
//            try context.save()
//        } catch  {
//            print(error)
//        }
//    }
//
//    func updatedtype(asset: Assets, devicetype: String) {
//        asset.devicetype = devicetype
//        getallassets()
//        do {
//            try context.save()
//        } catch  {
//            print(error)
//        }
//    }
//
//
