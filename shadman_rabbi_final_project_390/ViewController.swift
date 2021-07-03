//
//  ViewController.swift
//  shadman_rabbi_final_project_390
//
//  Created by Shadman UR Rabbi on 7/2/21.
//

import UIKit

class ViewController: UIViewController {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    
    
    
    
    //core Data getall, add, delete, //

    func getallassets() {
        do {
            let assets = try context.fetch(Assets.fetchRequest())
        } catch  {
            print(Error.self)
        }
    }
    
    func createAssets(ittag: String, flocation:String, slocation:String, devictype:String, datereg:Date) {
        let newasset = Assets(context: context)
        newasset.ittag = ittag
        newasset.foundlocation = flocation
        newasset.supposedlocation = slocation
        newasset.devicetype = devictype
        newasset.dateregisterd = datereg
        
        do {
            try context.save()
        } catch  {
            print(error)
        }
    }
    
    func deleteassets(asset: Assets) {
        context.delete(asset)
        
        do {
            try context.save()
        } catch  {
            print(error)
        }
    }
    
    func updateflocation(asset: Assets, newlocation: String) {
        asset.foundlocation = newlocation
        do {
            try context.save()
        } catch  {
            print(error)
        }
    }
    
    func updateslocation(asset: Assets, newlocation: String) {
        asset.supposedlocation = newlocation
        do {
            try context.save()
        } catch  {
            print(error)
        }
    }
    
    func updatedtype(asset: Assets, devicetype: String) {
        asset.devicetype = devicetype
        do {
            try context.save()
        } catch  {
            print(error)
        }
    }
    
    
}

