

protocol Car{
    
    var manufucturer : String{ get  set}
    func drive()
}


class SportsCar : Car {
    var manufucturer: String
    
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

//MARK: Abstract Factory Pattern
class CarFactory{
    func createCar(type : CarType , manufucturer : String)->Car{
        switch type {
        case .Sedan:
            return SedanCar(manufucturer: manufucturer)
        case .Sport:
            return SportsCar(manufucturer: manufucturer)
        }
    }
}
//--------------------------------------------------------------


//MARK: Factory Pattern
protocol CarFactory2{
    func createCar(manufucturer:String)->Car
}

class SportCarFactory : CarFactory2{
    func createCar(manufucturer:String) -> Car {
        return SportsCar(manufucturer: manufucturer)
    }
}
class SedanCarFactory : CarFactory2{
    func createCar(manufucturer:String) -> Car {
        return SedanCar(manufucturer: manufucturer)
    }
}
//---------------------------------------------------------------

