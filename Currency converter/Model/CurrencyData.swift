//
//  CurrencyData.swift
//  Currency converter
//
//  Created by Dusan Vojinovic on 16.12.21..
//

import Foundation

struct CurrencyData: Codable {
    let result: Result?
}

struct Result: Codable {
    let date: String
    let eur: AttributesOfCurrencies
    let usd: AttributesOfCurrencies
    let chf: AttributesOfCurrencies
    let gbp: AttributesOfCurrencies
    let aud: AttributesOfCurrencies
    let cad: AttributesOfCurrencies
    let sek: AttributesOfCurrencies
    let dkk: AttributesOfCurrencies
    let nok: AttributesOfCurrencies
    let jpy: AttributesOfCurrencies
    let rub: AttributesOfCurrencies
    let cny: AttributesOfCurrencies
    let hrk: AttributesOfCurrencies
    let kwd: AttributesOfCurrencies
    let pln: AttributesOfCurrencies
    let czk: AttributesOfCurrencies
    let huf: AttributesOfCurrencies
    let bam: AttributesOfCurrencies
}

struct AttributesOfCurrencies: Codable {
    let kup: String
    let sre: String
    let pro: String
}
