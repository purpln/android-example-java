import Java

public class View: JavaObject {
    override public class var javaClassName: String {
        "android.view.View"
    }
}

public extension View {
    func getWindowToken() throws -> Binder {
        try call(method: "getWindowToken")
    }
}
