Home::  ; 使用 Home 键作为触发键
{
    ; 使用默认浏览器打开链接
    Run, https://chatgpt.com/

    ; 使用更合适的等待方式
    WinWait, ChatGPT  ; 等待窗口存在

    ; 等待页面加载并发送剪贴板内容
    Sleep, 1500  ; 缩短等待时间以提高性能
    Send, ^v  ; 粘贴剪贴板内容
}
Return
