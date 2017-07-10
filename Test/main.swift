

import Foundation


extension NSArray
{
    func randomObjects_ck() -> NSArray {
        return self.sortedArray(comparator: { (obj1, obj2) -> ComparisonResult in
            let randomResult = Int(arc4random()) % 3 - 1; // arc4random() 返回值为 UInt32，不能为负数，先转为 Int
            return ComparisonResult(rawValue: randomResult)!
        }) as NSArray
    }
}

extension NSMutableArray
{
    func randomObjects_mutable_ck() {
        let sortedArray = self.sortedArray(comparator: { (obj1, obj2) -> ComparisonResult in
            let randomResult = Int(arc4random()) % 3 - 1; // arc4random() 返回值为 UInt32，不能为负数，先转为 Int
            let result = ComparisonResult(rawValue: randomResult)!
            print(result.rawValue)
            return result
        })
        self.removeAllObjects()
        self.addObjects(from: sortedArray)
    }
}

func randomItem(count:Int, str:NSMutableArray) -> (String,Int) {
    let index = Int(arc4random_uniform(UInt32(count)))
    return (str[index] as! String, index)
}
//设定路径
var url: URL = URL.init(fileURLWithPath: "/Users/zhang/Desktop/PhoneNumber/phone_number.txt")
let fileManager = FileManager.default
//从url里面读取数据，读取成功则赋予readData对象，读取失败则走else逻辑
if let readData = NSData(contentsOfFile: url.path) {
    //如果内容存在 则用readData创建文字列
    var data = NSString.init(data: readData as Data, encoding: 0)
    if let content = (data){
        let myStrings = content.components(separatedBy: NSCharacterSet.newlines)
        let nsmuTableArray = NSMutableArray.init(array: myStrings)
        let numberArray = NSMutableArray.init()
        for i in 0...nsmuTableArray.count - 1 {
            let randenNumber = randomItem(count: nsmuTableArray.count, str: nsmuTableArray)
            numberArray.add(randenNumber.0)
            nsmuTableArray.removeObject(at: randenNumber.1)
            if i % 100 == 0{
                let str = "/Users/zhang/Desktop/PhoneNumber/\(i)phone_number.txt"
                let exist = fileManager.fileExists(atPath: str)
                var strs = "100个打包"
                for i in numberArray {
                    strs.append("\n\(i)")
                }
                if !exist {
                    fileManager.createFile(atPath: str, contents: nil, attributes: nil)
                }
                do {
                    try  strs.write(to: URL.init(fileURLWithPath: str), atomically: true, encoding: String.Encoding.utf8)
                }catch{
                    
                }
                numberArray.removeAllObjects()
            }
        }
    }
} else {
    //nil的话，输出空
    print("sfsf")
}





