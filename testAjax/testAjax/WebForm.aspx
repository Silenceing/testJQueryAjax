<%@ Page Language="C#" AutoEventWireup="true" %>

<script runat="server">


    /// <summary> 
    /// 无参数 
    /// </summary> 
    /// <returns></returns> 
    [System.Web.Services.WebMethod]
    public static string HelloWorld()
    {
        return "Hello World ";
    }
    /// <summary> 
    /// 带参数 
    /// </summary> 
    /// <param name="value1"></param> 
    /// <param name="value2"></param> 
    /// <param name="value3"></param> 
    /// <param name="value4"></param> 
    /// <returns></returns> 
    [System.Web.Services.WebMethod]
    public static string GetWish(string value1, string value2, string value3, int value4)
    {
        return string.Format("祝您在{3}年里 {0}、{1}、{2}", value1, value2, value3, value4);
    }
    /// <summary> 
    /// 返回集合 
    /// </summary> 
    /// <param name="i"></param> 
    /// <returns></returns> 
    [System.Web.Services.WebMethod]
    public static List<int> GetArray(int i)
    {
        List<int> list = new List<int>();
        while (i >= 0)
        {
            list.Add(i--);
        }
        return list;
    }
    /// <summary> 
    /// 返回一个复合类型 
    /// </summary> 
    /// <returns></returns> 
    [System.Web.Services.WebMethod]
    public static Class1 GetClass()
    {
        return new Class1 { ID = "1", Value = "牛年大吉" };
    }

    [System.Web.Services.WebMethod]
    public static string ParmsObject(Class1 obj)
    {

        return obj.ID + ":" + obj.Value;
    }

    /// <summary> 
    /// 返回XML 
    /// </summary> 
    /// <returns></returns> 
    [System.Web.Services.WebMethod]
    public static System.Data.DataSet GetDataSet()
    {
        System.Data.DataSet ds = new System.Data.DataSet();
        System.Data.DataTable dt = new System.Data.DataTable();
        dt.Columns.Add("ID", Type.GetType("System.String"));
        dt.Columns.Add("Value", Type.GetType("System.String"));
        System.Data.DataRow dr = dt.NewRow();
        dr["ID"] = "1";
        dr["Value"] = "新年快乐";
        dt.Rows.Add(dr);
        dr = dt.NewRow();
        dr["ID"] = "2";
        dr["Value"] = "万事如意";
        dt.Rows.Add(dr);
        ds.Tables.Add(dt);
        return ds;
    }

    //自定义的类，只有两个属性 
    public class Class1
    {
        public string ID { get; set; }
        public string Value { get; set; }
    }

</script>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>jQuery Ajax方法调用 Asp.Net WebService、WebMethod 的详细实例代码</title>
    <script src="http://static.runoob.com/assets/jquery-validation-1.14.0/lib/jquery.js" type="text/javascript"></script>
    <style type="text/css">
        .hover {
            cursor: pointer; /*小手*/
            background: #ffc; /*背景*/
        }

        .button {
            width: 150px;
            float: left;
            text-align: center;
            margin: 10px;
            padding: 10px;
            border: 1px solid #888;
        }

        #dictionary {
            text-align: center;
            font-size: 18px;
            clear: both;
            border-top: 3px solid #888;
        }

        #loading {
            border: 1px #000 solid;
            background-color: #eee;
            padding: 20px;
            margin: 100px 0 0 200px;
            position: absolute;
            display: none;
        }

        #switcher {
        }
    </style>
    <script type="text/javascript">
        //无参数调用 
        $(document).ready(function () {
            $('#btn1').click(function () {
                $.ajax({
                    type: "POST", //访问WebService使用Post方式请求 
                    contentType: "application/json", //WebService 会返回Json类型 
                    url: "ws.aspx/HelloWorld", //调用WebService的地址和方法名称组合 ---- WsURL/方法名 
                    data: "{}", //这里是要传递的参数，格式为 data: "{paraName:paraValue}",下面将会看到 
                    dataType: 'json',
                    success: function (result) { //回调函数，result，返回值 
                        $('#dictionary').append(result.d);
                    }
                });
            });
        });
        //有参数调用 
        $(document).ready(function () {
            $("#btn2").click(function () {
                $.ajax({
                    type: "POST",
                    contentType: "application/json",
                    url: "ws.aspx/GetWish",
                    data: "{value1:'心想事成',value2:'万事如意',value3:'牛牛牛',value4:2009}",
                    dataType: 'json',
                    success: function (result) {
                        $('#dictionary').append(result.d);
                    }
                });
            });
        });
        //返回集合（引用自网络，很说明问题） 
        $(document).ready(function () {
            $("#btn3").click(function () {
                $.ajax({
                    type: "POST",
                    contentType: "application/json",
                    url: "ws.aspx/GetArray",
                    data: "{i:10}",
                    dataType: 'json',
                    success: function (result) {
                        $(result.d).each(function () {
                            //alert(this); 
                            $('#dictionary').append(this.toString() + " ");
                            //alert(result.d.join(" | ")); 
                        });
                    }
                });
            });
        });
        //返回复合类型 
        $(document).ready(function () {
            $('#btn4').click(function () {
                $.ajax({
                    type: "POST",
                    contentType: "application/json",
                    url: "ws.aspx/GetClass",
                    data: "{}",
                    dataType: 'json',
                    success: function (result) {
                        $(result.d).each(function () {
                            //alert(this); 
                            $('#dictionary').append(this['ID'] + " " + this['Value']);
                            //alert(result.d.join(" | ")); 
                        });
                    }
                });
            });
        });
        //============== 
        var aArray = ["sdf", "dasd", "dsa"]; //数组$.each(aArray,function(iNum,value){ document.write(“序号：”+iNum+” 值：”+value);});var oObj = {one:1,two:2,three:3};$.each(aArray,function(property,value){ document.write(“属性：”+ property +” 值：”+value);}); 
        //============================================== 
        //返回DataSet(XML) 
        $(document).ready(function () {
            $('#btn5').click(function () {
                $.ajax({
                    type: "POST",
                    url: "ws.aspx/GetDataSet",
                    data: "{}",
                    dataType: 'xml', //返回的类型为XML ，和前面的Json，不一样了 
                    success: function (result) {
                        //演示一下捕获 
                        try {
                            $(result).find("Table1").each(function () {
                                $('#dictionary').append($(this).find("ID").text() + " " + $(this).find("Value").text());
                            });
                        }
                        catch (e) {
                            alert(e);
                            return;
                        }
                    },
                    error: function (result, status) { //如果没有上面的捕获出错会执行这里的回调函数 
                        if (status == 'error') {
                            alert(status);
                        }
                    }
                });
            });
        });

        //传入对象
        $(function () {
            $("#btn6").click(function () {
                obj = new Object();
                obj.ID = "1";
                obj.Value = "aaa";
                //'{"obj":{"ID":"1",Value:"Horse"}}'
                var d = '{"obj":' + JSON.stringify(obj) + '}';
                $.ajax({
                    type: "POST",  //访问WebService使用Post方式请求
                    contentType: "application/json", //WebService 会返回Json类型
                    url: "ws.aspx/ParmsObject", //调用WebService的地址和方法名称组合 ---- WsURL/方法名
                    data: d,     //这里是要传递的参数，格式为 data: "{paraName:paraValue}",下面将会看到    
                    dataType: 'json',
                    success: function (result) {
                        alert(result.d);
                    },
                    error: function (result) {
                        alert("fail");
                    }
                });
            });

        });


        //Ajax 为用户提供反馈，利用ajaxStart和ajaxStop 方法，演示ajax跟踪相关事件的回调，他们两个方法可以添加给jQuery对象在Ajax前后回调 
        //但对与Ajax的监控，本身是全局性的 
        $(document).ready(function () {
            $('#loading').ajaxStart(function () {
                $(this).show();
            }).ajaxStop(function () {
                $(this).hide();
            });
        });
        // 鼠标移入移出效果，多个元素的时候，可以使用“，”隔开 
        $(document).ready(function () {
            $('div.button').hover(function () {
                $(this).addClass('hover');
            }, function () {
                $(this).removeClass('hover');
            });
        });
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div id="switcher">
            <h2>jQuery 的WebServices 调用</h2>
            <div class="button" id="btn1">
                HelloWorld
            </div>
            <div class="button" id="btn2">
                传入参数
            </div>
            <div class="button" id="btn3">
                返回集合
            </div>
            <div class="button" id="btn4">
                返回复合类型
            </div>
            <div class="button" id="btn5">
                返回DataSet(XML)
            </div>
            <div class="button" id="btn6">
                传入对象
            </div>
        </div>
        <div id="loading">
            服务器处理中，请稍后。 
        </div>
        <div id="dictionary">
        </div>
    </form>
</body>
</html>