//
//  ViewController.swift
//  Bitcoin Price Tracker
//
//  Created by Jamario Davis on 1/22/19.
//  Copyright © 2019 KAYCAM. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var usdLabel: UILabel!
    @IBOutlet var euroLabel: UILabel!
    @IBOutlet var jpyLabel: UILabel!
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        getDefaultPrices()
        getPrice()
    }
    func getDefaultPrices() {
        let usdPrice = UserDefaults.standard.double(forKey: "USD")
        if usdPrice != 0.0 {
              self.usdLabel.text = self.doubleToMoneyString(price: usdPrice, currencyCode: "USD") + "~"
        }
        let euroPrice = UserDefaults.standard.double(forKey: "EUR")
        if euroPrice != 0.0 {
            self.euroLabel.text = self.doubleToMoneyString(price: euroPrice, currencyCode: "EUR") + "~"
        }
        let jpyPrice = UserDefaults.standard.double(forKey: "USD")
        if jpyPrice != 0.0 {
            self.jpyLabel.text = self.doubleToMoneyString(price: jpyPrice, currencyCode: "JPY") + "~"
        }
    }
    func getPrice() {
        if let url = URL(string: "Https://min-api.cryptocompare.com/data/price?fsym=BTC&tsyms=USD,JPY,EUR") {
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let data = data {
                    if let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String:Double] {
                        if let jsonDictionary = json {
                            DispatchQueue.main.async {
                                if let usdPrice = jsonDictionary["USD"] {
                                self.usdLabel.text = self.doubleToMoneyString(price: usdPrice, currencyCode: "USD")
                                    UserDefaults.standard.set(usdPrice, forKey: "USD")
                                }
                                if let euroPrice = jsonDictionary["EUR"] {
                                    self.euroLabel.text = self.doubleToMoneyString(price: euroPrice, currencyCode: "EUR")
                                    UserDefaults.standard.set(euroPrice, forKey: "EUR")
                                }
                                if let jpyPrice = jsonDictionary["JPY"] {
                                    self.jpyLabel.text = self.doubleToMoneyString(price: jpyPrice, currencyCode: "JPY")
                                    UserDefaults.standard.set(jpyPrice, forKey: "JPY")
                                }
                                 UserDefaults.standard.synchronize()
                            }
                        }
                    }
                    
                } else {
                    print("Something went wrong")
                }
                }.resume()
        }
    }
    func doubleToMoneyString(price:Double,currencyCode: String) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = currencyCode
        let priceString = formatter.string(from: NSNumber(value: price))
        if priceString == nil {
            return "ERROR"
        } else {
            return priceString!
        }
    }
    
    @IBAction func refreshTapped(_ sender: Any) {
        getPrice()
    }
    
}

