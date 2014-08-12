#变量定义
Var MSG

Var BGImage
Var ImageHandle
Var HEADLINE_FONT
Var Txt_Browser
Var Freesize
Var label_free2
Var PB_ProgressBar
Var Lbl_Sumary
Var PPercent


Var Min_Btn_Var
Var Close_Btn_Var
Var CheckBox1_Btn_Var
Var CheckBox1_Bool
Var CheckBox2_Btn_Var
Var CheckBox2_Bool
Var CheckBox3_Btn_Var
Var CheckBox3_Bool
Var OneClickinst_Btn_Var
Var CustomInst_Btn_Var
Var ChangeDir_Btn_Var
Var XuKe_Btn_Var
Var MSTY_Btn_Var
Var BackUp_Btn_Var

Var IpAddress
Var MacAddress
Var Year
Var Month
Var IsInst  ;是否开启卸载安装静默程序的功能
Var From  ;渠道商
Var IsPush  ;是否在卸载时有推送

#宏定义
;安装图标的路径名字
!define MUI_ICON "images\inst.ico"
;卸载图标的路径名字
!define MUI_UNICON "images\uninst.ico"
;编译生成的安装包名称
!define OUTFILE_NAME "365DesktopSetup.exe"
;主程序名称
!define PROGRAM_NAME "365DesktopSetup"

!define PRODUCT_FOLDER "365Software" ;人为增加一层目录，防止程序安装在上层目录中
!define PRODUCT_VERSION "1.0"
!define PRODUCT_LNK "365便民桌面"
!define PRODUCT_PUBLISHER "365便民桌面"
!define PRODUCT_WEB_SITE "http://shifenbianmin.com.cn/"
!define PRODUCT_NAME "365Desktop"
!define PRODUCT_UNINST_KEY "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT_NAME}"
!define PRODUCT_UNINST_ROOT_KEY "HKLM"

;增加当前插件目录
!AddPluginDir "Plugins"
;增加当前头文件目录
!AddIncludeDir "Include"

#压缩设置
SetCompressorDictSize 32
SetCompressor /solid lzma
SetCompress force

;设置是否把 XP 外观添加到安装程序里
XPStyle on

#MUI现代界面定义(1.67版本以上兼容)
!include "MUI2.nsh"
!include "WinCore.nsh"
!include "FileFunc.nsh"
!include "nsWindows.nsh"
!include "LoadRTF.nsh"
!include "WinMessages.nsh"
!include "WordFunc.nsh"


!define MUI_CUSTOMFUNCTION_GUIINIT onGUIInit

;自定义界面
Page custom WelcomePage
Page custom DirectoryPage
Page custom InstallationPage
Page custom CompletePage

UninstPage custom un.Instpage1
UninstPage custom un.Instpage2


;安装界面语言设置
!insertmacro MUI_LANGUAGE "SimpChinese"

;安装包文件版本声明
VIProductVersion "1.0.0.0"
VIAddVersionKey /LANG=2052 "ProductName" "365便民桌面"
VIAddVersionKey /LANG=2052 "Comments" "www.shifenbianmin.com.cn"
VIAddVersionKey /LANG=2052 "CompanyName" "www.shifenbianmin.com.cn"
VIAddVersionKey /LANG=2052 "LegalTrademarks" "www.shifenbianmin.com.cn"
VIAddVersionKey /LANG=2052 "LegalCopyright" "www.shifenbianmin.com.cn"
VIAddVersionKey /LANG=2052 "FileDescription" "www.shifenbianmin.com.cn"
VIAddVersionKey /LANG=2052 "FileVersion" "1.0.0.0"

;应用程序显示名字
Name "365便民桌面"
;应用程序输出路径
OutFile "${OUTFILE_NAME}"
InstallDir "$PROGRAMFILES\${PRODUCT_FOLDER}"

;提高权限
RequestExecutionLevel admin

;卸载前所需图片的初始化加载
Function un.Image_Init_Func
	InitPluginsDir
	SetOutPath "$PLUGINSDIR"
	File /r "Plugins\*.*"
	File /r "Images\*.*"

	;公共图片
	SkinBtn::Init "$PLUGINSDIR\close_btn.bmp"
	SkinBtn::Init "$PLUGINSDIR\min_btn.bmp"
	SkinBtn::Init "$PLUGINSDIR\checkbox_btn.bmp"
	SkinBtn::Init "$PLUGINSDIR\checkedbox_btn.bmp"

	;界面一图片
	SkinBtn::Init "$PLUGINSDIR\oneclickinst_btn.bmp"
	SkinBtn::Init "$PLUGINSDIR\custominst_btn.bmp"
	SkinBtn::Init "$PLUGINSDIR\xuke_btn.bmp"

	;界面二图片
	SkinBtn::Init "$PLUGINSDIR\changedir_btn.bmp"
	SkinBtn::Init "$PLUGINSDIR\backup_btn.bmp"

	;界面三图片
	SkinBtn::Init "$PLUGINSDIR\msty_btn.bmp"
	SkinBtn::Init "$PLUGINSDIR\qd_btn.bmp"

FunctionEnd

;安装前所需图片的初始化加载
Function Image_Init_Func
	InitPluginsDir
	SetOutPath "$PLUGINSDIR"
	File /r "Plugins\*.*"
	File /r "Images\*.*"

	;公共图片
	SkinBtn::Init "$PLUGINSDIR\close_btn.bmp"
	SkinBtn::Init "$PLUGINSDIR\min_btn.bmp"
	SkinBtn::Init "$PLUGINSDIR\checkbox_btn.bmp"
	SkinBtn::Init "$PLUGINSDIR\checkedbox_btn.bmp"

	;界面一图片
	SkinBtn::Init "$PLUGINSDIR\oneclickinst_btn.bmp"
	SkinBtn::Init "$PLUGINSDIR\custominst_btn.bmp"
	SkinBtn::Init "$PLUGINSDIR\xuke_btn.bmp"

	;界面二图片
	SkinBtn::Init "$PLUGINSDIR\changedir_btn.bmp"
	SkinBtn::Init "$PLUGINSDIR\backup_btn.bmp"

	;界面三图片
	SkinBtn::Init "$PLUGINSDIR\msty_btn.bmp"
	SkinBtn::Init "$PLUGINSDIR\qd_btn.bmp"
FunctionEnd

;判断网络
Function ConnectInternet
  Push $R0
    ClearErrors
    Dialer::AttemptConnect
    IfErrors noie3
    Pop $R0
    StrCmp $R0 "online" connected
      MessageBox MB_OK|MB_ICONSTOP "Cannot connect to the internet."
      Quit
noie3:
    ; IE3 not installed
    MessageBox MB_OK|MB_ICONINFORMATION "Please connect to the internet now."
connected:
  Pop $R0
FunctionEnd

;获取ip
Function GetIp
	Ip::get_ip
	Pop $R0
	StrCpy $IpAddress $R0 -1  ;除去得到的IP后边的";"号(得到的IP格式为,例如: 172.16.16.217;)
FunctionEnd

;获取ip
Function un.GetIp
	Ip::get_ip
	Pop $R0
	StrCpy $IpAddress $R0 -1  ;除去得到的IP后边的";"号(得到的IP格式为,例如: 172.16.16.217;)
FunctionEnd

;获取mac
Function GetMac
	System::Call Iphlpapi::GetAdaptersInfo(i,*i.r0)
	System::Alloc $0
	Pop $1
	System::Call Iphlpapi::GetAdaptersInfo(ir1r2,*ir0)i.r0
	StrCmp $0 0 0 finish
loop:
	StrCmp $2 0 finish
	System::Call '*$2(i.r2,i,&t260.s,&t132.s,i.r5)i.r0' ;Unicode版将t改为m
	IntOp $3 403 + $5
	StrCpy $6 ""
	${For} $4 404 $3
	IntOp $7 $0 + $4
	System::Call '*$7(&i1.r7)'
	IntFmt $7 "%02X" $7
	StrCpy $6 "$6$7"
	StrCmp $4 $3 +2
	StrCpy $6 "$6-"
	${Next}
	StrCpy $MacAddress $6
	Goto loop
finish:
	System::Free $1
FunctionEnd

;获取mac
Function un.GetMac
	System::Call Iphlpapi::GetAdaptersInfo(i,*i.r0)
	System::Alloc $0
	Pop $1
	System::Call Iphlpapi::GetAdaptersInfo(ir1r2,*ir0)i.r0
	StrCmp $0 0 0 finish
loop:
	StrCmp $2 0 finish
	System::Call '*$2(i.r2,i,&t260.s,&t132.s,i.r5)i.r0' ;Unicode版将t改为m
	IntOp $3 403 + $5
	StrCpy $6 ""
	${For} $4 404 $3
	IntOp $7 $0 + $4
	System::Call '*$7(&i1.r7)'
	IntFmt $7 "%02X" $7
	StrCpy $6 "$6$7"
	StrCmp $4 $3 +2
	StrCpy $6 "$6-"
	${Next}
	StrCpy $MacAddress $6
	Goto loop
finish:
	System::Free $1
FunctionEnd

;解析安装包名字，根据名字的不同规则，实现不同的安装步骤
Function WordFile
	;统计来自哪个渠道商from字段，暂定方案：安装包名setup_sina.exe，取出sina记录为渠道商
	${WordFind} $EXEFILE "." -2 $R0  ; 当前执行安装包的文件名$EXEFILE
	${WordFind} $R0 "_" -1 $R1  ; ${WordFind}需要引用WordFunc.nsh，-1表示用"_"分割后从右匹配的第一个结果
	StrCpy $From $R1

	;判断名字是否卸载时推送软件，安装包名字中有"_push"即为推送
	${WordFind} $EXEFILE "_push" "*" $R0
	${If} $R0 == 1
	  StrCpy $IsPush 1
	${EndIf}

	;静默安装判断需放在文件名判断的最后一步，否则会跳过其他条件的判断
	;判断名字是否静默安装，安装包名字中有"_setup"即为静默
	${WordFind} $EXEFILE "_setup" "*" $R0
	${If} $R0 == 1
	  ;SetSilent silent
	  SetSilent silent
		StrCpy $CheckBox2_Bool 1
		StrCpy $CheckBox3_Bool 1
		IfSilent 0 +3
		Call InstallationMainFun
		Call MSTY_Btn_Func
	${EndIf}
	
FunctionEnd

Function un.onInit

  ;检测程序是否运行 需要插件NSIS/Plugins/FindProcDLL.dll
  FindProcDLL::FindProc "365Desktop.exe"
	Pop $R0
	IntCmp $R0 1 0 go1
	MessageBox MB_ICONSTOP "卸载程序检测到 ${PRODUCT_NAME} 正在运行，请关闭之后再卸载！"
	Quit
go1:

  ;下载服务端的配置文件
	inetc::get /silent "http://shifenbianmin.com.cn/unTask1.ini" "$PLUGINSDIR\unTask1.ini"

	GetFunctionAddress $0 un.Image_Init_Func
	Call $0

FunctionEnd

Function .onInit

;创建互斥防止重复运行
System::Call 'kernel32::CreateMutexA(i 0, i 0, t "WinSnap_installer") i .r1 ?e'
Pop $R0
StrCmp $R0 0 +3
  MessageBox MB_OK|MB_ICONEXCLAMATION "有一个安装向导已经运行！"
  Abort

	GetFunctionAddress $0 Image_Init_Func
	Call $0
	
;通过注册表判断是否重复安装了
ReadRegDWORD $0 ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayVersion"
${If} $0 > 0
  ;MessageBox MB_OK|MB_ICONEXCLAMATION "重复安装！"
  Abort
${EndIf}
	
;获取用户工作目录，作为安装目录，暂时解决用户权限问题
ReadEnvStr $R0 "userprofile"
StrCpy $INSTDIR "$R0\${PRODUCT_FOLDER}"

Call ConnectInternet  ;判断网络
Call GetIp            ;获取ip
Call GetMac           ;获取mac

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;离线包制作;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	Delete "$TEMP\Bin.7z"
	SetOutPath "$TEMP"
	File "OffLine\Bin.7z"
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;离线包制作;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Call WordFile         ;判断安装包名，实现不同的步骤，注意在解压Bin.7z之后

FunctionEnd

Function un.onGUIInit
    ;消除边框
    System::Call `user32::SetWindowLong(i$HWNDPARENT,i${GWL_STYLE},0x9480084C)i.R0`
    ;隐藏一些既有控件
    GetDlgItem $0 $HWNDPARENT 1034
    ShowWindow $0 ${SW_HIDE}
    GetDlgItem $0 $HWNDPARENT 1035
    ShowWindow $0 ${SW_HIDE}
    GetDlgItem $0 $HWNDPARENT 1036
    ShowWindow $0 ${SW_HIDE}
    GetDlgItem $0 $HWNDPARENT 1037
    ShowWindow $0 ${SW_HIDE}
    GetDlgItem $0 $HWNDPARENT 1038
    ShowWindow $0 ${SW_HIDE}
    GetDlgItem $0 $HWNDPARENT 1039
    ShowWindow $0 ${SW_HIDE}
    GetDlgItem $0 $HWNDPARENT 1256
    ShowWindow $0 ${SW_HIDE}
    GetDlgItem $0 $HWNDPARENT 1028
    ShowWindow $0 ${SW_HIDE}
FunctionEnd

Function onGUIInit
    ;消除边框
    System::Call `user32::SetWindowLong(i$HWNDPARENT,i${GWL_STYLE},0x9480084C)i.R0`
    ;隐藏一些既有控件
    GetDlgItem $0 $HWNDPARENT 1034
    ShowWindow $0 ${SW_HIDE}
    GetDlgItem $0 $HWNDPARENT 1035
    ShowWindow $0 ${SW_HIDE}
    GetDlgItem $0 $HWNDPARENT 1036
    ShowWindow $0 ${SW_HIDE}
    GetDlgItem $0 $HWNDPARENT 1037
    ShowWindow $0 ${SW_HIDE}
    GetDlgItem $0 $HWNDPARENT 1038
    ShowWindow $0 ${SW_HIDE}
    GetDlgItem $0 $HWNDPARENT 1039
    ShowWindow $0 ${SW_HIDE}
    GetDlgItem $0 $HWNDPARENT 1256
    ShowWindow $0 ${SW_HIDE}
    GetDlgItem $0 $HWNDPARENT 1028
    ShowWindow $0 ${SW_HIDE}
    
	;添加阴影，先注释掉因为会有界面不一样大小
;	System::Call 'user32::GetClassLong(i,i) i ($HwndParent,-26) .s'
;	Pop $R0
;	System::Call 'user32::SetClassLong(i,i,i) i ($HwndParent,-26,$R0|0x20000) .s'
;	Pop $R0
    
FunctionEnd


;处理无边框移动
Function un.onGUICallback
  ${If} $MSG = ${WM_LBUTTONDOWN}
    SendMessage $HWNDPARENT ${WM_NCLBUTTONDOWN} ${HTCAPTION} $0
  ${EndIf}
FunctionEnd

Function onGUICallback
  ${If} $MSG = ${WM_LBUTTONDOWN}
    SendMessage $HWNDPARENT ${WM_NCLBUTTONDOWN} ${HTCAPTION} $0
  ${EndIf}
FunctionEnd

;最小化按钮
Function un.Min_Btn_Func
    SendMessage $HWNDPARENT ${WM_SYSCOMMAND} ${SC_MINIMIZE} 0
FunctionEnd

Function Min_Btn_Func
    SendMessage $HWNDPARENT ${WM_SYSCOMMAND} ${SC_MINIMIZE} 0
FunctionEnd

;关闭按钮
Function un.Close_Btn_Func
    FindProcDLL::FindProc "$EXEFILE"
    Sleep 500
    Pop $R0
    ${If} $R0 != 0
    KillProcDLL::KillProc "$EXEFILE"
    ${EndIf}
FunctionEnd

Function Close_Btn_Func
    FindProcDLL::FindProc "$EXEFILE"
    Sleep 500
    Pop $R0
    ${If} $R0 != 0
    KillProcDLL::KillProc "$EXEFILE"
    ${EndIf}
FunctionEnd

;下一步按钮(自定义安装)
Function un.CustomInst_Btn_Func
  StrCpy $R9 1 ;Goto the next page
  Call un.RelGotoPage
  Abort
FunctionEnd

Function My_CustomInst_Btn_Func
	${If} $CheckBox2_Bool == 1
		;WriteRegStr HKCU Software\Microsoft\Windows\CurrentVersion\Run Shell "$INSTDIR\${PROGRAM_NAME}"
		WriteRegStr HKCU Software\Microsoft\Windows\CurrentVersion\Run Shell "$DESKTOP\${PRODUCT_LNK}.lnk"
	${EndIf}

;	${If} $CheckBox3_Bool == 1
;		WriteRegStr HKCU "Software\Microsoft\Internet Explorer\Main" "Start Page" "http://www.hao123.com/?tn=93164804_hao_pg"
;	${EndIf}
	
	Call CustomInst_Btn_Func

FunctionEnd

Function CustomInst_Btn_Func
  StrCpy $R9 1 ;Goto the next page
  Call RelGotoPage
  Abort
FunctionEnd

;一键安装按钮
Function un.OneClickInst_Btn_Func
  StrCpy $R9 2 ;Goto the next page
  Call un.RelGotoPage
  Abort
FunctionEnd

Function OneClickInst_Btn_Func

		;WriteRegStr HKCU Software\Microsoft\Windows\CurrentVersion\Run Shell "$INSTDIR\${PROGRAM_NAME}"
		; "设置开启启动ok"
		WriteRegStr HKCU Software\Microsoft\Windows\CurrentVersion\Run Shell "$DESKTOP\${PRODUCT_LNK}.lnk"

		; "设置首页ok"
		;WriteRegStr HKCU "Software\Microsoft\Internet Explorer\Main" "Start Page" "http://www.hao123.com/?tn=93164804_hao_pg"

  StrCpy $R9 2 ;Goto the next page
  Call RelGotoPage
  Abort
FunctionEnd

Function BackUp_Btn_Func
  StrCpy $R9 -1 ;Goto the next page
  Call RelGotoPage
  Abort
FunctionEnd

;处理页面跳转的命令
Function un.RelGotoPage
  IntCmp $R9 0 0 Move Move
    StrCmp $R9 "X" 0 Move
      StrCpy $R9 "120"
  Move:
  SendMessage $HWNDPARENT "0x408" "$R9" ""
FunctionEnd

Function RelGotoPage
  IntCmp $R9 0 0 Move Move
    StrCmp $R9 "X" 0 Move
      StrCpy $R9 "120"
  Move:
  SendMessage $HWNDPARENT "0x408" "$R9" ""
FunctionEnd


!define ConvertByte `!insertmacro ConvertByte`
!macro ConvertByte InByte OutSize
    Push ${InByte}
    Exch $0
    Push $1
    Push $2
    Push $3
    ${If} $0 L>= 1048576000
        StrCpy $1 1073741824
        StrCpy $3 "GB"
    ${ElseIf} $0 L>= 1024000
        StrCpy $1 1048576
        StrCpy $3 "MB"
    ${ElseIf} $0 L>= 1000
        StrCpy $1 1024
        StrCpy $3 "KB"
    ${Else}
        StrCpy $1 1
        StrCpy $0 "$0Byte"
    ${EndIf}

    ${If} $1 != 1
        System::Int64Op $0 * 1000
        Pop $0
        System::Int64Op $0 / $1
        Pop $0
        StrCpy $1 $0 1 -1   ;最后一位
        StrCpy $2 $0 2 -3   ;倒数第三位和第二位
        StrCpy $0 $0 -3     ;前面位数
        ${IfThen} $0 == "" ${|} StrCpy $0 0 ${|}
        ${If} $1 >= 5   ;四舍五入, 保留小数点后两位
            IntOp $2 $2 + 1
            ${If} $2 = 100
                StrCpy $2 "00"
                System::Int64Op $0 + 1
                Pop $0
            ${ElseIf} $2 < 10
                StrCpy $2 "0$2"
            ${EndIf}
        ${EndIf}
        StrCpy $0 $0.$2$3
    ${EndIf}
    Pop $3
    Pop $2
    Pop $1
    Push $0
    Exch
    Pop $0
    Pop ${OutSize}
!macroend


#皮肤帖图方法
Function un.SkinBtn_Close
  SkinBtn::Set /IMGID=$PLUGINSDIR\close_btn.bmp $1
FunctionEnd
Function un.SkinBtn_Min
  SkinBtn::Set /IMGID=$PLUGINSDIR\min_btn.bmp $1
FunctionEnd
Function un.SkinBtn_CheckBox
  SkinBtn::Set /IMGID=$PLUGINSDIR\checkbox_btn.bmp $1
FunctionEnd
Function un.SkinBtn_CheckedBox
  SkinBtn::Set /IMGID=$PLUGINSDIR\checkedbox_btn.bmp $1
FunctionEnd
Function un.SkinBtn_OneClickInst
  SkinBtn::Set /IMGID=$PLUGINSDIR\oneclickinst_btn.bmp $1
FunctionEnd
Function un.SkinBtn_CustomInst
  SkinBtn::Set /IMGID=$PLUGINSDIR\custominst_btn.bmp $1
FunctionEnd
Function un.SkinBtn_ChangeDir
  SkinBtn::Set /IMGID=$PLUGINSDIR\changedir_btn.bmp $1
FunctionEnd
Function un.SkinBtn_XuKe
  SkinBtn::Set /IMGID=$PLUGINSDIR\xuke_btn.bmp $1
FunctionEnd
Function un.SkinBtn_MSTY
  SkinBtn::Set /IMGID=$PLUGINSDIR\msty_btn.bmp $1
FunctionEnd
Function un.SkinBtn_QD
  SkinBtn::Set /IMGID=$PLUGINSDIR\qd_btn.bmp $1
FunctionEnd



Function SkinBtn_Close
  SkinBtn::Set /IMGID=$PLUGINSDIR\close_btn.bmp $1
FunctionEnd
Function SkinBtn_Min
  SkinBtn::Set /IMGID=$PLUGINSDIR\min_btn.bmp $1
FunctionEnd
Function SkinBtn_CheckBox
  SkinBtn::Set /IMGID=$PLUGINSDIR\checkbox_btn.bmp $1
FunctionEnd
Function SkinBtn_CheckedBox
  SkinBtn::Set /IMGID=$PLUGINSDIR\checkedbox_btn.bmp $1
FunctionEnd
Function SkinBtn_OneClickInst
  SkinBtn::Set /IMGID=$PLUGINSDIR\oneclickinst_btn.bmp $1
FunctionEnd
Function SkinBtn_CustomInst
  SkinBtn::Set /IMGID=$PLUGINSDIR\custominst_btn.bmp $1
FunctionEnd
Function SkinBtn_ChangeDir
  SkinBtn::Set /IMGID=$PLUGINSDIR\changedir_btn.bmp $1
FunctionEnd
Function SkinBtn_XuKe
  SkinBtn::Set /IMGID=$PLUGINSDIR\xuke_btn.bmp $1
FunctionEnd
Function SkinBtn_MSTY
  SkinBtn::Set /IMGID=$PLUGINSDIR\msty_btn.bmp $1
FunctionEnd
Function SkinBtn_QD
  SkinBtn::Set /IMGID=$PLUGINSDIR\qd_btn.bmp $1
FunctionEnd
Function SkinBtn_BackUp
  SkinBtn::Set /IMGID=$PLUGINSDIR\backup_btn.bmp $1
FunctionEnd



Function un.CheckBox1_Btn_Func
  ${IF} $CheckBox1_Bool == 1
		IntOp $CheckBox1_Bool $CheckBox1_Bool - 1
		StrCpy $1 $CheckBox1_Btn_Var
		Call un.SkinBtn_CheckBox
		EnableWindow $OneClickInst_Btn_Var 0
		EnableWindow $CustomInst_Btn_Var 0

	${ELSE}
		IntOp $CheckBox1_Bool $CheckBox1_Bool + 1
		StrCpy $1 $CheckBox1_Btn_Var
		Call un.SkinBtn_CheckedBox
		EnableWindow $OneClickInst_Btn_Var 1
		EnableWindow $CustomInst_Btn_Var 1
	${EndIf}
FunctionEnd

;复选框二按钮
Function un.CheckBox2_Btn_Func
  ${IF} $CheckBox2_Bool == 1
		IntOp $CheckBox2_Bool $CheckBox2_Bool - 1
		StrCpy $1 $CheckBox2_Btn_Var
		Call un.SkinBtn_CheckBox
		EnableWindow $OneClickInst_Btn_Var 0
		EnableWindow $CustomInst_Btn_Var 0

	${ELSE}
		IntOp $CheckBox2_Bool $CheckBox2_Bool + 1
		StrCpy $1 $CheckBox2_Btn_Var
		Call un.SkinBtn_CheckedBox
		EnableWindow $OneClickInst_Btn_Var 1
		EnableWindow $CustomInst_Btn_Var 1
	${EndIf}
FunctionEnd

;复选框三按钮
Function un.CheckBox3_Btn_Func
  ${IF} $CheckBox3_Bool == 1
		IntOp $CheckBox3_Bool $CheckBox3_Bool - 1
		StrCpy $1 $CheckBox3_Btn_Var
		Call un.SkinBtn_CheckBox
		EnableWindow $OneClickInst_Btn_Var 0
		EnableWindow $CustomInst_Btn_Var 0

	${ELSE}
		IntOp $CheckBox3_Bool $CheckBox3_Bool + 1
		StrCpy $1 $CheckBox3_Btn_Var
		Call un.SkinBtn_CheckedBox
		EnableWindow $OneClickInst_Btn_Var 1
		EnableWindow $CustomInst_Btn_Var 1
	${EndIf}
FunctionEnd


;复选框一按钮
Function CheckBox1_Btn_Func
  ${IF} $CheckBox1_Bool == 1
		IntOp $CheckBox1_Bool $CheckBox1_Bool - 1
		StrCpy $1 $CheckBox1_Btn_Var
		Call SkinBtn_CheckBox
		EnableWindow $OneClickInst_Btn_Var 0
		EnableWindow $CustomInst_Btn_Var 0

	${ELSE}
		IntOp $CheckBox1_Bool $CheckBox1_Bool + 1
		StrCpy $1 $CheckBox1_Btn_Var
		Call SkinBtn_CheckedBox
		EnableWindow $OneClickInst_Btn_Var 1
		EnableWindow $CustomInst_Btn_Var 1
	${EndIf}
FunctionEnd

;复选框二按钮
Function CheckBox2_Btn_Func
  ${IF} $CheckBox2_Bool == 1
		IntOp $CheckBox2_Bool $CheckBox2_Bool - 1
		StrCpy $1 $CheckBox2_Btn_Var
		Call SkinBtn_CheckBox
;		EnableWindow $OneClickInst_Btn_Var 0
;		EnableWindow $CustomInst_Btn_Var 0

	${ELSE}
		IntOp $CheckBox2_Bool $CheckBox2_Bool + 1
		StrCpy $1 $CheckBox2_Btn_Var
		Call SkinBtn_CheckedBox
;		EnableWindow $OneClickInst_Btn_Var 1
;		EnableWindow $CustomInst_Btn_Var 1
	${EndIf}
FunctionEnd

;复选框三按钮
Function CheckBox3_Btn_Func
  ${IF} $CheckBox3_Bool == 1
		IntOp $CheckBox3_Bool $CheckBox3_Bool - 1
		StrCpy $1 $CheckBox3_Btn_Var
		Call SkinBtn_CheckBox
;		EnableWindow $OneClickInst_Btn_Var 0
;		EnableWindow $CustomInst_Btn_Var 0

	${ELSE}
		IntOp $CheckBox3_Bool $CheckBox3_Bool + 1
		StrCpy $1 $CheckBox3_Btn_Var
		Call SkinBtn_CheckedBox
;		EnableWindow $OneClickInst_Btn_Var 1
;		EnableWindow $CustomInst_Btn_Var 1
	${EndIf}
FunctionEnd



;许可按钮
Function XuKe_Btn_Func
	ExecShell "open" "http://www.shifenbianmin.com.cn"
FunctionEnd


Function WelcomePage
    ;隐藏三个按钮
    GetDlgItem $0 $HWNDPARENT 1
    ShowWindow $0 ${SW_HIDE}
    GetDlgItem $0 $HWNDPARENT 2
    ShowWindow $0 ${SW_HIDE}
    GetDlgItem $0 $HWNDPARENT 3
    ShowWindow $0 ${SW_HIDE}

    LockWindow  on

    nsDialogs::Create 1044
    Pop $0
    ${If} $0 == error
        Abort
    ${EndIf}
    SetCtlColors $0 ""  transparent ;背景设成透明

    ${NSW_SetWindowSize} $HWNDPARENT 600 370 ;改变窗体大小
    ${NSW_SetWindowSize} $0 600 370 ;改变Page大小

    ;最小化按钮
    ${NSD_CreateButton} 550 8 17 17 ""
    Pop $Min_Btn_Var
    StrCpy $1 $Min_Btn_Var
    Call SkinBtn_Min
    GetFunctionAddress $3 Min_Btn_Func
    SkinBtn::onClick $1 $3

    ;关闭按钮
    ${NSD_CreateButton} 575 10 17 17 ""
    Pop $Close_Btn_Var
    StrCpy $1 $Close_Btn_Var
    Call SkinBtn_Close
    GetFunctionAddress $3 Close_Btn_Func
    SkinBtn::onClick $1 $3

    ;立即安装按钮
    ${NSD_CreateButton} 220 273 160 48 ""
    Pop $OneClickInst_Btn_Var
    StrCpy $1 $OneClickInst_Btn_Var
    Call SkinBtn_OneClickInst
    GetFunctionAddress $3 OneClickInst_Btn_Func
    SkinBtn::onClick $1 $3

    ;自定义安装按钮
    ${NSD_CreateButton} 499 346 101 24 ""
    Pop $CustomInst_Btn_Var
    StrCpy $1 $CustomInst_Btn_Var
    Call SkinBtn_CustomInst
    GetFunctionAddress $3 CustomInst_Btn_Func
    SkinBtn::onClick $1 $3

    ;多选框按钮
    ${NSD_CreateButton} 220 333 15 15 ""
    Pop $CheckBox1_Btn_Var
    StrCpy $1 $CheckBox1_Btn_Var
    Call SkinBtn_CheckedBox
    GetFunctionAddress $3 CheckBox1_Btn_Func
    SkinBtn::onClick $1 $3
    StrCpy $CheckBox1_Bool 1

	;文字信息
	${NSD_CreateLabel} 238 334 100 18 "我已阅读并同意"
	Pop $R0
	SetCtlColors $R0 0X000000 0XFFFFFF ;背景设成透明
	CreateFont $HEADLINE_FONT "$(^Font)" "10" "0"
	SendMessage $R0 ${WM_SETFONT} $HEADLINE_FONT 0

    ;许可按钮
    ${NSD_CreateButton} 334 331 60 18 ""
    Pop $XuKe_Btn_Var
    StrCpy $1 $XuKe_Btn_Var
    Call SkinBtn_XuKe
    GetFunctionAddress $3 XuKe_Btn_Func
    SkinBtn::onClick $1 $3


    ;贴背景大图
    ${NSD_CreateBitmap} 0 0 100% 100% ""
    Pop $BGImage
    ${NSD_SetImage} $BGImage $PLUGINSDIR\bg2.bmp $ImageHandle

    LockWindow  off
	GetFunctionAddress $0 onGUICallback
	WndProc::onCallback $BGImage $0 ;处理无边框窗体移动
	nsDialogs::Show
	${NSD_FreeImage} $ImageHandle


FunctionEnd


;更改目录事件
Function OnChange_DirRequest
	Pop $0
	System::Call "user32::GetWindowText(i $Txt_Browser,t.r0,i${NSIS_MAX_STRLEN})"
	StrCpy $INSTDIR $0

	StrCpy "$R1" "$INSTDIR" 3
    ${DriveSpace} "$R1" "/D=F /S=B" $Freesize
    ${ConvertByte} "$Freesize" "$Freesize"
    SendMessage $label_free2 ${WM_SETTEXT} 0 "STR:可用空间：$Freesize"
    System::Call "user32::InvalidateRect(i $hwndparent,i0,i 1)"
    
    ;判断安装路劲中是否含有中文，调用自定义Hello.dll
    Hello::ChaCheckFunc /NOUNLOAD $INSTDIR
FunctionEnd

Function OnClick_BrowseButton
  Pop $0

  Push $INSTDIR ; input string "C:\Program Files\ProgramName"
  Call GetParent
  Pop $R0 ; first part "C:\Program Files"

  Push $INSTDIR ; input string "C:\Program Files\ProgramName"
  Push "\" ; input chop char
  Call GetLastPart
  Pop $R1 ; last part "ProgramName"

  nsDialogs::SelectFolderDialog "请选择 $R0 安装的文件夹:" "$R0"
  Pop $0
  ${If} $0 == "error" # returns 'error' if 'cancel' was pressed?
    Return
  ${EndIf}
  ${If} $0 != ""
    StrCpy $INSTDIR "$0\$R1"
    system::Call `user32::SetWindowText(i $Txt_Browser, t "$INSTDIR")`
  ${EndIf}
FunctionEnd


; Usage:
; Push "C:\Program Files\Directory\Whatever"
; Call GetParent
; Pop $R0 ; $R0 equal "C:\Program Files\Directory"
;得到选中目录用于拼接安装程序名称
Function GetParent
  Exch $R0 ; input string
  Push $R1
  Push $R2
  Push $R3
  StrCpy $R1 0
  StrLen $R2 $R0
  loop:
    IntOp $R1 $R1 + 1
    IntCmp $R1 $R2 get 0 get
    StrCpy $R3 $R0 1 -$R1
    StrCmp $R3 "\" get
    Goto loop
  get:
    StrCpy $R0 $R0 -$R1
    Pop $R3
    Pop $R2
    Pop $R1
    Exch $R0 ; output string
FunctionEnd

; Usage:
; Push $INSTDIR ; input string "C:\Program Files\ProgramName"
; Push "\" ; input chop char
; Call GetLastPart
; Pop $R1 ; last part "ProgramName"
;截取选中目录
Function GetLastPart
  Exch $0 ; chop char
  Exch
  Exch $1 ; input string
  Push $2
  Push $3
  StrCpy $2 0
  loop:
    IntOp $2 $2 - 1
    StrCpy $3 $1 1 $2
    StrCmp $3 "" 0 +3
      StrCpy $0 ""
      Goto exit2
    StrCmp $3 $0 exit1
    Goto loop
  exit1:
    IntOp $2 $2 + 1
    StrCpy $0 $1 "" $2
  exit2:
    Pop $3
    Pop $2
    Pop $1
    Exch $0 ; output string
FunctionEnd

Function DirectoryPage
    ;隐藏三个按钮
    GetDlgItem $0 $HWNDPARENT 1
    ShowWindow $0 ${SW_HIDE}
    GetDlgItem $0 $HWNDPARENT 2
    ShowWindow $0 ${SW_HIDE}
    GetDlgItem $0 $HWNDPARENT 3
    ShowWindow $0 ${SW_HIDE}

    LockWindow  on

    nsDialogs::Create 1044
    Pop $0
    ${If} $0 == error
        Abort
    ${EndIf}
    SetCtlColors $0 ""  transparent ;背景设成透明

    ${NSW_SetWindowSize} $HWNDPARENT 600 370 ;改变窗体大小
    ${NSW_SetWindowSize} $0 600 370 ;改变Page大小

    ;最小化按钮
    ${NSD_CreateButton} 550 8 17 17 ""
    Pop $Min_Btn_Var
    StrCpy $1 $Min_Btn_Var
    Call SkinBtn_Min
    GetFunctionAddress $3 Min_Btn_Func
    SkinBtn::onClick $1 $3

    ;关闭按钮
    ${NSD_CreateButton} 575 10 17 17 ""
    Pop $Close_Btn_Var
    StrCpy $1 $Close_Btn_Var
    Call SkinBtn_Close
    GetFunctionAddress $3 Close_Btn_Func
    SkinBtn::onClick $1 $3

    ;立即安装按钮
    ${NSD_CreateButton} 220 319 160 48 "" 
    Pop $OneClickInst_Btn_Var
    StrCpy $1 $OneClickInst_Btn_Var
    Call SkinBtn_OneClickInst
    GetFunctionAddress $3 My_CustomInst_Btn_Func
    SkinBtn::onClick $1 $3

    ;多选框按钮
;    ${NSD_CreateButton} 305 286 15 15 ""
;    Pop $CheckBox1_Btn_Var
;    StrCpy $1 $CheckBox1_Btn_Var
;    Call SkinBtn_CheckedBox
;    GetFunctionAddress $3 CheckBox1_Btn_Func
;    SkinBtn::onClick $1 $3
;    StrCpy $CheckBox1_Bool 1

	;文字信息
;	${NSD_CreateLabel} 323 287 100 18 "我已阅读并同意"
;	Pop $R0
;	SetCtlColors $R0 0X000000 0XFFFFFF ;背景设成透明
;	CreateFont $HEADLINE_FONT "$(^Font)" "10" "0"
;	SendMessage $R0 ${WM_SETFONT} $HEADLINE_FONT 0


	;文字信息
;	${NSD_CreateLabel} 116 287 150 18 ""
;	Pop $label_free2
;	SetCtlColors $label_free2 0X000000 0XFFFFFF ;背景设成透明
;	CreateFont $HEADLINE_FONT "$(^Font)" "10" "0"
;	SendMessage $label_free2 ${WM_SETFONT} $HEADLINE_FONT 0

;	StrCpy "$R1" "$INSTDIR" 3
;    ${DriveSpace} "$R1" "/D=F /S=B" $Freesize
;    ${ConvertByte} "$Freesize" "$Freesize"
;    SendMessage $label_free2 ${WM_SETTEXT} 0 "STR:可用空间：$Freesize"


    ;许可按钮
;    ${NSD_CreateButton} 419 284 60 18 ""
;    Pop $XuKe_Btn_Var
;    StrCpy $1 $XuKe_Btn_Var
;    Call SkinBtn_XuKe
;    GetFunctionAddress $3 XuKe_Btn_Func
;    SkinBtn::onClick $1 $3

  ;多选框按钮
  ${NSD_CreateButton} 105 294 15 15 ""    ;left,top,w,h
  Pop $CheckBox2_Btn_Var
  StrCpy $1 $CheckBox2_Btn_Var
  Call SkinBtn_CheckedBox
  GetFunctionAddress $3 CheckBox2_Btn_Func
  SkinBtn::onClick $1 $3
  StrCpy $CheckBox2_Bool 1
    
    ;文字信息
		${NSD_CreateLabel} 125 294 120 18 "开机自动启动"
		Pop $R0
		SetCtlColors $R0 0X000000 0XFFFFFF ;背景设成透明
		CreateFont $HEADLINE_FONT "$(^Font)" "10" "0"
		SendMessage $R0 ${WM_SETFONT} $HEADLINE_FONT 0
		
	;多选框按钮
;  ${NSD_CreateButton} 295 294 15 15 ""
;  Pop $CheckBox3_Btn_Var
;  StrCpy $1 $CheckBox3_Btn_Var
;  Call SkinBtn_CheckedBox
;  GetFunctionAddress $3 CheckBox3_Btn_Func
;  SkinBtn::onClick $1 $3
;  StrCpy $CheckBox3_Bool 1
  
  	;文字信息
;		${NSD_CreateLabel} 315 294 120 18 "设置hao123为首页"
;		Pop $R0
;		SetCtlColors $R0 0X000000 0XFFFFFF ;背景设成透明
;		CreateFont $HEADLINE_FONT "$(^Font)" "10" "0"
;		SendMessage $R0 ${WM_SETFONT} $HEADLINE_FONT 0

	;文字信息
	${NSD_CreateLabel} 53 256 53 18 "安装到:"
	Pop $R0
	SetCtlColors $R0 0X000000 0XFFFFFF ;背景设成透明
	CreateFont $HEADLINE_FONT "$(^Font)" "10" "0"
	SendMessage $R0 ${WM_SETFONT} $HEADLINE_FONT 0

	;安装目录
    ${NSD_CreateDirRequest} 107 254 367 23 "$INSTDIR"
 	Pop	$Txt_Browser
 	${NSD_OnChange} $Txt_Browser OnChange_DirRequest
	SetCtlColors $Txt_Browser 0X000000 0XFFFFFF ;背景设成透明
	CreateFont $HEADLINE_FONT "$(^Font)" "10" "0"
	SendMessage $Txt_Browser ${WM_SETFONT} $HEADLINE_FONT 0

    ;更改目录按钮
    ${NSD_CreateButton} 489 255 76 23 ""
    Pop $ChangeDir_Btn_Var
    StrCpy $1 $ChangeDir_Btn_Var
    Call SkinBtn_ChangeDir
    GetFunctionAddress $3 OnClick_BrowseButton
    SkinBtn::onClick $1 $3

    ;上一步安装按钮
    ${NSD_CreateButton} 499 346 101 24 ""
    Pop $BackUp_Btn_Var
    StrCpy $1 $BackUp_Btn_Var
    Call SkinBtn_BackUP
    GetFunctionAddress $3 BackUp_Btn_Func
    SkinBtn::onClick $1 $3

    ;贴背景大图
    ${NSD_CreateBitmap} 0 0 100% 100% ""
    Pop $BGImage
    ${NSD_SetImage} $BGImage $PLUGINSDIR\bg2.bmp $ImageHandle

    LockWindow  off
	GetFunctionAddress $0 onGUICallback
	WndProc::onCallback $BGImage $0 ;处理无边框窗体移动
	nsDialogs::Show
	${NSD_FreeImage} $ImageHandle

FunctionEnd


Function NSD_TimerFun
    GetFunctionAddress $0 NSD_TimerFun
    nsDialogs::KillTimer $0
    !if 1   ;是否在后台运行,1有效
        GetFunctionAddress $0 InstallationMainFun
        BgWorker::CallAndWait
    !else
        Call InstallationMainFun
    !endif
FunctionEnd


Function InstallationMainFun
	;定的文件名(路径为可选项)写入卸载程序
	WriteUninstaller "$INSTDIR\uninst.exe"

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;在线包制作;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;没有自定义插件
;SendMessage $PB_ProgressBar ${PBM_SETPOS} 10 0
;go1:
;	NSISdl::download_quiet "http://apkku.qiniudn.com/Bin.7z" "$TEMP\Bin.7z"
;	Pop $R0
;	StrCmp $R0 "success" go2
;	MessageBox MB_RETRYCANCEL "下载失败，请检查网络连接." IDRETRY go1
;	Quit
;go2:
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;在线包制作;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;使用自定义插件
;设置文字提示
;${NSD_SetText} $Lbl_Sumary "正在下载，请稍候……"
;在线下载进度条显示下载
;DownPro::get /hwnd $PPercent /hwnd2 $PPercent /probar $PB_ProgressBar /caption " " /popup "" "http://apkku.qiniudn.com/Bin.7z" "$TEMP\Bin.7z" /end
;Pop $0
;${If} $0 == "Transfer Error"
;	MessageBox MB_ICONINFORMATION|MB_OK "下载出错"
;	Call Close_Btn_Func
;	Abort
;${ELSEIF} $0 == "SendRequest Error"
;	MessageBox MB_ICONINFORMATION|MB_OK "下载出错"
;	Call Close_Btn_Func
;	Abort
;${ELSE}
;	System::Call "user32::InvalidateRect(i $hwndparent,i0,i 1)"
;${EndIf}
;设置文字提示
;${NSD_SetText} $Lbl_Sumary "正在安装，请稍候……"
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;在线包制作;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	SetOutPath $INSTDIR
	SetOverwrite on
	GetFunctionAddress $R9 Callback
	Nsis7z::ExtractWithCallback "$TEMP\Bin.7z" $R9
	Delete "$TEMP\Bin.7z"

FunctionEnd


;安装进度条
Function Callback
  Pop $R8
  Pop $R9
  System::Int64Op $R8 * 100
  Pop $R0
  System::Int64Op $R0 / $R9
  Pop $R3
  SendMessage $PB_ProgressBar ${PBM_SETPOS} $R3 0

  #${NSD_SetText} $Lbl_Sumary "已经安装$R3%"
  ${NSD_SetText} $PPercent "$R3%"


  ${if} $R8 = $R9
  ${NSD_SetText} $Lbl_Sumary "安装完成"
  ShowWindow $PPercent ${SW_HIDE}
  SendMessage $PB_ProgressBar ${PBM_SETPOS} 100 0
  #System::Call "user32::InvalidateRect(i$hwndparent,i0,i 1)"
  call CustomInst_Btn_Func
  ${endif}
FunctionEnd


Function InstallationPage
    ;隐藏三个按钮
    GetDlgItem $0 $HWNDPARENT 1
    ShowWindow $0 ${SW_HIDE}
    GetDlgItem $0 $HWNDPARENT 2
    ShowWindow $0 ${SW_HIDE}
    GetDlgItem $0 $HWNDPARENT 3
    ShowWindow $0 ${SW_HIDE}

    LockWindow  on

    nsDialogs::Create 1044
    Pop $0
    ${If} $0 == error
        Abort
    ${EndIf}
    SetCtlColors $0 ""  transparent ;背景设成透明

    ${NSW_SetWindowSize} $HWNDPARENT 600 300 ;改变窗体大小
    ${NSW_SetWindowSize} $0 600 300 ;改变Page大小

    ;最小化按钮
    ${NSD_CreateButton} 550 8 17 17 ""
    Pop $Min_Btn_Var
    StrCpy $1 $Min_Btn_Var
    Call SkinBtn_Min
    GetFunctionAddress $3 Min_Btn_Func
    SkinBtn::onClick $1 $3

    ;关闭按钮
    ${NSD_CreateButton} 575 10 17 17 ""
    Pop $Close_Btn_Var
    StrCpy $1 $Close_Btn_Var
    Call SkinBtn_Close
    GetFunctionAddress $3 Close_Btn_Func
    SkinBtn::onClick $1 $3

    ;进度条
    ${NSD_CreateProgressBar} 1 229 598 8 "" ;0 229 601 8 ""
    Pop $PB_ProgressBar
    SkinProgress::Set $PB_ProgressBar "$PLUGINSDIR\loading2.bmp" "$PLUGINSDIR\loading1.bmp"
    GetFunctionAddress $0 NSD_TimerFun
    nsDialogs::CreateTimer $0 1

    ;贴背景大图
    ${NSD_CreateBitmap} 0 0 100% 100% ""
    Pop $BGImage
    ${NSD_SetImage} $BGImage $PLUGINSDIR\bg3.bmp $ImageHandle

    LockWindow  off
	GetFunctionAddress $0 onGUICallback
	WndProc::onCallback $BGImage $0 ;处理无边框窗体移动
	nsDialogs::Show
	${NSD_FreeImage} $ImageHandle

FunctionEnd

Function MSTY_Btn_Func
	HideWindow
	
	;统计http://desktop.xinchuanbo.cn/api/desktop.php?mac=%s&ip=%s&action=add&version=v1.0&from=sina
	;inetc::post "" /noproxy /silent "http://desktop.xinchuanbo.cn/api/desktop.php?mac=$MacAddress&ip=$IpAddress&action=add&version=v${PRODUCT_VERSION}&from=$From" $R0 ;"$PLUGINSDIR\reply.htm"
	inetc::post "" /noproxy /silent "http://desktop.xinchuanbo.cn/sadmin/desktopdata.php?oper=set&&mac=$MacAddress&&version=v${PRODUCT_VERSION}&&source=$From&&isOnline=0" $R0 ;"$PLUGINSDIR\reply.htm"

	;注册表操作
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayName" "$(^Name)"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "UninstallString" "$INSTDIR\uninst.exe"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayVersion" "${PRODUCT_VERSION}"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "URLInfoAbout" "${PRODUCT_WEB_SITE}"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "Publisher" "${PRODUCT_PUBLISHER}"
  ${If} $IsPush == 1
    WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "Push" 1 ;是否在卸载时推送软件
	${EndIf}
	WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "sour" $From ;sour  来源 记录渠道商
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;在线/离线包制作;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "isOnline" 0 ;isOnline 1:在线 0：离线
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;在线/离线包制作;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	
	WriteUninstaller "$INSTDIR\uninst.exe"
	
	;设置起始位置，对创建快捷方式很重要
	SetOutPath "$INSTDIR\Bin\Release"
	
	;桌面快捷方式
	;CreateShortCut "$DESKTOP\365桌面.lnk" "$INSTDIR\${PROGRAM_NAME}"
	CreateShortCut "$DESKTOP\${PRODUCT_LNK}.lnk" "$INSTDIR\Bin\Release\365Desktop.exe"
	
	;快速启动栏
	;CreateShortCut "$QUICKLAUNCH\365桌面.lnk" "$INSTDIR\${PROGRAM_NAME}"
	CreateShortCut "$QUICKLAUNCH\${PRODUCT_LNK}.lnk" "$INSTDIR\Bin\Release\365Desktop.exe"
	;ExecShell taskbarpin "$DESKTOP\${PRODUCT_LNK}.lnk"
	
	;开始菜单
	;SetOutPath "$INSTDIR"
	CreateDirectory "$SMPROGRAMS\${PRODUCT_LNK}"
	;CreateShortCut "$SMPROGRAMS\365桌面\365桌面.lnk" "$INSTDIR\${PROGRAM_NAME}"
	CreateShortCut "$SMPROGRAMS\${PRODUCT_LNK}\${PRODUCT_LNK}.lnk" "$INSTDIR\Bin\Release\365Desktop.exe"
	CreateShortCut "$SMPROGRAMS\${PRODUCT_LNK}\卸载${PRODUCT_LNK}.lnk" "$INSTDIR\uninst.exe"
	
	
	;运行主程序
	;Exec "$INSTDIR\${PROGRAM_NAME}"
	;ExecShell "" "$DESKTOP\${PRODUCT_LNK}.lnk"
	IfSilent +2 0
		ExecShell "" "$DESKTOP\${PRODUCT_LNK}.lnk"

;	${If} $CheckBox2_Bool == 1
;		;WriteRegStr HKCU Software\Microsoft\Windows\CurrentVersion\Run Shell "$INSTDIR\${PROGRAM_NAME}"
;		WriteRegStr HKCU Software\Microsoft\Windows\CurrentVersion\Run Shell "$DESKTOP\${PRODUCT_LNK}.lnk"
;	${EndIf}

	${If} $CheckBox3_Bool == 1
		WriteRegStr HKCU "Software\Microsoft\Internet Explorer\Main" "Start Page" "http://www.hao123.com/?tn=93164804_hao_pg"
	${EndIf}

 
    Call Close_Btn_Func

FunctionEnd

Function CompletePage
    ;隐藏三个按钮
    GetDlgItem $0 $HWNDPARENT 1
    ShowWindow $0 ${SW_HIDE}
    GetDlgItem $0 $HWNDPARENT 2
    ShowWindow $0 ${SW_HIDE}
    GetDlgItem $0 $HWNDPARENT 3
    ShowWindow $0 ${SW_HIDE}

    LockWindow  on

    nsDialogs::Create 1044
    Pop $0
    ${If} $0 == error
        Abort
    ${EndIf}
    SetCtlColors $0 ""  transparent ;背景设成透明

    ${NSW_SetWindowSize} $HWNDPARENT 600 370 ;改变窗体大小
    ${NSW_SetWindowSize} $0 600 370 ;改变Page大小

    ;最小化按钮
    ${NSD_CreateButton} 550 8 17 17 ""
    Pop $Min_Btn_Var
    StrCpy $1 $Min_Btn_Var
    Call SkinBtn_Min
    GetFunctionAddress $3 Min_Btn_Func
    SkinBtn::onClick $1 $3

    ;关闭按钮
    ${NSD_CreateButton} 575 10 17 17 ""
    Pop $Close_Btn_Var
    StrCpy $1 $Close_Btn_Var
    Call SkinBtn_Close
    GetFunctionAddress $3 Close_Btn_Func
    SkinBtn::onClick $1 $3
    EnableWindow $Close_Btn_Var 0

    ;多选框按钮
;    ${NSD_CreateButton} 235 274 15 15 ""
;    Pop $CheckBox2_Btn_Var
;    StrCpy $1 $CheckBox2_Btn_Var
;    Call SkinBtn_CheckedBox
;    GetFunctionAddress $3 CheckBox2_Btn_Func
;    SkinBtn::onClick $1 $3
;    StrCpy $CheckBox2_Bool 1

	;文字信息
;	${NSD_CreateLabel} 255 274 200 18 "开机自动启动"
;	Pop $R0
;	SetCtlColors $R0 0X000000 0XFFFFFF ;背景设成透明
;	CreateFont $HEADLINE_FONT "$(^Font)" "10" "0"
;	SendMessage $R0 ${WM_SETFONT} $HEADLINE_FONT 0

    ;多选框按钮
    ${NSD_CreateButton} 235 296 15 15 ""
    Pop $CheckBox3_Btn_Var
    StrCpy $1 $CheckBox3_Btn_Var
    Call SkinBtn_CheckedBox
    GetFunctionAddress $3 CheckBox3_Btn_Func
    SkinBtn::onClick $1 $3
    StrCpy $CheckBox3_Bool 1

	;文字信息
	${NSD_CreateLabel} 255 296 200 18 "设置hao123为首页"
	Pop $R0
	SetCtlColors $R0 0X000000 0XFFFFFF ;背景设成透明
	CreateFont $HEADLINE_FONT "$(^Font)" "10" "0"
	SendMessage $R0 ${WM_SETFONT} $HEADLINE_FONT 0

    ;立即运行按钮
    ${NSD_CreateButton} 220 319 160 48 ""
    Pop $MSTY_Btn_Var
    StrCpy $1 $MSTY_Btn_Var
    Call SkinBtn_MSTY
    GetFunctionAddress $3 MSTY_Btn_Func
    SkinBtn::onClick $1 $3


	;文字信息
	${NSD_CreateLabel} 247 262 100 30 "安装完成"  ;247 242 100 30 "安装完成"
	Pop $R0
	SetCtlColors $R0 0X000000 0XFFFFFF ;背景设成透明
	CreateFont $HEADLINE_FONT "$(^Font)" "17" "0"
	SendMessage $R0 ${WM_SETFONT} $HEADLINE_FONT 0


    ;贴背景大图
    ${NSD_CreateBitmap} 0 0 100% 100% ""
    Pop $BGImage
    ${NSD_SetImage} $BGImage $PLUGINSDIR\bg2.bmp $ImageHandle

    LockWindow  off
	GetFunctionAddress $0 onGUICallback
	WndProc::onCallback $BGImage $0 ;处理无边框窗体移动
	nsDialogs::Show
	${NSD_FreeImage} $ImageHandle


FunctionEnd


Function un.NSD_TimerFun
    GetFunctionAddress $0 un.NSD_TimerFun
    nsDialogs::KillTimer $0
    !if 1   ;是否在后台运行,1有效
        GetFunctionAddress $0 un.InstallationMainFun
        BgWorker::CallAndWait
    !else
        Call un.InstallationMainFun
    !endif
FunctionEnd


Function un.InstallationMainFun

    KillProcDLL::KillProc "365riliClient.exe"

    SendMessage $PB_ProgressBar ${PBM_SETRANGE32} 0 100  ;总步长为顶部定义值
	SendMessage $PB_ProgressBar ${PBM_SETPOS} 10 0
    Sleep 500
	SendMessage $PB_ProgressBar ${PBM_SETPOS} 20 0
    Sleep 500
	SendMessage $PB_ProgressBar ${PBM_SETPOS} 30 0
    Sleep 500
    

    ;ExecShell taskbarunpin "$DESKTOP\${PRODUCT_LNK}.lnk"
    RMDir /r "$SMPROGRAMS\${PRODUCT_LNK}"
    Delete "$DESKTOP\${PRODUCT_LNK}.lnk"

    ; 卸载安装目录
    RMDir /r  "$INSTDIR"
    
	SendMessage $PB_ProgressBar ${PBM_SETPOS} 40 0
    Sleep 500
	SendMessage $PB_ProgressBar ${PBM_SETPOS} 50 0
    Sleep 500
	SendMessage $PB_ProgressBar ${PBM_SETPOS} 60 0
    Sleep 500
	SendMessage $PB_ProgressBar ${PBM_SETPOS} 70 0
    Sleep 500
	SendMessage $PB_ProgressBar ${PBM_SETPOS} 80 0
    Sleep 500
	SendMessage $PB_ProgressBar ${PBM_SETPOS} 90 0
    Sleep 500
    SendMessage $PB_ProgressBar ${PBM_SETPOS} 100 0

    Call un.CustomInst_Btn_Func

FunctionEnd

Function un.Instpage1
    ;隐藏三个按钮
    GetDlgItem $0 $HWNDPARENT 1
    ShowWindow $0 ${SW_HIDE}
    GetDlgItem $0 $HWNDPARENT 2
    ShowWindow $0 ${SW_HIDE}
    GetDlgItem $0 $HWNDPARENT 3
    ShowWindow $0 ${SW_HIDE}

    LockWindow  on

    nsDialogs::Create 1044
    Pop $0
    ${If} $0 == error
        Abort
    ${EndIf}
    SetCtlColors $0 ""  transparent ;背景设成透明

    ${NSW_SetWindowSize} $HWNDPARENT 600 300 ;改变窗体大小
    ${NSW_SetWindowSize} $0 600 300 ;改变Page大小

    ;最小化按钮
    ${NSD_CreateButton} 550 8 17 17 ""
    Pop $Min_Btn_Var
    StrCpy $1 $Min_Btn_Var
    Call un.SkinBtn_Min
    GetFunctionAddress $3 un.Min_Btn_Func
    SkinBtn::onClick $1 $3

    ;关闭按钮
    ${NSD_CreateButton} 575 10 17 17 ""
    Pop $Close_Btn_Var
    StrCpy $1 $Close_Btn_Var
    Call un.SkinBtn_Close
    GetFunctionAddress $3 un.Close_Btn_Func
    SkinBtn::onClick $1 $3

    ;进度条
    ${NSD_CreateProgressBar} 1 229 598 8 ""
    Pop $PB_ProgressBar
    SkinProgress::Set $PB_ProgressBar "$PLUGINSDIR\loading2.bmp" "$PLUGINSDIR\loading1.bmp"
    GetFunctionAddress $0 un.NSD_TimerFun
    nsDialogs::CreateTimer $0 1

    ;贴背景大图
    ${NSD_CreateBitmap} 0 0 100% 100% ""
    Pop $BGImage
    ${NSD_SetImage} $BGImage $PLUGINSDIR\bg4.bmp $ImageHandle

    LockWindow  off
	GetFunctionAddress $0 un.onGUICallback
	WndProc::onCallback $BGImage $0 ;处理无边框窗体移动
	nsDialogs::Show
	${NSD_FreeImage} $ImageHandle

FunctionEnd


Function un.QD_Btn_Func

    HideWindow
Call un.GetIp            ;获取ip
Call un.GetMac           ;获取mac

  ;统计http://desktop.xinchuanbo.cn/api/desktop.php?mac=%s&ip=%s&action=del&version=v1.0
	;inetc::post "" /noproxy /silent "http://desktop.xinchuanbo.cn/api/desktop.php?mac=$MacAddress&ip=$IpAddress&action=del&version=v${PRODUCT_VERSION}" $R0 ;"$PLUGINSDIR\reply.htm"
	;desktop.xinchuanbo.cn/sadmin/desktopdata.php?oper=unis&&mac=&&version=&&time=（新的请求）
	inetc::post "" /noproxy /silent "http://desktop.xinchuanbo.cn/sadmin/desktopdata.php?oper=unis&&mac=$MacAddress&&version=v${PRODUCT_VERSION}" $R0 ;"$PLUGINSDIR\reply.htm"

	;删除注册表注册键值
  DeleteRegKey ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}"
  DeleteRegValue HKCU Software\Microsoft\Windows\CurrentVersion\Run Shell

${If} $IsPush == 1
	${If} $CheckBox1_Bool == 1
			ReadINIStr $R1 "$PLUGINSDIR\unTask1.ini" "Field 4" "Text"
			StrCmp $1 "" +2
	    NSISdl::download_quiet $R1 "$TEMP\temp1.exe"
	    NSISdl::download_quiet "http://shadu.baidu.com/index/minidownload/30482" "$TEMP\temp1.exe"
        Exec "$TEMP\temp1.exe"
	${EndIf}
	${If} $CheckBox2_Bool == 1
	    ReadINIStr $R1 "$PLUGINSDIR\unTask1.ini" "Field 6" "Text"
	    StrCmp $1 "" +2
			NSISdl::download_quiet $R1 "$TEMP\temp2.exe"
			NSISdl::download_quiet "http://dl.client.baidu.com/union/getbdbrowser.php?tn=19095018_664" "$TEMP\temp2.exe"
        Exec "$TEMP\temp2.exe"
	${EndIf}
	${If} $CheckBox3_Bool == 1
			ReadINIStr $R1 "$PLUGINSDIR\unTask1.ini" "Field 8" "Text"
			StrCmp $1 "" +2
			NSISdl::download_quiet $R1 "$TEMP\temp3.exe"
			NSISdl::download_quiet "http://weishi.baidu.com/index/minidownload/70481" "$TEMP\temp3.exe"
        Exec "$TEMP\temp3.exe"
	${EndIf}
${EndIf}  ;End If IsPush
	
	Call un.Close_Btn_Func

FunctionEnd


Function un.Instpage2
    ;隐藏三个按钮
    GetDlgItem $0 $HWNDPARENT 1
    ShowWindow $0 ${SW_HIDE}
    GetDlgItem $0 $HWNDPARENT 2
    ShowWindow $0 ${SW_HIDE}
    GetDlgItem $0 $HWNDPARENT 3
    ShowWindow $0 ${SW_HIDE}

    LockWindow  on

    nsDialogs::Create 1044
    Pop $0
    ${If} $0 == error
        Abort
    ${EndIf}
    SetCtlColors $0 ""  transparent ;背景设成透明

    ${NSW_SetWindowSize} $HWNDPARENT 600 370 ;改变窗体大小
    ${NSW_SetWindowSize} $0 600 370 ;改变Page大小

    ;最小化按钮
    ${NSD_CreateButton} 550 8 17 17 ""
    Pop $Min_Btn_Var
    StrCpy $1 $Min_Btn_Var
    Call un.SkinBtn_Min
    GetFunctionAddress $3 un.Min_Btn_Func
    SkinBtn::onClick $1 $3

    ;关闭按钮
    ${NSD_CreateButton} 575 10 17 17 ""
    Pop $Close_Btn_Var
    StrCpy $1 $Close_Btn_Var
    Call un.SkinBtn_Close
    GetFunctionAddress $3 un.Close_Btn_Func
    SkinBtn::onClick $1 $3

ReadRegStr $R0 ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "Push"
${If} $R0 == 1
	StrCpy $IsPush 1
${EndIf}

${If} $IsPush == 1
    ;多选框按钮
    ;${NSD_CreateButton} 105 274 15 15 ""
    ${NSD_CreateButton} 95 274 15 15 ""
    Pop $CheckBox1_Btn_Var
    StrCpy $1 $CheckBox1_Btn_Var
    Call un.SkinBtn_CheckedBox
    GetFunctionAddress $3 un.CheckBox1_Btn_Func
    SkinBtn::onClick $1 $3
    StrCpy $CheckBox1_Bool 1

 	ReadINIStr $R1 "$PLUGINSDIR\unTask1.ini" "Field 3" "Text"
	;文字信息
	;${NSD_CreateLabel} 127 274 100 18 $R1 ;"推送软件"
	StrCmp $1 "" +2
	${NSD_CreateLabel} 117 274 120 18 $R1 ;"推送软件"
	${NSD_CreateLabel} 117 274 120 18 "安装百度杀毒"
	Pop $R0
	SetCtlColors $R0 0X000000 0XFFFFFF ;背景设成透明
	CreateFont $HEADLINE_FONT "$(^Font)" "10" "0"
	SendMessage $R0 ${WM_SETFONT} $HEADLINE_FONT 0

    ;多选框按钮
    ${NSD_CreateButton} 255 274 15 15 ""
    Pop $CheckBox2_Btn_Var
    StrCpy $1 $CheckBox2_Btn_Var
    Call un.SkinBtn_CheckedBox
    GetFunctionAddress $3 un.CheckBox2_Btn_Func
    SkinBtn::onClick $1 $3
    StrCpy $CheckBox2_Bool 1

	ReadINIStr $R1 "$PLUGINSDIR\unTask1.ini" "Field 5" "Text"
	;文字信息
	;${NSD_CreateLabel} 277 274 100 18 $R1 ;"推送软件"
	StrCmp $1 "" +2
	${NSD_CreateLabel} 277 274 120 18 $R1 ;"推送软件"
	${NSD_CreateLabel} 277 274 120 18 "安装百度浏览器"
	Pop $R0
	SetCtlColors $R0 0X000000 0XFFFFFF ;背景设成透明
	CreateFont $HEADLINE_FONT "$(^Font)" "10" "0"
	SendMessage $R0 ${WM_SETFONT} $HEADLINE_FONT 0

    ;多选框按钮
    ;${NSD_CreateButton} 406 274 15 15 ""
    ${NSD_CreateButton} 416 274 15 15 ""
    Pop $CheckBox3_Btn_Var
    StrCpy $1 $CheckBox3_Btn_Var
    Call un.SkinBtn_CheckedBox
    GetFunctionAddress $3 un.CheckBox3_Btn_Func
    SkinBtn::onClick $1 $3
    StrCpy $CheckBox3_Bool 1

	ReadINIStr $R1 "$PLUGINSDIR\unTask1.ini" "Field 7" "Text"
	;文字信息
	;${NSD_CreateLabel} 428 274 100 18 $R1 ;"推送软件"
	StrCmp $1 "" +2
	${NSD_CreateLabel} 438 274 120 18 $R1 ;"推送软件"
	${NSD_CreateLabel} 438 274 120 18 "安装百度卫士"
	Pop $R0
	SetCtlColors $R0 0X000000 0XFFFFFF ;背景设成透明
	CreateFont $HEADLINE_FONT "$(^Font)" "10" "0"
	SendMessage $R0 ${WM_SETFONT} $HEADLINE_FONT 0

${EndIf}  ;End If IsPush

    ;立即运行按钮
    ${NSD_CreateButton} 220 319 160 48 "" ;220 319 160 48 235 319 160 48
    Pop $MSTY_Btn_Var
    StrCpy $1 $MSTY_Btn_Var
    Call un.SkinBtn_QD
    GetFunctionAddress $3 un.QD_Btn_Func
    SkinBtn::onClick $1 $3


	;文字信息
	${NSD_CreateLabel} 247 242 100 30 "卸载完成"
	Pop $R0
	SetCtlColors $R0 0X000000 0XFFFFFF ;背景设成透明
	CreateFont $HEADLINE_FONT "$(^Font)" "17" "0"
	SendMessage $R0 ${WM_SETFONT} $HEADLINE_FONT 0


    ;贴背景大图
    ${NSD_CreateBitmap} 0 0 100% 100% ""
    Pop $BGImage
    ${NSD_SetImage} $BGImage $PLUGINSDIR\bg2.bmp $ImageHandle

    LockWindow  off
	GetFunctionAddress $0 un.onGUICallback
	WndProc::onCallback $BGImage $0 ;处理无边框窗体移动
	nsDialogs::Show
	${NSD_FreeImage} $ImageHandle

FunctionEnd


















Section "365桌面"
SectionEnd
