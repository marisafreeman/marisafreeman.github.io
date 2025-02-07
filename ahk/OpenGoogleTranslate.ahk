PgDn::
{
    Run, "%userprofile%\scoop\apps\chromium\current\chrome.exe" --app=https://translate.google.com/?sl=auto&tl=zh-CN&op=images
    WinWaitActive, ahk_class Chrome_WidgetWin_1
    WinMove, ahk_class Chrome_WidgetWin_1, , 360, 100, 1200, 900 ; X=360, Y=100, Width=1200, Height=900
    Sleep, 1500
    Send, ^v
}
Return
