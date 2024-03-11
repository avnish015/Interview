import UIKit

protocol DataSource {
    associatedtype Model
    func fetchAll() -> [Model]
    func delete(_ model: Model)
    func update(_ model: Model)
}

class AnyDataSource<Model>: DataSource {
    
    private var fetchAllData: () -> [Model]
    private var deleteData: (Model) -> Void
    private var updateData: (Model) -> Void
    
    init<Source: DataSource>(_ dataSource: Source) where Source.Model == Model {
        self.fetchAllData = dataSource.fetchAll
        self.deleteData = dataSource.delete(_:)
        self.updateData = dataSource.update(_:)
    }

    func fetchAll() -> [Model] {
        fetchAllData()
    }
    
    func delete(_ model: Model) {
        deleteData(model)
    }
    
    func update(_ model: Model) {
        updateData(model)
    }
}

class CoreDataSource<Model>: DataSource {
    
    func fetchAll() -> [Model] {
        print("Fetch all called")
       return  []
    }
    
    func delete(_ model: Model) {
        print("Deleted data is \(model)")
    }
    
    func update(_ model: Model) {
        print("Update called is \(model)")
    }
}

let dataSource = CoreDataSource<Int>()
let anyDataSource = AnyDataSource(dataSource)
anyDataSource.fetchAll()
anyDataSource.delete(12)
anyDataSource.update(23)
