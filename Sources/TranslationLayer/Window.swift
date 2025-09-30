import Java

public class Window: JavaObject {
    override public class var javaClassName: String {
        "android.view.Window"
    }
}

public extension Window {
    func getDecorView() throws -> View {
        try call(method: "getDecorView")
    }
}
