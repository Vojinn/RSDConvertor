//
//  ViewController.swift
//  Currency converter
//
//  Created by Dusan Vojinovic on 10.12.21..
//

import UIKit
import iOSDropDown

class ViewController: UIViewController {
    
    @IBOutlet weak var amountLabel: UITextField!
    @IBOutlet weak var resultLabel: UITextField!
    
    @IBOutlet weak var dropDownTo: DropDown!
    
    var currencyData = CurrencyData(result: nil)
    
    private var apiKey: String {
        get {
            guard let filePath = Bundle.main.path(forResource: "kursnaLista-Info", ofType: "plist") else {
                fatalError("Couldn't find file 'kursnaLista-Info.plist'")
            }
            let plist = NSDictionary(contentsOfFile: filePath)
            guard let value = plist?.object(forKey: "API_KEY") as? String else {
                fatalError("Couldn't find key 'API-KEY' in 'kursnaLista-Info.plist'")
            }
            return value
        }
    }
    
    private var amountOfMoney: Double {
        get {
            guard let number = Double(amountLabel.text!) else {
                fatalError("Cannon convert display label text to a Double")
            }
            return number
        }
        set {
            resultLabel.text = String(newValue) + " \(dropDownTo.text!)"
        }
    }
    
    var arraysOfCurrencies = ["eur","usd","chf","gbp","aud","cad","sek","dkk","nok","jpy","rub","cny","hrk","kwd","pln","czk","huf","bam"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dropDownTo.optionArray = arraysOfCurrencies
        dropDownTo.selectedIndex = 0
        self.dropDownTo.text = dropDownTo.optionArray[0]
        
        dropDownTo.didSelect { selectedText, index, id in
            print("Selected String: \(selectedText) \n index: \(index)")
            self.dropDownTo.hideList()
            self.dropDownTo.text = selectedText
        }
        
        let url = URL(string: apiKey)
        let task = URLSession.shared.dataTask(with: url!) { (data,response,error) in
            
            if error != nil {
                print("Error")
            } else {
                if let content = data {
                    do {
                        let myJson = try JSONSerialization.jsonObject(with: content, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
                        print(myJson)
                        self.currencyData = self.parse(jsonData: content)!
                    } catch {
                        
                    }
                }
            }
        }
        task.resume()
    }
    
    @IBAction func convertButtonPressed(_ sender: Any) {
        
        
        var convertTo = dropDownTo.text
        var amountToConvert = Double(amountLabel.text!)
        if amountToConvert == nil  || amountToConvert! <= 0{
            return
        }
        
        var amountMoney = amountToConvert! / returnAmountKup(currency: convertTo!)
        
        amountOfMoney = Double(round(1000 * amountMoney) / 1000)
        amountLabel.resignFirstResponder()
    }
    
    
    private func parse(jsonData: Data) -> CurrencyData? {
        do {
            let decodedData = try JSONDecoder().decode(CurrencyData.self, from: jsonData)
            
            return decodedData
        } catch {
            print("Decode error.")
        }
        return nil
    }
    
    private func returnAmountKup(currency: String) -> Double {
        
        switch currency {
        case "eur":
            return Double(currencyData.result!.eur.kup)!
        case "usd":
            return Double(currencyData.result!.usd.kup)!
        case "chf":
            return Double(currencyData.result!.chf.kup)!
        case "gbp":
            return Double(currencyData.result!.gbp.kup)!
        case "aud":
            return Double(currencyData.result!.aud.kup)!
        case "cad":
            return Double(currencyData.result!.cad.kup)!
        case "sek":
            return Double(currencyData.result!.sek.kup)!
        case "dkk":
            return Double(currencyData.result!.dkk.kup)!
        case "nok":
            return Double(currencyData.result!.nok.kup)!
        case "jpy":
            return Double(currencyData.result!.jpy.kup)!
        case "rub":
            return Double(currencyData.result!.rub.kup)!
        case "cny":
            return Double(currencyData.result!.cny.kup)!
        case "hrk":
            return Double(currencyData.result!.hrk.kup)!
        case "kwd":
            return Double(currencyData.result!.kwd.kup)!
        case "pln":
            return Double(currencyData.result!.pln.kup)!
        case "czk":
            return Double(currencyData.result!.czk.kup)!
        case "huf":
            return Double(currencyData.result!.huf.kup)!
        case "bam":
            return Double(currencyData.result!.bam.kup)!
        
            
        default:
            return 0
        }
    }
    
}

