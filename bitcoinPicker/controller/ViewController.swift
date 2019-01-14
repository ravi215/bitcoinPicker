//
//  ViewController.swift
//  bitcoinPicker
//
//  Created by Ravi Bhooshan on 06/01/19.
//  Copyright © 2019 Ravi Bhooshan. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController , UIPickerViewDelegate , UIPickerViewDataSource {
   
    let baseURL = "https://apiv2.bitcoinaverage.com/indices/global/ticker/BTC"
    let countryName = ["USD","INR","AUD","BRL","CAD","NZD","IDR","ILS","CNY","BTN"]
    var finalURl = ""
   
    
    
    @IBOutlet weak var bitcoinImage: UIImageView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var pricePickerView: UIPickerView!
    @IBOutlet weak var priceInCurrency: UILabel!
    

    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return countryName.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return countryName[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        finalURl = baseURL + countryName[row]
        print(countryName[row])
        print(finalURl)
        getBitcoinData(url: finalURl)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pricePickerView.delegate =  self
        pricePickerView.dataSource = self
    }
  
    
    
    
    
     //                                   Networking
   
    
    func getBitcoinData(url: String ){
        
        Alamofire.request(url, method: .get).responseJSON{
            response in
            if response.result.isSuccess{
                print("yeah we got the data")
                
                // converting the  data came from server to the user understandble formats
                let bitcoinJSON: JSON = JSON(response.result.value!)
                //                 print(weatherJSON)
                self.updateBitcoinData(json: bitcoinJSON)
                
                
            }else{
                print("Error \(String(describing: response.result.error))")
                self.priceInCurrency.text = ""
            }
        }
       
    }
    
    //MARK: - JSON Parsing
    /***************************************************************/
    
    
      //Write the updateWeatherData method here:
    
    func updateBitcoinData(json: JSON){
        
        // grabbing the data from the json formats and converting them to understandble formats
        
        
        if let bitcoinResult = json["ask"].double{         // using if let to do  optional binding
            priceInCurrency.text = "\(bitcoinResult)"
            
        }else{
            priceInCurrency.text = "price Unavailiable"
         }

    
    }

}
