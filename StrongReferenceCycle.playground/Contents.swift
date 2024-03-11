import Foundation

//Retain Cycle in Closure
//Scenario 1
//A->A
class Test {
    
    var closure: (() -> Void)?
    let x: Int  = 12
    
    deinit {
        print("Deinit called")
    }
    
    //To fix strong reference cycle uncomment the commented code below
    func setClosure() {
        self.closure = {/*[weak self] in*/
            print(self/*?*/.x)
        }
    }
}

do {
    let test = Test()
    test.setClosure()
}

//Scenario 2
//A->B->A
class A {
    
    var details: String = "Details"
    var b: B
    
    init(b: B) {
        self.b = b
    }
    
    deinit {
        print("Deinit called")
    }
    
//To fix strong reference cycle uncomment the commented code below
    func test() {
        b.test =  {/*[weak self] in*/
            self/*?*/.details = "Details 2"
        }
    }
}

class B {
    var test: (() -> Void)?
}

do {
    let a = A(b: B())
    a.test()
}
