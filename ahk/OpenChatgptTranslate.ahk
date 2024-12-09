XButton1::  ; 使用 XButton1 键作为触发键
{
    ; 使用默认浏览器打开链接
    Run "https://chatgpt.com/?model=o1-mini"

    ; 使用更合适的等待方式
    WinWait("ChatGPT")  ; 等待窗口存在

    ; 等待页面加载并发送 "translate to Chinese:" 字符串，然后发送剪贴板内容
    Sleep(1500)  ; 缩短等待时间以提高性能
    Send "translate to Chinese:"  ; 发送 "translate to Chinese:"
    Sleep(100)  ; 稍作等待以确保内容发送顺序正确
    Send "^v"  ; 粘贴剪贴板内容
    Sleep(200)  ; 确保粘贴完成
    Send "{Enter}"  ; 按下 Enter 键
}
Return
