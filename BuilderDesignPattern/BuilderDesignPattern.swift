
protocol CoffeeBuilder {
    
    func setSugar() -> CoffeeBuilder
    func setMilky() -> CoffeeBuilder
    func getCoffee()->Coffee
}


class Coffee {
   private var isMilky : Bool?
   private var sugarCount : Int?
    
    func set(_ milky : Bool){
        self.isMilky = milky
    }
    func set(_ sugarCount : Int){
        self.sugarCount = sugarCount
    }
}


class AmericanoBuilder : CoffeeBuilder{
    
    private var coffee : Coffee
    init() {
        coffee = Coffee()
    }
    
    
    func getCoffee() -> Coffee {
        return coffee
    }
    
    func setSugar() -> CoffeeBuilder {
        coffee.set(0)
        return self
        
    }
    
    func setMilky() -> CoffeeBuilder {
        coffee.set(false)
        return self
        
    }
    
}
class LatteBuilder : CoffeeBuilder{
    
    private var coffee : Coffee
    init() {
        coffee = Coffee()
    }
    
    
    func getCoffee() -> Coffee {
        return coffee
    }
    
    func setSugar() -> CoffeeBuilder {
        
        coffee.set(5)
        return self
    }
    
    func setMilky() -> CoffeeBuilder {
        
        coffee.set(true)
        return self
        
    }
    
    
}


class Barista {
    
    
    private var builder : CoffeeBuilder
    
    init(builder : CoffeeBuilder) {
        self.builder = builder
    }
    func updateBuilder(builder : CoffeeBuilder){
        self.builder = builder
    }
    
    func buildCoffee() -> Barista{
        
        builder.setMilky()
        builder.setSugar()
        return self
    }
    
    func getCoffee() -> Coffee {
        return builder.getCoffee()
    }
}


let latteBuilder = LatteBuilder()
let americanoBuilder = AmericanoBuilder()

let barista = Barista(builder: latteBuilder)

barista.buildCoffee().getCoffee()

barista.updateBuilder(builder: americanoBuilder)

barista.buildCoffee().getCoffee()
