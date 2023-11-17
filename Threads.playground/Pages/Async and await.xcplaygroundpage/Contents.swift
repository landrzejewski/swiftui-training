import PlaygroundSupport
import Foundation
import CoreLocation

let url = URL(string: "https://raw.githubusercontent.com/landrzejewski/goodweather/combine/data.json")!


actor Account {
    
    var balace: Decimal
    let id = UUID().uuidString
    
    init(initialBalance: Decimal) {
        balace = initialBalance
    }
    
    func deposit(amount: Decimal) {
        balace += amount
    }
    
    func transfer(amount: Decimal, to other: Account) async {
        guard balace >= amount else {
            return
        }
        balace -= amount
        await other.deposit(amount: amount)
    }
    
    nonisolated func getId() -> String {
        id
    }
    
}

Task {
    let firstAccount = Account(initialBalance: 1000)
    let secondAccount = Account(initialBalance: 0)
    await firstAccount.deposit(amount: 200)
    await firstAccount.transfer(amount: 500, to: secondAccount)
    print("First account: \(await firstAccount.balace)")
    print("Second account: \(await secondAccount.balace)")
}


//
//// When actor is suspended new caller can be serviced. Thats why we should always protect actors state
//// The result of actor reentrancy is that any assumptions we make before an await should always be re-validated after an await
//
actor ImageLoader {
    
    private var imageData: [UUID: LoadingState] = [:]
    
    func loadImageData(using id: UUID) async throws -> Data {
        if let state = imageData[id] {
            switch state {
            case .loading(let task):
                return try await task.value
            case .completed(let data):
                return data
            }
        }
        
        let task = Task<Data, Error> {
            let url = URL(string: "baseUrl/\(id.uuidString)")!
            let (data, _) = try await URLSession.shared.data(from: url)
            return data
        }
        
        imageData[id] = .loading(task)
        
        do {
            let data = try await task.value
            imageData[id] = .completed(data)
            return data
        } catch {
            imageData[id] = nil
            throw error
        }
    }
}

extension ImageLoader {
    enum LoadingState {
        case loading(Task<Data, Error>)
        case completed(Data)
    }
}
//
//// The main actor is an actor that synchronizes its work on the main thread. In practical terms this means that any code that executes on the main actor is run on the main thread
await MainActor.run {
    // update UI
}
//
@MainActor  // annotation for Functions, Objects(classes,structs), Closures, Properties
func updateUI() {
    // update UI
}
//
//// While the main actor is currently the most useful example of a global actor we can define our own global actors by annotating an existing actor with @globalActor and conforming it to the GlobalActor protocol
//// The GlobalActor protocol requires us to implement a static shared property that is used as the instance to defer executing code to whenever we annotate something with our global actor. In other words, when we annotate a function with @MyActor the instance of MyActor that we created as the shared instance is the actor instance that will receive the call to our annotated function
@globalActor
actor MyActor: GlobalActor {
    static let shared = MyActor()
}
//
///*
// Objects like actors can safely be passed around across concurrency contexts; they were made for that. Other objects like structs, classes, closures, and others are not always safe to pass around. They might hold some non-thread-safe (non-Sendable) state that would make it unsafe to pass an instance of a particular class from one place to the next. However these objects aren’t always unsafe to pass around.
// For example, a struct that doesn’t hold on to any reference types can safely be passed around in our app; after all structs are value types so we’re passing around copies of structs instead of references to a single instance of our struct. A class that only holds immutable state where each property defined on that class is a struct can be safely passed around because there’s no way to get into a data race when it’s impossible to mutate the data that we’re passing around.
// Objects that can be passed across concurrency contexts safely are referred to as Sendable in Swift. Sendable is defined as a protocol in Swift and it has no required properties or methods. It’s a so-called marker protocol that will mark our object as Sendable so that the compiler can check whether our object actually meets all of the requirements for being sendable
// 
// To enable strict concurrency checking in your project, navigate to your project’s build settings tab and search for “strict concurrency”. By default, you will find this build setting to have a value of Minimal. As you can imagine, that will perform a very minimal set of constrains like explicit Sendable annotations for example (you will learn about Sendable annotations shortly).
// You could bump the concurrency checks to be Targeted which will enable sendability and actor isolation checks for your project using the same constraints that will be used in Swift 6.0. I would recommend you set this setting to be at least Targeted for existing projects where you want to ensure that your code is as thread safe as possible.
// The third setting is Complete. This will enable the full set of concurrency checks that exists in Swift 6.0. This includes sendability checking, actor isolation checks, and more. For new projects I would recommend you jump straight to setting your checking settings to Complete which will make sure that your code is compatible with Swift 6.0 right away
// 
// Let’s take a closer look at all rules that make a value type implicitly conform to Sendable:
// - All members of the struct or enum must be sendable and
// – The struct or enum is marked as frozen or
// – The struct or enum is not public or
// – The struct or enum is not marked as @useableFromInline
// If your struct or enum does not meet all of the above requirements, you can manually add Sendable conformance to tell the compiler to check the sendability for your object.
// 
// Classes can be manually marked to conform to the Sendable protocol but there are a few requirements that I’ll dig a bit deeper into in just a moment. Let’s list out the requirements first:
// - A sendable class mustbe final
// - All properties on the class must be sendable and immutable(declared as let)
// - The class cannot have any super classes other than NSObject
// - Classes annotated with @MainActor are implicitly sendable due to their synchronization through the main actor. This is true regardless of the class’ stored properties being mutable or sendable
// 
// When you’re certain that you’ve taken the needed steps to ensure that your class is thread safe and fully free of data races you can force the compiler to accept your Sendable confor- mance without actually verifying your conformance by marking your class as @unchecked Sendable
// 
// When a closure or function is sendable, the closure or function in question does not capture any non-sendable objects. And because functions and closures do not conform to protocols we declare sendability for these types using the @Sendable annotation
// Annotating a function or closure with @Sendable carries a heavy semantic meaning. It means you intend to use that closure or function in code that is concurrent, and it means that you want to make sure that calling your closure or function is completely thread-safe.
//
// @Sendable func sampleFunc() {
//    // ...
// }
// 
// var sample: @Sendable () -> Void = {
// }
// */

PlaygroundPage.current.needsIndefiniteExecution = true

