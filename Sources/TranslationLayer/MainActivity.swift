import Java

public class MainActivity: Activity {
    override public class var javaClassName: String {
        "org.company.app.MainActivity"
    }
}

public extension MainActivity {
    func string() throws -> String {
        try call(method: "string")
    }
}
