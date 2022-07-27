//
//  SwiftRandom.swift
//
//  Created by Furkan Yilmaz on 7/10/15.
//  Copyright (c) 2015 Furkan Yilmaz. All rights reserved.
//

import UIKit
import CloudKit

public protocol RandomElementProtocol {
    associatedtype ObjectType = Self
    static func random() -> ObjectType
}

extension Collection where Element: RandomElementProtocol {
    public static func random() -> [Element] {
        let itemsCount = Int.random(2,10)
        return (0...itemsCount).map{ _ in Element.random() as! Self.Element }
    }
}

extension Collection where Element == Bool {
    public static func random() -> [Element] {
        let itemsCount = Int.random(2,10)
        return (0...itemsCount).map{ _ in Element.random() }
    }
}

extension Collection where Element == Int {
    public static func random() -> [Element] {
        let itemsCount = Int.random(2,10)
        return (0...itemsCount).map{ _ in Element.random() }
    }
}

extension Collection where Element == Int32 {
    public static func random() -> [Element] {
        let itemsCount = Int.random(2,10)
        return (0...itemsCount).map{ _ in Element.random() }
    }
}

extension Collection where Element == String {
    public static func random() -> [Element] {
        let itemsCount = Int.random(2,10)
        return (0...itemsCount).map{ _ in Element.random(minimumLength: 4, maximumLength: 16) }
    }
}

extension Collection where Element == Double {
    public static func random() -> [Element] {
        let itemsCount = Int.random(2,10)
        return (0...itemsCount).map{ _ in Element.random() }
    }
}

extension Collection where Element == Float {
    public static func random() -> [Element] {
        let itemsCount = Int.random(2,10)
        return (0...itemsCount).map{ _ in Element.random() }
    }
}

extension Collection where Element == CGFloat {
    public static func random() -> [Element] {
        let itemsCount = Int.random(2,10)
        return (0...itemsCount).map{ _ in Element.random() }
    }
}

extension Collection where Element == Date {
    public static func random() -> [Element] {
        let itemsCount = Int.random(2,10)
        return (0...itemsCount).map{ _ in Element.random() }
    }
}

// each type has its own random

public extension Bool {
    /// SwiftRandom extension
    static func random() -> Bool {
        return Int.random() % 2 == 0
    }
}

public extension Int {
    /// SwiftRandom extension
    static func random(_ lower: Int = 0, _ upper: Int = 100) -> Int {
        return Int.random(in: lower...upper)
    }
}

public extension Int32 {
    /// SwiftRandom extension
    ///
    /// - note: Using `Int` as parameter type as we usually just want to write `Int32.random(13, 37)` and not `Int32.random(Int32(13), Int32(37))`
    static func random(_ lower: Int = 0, _ upper: Int = 100) -> Int32 {
        return Int32.random(in: Int32(lower)...Int32(upper))
    }
}

public extension String {

    static func random() -> String {
        return random(ofLength: Int.random(3, 10))
    }

    /// SwiftRandom extension
    static func random(ofLength length: Int) -> String {
        return random(minimumLength: length, maximumLength: length)
    }

    /// SwiftRandom extension
    static func random(minimumLength min: Int, maximumLength max: Int) -> String {
        return random(
            withCharactersInString: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789",
            minimumLength: min,
            maximumLength: max
        )
    }

    /// SwiftRandom extension
    static func random(withCharactersInString string: String, ofLength length: Int) -> String {
        return random(
            withCharactersInString: string,
            minimumLength: length,
            maximumLength: length
        )
    }

    /// SwiftRandom extension
    static func random(withCharactersInString string: String, minimumLength min: Int, maximumLength max: Int) -> String {
        guard min > 0 && max >= min else {
            return ""
        }

        let length: Int = (min < max) ? .random(in: min...max) : max
        var randomString = ""

        (1...length).forEach { _ in
            let randomIndex: Int = .random(in: 0..<string.count)
            let c = string.index(string.startIndex, offsetBy: randomIndex)
            randomString += String(string[c])
        }

        return randomString
    }
}

public extension Double {
    /// SwiftRandom extension
    static func random(_ lower: Double = 0, _ upper: Double = 100) -> Double {
        return Double.random(in: lower...upper)
    }
}

public extension Float {
    /// SwiftRandom extension
    static func random(_ lower: Float = 0, _ upper: Float = 100) -> Float {
        return Float.random(in: lower...upper)
    }
}

public extension CGFloat {
    /// SwiftRandom extension
    static func random(_ lower: CGFloat = 0, _ upper: CGFloat = 1) -> CGFloat {
        return CGFloat.random(in: lower...upper)
    }
}

public extension Date {
    /// SwiftRandom extension
    static func randomWithinDaysBeforeToday(_ days: Int) -> Date {
        let today = Date()
        let earliest = today.addingTimeInterval(TimeInterval(-days*24*60*60))

        return Date.random(between: earliest, and: today)
    }

    /// SwiftRandom extension
    static func random() -> Date {
        let randomTime = TimeInterval(arc4random_uniform(UInt32.max))
        return Date(timeIntervalSince1970: randomTime)
    }

    static func random(between initial: Date, and final:Date) -> Date {
        let interval = final.timeIntervalSince(initial)
        let randomInterval = TimeInterval(arc4random_uniform(UInt32(interval)))
        return initial.addingTimeInterval(randomInterval)
    }

}

public extension UIColor {
    /// SwiftRandom extension
    static func random(_ randomAlpha: Bool = false) -> UIColor {
        let randomRed = CGFloat.random()
        let randomGreen = CGFloat.random()
        let randomBlue = CGFloat.random()
        let alpha = randomAlpha ? CGFloat.random() : 1.0
        return UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: alpha)
    }
}

public extension URL {
    /// SwiftRandom extension
    static func random() -> URL {
        let urlList = ["http://www.google.com", "http://leagueoflegends.com/", "https://github.com/", "http://stackoverflow.com/", "https://medium.com/", "http://9gag.com/gag/6715049", "http://imgur.com/gallery/s9zoqs9", "https://www.youtube.com/watch?v=uelHwf8o7_U"]
        return URL(string: urlList.randomElement()!)!
    }
}


public struct Randoms {

    //==========================================================================================================
    // MARK: - Object randoms
    //==========================================================================================================

    public static func randomBool() -> Bool {
        return Bool.random()
    }

    public static func randomInt(_ range: Range<Int>) -> Int {
        return Int.random(in: range)
    }

    public static func randomInt(_ lower: Int = 0, _ upper: Int = 100) -> Int {
        return Int.random(lower, upper)
    }

    public static func randomInt32(_ range: Range<Int32>) -> Int32 {
        return Int32.random(in: range)
    }

    public static func randomInt32(_ lower: Int = 0, _ upper: Int = 100) -> Int32 {
        return Int32.random(lower, upper)
    }

    public static func randomString(ofLength length: Int) -> String {
        return String.random(ofLength: length)
    }

    public static func randomString(minimumLength min: Int, maximumLength max: Int) -> String {
        return String.random(minimumLength: min, maximumLength: max)
    }

    public static func randomString(withCharactersInString string: String, ofLength length: Int) -> String {
        return String.random(withCharactersInString: string, ofLength: length)
    }

    public static func randomString(withCharactersInString string: String, minimumLength min: Int, maximumLength max: Int) -> String {
        return String.random(withCharactersInString: string, minimumLength: min, maximumLength: max)
    }

    public static func randomPercentageisOver(_ percentage: Int) -> Bool {
        return Int.random() >= percentage
    }

    public static func randomDouble(_ lower: Double = 0, _ upper: Double = 100) -> Double {
        return Double.random(lower, upper)
    }

    public static func randomFloat(_ lower: Float = 0, _ upper: Float = 100) -> Float {
        return Float.random(lower, upper)
    }

    public static func randomCGFloat(_ lower: CGFloat = 0, _ upper: CGFloat = 1) -> CGFloat {
        return CGFloat.random(lower, upper)
    }

    public static func randomDateWithinDaysBeforeToday(_ days: Int) -> Date {
        return Date.randomWithinDaysBeforeToday(days)
    }

    public static func randomDate() -> Date {
        return Date.random()
    }

    public static func randomColor(_ randomAlpha: Bool = false) -> UIColor {
        return UIColor.random(randomAlpha)
    }

    public static func randomNSURL() -> URL {
        return URL.random()
    }

    //==========================================================================================================
    // MARK: - Fake random data generators
    //==========================================================================================================

    public static func randomFakeName() -> String {
        return randomFakeFirstName() + " " + randomFakeLastName()
    }

    public static func randomFakeUsername() -> String {
        return randomFakeFirstName() + randomFakeLastName()
    }

    public static func randomFakeFirstName() -> String {
        let firstNameList = ["Henry", "William", "Geoffrey", "Jim", "Yvonne", "Jamie", "Leticia", "Priscilla", "Sidney", "Nancy", "Edmund", "Bill", "Megan"]
        return firstNameList.randomElement()!
    }

    public static func randomFakeLastName() -> String {
        let lastNameList = ["Pearson", "Adams", "Cole", "Francis", "Andrews", "Casey", "Gross", "Lane", "Thomas", "Patrick", "Strickland", "Nicolas", "Freeman"]
        return lastNameList.randomElement()!
    }

    public static func randomFakeGender() -> String {
        return Bool.random() ? "Male" : "Female"
    }
    
    public static func randomFakeEmail() -> String {
        return randomFakeFirstName() + "\(Int.random())" + "@fake.com"
    }

    public static func randomFakeConversation() -> String {
        let convoList = ["You embarrassed me this evening.", "You don't think that was just lemonade in your glass, do you?", "Do you ever think we should just stop doing this?", "Why didn't he come and talk to me himself?", "Promise me you'll look after your mother.", "If you get me his phone, I might reconsider.", "I think the room is bugged.", "No! I'm tired of doing what you say.", "For some reason, I'm attracted to you."]
        return convoList.randomElement()!
    }

    public static func randomFakeTitle() -> String {
        let titleList = ["CEO of Google", "CEO of Facebook", "VP of Marketing @Uber", "Business Developer at IBM", "Jungler @ Fanatic", "B2 Pilot @ USAF", "Student at Stanford", "Student at Harvard", "Mayor of Raccoon City", "CTO @ Umbrella Corporation", "Professor at Pallet Town University"]
        return titleList.randomElement()!
    }

    public static func randomFakeTag() -> String {
        let tagList = ["meta", "forum", "troll", "meme", "question", "important", "like4like", "f4f"]
        return tagList.randomElement()!
    }

    fileprivate static func randomEnglishHonorific() -> String {
        let englishHonorificsList = ["Mr.", "Ms.", "Dr.", "Mrs.", "Mz.", "Mx.", "Prof."]
        return englishHonorificsList.randomElement()!
    }

    public static func randomFakeNameAndEnglishHonorific() -> String {
        let englishHonorific = randomEnglishHonorific()
        let name = randomFakeName()
        return englishHonorific + " " + name
    }

    public static func randomFakeCountry() -> String {
        return ["Afghanistan","ÅlandIslands","Albania","Algeria","AmericanSamoa","AndorrA","Angola","Anguilla","Antarctica","AntiguaandBarbuda","Argentina","Armenia","Aruba","Australia","Austria","Azerbaijan","Bahamas","Bahrain","Bangladesh","Barbados","Belarus","Belgium","Belize","Benin","Bermuda","Bhutan","Bolivia","BosniaandHerzegovina","Botswana","BouvetIsland","Brazil","BritishIndianOceanTerritory","BruneiDarussalam","Bulgaria","BurkinaFaso","Burundi","Cambodia","Cameroon","Canada","CapeVerde","CaymanIslands","CentralAfricanRepublic","Chad","Chile","China","ChristmasIsland","Cocos(Keeling)Islands","Colombia","Comoros","Congo","Congo,TheDemocraticRepublicofthe","CookIslands","CostaRica","CoteD\'Ivoire","Croatia","Cuba","Cyprus","CzechRepublic","Denmark","Djibouti","Dominica","DominicanRepublic","Ecuador","Egypt","ElSalvador","EquatorialGuinea","Eritrea","Estonia","Ethiopia","FalklandIslands(Malvinas)","FaroeIslands","Fiji","Finland","France","FrenchGuiana","FrenchPolynesia","FrenchSouthernTerritories","Gabon","Gambia","Georgia","Germany","Ghana","Gibraltar","Greece","Greenland","Grenada","Guadeloupe","Guam","Guatemala","Guernsey","Guinea","Guinea-Bissau","Guyana","Haiti","HeardIslandandMcdonaldIslands","HolySee(VaticanCityState)","Honduras","HongKong","Hungary","Iceland","India","Indonesia","Iran,IslamicRepublicOf","Iraq","Ireland","IsleofMan","Israel","Italy","Jamaica","Japan","Jersey","Jordan","Kazakhstan","Kenya","Kiribati","Korea,DemocraticPeople\'SRepublicof","Korea,Republicof","Kuwait","Kyrgyzstan","LaoPeople\'SDemocraticRepublic","Latvia","Lebanon","Lesotho","Liberia","LibyanArabJamahiriya","Liechtenstein","Lithuania","Luxembourg","Macao","Macedonia,TheFormerYugoslavRepublicof","Madagascar","Malawi","Malaysia","Maldives","Mali","Malta","MarshallIslands","Martinique","Mauritania","Mauritius","Mayotte","Mexico","Micronesia,FederatedStatesof","Moldova,Republicof","Monaco","Mongolia","Montserrat","Morocco","Mozambique","Myanmar","Namibia","Nauru","Nepal","Netherlands","NetherlandsAntilles","NewCaledonia","NewZealand","Nicaragua","Niger","Nigeria","Niue","NorfolkIsland","NorthernMarianaIslands","Norway","Oman","Pakistan","Palau","PalestinianTerritory,Occupied","Panama","PapuaNewGuinea","Paraguay","Peru","Philippines","Pitcairn","Poland","Portugal","PuertoRico","Qatar","Reunion","Romania","RussianFederation","RWANDA","SaintHelena","SaintKittsandNevis","SaintLucia","SaintPierreandMiquelon","SaintVincentandtheGrenadines","Samoa","SanMarino","SaoTomeandPrincipe","SaudiArabia","Senegal","SerbiaandMontenegro","Seychelles","SierraLeone","Singapore","Slovakia","Slovenia","SolomonIslands","Somalia","SouthAfrica","SouthGeorgiaandtheSouthSandwichIslands","Spain","SriLanka","Sudan","Suriname","SvalbardandJanMayen","Swaziland","Sweden","Switzerland","SyrianArabRepublic","Taiwan,ProvinceofChina","Tajikistan","Tanzania,UnitedRepublicof","Thailand","Timor-Leste","Togo","Tokelau","Tonga","TrinidadandTobago","Tunisia","Turkey","Turkmenistan","TurksandCaicosIslands","Tuvalu","Uganda","Ukraine","UnitedArabEmirates","UnitedKingdom","UnitedStates","UnitedStatesMinorOutlyingIslands","Uruguay","Uzbekistan","Vanuatu","Venezuela","VietNam","VirginIslands,British","VirginIslands,U.S.","WallisandFutuna","WesternSahara","Yemen","Zambia","Zimbabwe"].randomElement()!
    }

    public static func randomFakeState() -> String {
        return ["Alabama","Alaska","AmericanSamoa","Arizona","Arkansas","California","Colorado","Connecticut","Delaware","DistrictOfColumbia","FederatedStatesOfMicronesia","Florida","Georgia","Guam","Hawaii","Idaho","Illinois","Indiana","Iowa","Kansas","Kentucky","Louisiana","Maine","MarshallIslands","Maryland","Massachusetts","Michigan","Minnesota","Mississippi","Missouri","Montana","Nebraska","Nevada","NewHampshire","NewJersey","NewMexico","NewYork","NorthCarolina","NorthDakota","NorthernMarianaIslands","Ohio","Oklahoma","Oregon","Palau","Pennsylvania","PuertoRico","RhodeIsland","SouthCarolina","SouthDakota","Tennessee","Texas","Utah","Vermont","VirginIslands","Virginia","Washington","WestVirginia","Wisconsin","Wyoming"].randomElement()!
    }

    public static func randomFakeCity() -> String {
        let cityPrefixes = ["North", "East", "West", "South", "New", "Lake", "Port"]
        let citySuffixes = ["town", "ton", "land", "ville", "berg", "burgh", "borough", "bury", "view", "port", "mouth", "stad", "furt", "chester", "mouth", "fort", "haven", "side", "shire"]
        return cityPrefixes.randomElement()! + citySuffixes.randomElement()!
    }

    public static func randomFakeAddress() -> String {
        return "\(Int.random()) \(randomFakeCity) Street"
    }

    public static func randomFakeStreet() -> String {
        return "\(Int.random()) \(randomFakeCity) Street"
    }

    public static func randomZipCode() -> String {
        return String.random(ofLength: 5)
    }

    public static func randomFakeUrl() -> String {
        return URL.random().absoluteString
    }
    
    public static func randomFakeAvatar() -> String {
        return Self.randomAvatar()
    }
    
    public static func randomFakePhotoUrl() -> String {
        return Self.randomAvatar()
    }
    
    public static func randomAvatar() -> String {
        return "https://i.pravatar.cc/150?img=\(Int.random(0, 70))"
    }

    public static func randomCurrency() -> String {
        let currencyList = ["USD", "EUR", "GBP", "JPY", "AUD", "CAD", "ZAR", "NZD", "INR", "BRP", "CNY", "EGP", "KRW", "MXN", "SAR", "SGD",]

        return currencyList.randomElement()!
    }

       public enum GravatarStyle: String {
        case Standard
        case MM
        case Identicon
        case MonsterID
        case Wavatar
        case Retro

        static let allValues = [Standard, MM, Identicon, MonsterID, Wavatar, Retro]
    }

    public static func createGravatar(_ style: Randoms.GravatarStyle = .Standard, size: Int = 80, completion: ((_ image: UIImage?, _ error: Error?) -> Void)?) {
        var url = "https://secure.gravatar.com/avatar/thisimagewillnotbefound?s=\(size)"
        if style != .Standard {
            url += "&d=\(style.rawValue.lowercased())"
        }

        let request = URLRequest(url: URL(string: url)! as URL, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 5.0)
        let session = URLSession.shared

        session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) in
            DispatchQueue.main.async {
                if error == nil {
                    completion?(UIImage(data: data!), nil)
                } else {
                    completion?(nil, error)
                }
            }
        }).resume()
    }

    public static func randomGravatar(_ size: Int = 80, completion: ((_ image: UIImage?, _ error: Error?) -> Void)?) {
        let options = Randoms.GravatarStyle.allValues
        Randoms.createGravatar(options.randomElement()!, size: size, completion: completion)
    }
}
