//
//  main.swift
//  L5_TimokhinMaksim(HW)
//
//  Created by Максим Тимохин on 29.07.2020.
//  Copyright © 2020 Максим Тимохин. All rights reserved.
//

import Foundation
//1. Создать протокол «Car» и описать свойства, общие для автомобилей, а также метод действия.
//
//2. Создать расширения для протокола «Car» и реализовать в них методы конкретных действий с автомобилем: открыть/закрыть окно, запустить/заглушить двигатель и т.д. (по одному методу на действие, реализовывать следует только те действия, реализация которых общая для всех автомобилей).
//
//3. Создать два класса, имплементирующих протокол «Car» - trunkCar и sportСar. Описать в них свойства, отличающиеся для спортивного автомобиля и цистерны.
//
//4. Для каждого класса написать расширение, имплементирующее протокол CustomStringConvertible.
//
//5. Создать несколько объектов каждого класса. Применить к ним различные действия.
//
//6. Вывести сами объекты в консоль.

enum CarActions {
    case turnEngineOn
    case turnEngineOff
    case openWindow
    case closeWindow
}

enum SportCarActions {
    case spolerUp
    case spolerDown
    case speedUp
    case speedDowm
}

enum TrunkCarAction {
    case truckLoad
    case truckUnLoad
}

protocol CarAction {
    func carAction(action: CarActions)
}

class Car: CarAction{
    
    var color: Int = 0
    var wheelCount: Int = 0
    var isEngineOn: Bool = false
    var isWindowOn: Bool = true
    
    init (color: Int, wheelCount: Int) {
        self.color = color
        self.wheelCount = wheelCount
    }
    
    func carAction(action: CarActions) {
        switch action {
        case .turnEngineOff:
            guard isEngineOn else {
                print("Двигатель уже включен")
                return
            }
            isEngineOn = false
            
        case .turnEngineOn:
            guard !isEngineOn else {
                print("Двигатель уже выключен")
                return
            }
            isEngineOn = true
            
        case .openWindow:
            guard !isWindowOn else {
                print("Окна уже открыты")
                return
            }
            isWindowOn = false
            
        case .closeWindow:
            guard isWindowOn else {
                print("Окна уже закрыты")
                return
            }
            isWindowOn = true
        }
    }
}

protocol SportCar {
    func sportCarAction(action: SportCarActions)
}

class SportCars: Car, SportCar {
    var isSpolerOn: Bool = true
    init (color: Int, wheelCount: Int, isEngineOn: Bool, isWindowOn: Bool, isSpolerOn: Bool){
        self.isSpolerOn = isSpolerOn
        super.init(color: color, wheelCount: wheelCount)
    }
    
    let maxSpeedLimit: Int = 252849
    var speed: Int = 0
    
    func sportCarAction(action: SportCarActions){
        if action == .speedUp {
            speed = min(speed + 1, maxSpeedLimit)
            
        } else if action == .speedDowm {
            speed = max(speed - 1, 0)
        }
        
        switch action {
        case .spolerUp:
            guard isSpolerOn else {
                print("Сполер уже поднят")
                return
            }
            
            isSpolerOn = true
        case .spolerDown:
            guard !isSpolerOn else {
                print("Сполер уже опущен")
                return
            }
            isSpolerOn = false
            
        default:
            print("ХЗ")
        }
    }
}
protocol TrunkCar {
    func truckCarAction(action: TrunkCarAction)
}

class TrunkCars: Car, TrunkCar {
    var trunkCappacity: Int
    var trunkIn: Int
    
    init (color: Int, wheelCount: Int, trunkCappacity: Int, trunkIn: Int, isEngineOn: Bool,
          isWindowOn: Bool ){
        self.trunkCappacity = trunkCappacity
        self.trunkIn = trunkIn
        // Здесь выдает ошибку "Consecutive declarations on a line must be separated by ';'"
        super.init(color: color, wheelCount: wheelCount)
        //        self.color = color
        //        self.wheelCount = wheelCount
    }
    func truckCarAction(action: TrunkCarAction) {
        if action == .truckLoad {
            trunkIn = min(trunkIn + 1, trunkCappacity )
        }
        else if action == .truckUnLoad {
            trunkIn = max(trunkIn - 1, 0)
        }
    }
}
let truck = TrunkCars(color: 0x000000, wheelCount: 16, trunkCappacity: 100, trunkIn: 0, isEngineOn: true, isWindowOn: false)

truck.carAction(action: .turnEngineOn)
truck.truckCarAction(action: .truckLoad)
truck.carAction(action: .openWindow)
//
let sportCar = SportCars(color: 0x009999, wheelCount: 4, isEngineOn: false, isWindowOn: false, isSpolerOn: false)
sportCar.sportCarAction(action: .speedUp)
sportCar.sportCarAction(action: .spolerUp)
//
print("Truck: в багажнике \(truck.trunkIn)кг, двигатель включен \(truck.isEngineOn)")
print("SportCar: окна \(sportCar.isWindowOn), сполер \(sportCar.isSpolerOn), скорость \(sportCar.speed)")

print("Cпасибо за внимание")

