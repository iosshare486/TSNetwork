# 网络组件使用API

## ModuleName TSNetwork

## Discription 基于Alamofire封装的网络组件，基于HandyJSON封装数据转模型，基于ReachabilitySwift封装的网络监听

## Quote
```
source = git@gitlab.caiqr.com:ios_module/TSNetwork.git
pod 'TSNetwork'

```

## Configure

### 基础网络配置
<pre>
	基于TSBaseRequest创建自己的网络基类，配置网络请求Url和请求头
	class TSCustomBaseAPI : TSBaseRequest {
		//配置默认请求方式 其余配置可默认配置
		override var HTTPMethod: TSRequestMethod {
        set {
            
        }
        get {
            return .tsPost
        }
    	}
		//必须重写配置网络URL方法
    	override func tsRequestUrl() -> String? {
       return "https://sports.caiqr.cn/api"
      	
      	override func tsRequestHeader() -> [String : String]? {
      		//此处要定义自己的请求头，可根据业务配置，比如验签，重写User-Agent，时间戳等等
      		//注意事项：如果重写User_Agent的key，Value会在默认Value的基础上拼接
      		return ["" : ""]
      	}
    }
	}
</pre>

### 基础模型配置
<pre>
	创建模型，可为Class或是Struct，需要遵守TSMoyaAddable协议
	注意事项： 如果想重写协议定义API，需要创建模型为Class
</pre>


## Usage

### 网络请求使用方法
<pre>
Class : TSNetworkManager
method : public class func send<R: TSBaseRequest>(
        _ api: R,
        completion: @escaping ((TSBaseResponse) -> ()),
        error: @escaping (TSNetworkError) -> () )

api : 请求类实例
completion : 请求成功回调
error : 请求失败回调

</pre>

### 网络监听使用方法
<pre>
开始监听
TSNetworkMonitor.shared.startNotifier { [weak self] (status) in
	status : 当前网络状态        
}
let netType = TSNetworkMonitor.shared.reachabilityStatus 当前网络类型1.tsFiwi 2.tsWan 3.tsOther 4.tsNoNet
停止监听
TSNetworkMonitor.shared.stopNotifier() 
</pre>
### 数据转模型使用方法	
<pre>
	TSBaseResponse {
		//通过dict转Model
    public class func ts_deserializeModelFrom<T : TSMoyaAddable> (dict : [String : Any]) -> T 
    
    public class func ts_deserializeModelFrom<T : TSMoyaAddable> (dict : NSDictionary) -> T
    
    //通过jsonString转Model
    public class func ts_deserializeModelFrom<T : TSMoyaAddable> (json : String) -> T
    
    //通过数组转模型数组
    public class func ts_deserializeModelArrFrom<T : TSMoyaAddable> (arr : [Any]) -> [T]
    
    public class func ts_deserializeModelArrFrom<T : TSMoyaAddable> (arr : NSArray) -> [T]
    
    public class func ts_deserializeModelArrFrom<T : TSMoyaAddable> (jsonString : String) -> [T]
	}
</pre>

## Example

### 网络请求子类创建例子
<pre>
	class TSCustomDemoAPI: TSCustomBaseAPI {
    	// 此处可重写父类属性，如下
    	//请求path
   		 open var path: String = ""
    	//请求方式
    	open var HTTPMethod: TSRequestMethod = .tsGet
    	//请求超时时间
    	open var timeoutInterval: TimeInterval?
    	//请求参数
    	open var parameter: [String:Any]?
	}
</pre>


### 模型创建例子
<pre>
	Class MJTSOmModel : TSMoyaAddable {
		 required init () { }
	    func objectToModelFinish() {
	        
	    }
	    var aaa : String?
	}
</pre>

### 网络请求使用例子
<pre>
	1.定义PAI
let api = TSCustomDemoAPI() 基于TSBaseRequest的子类，需要重写配置请求域名方法
api.parameter = ["cmd" : "get_home_operate_info"] 请求参数
 api.HTTPMethod = .tsPost 请求方式，包括Get、Post请求
api.path = "/get_home_operate_info" 请求Path
api.timeoutInterval = 10 请求超时时间
2.请求网络
TSNetworkManager.send(api, completion: { (resp) in
	 let jsonObject = resp.jsonObject 请求返回的jsonObject
	 在此可以数据模型转换
}) { (error) in
    let code = error.code  错误Code码 ，包括网络和业务返回Code
    let message  = error.message 错误信息
    let urlError = error.error 网络错误的URLError
    let netType = error.networkType 当前网络类型
}
</pre>
	
### Future
    1.支持接口返回数据结构可配置
    2.支持数据缓存API