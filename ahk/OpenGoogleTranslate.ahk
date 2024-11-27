; 监听 XButton2 键
XButton2::
{
    ; 打开默认浏览器并跳转到 Google 图片翻译页面
    Run "https://translate.google.com/?sl=auto&tl=zh-CN&op=images"

    ; 等待 Chromium 浏览器窗口激活
    WinWaitActive("ahk_class Chrome_WidgetWin_1")

    ; 等待页面加载完成
    Sleep(3000)  ; 根据网络速度调整等待时间

    ; 发送 Ctrl+V 粘贴剪切板中的图片
    Send "^v"
}
Return
