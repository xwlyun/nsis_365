#��������
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
Var IsInst  ;�Ƿ���ж�ذ�װ��Ĭ����Ĺ���
Var From  ;������
Var IsPush  ;�Ƿ���ж��ʱ������

#�궨��
;��װͼ���·������
!define MUI_ICON "images\inst.ico"
;ж��ͼ���·������
!define MUI_UNICON "images\uninst.ico"
;�������ɵİ�װ������
!define OUTFILE_NAME "365DesktopSetup.exe"
;����������
!define PROGRAM_NAME "365DesktopSetup"

!define PRODUCT_FOLDER "365Software" ;��Ϊ����һ��Ŀ¼����ֹ����װ���ϲ�Ŀ¼��
!define PRODUCT_VERSION "1.0"
!define PRODUCT_LNK "365��������"
!define PRODUCT_PUBLISHER "365��������"
!define PRODUCT_WEB_SITE "http://shifenbianmin.com.cn/"
!define PRODUCT_NAME "365Desktop"
!define PRODUCT_UNINST_KEY "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT_NAME}"
!define PRODUCT_UNINST_ROOT_KEY "HKLM"

;���ӵ�ǰ���Ŀ¼
!AddPluginDir "Plugins"
;���ӵ�ǰͷ�ļ�Ŀ¼
!AddIncludeDir "Include"

#ѹ������
SetCompressorDictSize 32
SetCompressor /solid lzma
SetCompress force

;�����Ƿ�� XP �����ӵ���װ������
XPStyle on

#MUI�ִ����涨��(1.67�汾���ϼ���)
!include "MUI2.nsh"
!include "WinCore.nsh"
!include "FileFunc.nsh"
!include "nsWindows.nsh"
!include "LoadRTF.nsh"
!include "WinMessages.nsh"
!include "WordFunc.nsh"


!define MUI_CUSTOMFUNCTION_GUIINIT onGUIInit

;�Զ������
Page custom WelcomePage
Page custom DirectoryPage
Page custom InstallationPage
Page custom CompletePage

UninstPage custom un.Instpage1
UninstPage custom un.Instpage2


;��װ������������
!insertmacro MUI_LANGUAGE "SimpChinese"

;��װ���ļ��汾����
VIProductVersion "1.0.0.0"
VIAddVersionKey /LANG=2052 "ProductName" "365��������"
VIAddVersionKey /LANG=2052 "Comments" "www.shifenbianmin.com.cn"
VIAddVersionKey /LANG=2052 "CompanyName" "www.shifenbianmin.com.cn"
VIAddVersionKey /LANG=2052 "LegalTrademarks" "www.shifenbianmin.com.cn"
VIAddVersionKey /LANG=2052 "LegalCopyright" "www.shifenbianmin.com.cn"
VIAddVersionKey /LANG=2052 "FileDescription" "www.shifenbianmin.com.cn"
VIAddVersionKey /LANG=2052 "FileVersion" "1.0.0.0"

;Ӧ�ó�����ʾ����
Name "365��������"
;Ӧ�ó������·��
OutFile "${OUTFILE_NAME}"
InstallDir "$PROGRAMFILES\${PRODUCT_FOLDER}"

;���Ȩ��
RequestExecutionLevel admin

;ж��ǰ����ͼƬ�ĳ�ʼ������
Function un.Image_Init_Func
	InitPluginsDir
	SetOutPath "$PLUGINSDIR"
	File /r "Plugins\*.*"
	File /r "Images\*.*"

	;����ͼƬ
	SkinBtn::Init "$PLUGINSDIR\close_btn.bmp"
	SkinBtn::Init "$PLUGINSDIR\min_btn.bmp"
	SkinBtn::Init "$PLUGINSDIR\checkbox_btn.bmp"
	SkinBtn::Init "$PLUGINSDIR\checkedbox_btn.bmp"

	;����һͼƬ
	SkinBtn::Init "$PLUGINSDIR\oneclickinst_btn.bmp"
	SkinBtn::Init "$PLUGINSDIR\custominst_btn.bmp"
	SkinBtn::Init "$PLUGINSDIR\xuke_btn.bmp"

	;�����ͼƬ
	SkinBtn::Init "$PLUGINSDIR\changedir_btn.bmp"
	SkinBtn::Init "$PLUGINSDIR\backup_btn.bmp"

	;������ͼƬ
	SkinBtn::Init "$PLUGINSDIR\msty_btn.bmp"
	SkinBtn::Init "$PLUGINSDIR\qd_btn.bmp"

FunctionEnd

;��װǰ����ͼƬ�ĳ�ʼ������
Function Image_Init_Func
	InitPluginsDir
	SetOutPath "$PLUGINSDIR"
	File /r "Plugins\*.*"
	File /r "Images\*.*"

	;����ͼƬ
	SkinBtn::Init "$PLUGINSDIR\close_btn.bmp"
	SkinBtn::Init "$PLUGINSDIR\min_btn.bmp"
	SkinBtn::Init "$PLUGINSDIR\checkbox_btn.bmp"
	SkinBtn::Init "$PLUGINSDIR\checkedbox_btn.bmp"

	;����һͼƬ
	SkinBtn::Init "$PLUGINSDIR\oneclickinst_btn.bmp"
	SkinBtn::Init "$PLUGINSDIR\custominst_btn.bmp"
	SkinBtn::Init "$PLUGINSDIR\xuke_btn.bmp"

	;�����ͼƬ
	SkinBtn::Init "$PLUGINSDIR\changedir_btn.bmp"
	SkinBtn::Init "$PLUGINSDIR\backup_btn.bmp"

	;������ͼƬ
	SkinBtn::Init "$PLUGINSDIR\msty_btn.bmp"
	SkinBtn::Init "$PLUGINSDIR\qd_btn.bmp"
FunctionEnd

;�ж�����
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

;��ȡip
Function GetIp
	Ip::get_ip
	Pop $R0
	StrCpy $IpAddress $R0 -1  ;��ȥ�õ���IP��ߵ�";"��(�õ���IP��ʽΪ,����: 172.16.16.217;)
FunctionEnd

;��ȡip
Function un.GetIp
	Ip::get_ip
	Pop $R0
	StrCpy $IpAddress $R0 -1  ;��ȥ�õ���IP��ߵ�";"��(�õ���IP��ʽΪ,����: 172.16.16.217;)
FunctionEnd

;��ȡmac
Function GetMac
	System::Call Iphlpapi::GetAdaptersInfo(i,*i.r0)
	System::Alloc $0
	Pop $1
	System::Call Iphlpapi::GetAdaptersInfo(ir1r2,*ir0)i.r0
	StrCmp $0 0 0 finish
loop:
	StrCmp $2 0 finish
	System::Call '*$2(i.r2,i,&t260.s,&t132.s,i.r5)i.r0' ;Unicode�潫t��Ϊm
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

;��ȡmac
Function un.GetMac
	System::Call Iphlpapi::GetAdaptersInfo(i,*i.r0)
	System::Alloc $0
	Pop $1
	System::Call Iphlpapi::GetAdaptersInfo(ir1r2,*ir0)i.r0
	StrCmp $0 0 0 finish
loop:
	StrCmp $2 0 finish
	System::Call '*$2(i.r2,i,&t260.s,&t132.s,i.r5)i.r0' ;Unicode�潫t��Ϊm
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

;������װ�����֣��������ֵĲ�ͬ����ʵ�ֲ�ͬ�İ�װ����
Function WordFile
	;ͳ�������ĸ�������from�ֶΣ��ݶ���������װ����setup_sina.exe��ȡ��sina��¼Ϊ������
	${WordFind} $EXEFILE "." -2 $R0  ; ��ǰִ�а�װ�����ļ���$EXEFILE
	${WordFind} $R0 "_" -1 $R1  ; ${WordFind}��Ҫ����WordFunc.nsh��-1��ʾ��"_"�ָ�����ƥ��ĵ�һ�����
	StrCpy $From $R1

	;�ж������Ƿ�ж��ʱ�����������װ����������"_push"��Ϊ����
	${WordFind} $EXEFILE "_push" "*" $R0
	${If} $R0 == 1
	  StrCpy $IsPush 1
	${EndIf}

	;��Ĭ��װ�ж�������ļ����жϵ����һ������������������������ж�
	;�ж������Ƿ�Ĭ��װ����װ����������"_setup"��Ϊ��Ĭ
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

  ;�������Ƿ����� ��Ҫ���NSIS/Plugins/FindProcDLL.dll
  FindProcDLL::FindProc "365Desktop.exe"
	Pop $R0
	IntCmp $R0 1 0 go1
	MessageBox MB_ICONSTOP "ж�س����⵽ ${PRODUCT_NAME} �������У���ر�֮����ж�أ�"
	Quit
go1:

  ;���ط���˵������ļ�
	inetc::get /silent "http://shifenbianmin.com.cn/unTask1.ini" "$PLUGINSDIR\unTask1.ini"

	GetFunctionAddress $0 un.Image_Init_Func
	Call $0

FunctionEnd

Function .onInit

;���������ֹ�ظ�����
System::Call 'kernel32::CreateMutexA(i 0, i 0, t "WinSnap_installer") i .r1 ?e'
Pop $R0
StrCmp $R0 0 +3
  MessageBox MB_OK|MB_ICONEXCLAMATION "��һ����װ���Ѿ����У�"
  Abort

	GetFunctionAddress $0 Image_Init_Func
	Call $0
	
;ͨ��ע����ж��Ƿ��ظ���װ��
ReadRegDWORD $0 ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayVersion"
${If} $0 > 0
  ;MessageBox MB_OK|MB_ICONEXCLAMATION "�ظ���װ��"
  Abort
${EndIf}
	
;��ȡ�û�����Ŀ¼����Ϊ��װĿ¼����ʱ����û�Ȩ������
ReadEnvStr $R0 "userprofile"
StrCpy $INSTDIR "$R0\${PRODUCT_FOLDER}"

Call ConnectInternet  ;�ж�����
Call GetIp            ;��ȡip
Call GetMac           ;��ȡmac

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;���߰�����;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	Delete "$TEMP\Bin.7z"
	SetOutPath "$TEMP"
	File "OffLine\Bin.7z"
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;���߰�����;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Call WordFile         ;�жϰ�װ������ʵ�ֲ�ͬ�Ĳ��裬ע���ڽ�ѹBin.7z֮��

FunctionEnd

Function un.onGUIInit
    ;�����߿�
    System::Call `user32::SetWindowLong(i$HWNDPARENT,i${GWL_STYLE},0x9480084C)i.R0`
    ;����һЩ���пؼ�
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
    ;�����߿�
    System::Call `user32::SetWindowLong(i$HWNDPARENT,i${GWL_STYLE},0x9480084C)i.R0`
    ;����һЩ���пؼ�
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
    
	;�����Ӱ����ע�͵���Ϊ���н��治һ����С
;	System::Call 'user32::GetClassLong(i,i) i ($HwndParent,-26) .s'
;	Pop $R0
;	System::Call 'user32::SetClassLong(i,i,i) i ($HwndParent,-26,$R0|0x20000) .s'
;	Pop $R0
    
FunctionEnd


;�����ޱ߿��ƶ�
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

;��С����ť
Function un.Min_Btn_Func
    SendMessage $HWNDPARENT ${WM_SYSCOMMAND} ${SC_MINIMIZE} 0
FunctionEnd

Function Min_Btn_Func
    SendMessage $HWNDPARENT ${WM_SYSCOMMAND} ${SC_MINIMIZE} 0
FunctionEnd

;�رհ�ť
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

;��һ����ť(�Զ��尲װ)
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

;һ����װ��ť
Function un.OneClickInst_Btn_Func
  StrCpy $R9 2 ;Goto the next page
  Call un.RelGotoPage
  Abort
FunctionEnd

Function OneClickInst_Btn_Func

		;WriteRegStr HKCU Software\Microsoft\Windows\CurrentVersion\Run Shell "$INSTDIR\${PROGRAM_NAME}"
		; "���ÿ�������ok"
		WriteRegStr HKCU Software\Microsoft\Windows\CurrentVersion\Run Shell "$DESKTOP\${PRODUCT_LNK}.lnk"

		; "������ҳok"
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

;����ҳ����ת������
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
        StrCpy $1 $0 1 -1   ;���һλ
        StrCpy $2 $0 2 -3   ;��������λ�͵ڶ�λ
        StrCpy $0 $0 -3     ;ǰ��λ��
        ${IfThen} $0 == "" ${|} StrCpy $0 0 ${|}
        ${If} $1 >= 5   ;��������, ����С�������λ
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


#Ƥ����ͼ����
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

;��ѡ�����ť
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

;��ѡ������ť
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


;��ѡ��һ��ť
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

;��ѡ�����ť
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

;��ѡ������ť
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



;��ɰ�ť
Function XuKe_Btn_Func
	ExecShell "open" "http://www.shifenbianmin.com.cn"
FunctionEnd


Function WelcomePage
    ;����������ť
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
    SetCtlColors $0 ""  transparent ;�������͸��

    ${NSW_SetWindowSize} $HWNDPARENT 600 370 ;�ı䴰���С
    ${NSW_SetWindowSize} $0 600 370 ;�ı�Page��С

    ;��С����ť
    ${NSD_CreateButton} 550 8 17 17 ""
    Pop $Min_Btn_Var
    StrCpy $1 $Min_Btn_Var
    Call SkinBtn_Min
    GetFunctionAddress $3 Min_Btn_Func
    SkinBtn::onClick $1 $3

    ;�رհ�ť
    ${NSD_CreateButton} 575 10 17 17 ""
    Pop $Close_Btn_Var
    StrCpy $1 $Close_Btn_Var
    Call SkinBtn_Close
    GetFunctionAddress $3 Close_Btn_Func
    SkinBtn::onClick $1 $3

    ;������װ��ť
    ${NSD_CreateButton} 220 273 160 48 ""
    Pop $OneClickInst_Btn_Var
    StrCpy $1 $OneClickInst_Btn_Var
    Call SkinBtn_OneClickInst
    GetFunctionAddress $3 OneClickInst_Btn_Func
    SkinBtn::onClick $1 $3

    ;�Զ��尲װ��ť
    ${NSD_CreateButton} 499 346 101 24 ""
    Pop $CustomInst_Btn_Var
    StrCpy $1 $CustomInst_Btn_Var
    Call SkinBtn_CustomInst
    GetFunctionAddress $3 CustomInst_Btn_Func
    SkinBtn::onClick $1 $3

    ;��ѡ��ť
    ${NSD_CreateButton} 220 333 15 15 ""
    Pop $CheckBox1_Btn_Var
    StrCpy $1 $CheckBox1_Btn_Var
    Call SkinBtn_CheckedBox
    GetFunctionAddress $3 CheckBox1_Btn_Func
    SkinBtn::onClick $1 $3
    StrCpy $CheckBox1_Bool 1

	;������Ϣ
	${NSD_CreateLabel} 238 334 100 18 "�����Ķ���ͬ��"
	Pop $R0
	SetCtlColors $R0 0X000000 0XFFFFFF ;�������͸��
	CreateFont $HEADLINE_FONT "$(^Font)" "10" "0"
	SendMessage $R0 ${WM_SETFONT} $HEADLINE_FONT 0

    ;��ɰ�ť
    ${NSD_CreateButton} 334 331 60 18 ""
    Pop $XuKe_Btn_Var
    StrCpy $1 $XuKe_Btn_Var
    Call SkinBtn_XuKe
    GetFunctionAddress $3 XuKe_Btn_Func
    SkinBtn::onClick $1 $3


    ;��������ͼ
    ${NSD_CreateBitmap} 0 0 100% 100% ""
    Pop $BGImage
    ${NSD_SetImage} $BGImage $PLUGINSDIR\bg2.bmp $ImageHandle

    LockWindow  off
	GetFunctionAddress $0 onGUICallback
	WndProc::onCallback $BGImage $0 ;�����ޱ߿����ƶ�
	nsDialogs::Show
	${NSD_FreeImage} $ImageHandle


FunctionEnd


;����Ŀ¼�¼�
Function OnChange_DirRequest
	Pop $0
	System::Call "user32::GetWindowText(i $Txt_Browser,t.r0,i${NSIS_MAX_STRLEN})"
	StrCpy $INSTDIR $0

	StrCpy "$R1" "$INSTDIR" 3
    ${DriveSpace} "$R1" "/D=F /S=B" $Freesize
    ${ConvertByte} "$Freesize" "$Freesize"
    SendMessage $label_free2 ${WM_SETTEXT} 0 "STR:���ÿռ䣺$Freesize"
    System::Call "user32::InvalidateRect(i $hwndparent,i0,i 1)"
    
    ;�жϰ�װ·�����Ƿ������ģ������Զ���Hello.dll
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

  nsDialogs::SelectFolderDialog "��ѡ�� $R0 ��װ���ļ���:" "$R0"
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
;�õ�ѡ��Ŀ¼����ƴ�Ӱ�װ��������
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
;��ȡѡ��Ŀ¼
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
    ;����������ť
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
    SetCtlColors $0 ""  transparent ;�������͸��

    ${NSW_SetWindowSize} $HWNDPARENT 600 370 ;�ı䴰���С
    ${NSW_SetWindowSize} $0 600 370 ;�ı�Page��С

    ;��С����ť
    ${NSD_CreateButton} 550 8 17 17 ""
    Pop $Min_Btn_Var
    StrCpy $1 $Min_Btn_Var
    Call SkinBtn_Min
    GetFunctionAddress $3 Min_Btn_Func
    SkinBtn::onClick $1 $3

    ;�رհ�ť
    ${NSD_CreateButton} 575 10 17 17 ""
    Pop $Close_Btn_Var
    StrCpy $1 $Close_Btn_Var
    Call SkinBtn_Close
    GetFunctionAddress $3 Close_Btn_Func
    SkinBtn::onClick $1 $3

    ;������װ��ť
    ${NSD_CreateButton} 220 319 160 48 "" 
    Pop $OneClickInst_Btn_Var
    StrCpy $1 $OneClickInst_Btn_Var
    Call SkinBtn_OneClickInst
    GetFunctionAddress $3 My_CustomInst_Btn_Func
    SkinBtn::onClick $1 $3

    ;��ѡ��ť
;    ${NSD_CreateButton} 305 286 15 15 ""
;    Pop $CheckBox1_Btn_Var
;    StrCpy $1 $CheckBox1_Btn_Var
;    Call SkinBtn_CheckedBox
;    GetFunctionAddress $3 CheckBox1_Btn_Func
;    SkinBtn::onClick $1 $3
;    StrCpy $CheckBox1_Bool 1

	;������Ϣ
;	${NSD_CreateLabel} 323 287 100 18 "�����Ķ���ͬ��"
;	Pop $R0
;	SetCtlColors $R0 0X000000 0XFFFFFF ;�������͸��
;	CreateFont $HEADLINE_FONT "$(^Font)" "10" "0"
;	SendMessage $R0 ${WM_SETFONT} $HEADLINE_FONT 0


	;������Ϣ
;	${NSD_CreateLabel} 116 287 150 18 ""
;	Pop $label_free2
;	SetCtlColors $label_free2 0X000000 0XFFFFFF ;�������͸��
;	CreateFont $HEADLINE_FONT "$(^Font)" "10" "0"
;	SendMessage $label_free2 ${WM_SETFONT} $HEADLINE_FONT 0

;	StrCpy "$R1" "$INSTDIR" 3
;    ${DriveSpace} "$R1" "/D=F /S=B" $Freesize
;    ${ConvertByte} "$Freesize" "$Freesize"
;    SendMessage $label_free2 ${WM_SETTEXT} 0 "STR:���ÿռ䣺$Freesize"


    ;��ɰ�ť
;    ${NSD_CreateButton} 419 284 60 18 ""
;    Pop $XuKe_Btn_Var
;    StrCpy $1 $XuKe_Btn_Var
;    Call SkinBtn_XuKe
;    GetFunctionAddress $3 XuKe_Btn_Func
;    SkinBtn::onClick $1 $3

  ;��ѡ��ť
  ${NSD_CreateButton} 105 294 15 15 ""    ;left,top,w,h
  Pop $CheckBox2_Btn_Var
  StrCpy $1 $CheckBox2_Btn_Var
  Call SkinBtn_CheckedBox
  GetFunctionAddress $3 CheckBox2_Btn_Func
  SkinBtn::onClick $1 $3
  StrCpy $CheckBox2_Bool 1
    
    ;������Ϣ
		${NSD_CreateLabel} 125 294 120 18 "�����Զ�����"
		Pop $R0
		SetCtlColors $R0 0X000000 0XFFFFFF ;�������͸��
		CreateFont $HEADLINE_FONT "$(^Font)" "10" "0"
		SendMessage $R0 ${WM_SETFONT} $HEADLINE_FONT 0
		
	;��ѡ��ť
;  ${NSD_CreateButton} 295 294 15 15 ""
;  Pop $CheckBox3_Btn_Var
;  StrCpy $1 $CheckBox3_Btn_Var
;  Call SkinBtn_CheckedBox
;  GetFunctionAddress $3 CheckBox3_Btn_Func
;  SkinBtn::onClick $1 $3
;  StrCpy $CheckBox3_Bool 1
  
  	;������Ϣ
;		${NSD_CreateLabel} 315 294 120 18 "����hao123Ϊ��ҳ"
;		Pop $R0
;		SetCtlColors $R0 0X000000 0XFFFFFF ;�������͸��
;		CreateFont $HEADLINE_FONT "$(^Font)" "10" "0"
;		SendMessage $R0 ${WM_SETFONT} $HEADLINE_FONT 0

	;������Ϣ
	${NSD_CreateLabel} 53 256 53 18 "��װ��:"
	Pop $R0
	SetCtlColors $R0 0X000000 0XFFFFFF ;�������͸��
	CreateFont $HEADLINE_FONT "$(^Font)" "10" "0"
	SendMessage $R0 ${WM_SETFONT} $HEADLINE_FONT 0

	;��װĿ¼
    ${NSD_CreateDirRequest} 107 254 367 23 "$INSTDIR"
 	Pop	$Txt_Browser
 	${NSD_OnChange} $Txt_Browser OnChange_DirRequest
	SetCtlColors $Txt_Browser 0X000000 0XFFFFFF ;�������͸��
	CreateFont $HEADLINE_FONT "$(^Font)" "10" "0"
	SendMessage $Txt_Browser ${WM_SETFONT} $HEADLINE_FONT 0

    ;����Ŀ¼��ť
    ${NSD_CreateButton} 489 255 76 23 ""
    Pop $ChangeDir_Btn_Var
    StrCpy $1 $ChangeDir_Btn_Var
    Call SkinBtn_ChangeDir
    GetFunctionAddress $3 OnClick_BrowseButton
    SkinBtn::onClick $1 $3

    ;��һ����װ��ť
    ${NSD_CreateButton} 499 346 101 24 ""
    Pop $BackUp_Btn_Var
    StrCpy $1 $BackUp_Btn_Var
    Call SkinBtn_BackUP
    GetFunctionAddress $3 BackUp_Btn_Func
    SkinBtn::onClick $1 $3

    ;��������ͼ
    ${NSD_CreateBitmap} 0 0 100% 100% ""
    Pop $BGImage
    ${NSD_SetImage} $BGImage $PLUGINSDIR\bg2.bmp $ImageHandle

    LockWindow  off
	GetFunctionAddress $0 onGUICallback
	WndProc::onCallback $BGImage $0 ;�����ޱ߿����ƶ�
	nsDialogs::Show
	${NSD_FreeImage} $ImageHandle

FunctionEnd


Function NSD_TimerFun
    GetFunctionAddress $0 NSD_TimerFun
    nsDialogs::KillTimer $0
    !if 1   ;�Ƿ��ں�̨����,1��Ч
        GetFunctionAddress $0 InstallationMainFun
        BgWorker::CallAndWait
    !else
        Call InstallationMainFun
    !endif
FunctionEnd


Function InstallationMainFun
	;�����ļ���(·��Ϊ��ѡ��)д��ж�س���
	WriteUninstaller "$INSTDIR\uninst.exe"

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;���߰�����;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;û���Զ�����
;SendMessage $PB_ProgressBar ${PBM_SETPOS} 10 0
;go1:
;	NSISdl::download_quiet "http://apkku.qiniudn.com/Bin.7z" "$TEMP\Bin.7z"
;	Pop $R0
;	StrCmp $R0 "success" go2
;	MessageBox MB_RETRYCANCEL "����ʧ�ܣ�������������." IDRETRY go1
;	Quit
;go2:
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;���߰�����;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;ʹ���Զ�����
;����������ʾ
;${NSD_SetText} $Lbl_Sumary "�������أ����Ժ򡭡�"
;�������ؽ�������ʾ����
;DownPro::get /hwnd $PPercent /hwnd2 $PPercent /probar $PB_ProgressBar /caption " " /popup "" "http://apkku.qiniudn.com/Bin.7z" "$TEMP\Bin.7z" /end
;Pop $0
;${If} $0 == "Transfer Error"
;	MessageBox MB_ICONINFORMATION|MB_OK "���س���"
;	Call Close_Btn_Func
;	Abort
;${ELSEIF} $0 == "SendRequest Error"
;	MessageBox MB_ICONINFORMATION|MB_OK "���س���"
;	Call Close_Btn_Func
;	Abort
;${ELSE}
;	System::Call "user32::InvalidateRect(i $hwndparent,i0,i 1)"
;${EndIf}
;����������ʾ
;${NSD_SetText} $Lbl_Sumary "���ڰ�װ�����Ժ򡭡�"
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;���߰�����;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	SetOutPath $INSTDIR
	SetOverwrite on
	GetFunctionAddress $R9 Callback
	Nsis7z::ExtractWithCallback "$TEMP\Bin.7z" $R9
	Delete "$TEMP\Bin.7z"

FunctionEnd


;��װ������
Function Callback
  Pop $R8
  Pop $R9
  System::Int64Op $R8 * 100
  Pop $R0
  System::Int64Op $R0 / $R9
  Pop $R3
  SendMessage $PB_ProgressBar ${PBM_SETPOS} $R3 0

  #${NSD_SetText} $Lbl_Sumary "�Ѿ���װ$R3%"
  ${NSD_SetText} $PPercent "$R3%"


  ${if} $R8 = $R9
  ${NSD_SetText} $Lbl_Sumary "��װ���"
  ShowWindow $PPercent ${SW_HIDE}
  SendMessage $PB_ProgressBar ${PBM_SETPOS} 100 0
  #System::Call "user32::InvalidateRect(i$hwndparent,i0,i 1)"
  call CustomInst_Btn_Func
  ${endif}
FunctionEnd


Function InstallationPage
    ;����������ť
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
    SetCtlColors $0 ""  transparent ;�������͸��

    ${NSW_SetWindowSize} $HWNDPARENT 600 300 ;�ı䴰���С
    ${NSW_SetWindowSize} $0 600 300 ;�ı�Page��С

    ;��С����ť
    ${NSD_CreateButton} 550 8 17 17 ""
    Pop $Min_Btn_Var
    StrCpy $1 $Min_Btn_Var
    Call SkinBtn_Min
    GetFunctionAddress $3 Min_Btn_Func
    SkinBtn::onClick $1 $3

    ;�رհ�ť
    ${NSD_CreateButton} 575 10 17 17 ""
    Pop $Close_Btn_Var
    StrCpy $1 $Close_Btn_Var
    Call SkinBtn_Close
    GetFunctionAddress $3 Close_Btn_Func
    SkinBtn::onClick $1 $3

    ;������
    ${NSD_CreateProgressBar} 1 229 598 8 "" ;0 229 601 8 ""
    Pop $PB_ProgressBar
    SkinProgress::Set $PB_ProgressBar "$PLUGINSDIR\loading2.bmp" "$PLUGINSDIR\loading1.bmp"
    GetFunctionAddress $0 NSD_TimerFun
    nsDialogs::CreateTimer $0 1

    ;��������ͼ
    ${NSD_CreateBitmap} 0 0 100% 100% ""
    Pop $BGImage
    ${NSD_SetImage} $BGImage $PLUGINSDIR\bg3.bmp $ImageHandle

    LockWindow  off
	GetFunctionAddress $0 onGUICallback
	WndProc::onCallback $BGImage $0 ;�����ޱ߿����ƶ�
	nsDialogs::Show
	${NSD_FreeImage} $ImageHandle

FunctionEnd

Function MSTY_Btn_Func
	HideWindow
	
	;ͳ��http://desktop.xinchuanbo.cn/api/desktop.php?mac=%s&ip=%s&action=add&version=v1.0&from=sina
	;inetc::post "" /noproxy /silent "http://desktop.xinchuanbo.cn/api/desktop.php?mac=$MacAddress&ip=$IpAddress&action=add&version=v${PRODUCT_VERSION}&from=$From" $R0 ;"$PLUGINSDIR\reply.htm"
	inetc::post "" /noproxy /silent "http://desktop.xinchuanbo.cn/sadmin/desktopdata.php?oper=set&&mac=$MacAddress&&version=v${PRODUCT_VERSION}&&source=$From&&isOnline=0" $R0 ;"$PLUGINSDIR\reply.htm"

	;ע������
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayName" "$(^Name)"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "UninstallString" "$INSTDIR\uninst.exe"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayVersion" "${PRODUCT_VERSION}"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "URLInfoAbout" "${PRODUCT_WEB_SITE}"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "Publisher" "${PRODUCT_PUBLISHER}"
  ${If} $IsPush == 1
    WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "Push" 1 ;�Ƿ���ж��ʱ�������
	${EndIf}
	WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "sour" $From ;sour  ��Դ ��¼������
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;����/���߰�����;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "isOnline" 0 ;isOnline 1:���� 0������
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;����/���߰�����;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	
	WriteUninstaller "$INSTDIR\uninst.exe"
	
	;������ʼλ�ã��Դ�����ݷ�ʽ����Ҫ
	SetOutPath "$INSTDIR\Bin\Release"
	
	;�����ݷ�ʽ
	;CreateShortCut "$DESKTOP\365����.lnk" "$INSTDIR\${PROGRAM_NAME}"
	CreateShortCut "$DESKTOP\${PRODUCT_LNK}.lnk" "$INSTDIR\Bin\Release\365Desktop.exe"
	
	;����������
	;CreateShortCut "$QUICKLAUNCH\365����.lnk" "$INSTDIR\${PROGRAM_NAME}"
	CreateShortCut "$QUICKLAUNCH\${PRODUCT_LNK}.lnk" "$INSTDIR\Bin\Release\365Desktop.exe"
	;ExecShell taskbarpin "$DESKTOP\${PRODUCT_LNK}.lnk"
	
	;��ʼ�˵�
	;SetOutPath "$INSTDIR"
	CreateDirectory "$SMPROGRAMS\${PRODUCT_LNK}"
	;CreateShortCut "$SMPROGRAMS\365����\365����.lnk" "$INSTDIR\${PROGRAM_NAME}"
	CreateShortCut "$SMPROGRAMS\${PRODUCT_LNK}\${PRODUCT_LNK}.lnk" "$INSTDIR\Bin\Release\365Desktop.exe"
	CreateShortCut "$SMPROGRAMS\${PRODUCT_LNK}\ж��${PRODUCT_LNK}.lnk" "$INSTDIR\uninst.exe"
	
	
	;����������
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
    ;����������ť
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
    SetCtlColors $0 ""  transparent ;�������͸��

    ${NSW_SetWindowSize} $HWNDPARENT 600 370 ;�ı䴰���С
    ${NSW_SetWindowSize} $0 600 370 ;�ı�Page��С

    ;��С����ť
    ${NSD_CreateButton} 550 8 17 17 ""
    Pop $Min_Btn_Var
    StrCpy $1 $Min_Btn_Var
    Call SkinBtn_Min
    GetFunctionAddress $3 Min_Btn_Func
    SkinBtn::onClick $1 $3

    ;�رհ�ť
    ${NSD_CreateButton} 575 10 17 17 ""
    Pop $Close_Btn_Var
    StrCpy $1 $Close_Btn_Var
    Call SkinBtn_Close
    GetFunctionAddress $3 Close_Btn_Func
    SkinBtn::onClick $1 $3
    EnableWindow $Close_Btn_Var 0

    ;��ѡ��ť
;    ${NSD_CreateButton} 235 274 15 15 ""
;    Pop $CheckBox2_Btn_Var
;    StrCpy $1 $CheckBox2_Btn_Var
;    Call SkinBtn_CheckedBox
;    GetFunctionAddress $3 CheckBox2_Btn_Func
;    SkinBtn::onClick $1 $3
;    StrCpy $CheckBox2_Bool 1

	;������Ϣ
;	${NSD_CreateLabel} 255 274 200 18 "�����Զ�����"
;	Pop $R0
;	SetCtlColors $R0 0X000000 0XFFFFFF ;�������͸��
;	CreateFont $HEADLINE_FONT "$(^Font)" "10" "0"
;	SendMessage $R0 ${WM_SETFONT} $HEADLINE_FONT 0

    ;��ѡ��ť
    ${NSD_CreateButton} 235 296 15 15 ""
    Pop $CheckBox3_Btn_Var
    StrCpy $1 $CheckBox3_Btn_Var
    Call SkinBtn_CheckedBox
    GetFunctionAddress $3 CheckBox3_Btn_Func
    SkinBtn::onClick $1 $3
    StrCpy $CheckBox3_Bool 1

	;������Ϣ
	${NSD_CreateLabel} 255 296 200 18 "����hao123Ϊ��ҳ"
	Pop $R0
	SetCtlColors $R0 0X000000 0XFFFFFF ;�������͸��
	CreateFont $HEADLINE_FONT "$(^Font)" "10" "0"
	SendMessage $R0 ${WM_SETFONT} $HEADLINE_FONT 0

    ;�������а�ť
    ${NSD_CreateButton} 220 319 160 48 ""
    Pop $MSTY_Btn_Var
    StrCpy $1 $MSTY_Btn_Var
    Call SkinBtn_MSTY
    GetFunctionAddress $3 MSTY_Btn_Func
    SkinBtn::onClick $1 $3


	;������Ϣ
	${NSD_CreateLabel} 247 262 100 30 "��װ���"  ;247 242 100 30 "��װ���"
	Pop $R0
	SetCtlColors $R0 0X000000 0XFFFFFF ;�������͸��
	CreateFont $HEADLINE_FONT "$(^Font)" "17" "0"
	SendMessage $R0 ${WM_SETFONT} $HEADLINE_FONT 0


    ;��������ͼ
    ${NSD_CreateBitmap} 0 0 100% 100% ""
    Pop $BGImage
    ${NSD_SetImage} $BGImage $PLUGINSDIR\bg2.bmp $ImageHandle

    LockWindow  off
	GetFunctionAddress $0 onGUICallback
	WndProc::onCallback $BGImage $0 ;�����ޱ߿����ƶ�
	nsDialogs::Show
	${NSD_FreeImage} $ImageHandle


FunctionEnd


Function un.NSD_TimerFun
    GetFunctionAddress $0 un.NSD_TimerFun
    nsDialogs::KillTimer $0
    !if 1   ;�Ƿ��ں�̨����,1��Ч
        GetFunctionAddress $0 un.InstallationMainFun
        BgWorker::CallAndWait
    !else
        Call un.InstallationMainFun
    !endif
FunctionEnd


Function un.InstallationMainFun

    KillProcDLL::KillProc "365riliClient.exe"

    SendMessage $PB_ProgressBar ${PBM_SETRANGE32} 0 100  ;�ܲ���Ϊ��������ֵ
	SendMessage $PB_ProgressBar ${PBM_SETPOS} 10 0
    Sleep 500
	SendMessage $PB_ProgressBar ${PBM_SETPOS} 20 0
    Sleep 500
	SendMessage $PB_ProgressBar ${PBM_SETPOS} 30 0
    Sleep 500
    

    ;ExecShell taskbarunpin "$DESKTOP\${PRODUCT_LNK}.lnk"
    RMDir /r "$SMPROGRAMS\${PRODUCT_LNK}"
    Delete "$DESKTOP\${PRODUCT_LNK}.lnk"

    ; ж�ذ�װĿ¼
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
    ;����������ť
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
    SetCtlColors $0 ""  transparent ;�������͸��

    ${NSW_SetWindowSize} $HWNDPARENT 600 300 ;�ı䴰���С
    ${NSW_SetWindowSize} $0 600 300 ;�ı�Page��С

    ;��С����ť
    ${NSD_CreateButton} 550 8 17 17 ""
    Pop $Min_Btn_Var
    StrCpy $1 $Min_Btn_Var
    Call un.SkinBtn_Min
    GetFunctionAddress $3 un.Min_Btn_Func
    SkinBtn::onClick $1 $3

    ;�رհ�ť
    ${NSD_CreateButton} 575 10 17 17 ""
    Pop $Close_Btn_Var
    StrCpy $1 $Close_Btn_Var
    Call un.SkinBtn_Close
    GetFunctionAddress $3 un.Close_Btn_Func
    SkinBtn::onClick $1 $3

    ;������
    ${NSD_CreateProgressBar} 1 229 598 8 ""
    Pop $PB_ProgressBar
    SkinProgress::Set $PB_ProgressBar "$PLUGINSDIR\loading2.bmp" "$PLUGINSDIR\loading1.bmp"
    GetFunctionAddress $0 un.NSD_TimerFun
    nsDialogs::CreateTimer $0 1

    ;��������ͼ
    ${NSD_CreateBitmap} 0 0 100% 100% ""
    Pop $BGImage
    ${NSD_SetImage} $BGImage $PLUGINSDIR\bg4.bmp $ImageHandle

    LockWindow  off
	GetFunctionAddress $0 un.onGUICallback
	WndProc::onCallback $BGImage $0 ;�����ޱ߿����ƶ�
	nsDialogs::Show
	${NSD_FreeImage} $ImageHandle

FunctionEnd


Function un.QD_Btn_Func

    HideWindow
Call un.GetIp            ;��ȡip
Call un.GetMac           ;��ȡmac

  ;ͳ��http://desktop.xinchuanbo.cn/api/desktop.php?mac=%s&ip=%s&action=del&version=v1.0
	;inetc::post "" /noproxy /silent "http://desktop.xinchuanbo.cn/api/desktop.php?mac=$MacAddress&ip=$IpAddress&action=del&version=v${PRODUCT_VERSION}" $R0 ;"$PLUGINSDIR\reply.htm"
	;desktop.xinchuanbo.cn/sadmin/desktopdata.php?oper=unis&&mac=&&version=&&time=���µ�����
	inetc::post "" /noproxy /silent "http://desktop.xinchuanbo.cn/sadmin/desktopdata.php?oper=unis&&mac=$MacAddress&&version=v${PRODUCT_VERSION}" $R0 ;"$PLUGINSDIR\reply.htm"

	;ɾ��ע���ע���ֵ
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
    ;����������ť
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
    SetCtlColors $0 ""  transparent ;�������͸��

    ${NSW_SetWindowSize} $HWNDPARENT 600 370 ;�ı䴰���С
    ${NSW_SetWindowSize} $0 600 370 ;�ı�Page��С

    ;��С����ť
    ${NSD_CreateButton} 550 8 17 17 ""
    Pop $Min_Btn_Var
    StrCpy $1 $Min_Btn_Var
    Call un.SkinBtn_Min
    GetFunctionAddress $3 un.Min_Btn_Func
    SkinBtn::onClick $1 $3

    ;�رհ�ť
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
    ;��ѡ��ť
    ;${NSD_CreateButton} 105 274 15 15 ""
    ${NSD_CreateButton} 95 274 15 15 ""
    Pop $CheckBox1_Btn_Var
    StrCpy $1 $CheckBox1_Btn_Var
    Call un.SkinBtn_CheckedBox
    GetFunctionAddress $3 un.CheckBox1_Btn_Func
    SkinBtn::onClick $1 $3
    StrCpy $CheckBox1_Bool 1

 	ReadINIStr $R1 "$PLUGINSDIR\unTask1.ini" "Field 3" "Text"
	;������Ϣ
	;${NSD_CreateLabel} 127 274 100 18 $R1 ;"�������"
	StrCmp $1 "" +2
	${NSD_CreateLabel} 117 274 120 18 $R1 ;"�������"
	${NSD_CreateLabel} 117 274 120 18 "��װ�ٶ�ɱ��"
	Pop $R0
	SetCtlColors $R0 0X000000 0XFFFFFF ;�������͸��
	CreateFont $HEADLINE_FONT "$(^Font)" "10" "0"
	SendMessage $R0 ${WM_SETFONT} $HEADLINE_FONT 0

    ;��ѡ��ť
    ${NSD_CreateButton} 255 274 15 15 ""
    Pop $CheckBox2_Btn_Var
    StrCpy $1 $CheckBox2_Btn_Var
    Call un.SkinBtn_CheckedBox
    GetFunctionAddress $3 un.CheckBox2_Btn_Func
    SkinBtn::onClick $1 $3
    StrCpy $CheckBox2_Bool 1

	ReadINIStr $R1 "$PLUGINSDIR\unTask1.ini" "Field 5" "Text"
	;������Ϣ
	;${NSD_CreateLabel} 277 274 100 18 $R1 ;"�������"
	StrCmp $1 "" +2
	${NSD_CreateLabel} 277 274 120 18 $R1 ;"�������"
	${NSD_CreateLabel} 277 274 120 18 "��װ�ٶ������"
	Pop $R0
	SetCtlColors $R0 0X000000 0XFFFFFF ;�������͸��
	CreateFont $HEADLINE_FONT "$(^Font)" "10" "0"
	SendMessage $R0 ${WM_SETFONT} $HEADLINE_FONT 0

    ;��ѡ��ť
    ;${NSD_CreateButton} 406 274 15 15 ""
    ${NSD_CreateButton} 416 274 15 15 ""
    Pop $CheckBox3_Btn_Var
    StrCpy $1 $CheckBox3_Btn_Var
    Call un.SkinBtn_CheckedBox
    GetFunctionAddress $3 un.CheckBox3_Btn_Func
    SkinBtn::onClick $1 $3
    StrCpy $CheckBox3_Bool 1

	ReadINIStr $R1 "$PLUGINSDIR\unTask1.ini" "Field 7" "Text"
	;������Ϣ
	;${NSD_CreateLabel} 428 274 100 18 $R1 ;"�������"
	StrCmp $1 "" +2
	${NSD_CreateLabel} 438 274 120 18 $R1 ;"�������"
	${NSD_CreateLabel} 438 274 120 18 "��װ�ٶ���ʿ"
	Pop $R0
	SetCtlColors $R0 0X000000 0XFFFFFF ;�������͸��
	CreateFont $HEADLINE_FONT "$(^Font)" "10" "0"
	SendMessage $R0 ${WM_SETFONT} $HEADLINE_FONT 0

${EndIf}  ;End If IsPush

    ;�������а�ť
    ${NSD_CreateButton} 220 319 160 48 "" ;220 319 160 48 235 319 160 48
    Pop $MSTY_Btn_Var
    StrCpy $1 $MSTY_Btn_Var
    Call un.SkinBtn_QD
    GetFunctionAddress $3 un.QD_Btn_Func
    SkinBtn::onClick $1 $3


	;������Ϣ
	${NSD_CreateLabel} 247 242 100 30 "ж�����"
	Pop $R0
	SetCtlColors $R0 0X000000 0XFFFFFF ;�������͸��
	CreateFont $HEADLINE_FONT "$(^Font)" "17" "0"
	SendMessage $R0 ${WM_SETFONT} $HEADLINE_FONT 0


    ;��������ͼ
    ${NSD_CreateBitmap} 0 0 100% 100% ""
    Pop $BGImage
    ${NSD_SetImage} $BGImage $PLUGINSDIR\bg2.bmp $ImageHandle

    LockWindow  off
	GetFunctionAddress $0 un.onGUICallback
	WndProc::onCallback $BGImage $0 ;�����ޱ߿����ƶ�
	nsDialogs::Show
	${NSD_FreeImage} $ImageHandle

FunctionEnd


















Section "365����"
SectionEnd
