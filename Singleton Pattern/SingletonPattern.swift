
import Foundation

protocol Car{
    
    private var manufucturer : String{ get  set}
    func drive()
}


class SportsCar : Car {
   private var manufucturer: String
    
    init(manufucturer : String){
        self.manufucturer = manufucturer
    }
    func drive() {
        print("Sports car \(manufucturer) is driving")
        
    }
    
}

class SedanCar : Car{
    var manufucturer: String
    init(manufucturer : String){
        self.manufucturer = manufucturer
    }
    func drive() {
        print("Sedan car \(manufucturer) is driving")
    }
}


enum CarType{
    case Sport
    case Sedan
}

//MARK: Thread-Safe Singleton

class CarManagement {
    private let queue = DispatchQueue(label: "Concurrent",attributes: .concurrent)
    private var allCars : [Car] = []
    static let shared = CarManagement()
    private init(){}
    
    func addCar(type : CarType , manufucturer : String){
        
        queue.async(flags : .barrier){
            switch type {
            case .Sedan:
                self.allCars.append(SedanCar(manufucturer: manufucturer))
                break
            case .Sport:
                self.allCars.append(SportsCar(manufucturer: manufucturer))
                break
            }
        }
        
    }
    
    func getAllCar()->[Car]{
        var cars : [Car]!
        queue.sync {
            cars = allCars
        }
        return cars
    }
    
    func getCar(manufucturer : String)->Car{
        var car : Car!
        queue.sync {
            car = allCars.filter{
                $0.manufucturer == manufucturer
                }[0]
        }
        return car
    }
    func removeCar(manufucturer : String){
        
        queue.async(flags : .barrier){
            self.allCars.removeAll{
                $0.manufucturer == manufucturer
            }
        }
    }
    
    func printAllCars(){
        queue.sync {
            for car in allCars {
                print(car.manufucturer)
                car.drive()
            }
        }
    }
}
