unit Artbear_ActiveFormImpl1;

{$WARN SYMBOL_PLATFORM OFF}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ActiveX, AxCtrls, Project1_TLB, StdVcl, StdCtrls, OpenConf_TLB, Ex_Grid,
  Tabs, ComCtrls, ExtCtrls, Ex_Inspector, TabNotBk, OpenConfEvents, JclLogic,
  Math, ColorGrd;

type
  T1CDtgType = (t1cString,t1cStrings,t1cInteger,t1cBool,t1cFont,t1cFontSize,
                t1cExec,t1cLayers,t1cType,t1cAlign,t1cColor);

const
 addpLength       = -2;
 addpPrecision    = -3;
 addpPositiveOnly = -4;
 addpNumSeparated = -5;
{
 '' //0
 '' //1
 '���������� ��� �����'//2
 '' //3
 '������������ ��������'//4
 '����� ������ ������' //5
 '����� �� ���������'//6
 '������������ ���� ������ "����"'//7
 '���������'//8
 '���������'//9
 '�� ������'//10
 '���������������'//11
 '�������������'//12
 '������� ���������'//13
 '������� �����������'//14
 '' //15
 '���������� ���'//16
 '����� �������'//17
 '����� ��������'//18
 '����� ����������'//19
 '���������'//20
 '' //21
 '�� ��������� ������'//22
 '� ��� �� �������'//23
 '��������� ��� ���� ���������'//24
 '������ � ���������'//25
 '������������� �������'//26
 '�������� �����������'//27
 '������ ��������������';//28
}
 n1CForm : array [0..13] of integer = (fpTitle,          fpWidth,    fpHeight,  fpUseAutoFont,        fpFontName,  fpFontWeight,  fpFontItalic,     fpFontUnderline     , fpFlags,        fpAutoLayout,             fpToolBar,                     fpAutoSize,       fpBKColor,fpFlags);
 h1CForm : array [0..13] of string = ('��������� �����','������',   '������',   '����� �� ���������','��� ������','������ �����','��������� �����','������������ �����','��������� ���������','�������. ������� ������','�������� ������ ������������','�������� ������','���� ������� ����','������������ ��������');//,''
 t1CForm : array [0..13] of T1CDtgType = (t1cString,     t1cInteger, t1cInteger,t1cBool,           t1cFont,     t1cBool,       t1cBool,          t1cBool,             t1cBool,              t1cBool,                  t1cBool,                       t1cBool,          t1cColor,t1cAlign);

 nButtons : array [0..14] of integer = (cpTitle,cpStrID,cpFormul,cpLayer,cpLeft,cpTop,cpWidth,cpHeight,cpFlags,cpFlags,cpFlags,cpFlags,cpToolTip,cpHelpString,cpFlags);
 hButtons : array [0..14] of string = ('������������','�������������','�������','����','����','����','������','������','���������� ��� �����','������� ���������','������� �����������','������������ ��������','���������','��������','������������ ��������');//,''
 tButtons : array [0..14] of T1CDtgType = (t1cString,t1cString,t1cExec,t1cLayers,t1cInteger,t1cInteger,t1cInteger,t1cInteger,t1cBool,t1cBool,t1cBool, t1cAlign,t1cString,t1cStrings,t1cBool);

 nCheckBox : array [0..14] of integer = (cpTitle,       cpStrID,       cpFormul,  cpLayer,cpLeft,      cpTop,     cpWidth,   cpHeight,  cpFlags,              cpFlags,            cpFlags,               cpFlags,                       cpToolTip,  cpHelpString,cpFlags);
 hCheckBox : array [0..14] of string = ('������������','�������������','�������','����',  '����',      '����',    '������', '������',  '���������� ��� �����','������� ���������','������� �����������','��������� ��� ���� ���������','���������','��������',   '������������ ��������');//,''
 tCheckBox : array [0..14] of T1CDtgType = (t1cString, t1cString,      t1cExec,   t1cLayers,t1cInteger,t1cInteger,t1cInteger,t1cInteger,t1cBool,              t1cBool,            t1cBool,               t1cBool,                       t1cString,  t1cStrings,  t1cBool);

 nStatic : array [0..15] of integer = (cpTitle,       cpStrID,        cpFormul,  cpLayer,  cpLeft,    cpTop,     cpWidth,   cpHeight,  cpFlags,               cpFlags,            cpFlags,              cpFlags,          cpFontName,  cpToolTip,  cpHelpString,cpFlags);
 hStatic : array [0..15] of string =  ('������������','�������������','�������','����',   '����',    '����',    '������',   '������', '���������� ��� �����','������� ���������','������� �����������','���������� ���','��� ������','���������','��������',   '������������ ��������');//,''
 tStatic : array [0..15] of T1CDtgType = (t1cString,  t1cString,      t1cExec,   t1cLayers,t1cInteger,t1cInteger,t1cInteger,t1cInteger,t1cBool,               t1cBool,            t1cBool,              t1cBool,        t1cFont,     t1cString,  t1cStrings,   t1cBool);

 nGroupBox : array [0..8] of integer = (cpTitle,       cpStrID,        cpLayer,  cpLeft,    cpTop,     cpWidth,   cpHeight,  cpFlags,            cpFlags);
 hGroupBox : array [0..8] of string =  ('������������','�������������','����',   '����',    '����',    '������',   '������', '������� ���������','������� �����������');//,''
 tGroupBox : array [0..8] of T1CDtgType = (t1cString,  t1cString,       t1cLayers,t1cInteger,t1cInteger,t1cInteger,t1cInteger,t1cBool,            t1cBool);

 nRadio : array [0..13] of integer = (cpTitle,       cpStrID,        cpFormul,  cpLayer,  cpLeft,    cpTop,     cpWidth,   cpHeight,  cpFlags,              cpFlags,             cpFlags,             cpToolTip,  cpHelpString,cpFlags);
 hRadio : array [0..13] of string =  ('������������','�������������','�������','����',   '����',    '����',    '������',   '������', '���������� ��� �����','������� ���������','������� �����������','���������','��������',   '������������ ��������');//,''
 tRadio : array [0..13] of T1CDtgType = (t1cString,  t1cString,       t1cExec,  t1cLayers,t1cInteger,t1cInteger,t1cInteger,t1cInteger,t1cBool,              t1cBool,             t1cBool,               t1cString,  t1cStrings,   t1cBool);

 nListBox : array [0..13] of integer = (cpStrID,        cpFormul,  cpLayer,  cpLeft,    cpTop,     cpWidth,   cpHeight,  cpFlags,              cpFlags,              cpFlags,            cpFlags,             cpToolTip,  cpHelpString,cpFlags);
 hListBox : array [0..13] of string =  ('�������������','�������','����',   '����',    '����',    '������',   '������', '���������� ��� �����','������ � ���������','������� ���������','������� �����������','���������','��������',   '������������ ��������');//,''
 tListBox : array [0..13] of T1CDtgType = (t1cString,       t1cExec,  t1cLayers,t1cInteger,t1cInteger,t1cInteger,t1cInteger,t1cBool,              t1cBool,              t1cBool,            t1cBool,              t1cString,  t1cStrings,   t1cBool);

 n1cComboBox : array [0..12] of integer = (cpStrID,        cpFormul,  cpLayer,  cpLeft,    cpTop,     cpWidth,   cpHeight,  cpFlags,              cpFlags,            cpFlags,             cpToolTip,  cpHelpString,cpFlags);
 h1cComboBox : array [0..12] of string =  ('�������������','�������','����',   '����',    '����',    '������',   '������', '���������� ��� �����','������� ���������','������� �����������','���������','��������',   '������������ ��������');//,''
 t1cComboBox : array [0..12] of T1CDtgType = (t1cString,       t1cExec,  t1cLayers,t1cInteger,t1cInteger,t1cInteger,t1cInteger,t1cBool,              t1cBool,            t1cBool,              t1cString,  t1cStrings,   t1cBool);

 nTable : array [0..12] of integer = (cpStrID,        cpFormul,  cpLayer,  cpLeft,    cpTop,     cpWidth,   cpHeight,  cpFlags,              cpFlags,            cpFlags,             cpToolTip,  cpHelpString,cpFlags);
 hTable : array [0..12] of string =  ('�������������','�������','����',   '����',    '����',    '������',   '������', '���������� ��� �����','������� ���������','������� �����������','���������','��������',   '������������ ��������');//,''
 tTable : array [0..12] of T1CDtgType = (t1cString,       t1cExec,  t1cLayers,t1cInteger,t1cInteger,t1cInteger,t1cInteger,t1cBool,              t1cBool,            t1cBool,              t1cString,  t1cStrings,   t1cBool);

 nPicture : array [0..8] of integer = (cpStrID,        cpLayer,  cpLeft,    cpTop,     cpWidth,   cpHeight,  cpFlags,            cpFlags,             cpFlags);
 hPicture : array [0..8] of string =  ('�������������','����',   '����',    '����',    '������',   '������', '������� ���������','������� �����������','������������ ��������');//,''
 tPicture : array [0..8] of T1CDtgType = (t1cString,    t1cLayers,t1cInteger,t1cInteger,t1cInteger,t1cInteger,t1cBool,            t1cBool,             t1cAlign);

 nEdit_Void : array [0..11] of integer = (cpStrID,        cpFormul,  -1,      cpFlags,             cpLayer,  cpLeft,    cpTop,     cpWidth,   cpHeight,  cpToolTip,  cpHelpString,cpFlags);
 hEdit_Void : array [0..11] of string =  ('�������������','�������','���',   '����� ������ ������', '����',   '����',    '����',    '������',   '������', '���������','��������',   '������������ ��������');//,''
 tEdit_Void : array [0..11] of T1CDtgType = (t1cString,       t1cExec,  t1cType, t1cBool,             t1cLayers,t1cInteger,t1cInteger,t1cInteger,t1cInteger,t1cString,  t1cStrings,   t1cBool);


//************** ������ ������ ***************

{
 '' //0
 '' //1
 '���������� ��� �����'//2
 '' //3
 '������������ ��������'//4
 '����� ������ ������' //5
 '����� �� ���������'//6
 '������������ ���� ������ "����"'//7
 '���������'//8
 '���������'//9
 '�� ������'//10
 '���������������'//11
 '�������������'//12
 '������� ���������'//13
 '������� �����������'//14
 '' //15
 '���������� ���'//16
 '����� �������'//17
 '����� ��������'//18
 '����� ����������'//19
 '���������'//20
 '' //21
 '�� ��������� ������'//22
 '� ��� �� �������'//23
 '��������� ��� ���� ���������'//24
 '������ � ���������'//25
 '������������� �������'//26
 '�������� �����������'//27
 '������ ��������������';//28
}
//**
 hDateFlags : array [0..16] of string = ('�������������','�������','���',   '����� ������ ������', '����',   '����',    '����',    '������',   '������', '���������','��������',   '������������ ��������',
 '���������� ��� �����',
 '����� ������ ������',
 '������������ ��������',
 '��������� ��� ���� ���������',
 '������ ��������������'
 );
 nDateFlags : array [0..16] of integer = (cpStrID,        cpFormul,  -1,      cpFlags,             cpLayer,  cpLeft,    cpTop,     cpWidth,   cpHeight,  cpToolTip,  cpHelpString,cpFlags,cpFlags,cpFlags,cpFlags,cpFlags,cpFlags);
 tDateFlags : array [0..16] of T1CDtgType = (t1cString,       t1cExec,  t1cType, t1cBool,             t1cLayers,t1cInteger,t1cInteger,t1cInteger,t1cInteger,t1cString,  t1cStrings,   t1cBool,t1cBool,t1cBool,t1cBool,t1cBool,t1cBool);

//**
 hDocEnFlags : array [0..16] of string = ('�������������','�������','���',   '����� ������ ������', '����',   '����',    '����',    '������',   '������', '���������','��������',   '������������ ��������',
 '���������',
 '���������� ��� �����',
 '������������ ��������',
 '��������� ��� ���� ���������',
 '������ ��������������'
 );

 nDocEnFlags : array [0..16] of integer = (cpStrID,        cpFormul,  -1,      cpFlags,             cpLayer,  cpLeft,    cpTop,     cpWidth,   cpHeight,  cpToolTip,  cpHelpString,cpFlags,cpFlags,cpFlags,cpFlags,cpFlags,cpFlags);
 tDocEnFlags : array [0..16] of T1CDtgType = (t1cString,       t1cExec,  t1cType, t1cBool,             t1cLayers,t1cInteger,t1cInteger,t1cInteger,t1cInteger,t1cString,  t1cStrings,   t1cBool,t1cBool,t1cBool,t1cBool,t1cBool,t1cBool);
//**
 hRefFlags : array [0..17] of string = ('�������������','�������','���',   '����� ������ ������', '����',   '����',    '����',    '������',   '������', '���������','��������',   '������������ ��������',
 '���������',
 '������ �',
 '���������� ��� �����',
 '������������ ��������',
 '��������� ��� ���� ���������',
 '������ ��������������'
 );
 nRefFlags : array [0..17] of integer = (cpStrID,        cpFormul,  -1,      cpFlags,             cpLayer,  cpLeft,    cpTop,     cpWidth,   cpHeight,  cpToolTip,  cpHelpString,cpFlags,cpFlags,cpLinkWith,cpFlags,cpFlags,cpFlags,cpFlags);
 tRefFlags : array [0..17] of T1CDtgType = (t1cString,       t1cExec,  t1cType, t1cBool,             t1cLayers,t1cInteger,t1cInteger,t1cInteger,t1cInteger,t1cString,  t1cStrings,   t1cBool,t1cBool,t1cString,t1cBool,t1cBool,t1cBool,t1cBool);
//**

 hNumberFlags : array [0..21] of string = ('�������������','�������','���',   '����� ������ ������', '����',   '����',    '����',    '������',   '������', '���������','��������',   '������������ ��������',
 '�����',
 '��������',
 '���������������',
 '��������� ������',
 '������������� �������',
 '���������� ��� �����',
 '������� ���������',
 '������� �����������',
 '������ ��������������',
 '��������� ��� ���� ���������'
 );
 nNumberFlags : array [0..21] of integer = (cpStrID,        cpFormul,  -1,      cpFlags,             cpLayer,  cpLeft,    cpTop,     cpWidth,   cpHeight,  cpToolTip,  cpHelpString,cpFlags,addpLength,addpPrecision,addpPositiveOnly,addpNumSeparated,cpFlags,cpFlags,cpFlags,cpFlags,cpFlags,cpFlags);
 tNumberFlags : array [0..21] of T1CDtgType = (t1cString,       t1cExec,  t1cType, t1cBool,             t1cLayers,t1cInteger,t1cInteger,t1cInteger,t1cInteger,t1cString,  t1cStrings,   t1cBool,t1cInteger,t1cInteger,t1cBool,t1cBool,t1cBool,t1cBool,t1cBool,t1cBool,t1cBool,t1cBool);


 hStringFlags : array [0..19] of string = ('�������������','�������','���',   '����� ������ ������', '����',   '����',    '����',    '������',   '������', '���������','��������',   '������������ ��������',
 '�����',
 '�����',
// '��� ����� ������',
 '���������� ��� �����',
 '�������������',
 '������� ���������',
 '������� �����������',
 '��������� ��� ���� ���������',
 '������ ��������������'
 );
 nStringFlags : array [0..19] of integer = (cpStrID,        cpFormul,  -1,      cpFlags,             cpLayer,  cpLeft,    cpTop,     cpWidth,   cpHeight,  cpToolTip,  cpHelpString,cpFlags,addpLength,cpLinkWith,cpFlags,cpFlags,cpFlags,cpFlags,cpFlags,cpFlags);
 tStringFlags : array [0..19] of T1CDtgType = (t1cString,       t1cExec,  t1cType, t1cBool,             t1cLayers,t1cInteger,t1cInteger,t1cInteger,t1cInteger,t1cString,  t1cStrings,   t1cBool,t1cInteger,t1cString,t1cBool,t1cBool,t1cBool,t1cBool,t1cBool,t1cBool);

const
    ConstPluginName = '��������� ���������';

type
  TArtbear_ActiveFormX = class(TActiveForm, IArtbear_ActiveFormX, IConfigPlugin)
    Panel1: TPanel;
    ComboBox1: TComboBox;
    Layers: TTabSet;
    ColorDialog: TColorDialog;
    TabControl1: TTabControl;
    PropertyInspector: TExInspector;
    procedure PropertyInspectorGetCellText(Sender: TObject;
      Cell: TGridCell; var Value: String);
    procedure PropertyInspectorGetCellText_Group(Sender: TObject;
      Cell: TGridCell; var Value: String);
    procedure ComboBox1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ComboBox1KeyPress(Sender: TObject; var Key: Char);
    procedure TabControl1Change(Sender: TObject);
    procedure PropertyInspectorChanging(Sender: TObject;
      var Cell: TGridCell; var Selected: Boolean);
  private
    { Private declarations }
    FActivateWindowEventSink : TOpenConfEventSink;
    FEvents: IArtbear_ActiveFormXEvents;
    procedure ActivateEvent(Sender: TObject);
    procedure ClickEvent(Sender: TObject);
    procedure CreateEvent(Sender: TObject);
    procedure DblClickEvent(Sender: TObject);
    procedure DeactivateEvent(Sender: TObject);
    procedure DestroyEvent(Sender: TObject);
    procedure KeyPressEvent(Sender: TObject; var Key: Char);
    procedure PaintEvent(Sender: TObject);
  protected
    { Protected declarations }
    procedure DefinePropertyPages(DefinePropertyPage: TDefinePropertyPage); override;
    procedure EventSinkChanged(const EventSink: IUnknown); override;
    function Get_Active: WordBool; safecall;
    function Get_AlignDisabled: WordBool; safecall;
    function Get_AutoScroll: WordBool; safecall;
    function Get_AutoSize: WordBool; safecall;
    function Get_AxBorderStyle: TxActiveFormBorderStyle; safecall;
    function Get_Caption: WideString; safecall;
    function Get_Color: OLE_COLOR; safecall;
    function Get_Cursor: Smallint; safecall;
    function Get_DoubleBuffered: WordBool; safecall;
    function Get_DropTarget: WordBool; safecall;
    function Get_Enabled: WordBool; safecall;
    function Get_Font: IFontDisp; safecall;
    function Get_HelpFile: WideString; safecall;
    function Get_HelpKeyword: WideString; safecall;
    function Get_HelpType: TxHelpType; safecall;
    function Get_KeyPreview: WordBool; safecall;
    function Get_PixelsPerInch: Integer; safecall;
    function Get_PrintScale: TxPrintScale; safecall;
    function Get_Scaled: WordBool; safecall;
    function Get_Visible: WordBool; safecall;
    function Get_VisibleDockClientCount: Integer; safecall;
    procedure _Set_Font(var Value: IFontDisp); safecall;
    procedure Set_AutoScroll(Value: WordBool); safecall;
    procedure Set_AutoSize(Value: WordBool); safecall;
    procedure Set_AxBorderStyle(Value: TxActiveFormBorderStyle); safecall;
    procedure Set_Caption(const Value: WideString); safecall;
    procedure Set_Color(Value: OLE_COLOR); safecall;
    procedure Set_Cursor(Value: Smallint); safecall;
    procedure Set_DoubleBuffered(Value: WordBool); safecall;
    procedure Set_DropTarget(Value: WordBool); safecall;
    procedure Set_Enabled(Value: WordBool); safecall;
    procedure Set_Font(const Value: IFontDisp); safecall;
    procedure Set_HelpFile(const Value: WideString); safecall;
    procedure Set_HelpKeyword(const Value: WideString); safecall;
    procedure Set_HelpType(Value: TxHelpType); safecall;
    procedure Set_KeyPreview(Value: WordBool); safecall;
    procedure Set_PixelsPerInch(Value: Integer); safecall;
    procedure Set_PrintScale(Value: TxPrintScale); safecall;
    procedure Set_Scaled(Value: WordBool); safecall;
    procedure Set_Visible(Value: WordBool); safecall;
    procedure Run; safecall;
    procedure PropertyInspectorSetEditText(Sender: TObject;
      Cell: TGridCell; var Value: String);
    procedure PropertyInspectorSetEditText_Group(Sender: TObject;
      Cell: TGridCell; var Value: String);
    procedure PropertyInspectorGetEditList(Sender: TObject;
      Cell: TGridCell; Items: TStrings);
    procedure PropertyInspectorGetEditStyle(Sender: TObject;
      Cell: TGridCell; var Style: TGridEditStyle);
    procedure PropertyInspectorDblClick(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure PropertyInspectorEditButtonPress(Sender: TObject;
      Cell: TGridCell);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
{    procedure EventInspectorGetCellText(Sender: TObject; Cell: TGridCell;
      var Value: String);
    procedure EventInspectorGetEditStyle(Sender: TObject; Cell: TGridCell;
      var Style: TGridEditStyle);
    procedure EventInspectorEditButtonPress(Sender: TObject;
      Cell: TGridCell);
    procedure PropertyInspectorEditAcceptKey(Sender: TObject;
      Cell: TGridCell; Key: Char; var Accept: Boolean);
 }   procedure LayersChange(Sender: TObject; NewTab: Integer;
      var AllowChange: Boolean);
    procedure ShowInspector();
//    function GetType1c(_type:String):String;
    procedure VisibleProperty;
    procedure VisibleControlGroup;
    procedure FormProperty;
    Procedure CheckFlags(ctrlType,flag: string; row,ctrlIdx:integer);
    Procedure CheckFormFlags(flag: string; row:integer);
    procedure OnActivateWindow(const Wnd: ICfgWindow; bActive: WordBool);
//    procedure OnTimer(Sender: TObject);
    Function GetProcFuncPos(proc: boolean; Name: String):Integer;
    procedure SetFormulaPostfix(const vClassName, vPostfix: WideString);
      safecall;
    procedure SetFormulaPrefix(const vClassName, vPrefix: WideString);
      safecall;
    procedure SetProcFuncDivider(vCount: SYSINT; const vDivider: WideString);
      safecall;  public
    Procedure OnDialogChange (const Dialog: IDialogDoc);
    Procedure OnIdle;
    { Public declarations }
    procedure Initialize; override;
  private
    FConfigurator:IConfigurator;
    FDebugFlag: Boolean;
{ IConfigPlugin }
    function  Init(const pConfigurator: IConfigurator; out PluginName: WideString): HResult; stdcall;
    function  Done: HResult; stdcall;
    function  GetPluginCaps(capNum: PluginCaps; out pResult: OleVariant): HResult; stdcall;
    function  DoAction(Action: PluginAction; Param: OleVariant; out pResult: OleVariant): HResult; stdcall;

{ ��� �����������}
        procedure Echo(s:string);
    procedure Debug(s:string);overload;
        procedure Debug(title, s:string);overload;
//        procedure ErrorMessage(s:string);

		function GetFormulsList : TStrings;
  end;


implementation

uses ComObj, ComServ, Unit2;
{$R *.dfm}
var
//  ParamsList:TStringList;

  nInspectorDef : array of integer;
  hInspectorDef : array of string;
  tInspectorDef : array of T1CDtgType;

  flag:boolean;
  AllFlags: TStringList;

//  PredDlgSteram: WideString;
//  PredLayer: String;
  PredSelections: String;
//  predTabControlIndex{,PredControlIndex}: Integer;
  SelCell: TGridCell;

//  MaxTabIndex: integer;


// + Phoenix
{
0 ������
1 �����
2 �������������
3 ������
4 ������
5 ����������
6 ���������������
7 ��������
}

mPrefix : array [0..7] of string = (
                                    '��������',
                                    '�����',
                                    '�����������������',
                                    '�������������������������',
                                    '�����������',
                                    '�����������',
                                    '�����������',
                                    '������������'
                                   );

mPostfix : array [0..7] of string = (
                                    '',
                                    '',
                                    '',
                                    '',
                                    '',
                                    '',
                                    '',
                                    ''
                                    );

mDividerCount : Integer = 79;
mDividerSymb : string = '_';                                    
// - Phoenix


{ TArtbear_ActiveFormX }

procedure TArtbear_ActiveFormX.DefinePropertyPages(DefinePropertyPage: TDefinePropertyPage);
begin
  { Define property pages here.  Property pages are defined by calling
    DefinePropertyPage with the class id of the page.  For example,
      DefinePropertyPage(Class_Artbear_ActiveFormXPage); }
end;
function GetRussAlias(t1C: String): String;
Begin
 result:=t1C;
 If t1C='BMASKED' then result:='���� �����'
 else If t1C='1CEDIT' then result:='���� �����'
 else If t1C='BUTTON' then result:='������'
 else If t1C='CHECKBOX' then result:='������'
 else If t1C='RADIO' then result:='�������������'
 else If t1C='LISTBOX' then result:='������'
 else If t1C='COMBOBOX' then result:='���� �� �������'
 else If t1C='1CGROUPBOX' then result:='�����'
 else If t1C='STATIC' then result:='�����'
 else If t1C='TABLE' then result:='�������'
 else If t1C='PICTURE' then result:='��������'
end;
procedure TArtbear_ActiveFormX.EventSinkChanged(const EventSink: IUnknown);
begin
  FEvents := EventSink as IArtbear_ActiveFormXEvents;
  inherited EventSinkChanged(EventSink);
end;

procedure TArtbear_ActiveFormX.Initialize;
begin
  inherited Initialize;
  OnActivate := ActivateEvent;
  OnClick := ClickEvent;
  OnCreate := CreateEvent;
  OnDblClick := DblClickEvent;
  OnDeactivate := DeactivateEvent;
  OnDestroy := DestroyEvent;
  OnKeyPress := KeyPressEvent;
  OnPaint := PaintEvent;
end;

function TArtbear_ActiveFormX.Get_Active: WordBool;
begin
  Result := Active;  
end;

function TArtbear_ActiveFormX.Get_AlignDisabled: WordBool;
begin
  Result := AlignDisabled;
end;

function TArtbear_ActiveFormX.Get_AutoScroll: WordBool;
begin
  Result := AutoScroll;
end;

function TArtbear_ActiveFormX.Get_AutoSize: WordBool;
begin
  Result := AutoSize;
end;

function TArtbear_ActiveFormX.Get_AxBorderStyle: TxActiveFormBorderStyle;
begin
  Result := Ord(AxBorderStyle);
end;

function TArtbear_ActiveFormX.Get_Caption: WideString;
begin
  Result := WideString(Caption);
end;

function TArtbear_ActiveFormX.Get_Color: OLE_COLOR;
begin
  Result := OLE_COLOR(Color);
end;

function TArtbear_ActiveFormX.Get_Cursor: Smallint;
begin
  Result := Smallint(Cursor);
end;

function TArtbear_ActiveFormX.Get_DoubleBuffered: WordBool;
begin
  Result := DoubleBuffered;
end;

function TArtbear_ActiveFormX.Get_DropTarget: WordBool;
begin
  Result := DropTarget;
end;

function TArtbear_ActiveFormX.Get_Enabled: WordBool;
begin
  Result := Enabled;
end;

function TArtbear_ActiveFormX.Get_Font: IFontDisp;
begin
  GetOleFont(Font, Result);
end;

function TArtbear_ActiveFormX.Get_HelpFile: WideString;
begin
  Result := WideString(HelpFile);
end;

function TArtbear_ActiveFormX.Get_HelpKeyword: WideString;
begin
  Result := WideString(HelpKeyword);
end;

function TArtbear_ActiveFormX.Get_HelpType: TxHelpType;
begin
  Result := Ord(HelpType);
end;

function TArtbear_ActiveFormX.Get_KeyPreview: WordBool;
begin
  Result := KeyPreview;
end;

function TArtbear_ActiveFormX.Get_PixelsPerInch: Integer;
begin
  Result := PixelsPerInch;
end;

function TArtbear_ActiveFormX.Get_PrintScale: TxPrintScale;
begin
  Result := Ord(PrintScale);
end;

function TArtbear_ActiveFormX.Get_Scaled: WordBool;
begin
  Result := Scaled;
end;

function TArtbear_ActiveFormX.Get_Visible: WordBool;
begin
  Result := Visible;
end;

function TArtbear_ActiveFormX.Get_VisibleDockClientCount: Integer;
begin
  Result := VisibleDockClientCount;
end;

procedure TArtbear_ActiveFormX._Set_Font(var Value: IFontDisp);
begin
  SetOleFont(Font, Value);
end;

procedure TArtbear_ActiveFormX.ActivateEvent(Sender: TObject);
begin
  if FEvents <> nil then FEvents.OnActivate;
end;

procedure TArtbear_ActiveFormX.ClickEvent(Sender: TObject);
begin
  if FEvents <> nil then FEvents.OnClick;
end;

procedure TArtbear_ActiveFormX.CreateEvent(Sender: TObject);
begin
  if FEvents <> nil then FEvents.OnCreate;
end;

procedure TArtbear_ActiveFormX.DblClickEvent(Sender: TObject);
begin
  if FEvents <> nil then FEvents.OnDblClick;
end;

procedure TArtbear_ActiveFormX.DeactivateEvent(Sender: TObject);
begin
  if FEvents <> nil then FEvents.OnDeactivate;
end;

procedure TArtbear_ActiveFormX.DestroyEvent(Sender: TObject);
begin
  if FEvents <> nil then FEvents.OnDestroy;
end;

procedure TArtbear_ActiveFormX.KeyPressEvent(Sender: TObject;
  var Key: Char);
var
  TempKey: Smallint;
begin
  TempKey := Smallint(Key);
  if FEvents <> nil then FEvents.OnKeyPress(TempKey);
  Key := Char(TempKey);
end;

procedure TArtbear_ActiveFormX.PaintEvent(Sender: TObject);
begin
  if FEvents <> nil then FEvents.OnPaint;
  ComboBox1.Width:=ClientWidth;
end;

procedure TArtbear_ActiveFormX.Set_AutoScroll(Value: WordBool);
begin
  AutoScroll := Value;
end;

procedure TArtbear_ActiveFormX.Set_AutoSize(Value: WordBool);
begin
  AutoSize := Value;
end;

procedure TArtbear_ActiveFormX.Set_AxBorderStyle(
  Value: TxActiveFormBorderStyle);
begin
  AxBorderStyle := TActiveFormBorderStyle(Value);
end;

procedure TArtbear_ActiveFormX.Set_Caption(const Value: WideString);
begin
  Caption := TCaption(Value);
end;

procedure TArtbear_ActiveFormX.Set_Color(Value: OLE_COLOR);
begin
  Color := TColor(Value);
end;

procedure TArtbear_ActiveFormX.Set_Cursor(Value: Smallint);
begin
  Cursor := TCursor(Value);
end;

procedure TArtbear_ActiveFormX.Set_DoubleBuffered(Value: WordBool);
begin
  DoubleBuffered := Value;
end;

procedure TArtbear_ActiveFormX.Set_DropTarget(Value: WordBool);
begin
  DropTarget := Value;
end;

procedure TArtbear_ActiveFormX.Set_Enabled(Value: WordBool);
begin
  Enabled := Value;
end;

procedure TArtbear_ActiveFormX.Set_Font(const Value: IFontDisp);
begin
  SetOleFont(Font, Value);
end;

procedure TArtbear_ActiveFormX.Set_HelpFile(const Value: WideString);
begin
  HelpFile := String(Value);
end;

procedure TArtbear_ActiveFormX.Set_HelpKeyword(const Value: WideString);
begin
  HelpKeyword := String(Value);
end;

procedure TArtbear_ActiveFormX.Set_HelpType(Value: TxHelpType);
begin
  HelpType := THelpType(Value);
end;

procedure TArtbear_ActiveFormX.Set_KeyPreview(Value: WordBool);
begin
  KeyPreview := Value;
end;

procedure TArtbear_ActiveFormX.Set_PixelsPerInch(Value: Integer);
begin
  PixelsPerInch := Value;
end;

procedure TArtbear_ActiveFormX.Set_PrintScale(Value: TxPrintScale);
begin
  PrintScale := TPrintScale(Value);
end;

procedure TArtbear_ActiveFormX.Set_Scaled(Value: WordBool);
begin
  Scaled := Value;
end;

procedure TArtbear_ActiveFormX.Set_Visible(Value: WordBool);
begin
  Visible := Value;
end;


procedure TArtbear_ActiveFormX.Echo(s:string);
begin
    FConfigurator.Message(s, mNone);
end;

{
procedure TArtbear_ActiveFormX.ErrorMessage(s:string);
begin
    FConfigurator.Message(s, mRedErr);
end;
}

procedure TArtbear_ActiveFormX.Debug(s:string);
begin
    if FDebugFlag then
        Echo(s);
end;

procedure TArtbear_ActiveFormX.Debug(title, s:string);
begin
    if FDebugFlag then
        Echo(title+'-'+s);
end;

{ IConfigPlugin }
function  TArtbear_ActiveFormX.Init(const pConfigurator: IConfigurator; out PluginName: WideString): HResult;
begin

  FConfigurator := pConfigurator;
  PluginName := ConstPluginName;
  FDebugFlag := False;
  FDebugFlag := True;

  // �������� ��������� ������� ���������
  FActivateWindowEventSink := TOpenConfEventSink.Create;
  FActivateWindowEventSink.OnActivateWindow := OnActivateWindow;
  FActivateWindowEventSink.OnDialogChange := OnDialogChange;
  FActivateWindowEventSink.Connect(FConfigurator);
  FActivateWindowEventSink.OnIdle:=OnIdle;


    Result := S_OK;
end;

function  TArtbear_ActiveFormX.Done: HResult; stdcall;
begin
    // ���������� ���������� �������
    FreeAndNil(FActivateWindowEventSink);

    FConfigurator := nil;
    Result := S_OK;
end;

function  TArtbear_ActiveFormX.GetPluginCaps(capNum: PluginCaps; out pResult: OleVariant): HResult; //stdcall;
begin
    if capNum = capOpenIn then
    pResult := 2;
    Result := S_OK;
end;

function  TArtbear_ActiveFormX.DoAction(Action: PluginAction; Param: OleVariant; out pResult: OleVariant): HResult; stdcall;
begin
    Result := S_OK;
end;


procedure TArtbear_ActiveFormX.FormProperty;
var i, c: integer;
begin
 TabControl1.TabIndex:= TabControl1.Tabs.IndexOf('�������� �����');
 PropertyInspector.OnSetEditText:=PropertyInspectorSetEditText;
 PropertyInspector.OnGetCellText:=PropertyInspectorGetCellText;

 c:=length(n1CForm);

 SetLength(nInspectorDef, c);
 SetLength(hInspectorDef, c);
 SetLength(tInspectorDef, c);

 for i:=0 to c-1 do begin
   nInspectorDef[i]:=n1CForm[i];
   hInspectorDef[i]:=h1CForm[i];
   tInspectorDef[i]:=t1CForm[i];
 end;

 PropertyInspector.Rows.Count:=0;
 PropertyInspector.Rows.Count:=C;
end;

function FillList(Arr: Array of string): TStringList;
 var i: Integer;
begin
 result:=TStringList.Create;
 For i:=0 to length(arr)-1 do
  If arr[i]<>'�������������' then Result.Add(arr[i])
end;

function PropertyIn(Prop:string; Arr: Array of string): boolean;
 var i: Integer;
begin
 result:=false;
 For i:=0 to length(arr)-1 do
  if arr[i]=prop then begin
   result:=true;
   Exit;
  end

end;

procedure TArtbear_ActiveFormX.VisibleControlGroup;
var c, i, x: integer;
//		ctlID: integer;
    mDoc:IDialogDoc;
    ctlType, firgstctlType:String;
    Type1C:IType1C;
    ControlList: TStringList;
    tmpList: TStringList;

  nGroupDef : array of integer;
  hGroupDef : array of string;
  tGroupDef : array of T1CDtgType;

begin
 Flag:=false;
 PropertyInspector.Rows.Count:=0;
 PropertyInspector.OnSetEditText:=PropertyInspectorSetEditText_Group;
 PropertyInspector.OnGetCellText:=PropertyInspectorGetCellText_Group;

// c:=0;

 SetLength(nGroupDef, 50);
 SetLength(hGroupDef, 50);
 SetLength(tGroupDef, 50);

 ComboBox1.Text:='������ ���������';
 ControlList:=TStringList.Create;

 tmpList := TStringList.Create; // �����

 mDoc:=((FConfigurator.Windows.ActiveWnd.Document as IWorkBook).Page[0] as IDialogDoc);
 ControlList.CommaText:=mDoc.Selection;
 for x:=0 to ControlList.Count-1 do begin
//  ctlType:=mdoc.ctrlType[x];
  ctlType:=mdoc.ctrlType[StrToInt(ControlList[x])];

  if ctlType='������' then
   if x=0 then begin
    firgstctlType:=ctlType;
    tmpList:=FillList(hButtons);
    For i:=0 to length(nButtons)-1 do begin
     nGroupDef[i] := nButtons[i];
     hGroupDef[i] := hButtons[i];
     tGroupDef[i] := tButtons[i];
    end
   end else begin
    tmpList:=FillList(hButtons); // �����
    i:=0;
    while i<>tmpList.Count-1 do
     if not PropertyIn(tmpList[i],hButtons) then
      tmpList.Delete(i)
     else inc(i)
   end
  else if ctlType='�����' then
   if x=0 then begin
    firgstctlType:=ctlType;
    tmpList:=FillList(hStatic);
    For i:=0 to length(nStatic)-1 do begin
     nGroupDef[i] := nStatic[i];
     hGroupDef[i] := hStatic[i];
     tGroupDef[i] := tStatic[i];
    end
   end else begin
    i:=0;
    tmpList:=FillList(hStatic); // �����
    while i<>tmpList.Count-1 do
     if not PropertyIn(tmpList[i],hStatic) then
      tmpList.Delete(i)
     else inc(i)
   end
  else if ctlType='�����' then
   if x=0 then begin
    firgstctlType:=ctlType;
    tmpList:=FillList(hGroupBox);
    For i:=0 to length(nGroupBox)-1 do begin
     nGroupDef[i] := nGroupBox[i];
     hGroupDef[i] := hGroupBox[i];
     tGroupDef[i] := tGroupBox[i];
    end
   end else begin
    i:=0;
    tmpList:=FillList(hGroupBox); // �����
    while i<>tmpList.Count-1 do
     if not PropertyIn(tmpList[i],hGroupBox) then
      tmpList.Delete(i)
     else inc(i)
   end
  else if ctlType='�������������' then
   if x=0 then begin
    firgstctlType:=ctlType;
    tmpList:=FillList(hRadio);
    For i:=0 to length(nRadio)-1 do begin
     nGroupDef[i] := nRadio[i];
     hGroupDef[i] := hRadio[i];
     tGroupDef[i] := tRadio[i];
    end
   end else begin
    i:=0;
    tmpList:=FillList(hRadio);  // �����
    while i<>tmpList.Count-1 do
     if not PropertyIn(tmpList[i],hRadio) then
      tmpList.Delete(i)
     else inc(i)
   end
  else if ctlType='������' then
   if x=0 then begin
    firgstctlType:=ctlType;
    tmpList:=FillList(hCheckBox);
    For i:=0 to length(nCheckBox)-1 do begin
     nGroupDef[i] := nCheckBox[i];
     hGroupDef[i] := hCheckBox[i];
     tGroupDef[i] := tCheckBox[i];
    end
   end else begin
    i:=0;
    tmpList:=FillList(hCheckBox); // �����
    while i<>tmpList.Count-1 do
     if not PropertyIn(tmpList[i],hCheckBox) then
      tmpList.Delete(i)
     else inc(i)
   end
  else if ctlType='������' then
   if x=0 then begin
    firgstctlType:=ctlType;
    tmpList:=FillList(hListBox);
    For i:=0 to length(nListBox)-1 do begin
     nGroupDef[i] := nListBox[i];
     hGroupDef[i] := hListBox[i];
     tGroupDef[i] := tListBox[i];
    end
   end else begin
    i:=0;
    tmpList:=FillList(hListBox); // �����
    while i<>tmpList.Count-1 do
     if not PropertyIn(tmpList[i],hListBox) then
      tmpList.Delete(i)
     else inc(i)
   end
  else if ctlType='����������' then
   if x=0 then begin
    firgstctlType:=ctlType;
    tmpList:=FillList(h1cComboBox);
    For i:=0 to length(n1cComboBox)-1 do begin
     nGroupDef[i] := n1cComboBox[i];
     hGroupDef[i] := h1cComboBox[i];
     tGroupDef[i] := t1cComboBox[i];
    end
   end else begin
    i:=0;
    tmpList:=FillList(h1cComboBox); // �����
    while i<>tmpList.Count-1 do
     if not PropertyIn(tmpList[i],h1cComboBox) then
      tmpList.Delete(i)
     else inc(i)
   end
 else if ctlType='���������������' then
   if x=0 then begin
    firgstctlType:=ctlType;
    tmpList:=FillList(hTable);
    For i:=0 to length(nTable)-1 do begin
     nGroupDef[i] := nTable[i];
     hGroupDef[i] := hTable[i];
     tGroupDef[i] := tTable[i];
    end
   end else begin
    i:=0;
    tmpList:=FillList(hTable); // �����
    while i<>tmpList.Count-1 do
     if not PropertyIn(tmpList[i],hTable) then
      tmpList.Delete(i)
     else inc(i)
   end
 else if ctlType='��������' then
   if x=0 then begin
    firgstctlType:=ctlType;
    tmpList:=FillList(hPicture);
    For i:=0 to length(nPicture)-1 do begin
     nGroupDef[i] := nPicture[i];
     hGroupDef[i] := hPicture[i];
     tGroupDef[i] := tPicture[i];
    end
   end else begin
    i:=0;
    tmpList:=FillList(hPicture); // �����
    while i<>tmpList.Count-1 do
     if not PropertyIn(tmpList[i],hPicture) then
      tmpList.Delete(i)
     else inc(i)
   end
 else if ctlType='��������' then begin
  Type1C:=mdoc.ctrlType1C[StrToInt(ControlList[x])];
  if Type1C.Type_=ttString then
   if x=0 then begin
    firgstctlType:=ctlType;
    tmpList:=FillList(hStringFlags);
    For i:=0 to length(nStringFlags)-1 do begin
     nGroupDef[i] := nStringFlags[i];
     hGroupDef[i] := hStringFlags[i];
     tGroupDef[i] := tStringFlags[i];
    end
   end else begin
    i:=0;
    tmpList:=FillList(hStringFlags); // �����
    while i<>tmpList.Count-1 do
     if not PropertyIn(tmpList[i],hStringFlags) then
      tmpList.Delete(i)
     else inc(i)
   end
  else if Type1C.Type_=ttNumber then
   if x=0 then begin
    firgstctlType:=ctlType;
    tmpList:=FillList(hNumberFlags);
    For i:=0 to length(nNumberFlags)-1 do begin
     nGroupDef[i] := nNumberFlags[i];
     hGroupDef[i] := hNumberFlags[i];
     tGroupDef[i] := tNumberFlags[i];
    end
   end else begin
    i:=0;
    tmpList:=FillList(hNumberFlags); // �����
    while i<>tmpList.Count-1 do
     if not PropertyIn(tmpList[i],hNumberFlags) then
      tmpList.Delete(i)
     else inc(i)
   end
  else if Type1C.Type_=ttDate then
   if x=0 then begin
    firgstctlType:=ctlType;
    tmpList:=FillList(hDateFlags);
    For i:=0 to length(nDateFlags)-1 do begin
     nGroupDef[i] := nDateFlags[i];
     hGroupDef[i] := hDateFlags[i];
     tGroupDef[i] := tDateFlags[i];
    end
   end else begin
    i:=0;
    tmpList:=FillList(hDateFlags); // �����
    while i<>tmpList.Count-1 do
     if not PropertyIn(tmpList[i],hDateFlags) then
      tmpList.Delete(i)
     else inc(i)
   end
  else if Type1C.Type_=ttReference then
   if x=0 then begin
    firgstctlType:=ctlType;
    tmpList:=FillList(hRefFlags);
    For i:=0 to length(nRefFlags)-1 do begin
     nGroupDef[i] := nRefFlags[i];
     hGroupDef[i] := hRefFlags[i];
     tGroupDef[i] := tRefFlags[i];
    end
   end else begin
    i:=0;
    tmpList:=FillList(hRefFlags); // �����
    while i<>tmpList.Count-1 do
     if not PropertyIn(tmpList[i],hRefFlags) then
      tmpList.Delete(i)
     else inc(i)
   end
  else if (Type1C.Type_=ttEnum)or(Type1C.Type_=ttDocument) then
   if x=0 then begin
    firgstctlType:=ctlType;
    tmpList:=FillList(hDocEnFlags);
    For i:=0 to length(nDocEnFlags)-1 do begin
     nGroupDef[i] := nDocEnFlags[i];
     hGroupDef[i] := hDocEnFlags[i];
     tGroupDef[i] := tDocEnFlags[i];
    end
   end else begin
    i:=0;
    tmpList:=FillList(hDocEnFlags); // �����
    while i<>tmpList.Count-1 do
     if not PropertyIn(tmpList[i],hDocEnFlags) then
      tmpList.Delete(i)
     else inc(i)
   end
  else if Type1C.Type_=ttVoid then
   if x=0 then begin
    firgstctlType:=ctlType;
    tmpList:=FillList(hEdit_Void);
    For i:=0 to length(nEdit_Void)-1 do begin
     nGroupDef[i] := nEdit_Void[i];
     hGroupDef[i] := hEdit_Void[i];
     tGroupDef[i] := tEdit_Void[i];
    end
   end else begin
    i:=0;
    tmpList:=FillList(hEdit_Void); // �����
    while i<>tmpList.Count-1 do
     if not PropertyIn(tmpList[i],hEdit_Void) then
      tmpList.Delete(i)
     else inc(i)
   end
  end
 end;


 c := tmpList.Count;

 SetLength(nInspectorDef, c);
 SetLength(hInspectorDef, c);
 SetLength(tInspectorDef, c);

 x:=0;
 for i:=0 to length(hGroupDef)-1 do
  if tmpList.IndexOf(hGroupDef[i])<>-1 then begin
   nInspectorDef[x]:=nGroupDef[i];
   hInspectorDef[x]:=hGroupDef[i];
   tInspectorDef[x]:=tGroupDef[i];
   inc(x);
  end;
 PropertyInspector.Rows.Count:=C;
flag:=true;
end;

procedure TArtbear_ActiveFormX.VisibleProperty;
var ctlID,c, i, x, length1CAllControls: integer;
    mDoc:IDialogDoc;
    ctlType:String;
    Type1C:IType1C;
begin
 if ComboBox1.ItemIndex=-1 then exit;
 PropertyInspector.Rows.Count:=0;
 PropertyInspector.OnSetEditText:=PropertyInspectorSetEditText;
 PropertyInspector.OnGetCellText:=PropertyInspectorGetCellText;

 TabControl1.TabIndex:= TabControl1.Tabs.IndexOf('�������� �����');

 c:=0;
 mDoc:=((FConfigurator.Windows.ActiveWnd.Document as IWorkBook).Page[0] as IDialogDoc);
 ctlID:=Integer(ComboBox1.Items.Objects[ComboBox1.ItemIndex]);
 mDoc.Selection:=IntToStr(mdoc.ctrlIdx(ctlID));
 ctlType:=mdoc.ctrlType[mDoc.ctrlIdx(ctlID)];


 if ctlType='������' then
  c:=length(nButtons)
 else if ctlType='�����' then
  c:=length(nStatic)
 else if ctlType='�����' then
  c:=length(nGroupBox)
 else if ctlType='�������������' then
  c:=length(nRadio)
 else if ctlType='������' then
  c:=length(nCheckBox)
 else if ctlType='������' then
  c:=length(nListBox)
 else if ctlType='����������' then
  c:=length(n1cComboBox)
 else if ctlType='���������������' then
  c:=length(nTable)
 else if ctlType='��������' then
  c:=length(nPicture)
 else if ctlType='��������' then begin
  Type1C:=mdoc.ctrlType1C[mDoc.ctrlIdx(ctlID)];
  if Type1C.Type_=ttString then
   c:=c+length(nStringFlags)
  else if Type1C.Type_=ttNumber then
   c:=c+length(nNumberFlags)
  else if Type1C.Type_=ttDate then
   c:=c+length(nDateFlags)
  else if Type1C.Type_=ttReference then
   c:=c+length(nRefFlags)
  else if (Type1C.Type_=ttEnum)or(Type1C.Type_=ttDocument) then
   c:=length(nDocEnFlags)
  else if Type1C.Type_=ttVoid then
   c:=length(nEdit_Void);
 end
  ;

 SetLength(nInspectorDef, c);
 SetLength(hInspectorDef, c);
 SetLength(tInspectorDef, c);

 for i:=0 to c-1 do
  if ctlType='������' then begin
   nInspectorDef[i]:=nButtons[i];
   hInspectorDef[i]:=hButtons[i];
   tInspectorDef[i]:=tButtons[i];
  end
  else if ctlType='�����' then begin
   nInspectorDef[i]:=nStatic[i];
   hInspectorDef[i]:=hStatic[i];
   tInspectorDef[i]:=tStatic[i];
  end
  else if ctlType='�����' then begin
   nInspectorDef[i]:=nGroupBox[i];
   hInspectorDef[i]:=hGroupBox[i];
   tInspectorDef[i]:=tGroupBox[i];
  end
 else if ctlType='�������������' then begin
   nInspectorDef[i]:=nRadio[i];
   hInspectorDef[i]:=hRadio[i];
   tInspectorDef[i]:=tRadio[i];
  end
 else if ctlType='������' then begin
   nInspectorDef[i]:=nCheckBox[i];
   hInspectorDef[i]:=hCheckBox[i];
   tInspectorDef[i]:=tCheckBox[i];
  end
 else if ctlType='������' then begin
   nInspectorDef[i]:=nListBox[i];
   hInspectorDef[i]:=hListBox[i];
   tInspectorDef[i]:=tListBox[i];
  end
 else if ctlType='����������' then begin
   nInspectorDef[i]:=n1cComboBox[i];
   hInspectorDef[i]:=h1cComboBox[i];
   tInspectorDef[i]:=t1cComboBox[i];
  end
 else if ctlType='���������������' then begin
   nInspectorDef[i]:=nTable[i];
   hInspectorDef[i]:=hTable[i];
   tInspectorDef[i]:=tTable[i];
  end
 else if ctlType='��������' then begin
   nInspectorDef[i]:=nPicture[i];
   hInspectorDef[i]:=hPicture[i];
   tInspectorDef[i]:=tPicture[i];
  end
 else if ctlType='��������' then //begin
  if Type1C.Type_=ttString then begin
    nInspectorDef[i]:=nStringFlags[i];
    hInspectorDef[i]:=hStringFlags[i];
    tInspectorDef[i]:=tStringFlags[i];
  end
  else if Type1C.Type_=ttNumber then begin
    nInspectorDef[i]:=nNumberFlags[i];
    hInspectorDef[i]:=hNumberFlags[i];
    tInspectorDef[i]:=tNumberFlags[i];
   end
  else if Type1C.Type_=ttDate then begin
    nInspectorDef[i]:=nDateFlags[i];
    hInspectorDef[i]:=hDateFlags[i];
    tInspectorDef[i]:=tDateFlags[i];
   end
  else if Type1C.Type_=ttReference then begin
    nInspectorDef[i]:=nRefFlags[i];
    hInspectorDef[i]:=hRefFlags[i];
    tInspectorDef[i]:=tRefFlags[i];
   end
  else if (Type1C.Type_=ttEnum)or(Type1C.Type_=ttDocument) then begin
    nInspectorDef[i]:=nDocEnFlags[i];
    hInspectorDef[i]:=hDocEnFlags[i];
    tInspectorDef[i]:=tDocEnFlags[i];
   end
  else begin
   nInspectorDef[i]:=nEdit_Void[i];
   hInspectorDef[i]:=hEdit_Void[i];
   tInspectorDef[i]:=tEdit_Void[i];
  end

   ;

 PropertyInspector.Rows.Count:=c;

end;

Procedure TArtbear_ActiveFormX.CheckFormFlags(flag: string; row:integer);
Var {i, }x: integer;
//		i: integer;
    FlagsArray: TBooleanArray;
    item: string;
    mDoc:IDialogDoc;

begin

 mDoc:=((FConfigurator.Windows.ActiveWnd.Document as IWorkBook).Page[0] as IDialogDoc);

 if nInspectorDef[row]=fpFlags then
  begin
   BitsToBooleans(StrToInt(mDoc.formProp[fpFlags]),FlagsArray);
   SetLength(FlagsArray, 29);

   if hInspectorDef[row]='������������ ��������' then begin
    FlagsArray[8]:=false;//AllFlags.IndexOf('���������')
    FlagsArray[10]:=false;//AllFlags.IndexOf('�� ������')
    FlagsArray[11]:=false;//AllFlags.IndexOf('���������������')
    item:=flag;
    flag:='��';
    x:=AllFlags.IndexOf(item);
    end
   else
    x:=24;

   If flag='��' then
    FlagsArray[x]:=true
    else FlagsArray[x]:=false;
   If x = 24 then //'��������� ��� ���� ���������'
    FlagsArray[x]:= not FlagsArray[x];

   BooleansToBits(x,FlagsArray);
   mDoc.formProp[fpFlags]:=x;
  end;
End;

Procedure TArtbear_ActiveFormX.CheckFlags(ctrlType,flag: string; row,ctrlIdx:integer);
Var {i, }x: integer;
//		i: integer;
    FlagsArray: TBooleanArray;
    item: string;
    mDoc:IDialogDoc;
    Type1C:IType1C;
begin
// i:=0;
 mDoc:=((FConfigurator.Windows.ActiveWnd.Document as IWorkBook).Page[0] as IDialogDoc);

 if nInspectorDef[row]=cpFlags then
  begin
   BitsToBooleans(StrToInt(mDoc.ctrlProp[ctrlIdx, cpFlags]),FlagsArray);
   SetLength(FlagsArray, 29);

   if hInspectorDef[row]='������������ ��������' then begin
    FlagsArray[8]:=false;//AllFlags.IndexOf('���������')
    FlagsArray[10]:=false;//AllFlags.IndexOf('�� ������')
    FlagsArray[11]:=false;//AllFlags.IndexOf('���������������')
    item:=flag;
    flag:='��';
    end
   else
    item:=hInspectorDef[row];

   x:=AllFlags.IndexOf(item);
//   FlagsArray[x]:=not FlagsArray[x];
   If flag='��' then
    FlagsArray[x]:=true
    else FlagsArray[x]:=false;
   If x = 24 then //'��������� ��� ���� ���������'
    FlagsArray[x]:= not FlagsArray[x];

   BooleansToBits(x,FlagsArray);
   mDoc.ctrlProp[ctrlIdx, cpFlags]:=x;

  end;

  if nInspectorDef[row] = addpPositiveOnly then
   if Flag='��' then begin
    Type1C:=mdoc.ctrlType1C[ctrlIdx];
    Type1C.PositiveOnly:=true;
    mdoc.ctrlType1C[ctrlIdx]:=Type1C;
   end
   else begin
    Type1C:=mdoc.ctrlType1C[ctrlIdx];
    Type1C.PositiveOnly:=false;
    mdoc.ctrlType1C[ctrlIdx]:=Type1C;
   end;

  if nInspectorDef[row] = addpNumSeparated then
   if Flag='��' then begin
    Type1C:=mdoc.ctrlType1C[ctrlIdx];
    Type1C.NumSeparated:=true;
    mdoc.ctrlType1C[ctrlIdx]:=Type1C;
   end
   else begin
    Type1C:=mdoc.ctrlType1C[ctrlIdx];
    Type1C.NumSeparated:=false;
    mdoc.ctrlType1C[ctrlIdx]:=Type1C;
   end;


{ if hInspectorDef[row]='����� ������ ������' then
  begin
    if Flag='��' then
     ParamsList[1]:='BMASKED'
    else
     ParamsList[1]:='1CEDIT';

   i:=ComboBox1.ItemIndex;

   ComboBox1.ItemIndex:=i;
  end;
 if nInspectorDef[row]=2 then
    if Flag='��' then
     ParamsList[2]:='1350565920'
    else
     ParamsList[2]:='1350565888';
 if nInspectorDef[row]=18 then
  if (hInspectorDef[row]='���������������') then
    if Flag='��' then
     ParamsList[18]:=inttostr(strtoint(ParamsList[18])+1)
    else
     ParamsList[18]:=inttostr(strtoint(ParamsList[18])-1)
  else if (hInspectorDef[row]='��������� ������') then
    if Flag='��' then
     ParamsList[18]:=inttostr(strtoint(ParamsList[18])+2)
    else
     ParamsList[18]:=inttostr(strtoint(ParamsList[18])-2);
 }

exit;
 if nInspectorDef[row]=cpFontWeight then
  begin
  if Flag='��' then
   mDoc.ctrlProp[ctrlIdx, cpFontWeight]:=700
  else
   mDoc.ctrlProp[ctrlIdx, cpFontWeight]:=0
  end;

 if (nInspectorDef[row]=cpFontItalic) then
  if Flag='��' then
   mDoc.ctrlProp[ctrlIdx, cpFontItalic]:=1
  else
   mDoc.ctrlProp[ctrlIdx, cpFontItalic]:=0;

 if (nInspectorDef[row]=cpFontUnderline) then
  if Flag='��' then
   mDoc.ctrlProp[ctrlIdx, cpFontUnderline]:=1
  else
   mDoc.ctrlProp[ctrlIdx, cpFontUnderline]:=0

end;

(*Procedure TArtbear_ActiveFormX.CheckFlags(ctrlType,flag: string; row:integer);
Var ctlID, i, x: integer;
    FlagsArray: TBooleanArray;
    item: string;
    mDoc:IDialogDoc;
    Type1C:IType1C;
begin
 i:=0;
 mDoc:=((FConfigurator.Windows.ActiveWnd.Document as IWorkBook).Page[0] as IDialogDoc);
 ctlID:=Integer(ComboBox1.Items.Objects[ComboBox1.ItemIndex]);

 if nInspectorDef[row]=cpFlags then
  begin
   BitsToBooleans(StrToInt(mDoc.ctrlProp[ctrlIdx(ctlID), cpFlags]),FlagsArray);
   SetLength(FlagsArray, 29);

   if hInspectorDef[row]='������������ ��������' then begin
    FlagsArray[8]:=false;//AllFlags.IndexOf('���������')
    FlagsArray[10]:=false;//AllFlags.IndexOf('�� ������')
    FlagsArray[11]:=false;//AllFlags.IndexOf('���������������')
    item:=flag;
    end
   else
    item:=hInspectorDef[row];

   x:=AllFlags.IndexOf(item);
   FlagsArray[x]:=not FlagsArray[x];

   BooleansToBits(x,FlagsArray);
   mDoc.ctrlProp[mDoc.ctrlIdx(ctlID), cpFlags]:=x;

  end;

  if nInspectorDef[row] = addpPositiveOnly then
   if Flag='��' then begin
    Type1C:=mdoc.ctrlType1C[mDoc.ctrlIdx(ctlID)];
    Type1C.PositiveOnly:=true;
    mdoc.ctrlType1C[mDoc.ctrlIdx(ctlID)]:=Type1C;
   end
   else begin
    Type1C:=mdoc.ctrlType1C[mDoc.ctrlIdx(ctlID)];
    Type1C.PositiveOnly:=false;
    mdoc.ctrlType1C[mDoc.ctrlIdx(ctlID)]:=Type1C;
   end;

  if nInspectorDef[row] = addpNumSeparated then
   if Flag='��' then begin
    Type1C:=mdoc.ctrlType1C[mDoc.ctrlIdx(ctlID)];
    Type1C.NumSeparated:=true;
    mdoc.ctrlType1C[mDoc.ctrlIdx(ctlID)]:=Type1C;
   end
   else begin
    Type1C:=mdoc.ctrlType1C[mDoc.ctrlIdx(ctlID)];
    Type1C.NumSeparated:=false;
    mdoc.ctrlType1C[mDoc.ctrlIdx(ctlID)]:=Type1C;
   end;


{ if hInspectorDef[row]='����� ������ ������' then
  begin
    if Flag='��' then
     ParamsList[1]:='BMASKED'
    else
     ParamsList[1]:='1CEDIT';

   i:=ComboBox1.ItemIndex;

   ComboBox1.ItemIndex:=i;
  end;
 if nInspectorDef[row]=2 then
    if Flag='��' then
     ParamsList[2]:='1350565920'
    else
     ParamsList[2]:='1350565888';
 if nInspectorDef[row]=18 then
  if (hInspectorDef[row]='���������������') then
    if Flag='��' then
     ParamsList[18]:=inttostr(strtoint(ParamsList[18])+1)
    else
     ParamsList[18]:=inttostr(strtoint(ParamsList[18])-1)
  else if (hInspectorDef[row]='��������� ������') then
    if Flag='��' then
     ParamsList[18]:=inttostr(strtoint(ParamsList[18])+2)
    else
     ParamsList[18]:=inttostr(strtoint(ParamsList[18])-2);
 }

exit;
 if nInspectorDef[row]=cpFontWeight then
  begin
  if Flag='��' then
   mDoc.ctrlProp[mDoc.ctrlIdx(ctlID), cpFontWeight]:=700
  else
   mDoc.ctrlProp[mDoc.ctrlIdx(ctlID), cpFontWeight]:=0
  end;

 if (nInspectorDef[row]=cpFontItalic) then
  if Flag='��' then
   mDoc.ctrlProp[mDoc.ctrlIdx(ctlID), cpFontItalic]:=1
  else
   mDoc.ctrlProp[mDoc.ctrlIdx(ctlID), cpFontItalic]:=0;

 if (nInspectorDef[row]=cpFontUnderline) then
  if Flag='��' then
   mDoc.ctrlProp[mDoc.ctrlIdx(ctlID), cpFontUnderline]:=1
  else
   mDoc.ctrlProp[mDoc.ctrlIdx(ctlID), cpFontUnderline]:=0

end;
*)
function GetCheckingFlags(Cheking,p: string):boolean;
Var FlagsArray: TBooleanArray;
begin
	result:= false;

 BitsToBooleans(StrToInt(p),FlagsArray);
 SetLength(FlagsArray, 29);
 if Cheking='���������� ��� �����' then result:=FlagsArray[2]
 else if Cheking='������������ ��������' then result:=FlagsArray[4]
 else if Cheking='����� ������ ������' then result:=FlagsArray[5]
 else if Cheking='����� �� ���������' then result:=FlagsArray[6]
 else if Cheking='������������ ���� ������ "����"' then result:=FlagsArray[7]
 else if Cheking='���������' then result:=FlagsArray[8]
 else if Cheking='���������' then result:=not FlagsArray[9]
 else if Cheking='�� ������' then result:=FlagsArray[10]
 else if Cheking='���������������' then result:=FlagsArray[11]
 else if Cheking='�������������' then result:=FlagsArray[12]
 else if Cheking='������� ���������' then result:=FlagsArray[13]
 else if Cheking='������� �����������' then result:=FlagsArray[14]
 else if Cheking='���������� ���' then result:=FlagsArray[16]
 else if Cheking='����� �������' then result:=FlagsArray[17]
 else if Cheking='����� ��������' then result:=FlagsArray[18]
 else if Cheking='����� ����������' then result:=FlagsArray[19]
 else if Cheking='���������' then result:=FlagsArray[20]
 else if Cheking='�� ��������� ������' then result:=FlagsArray[22]
 else if Cheking='� ��� �� �������' then result:=FlagsArray[23]
 else if Cheking='��������� ��� ���� ���������' then result:=not FlagsArray[24]
 else if Cheking='������ � ���������' then result:=FlagsArray[25]
 else if Cheking='������������� �������' then result:=FlagsArray[26]
 else if Cheking='�������� �����������' then result:=FlagsArray[27]
 else if Cheking='������ ��������������' then result:=FlagsArray[28]
end;


function GetCheckingFormFlags(Cheking,p: string):boolean;
Var FlagsArray: TBooleanArray;
begin
 result:=false;
 BitsToBooleans(StrToInt(p),FlagsArray);
 SetLength(FlagsArray, 12);
 if Cheking='��������� ���������' then result:=not FlagsArray[24]
 else if Cheking='���������' then result:=FlagsArray[8]
 else if Cheking='�� ������' then result:=FlagsArray[10]
 else if Cheking='���������������' then result:=FlagsArray[11]
end;

procedure TArtbear_ActiveFormX.ShowInspector();
var //SourceList,Params,tmpList:TStringList;
//    x,c,i, j:integer;
    i:integer;
    SelectedProps, tmpStrList :TStringList;
    Alias: String;
    Doc:IDialogDoc;
//    mWorkBook:IWorkBook;
begin
 ComboBox1.Enabled:=true;
 Flag:=false;
 ComboBox1.Items.Clear;
 ComboBox1.Text:='��� ��������� ���������';
 PropertyInspector.Rows.Count:=0;
 Layers.Tabs.Clear;
 if FConfigurator.Windows.ActiveWnd.Document.Type_<>docWorkBook then
  begin
    ComboBox1.Text:='��� ���������';
    ComboBox1.Enabled:=false;
    Repaint;
    Exit;
  end;
 Doc:=((FConfigurator.Windows.ActiveWnd.Document as IWorkBook).Page[0] as IDialogDoc);
 SelectedProps:=TStringList.Create;
 SelectedProps.CommaText:=Doc.Selection;

 for i:=0 to doc.LayerCount-1 do
  Layers.Tabs.Add(doc.LayerName[i]);


 tmpStrList:=TStringList.Create;
 for i:=0 to doc.ctrlCount-1 do begin
  if doc.ctrlProp[i,cpLayer]=doc.ActiveLayer then begin
   Alias:=doc.ctrlProp[i,cpStrID];
   If Alias='' then
    Alias:=doc.ctrlProp[i,cpTitle];
   If Alias='' then
    Alias:=doc.ctrlProp[i,cpFormul];

   tmpStrList.AddObject('['+doc.ctrlType[i]+'] - "'+Alias+'"', TObject(doc.ctrlUID(i)));
  end;
 end;
 tmpStrList.Sort;
 ComboBox1.Items.AddStrings(tmpStrList);
 Layers.TabIndex:= Layers.Tabs.IndexOf(doc.ActiveLayer);




 if SelectedProps.Count=0 then
  begin
    ComboBox1.Text:='�������� �����';
    ComboBox1.Enabled:=true;
//    Repaint;
    FormProperty;
    Flag:=true;
    Exit;
  end;


 If ComboBox1.Items.Count=0 then
  begin
    ComboBox1.Text:='��� ���������';
    ComboBox1.Enabled:=false;
    Repaint;
    Flag:=true;
    Exit;
  end;


 // ������������� �������� �������
 if SelectedProps.Count=1 then begin
  for i:=0 to ComboBox1.Items.Count-1 do
   if Doc.ctrlUID(strToInt(SelectedProps[0])) = Integer(ComboBox1.Items.Objects[i]) then begin
    ComboBox1.ItemIndex:=i;
    VisibleProperty;
     Flag:=true;
     exit;
   end
 end
 else  VisibleControlGroup;

 Flag:=true;
end;

procedure TArtbear_ActiveFormX.PropertyInspectorGetCellText(Sender: TObject;
  Cell: TGridCell; var Value: String);
var ctlID,x: integer;
//    xx:Extended;
    FlagsArray: TBooleanArray;
    mDoc:IDialogDoc;

begin
// if not flag then exit;
 mDoc:=((FConfigurator.Windows.ActiveWnd.Document as IWorkBook).Page[0] as IDialogDoc);
 if TabControl1.Tabs[tabControl1.TabIndex]<>'�������� �����' then begin
  case cell.Col of
    0: Begin value:=hInspectorDef[cell.row]; end;
    1: Begin
        ctlID:=Integer(ComboBox1.Items.Objects[ComboBox1.ItemIndex]);
        Case tInspectorDef[cell.row] of

          t1cBool : begin
                    if nInspectorDef[cell.row]=cpFlags then
                     if GetCheckingFlags(hInspectorDef[cell.row],mDoc.ctrlProp[mDoc.ctrlIdx(ctlID), cpFlags])
                      then value:='��'
                      else value:='���'

                    else if nInspectorDef[cell.row] = cpFontWeight then
                     if mDoc.ctrlProp[mDoc.ctrlIdx(ctlID), nInspectorDef[cell.row]]=700
                      then value:='��'
                      else value:='���'

                    else if nInspectorDef[cell.row] in [cpFontItalic,cpFontUnderline] then
                     if Bool(mDoc.ctrlProp[mDoc.ctrlIdx(ctlID), nInspectorDef[cell.row]])
                      then value:='��'
                      else value:='���'

                    else if nInspectorDef[cell.row] = addpPositiveOnly then
                     if Bool(mdoc.ctrlType1C[mDoc.ctrlIdx(ctlID)].PositiveOnly)
                      then value:='��'
                      else value:='���'

                    else if nInspectorDef[cell.row] = addpNumSeparated then
                     if Bool(mdoc.ctrlType1C[mDoc.ctrlIdx(ctlID)].NumSeparated)
                      then value:='��'
                      else value:='���';


{                    else if nInspectorDef[cell.row]=cpFontWeight then
                     if mDoc.ctrlProp[mDoc.ctrlIdx(ctlID), cpFontWeight]=1
                      then value:='��'
                      else value:='���'

                    else if nInspectorDef[cell.row]=cpFontItalic then
                     if mDoc.ctrlProp[mDoc.ctrlIdx(ctlID), cpFontItalic]=1
                      then value:='��'
                      else value:='���'

                    else if nInspectorDef[cell.row]=cpFontUnderline then
                     if mDoc.ctrlProp[mDoc.ctrlIdx(ctlID), cpFontUnderline]=1
                      then value:='��'
                      else value:='���';
                      }
                   end;

          t1cAlign: if hInspectorDef[cell.row]='������������ ��������' then begin
                   if GetCheckingFlags('���������',mDoc.ctrlProp[mDoc.ctrlIdx(ctlID), nInspectorDef[cell.row]]) then value:='���������'
                   else if GetCheckingFlags('�� ������',mDoc.ctrlProp[mDoc.ctrlIdx(ctlID), nInspectorDef[cell.row]]) then value:='�� ������'
                   else if GetCheckingFlags('���������������',mDoc.ctrlProp[mDoc.ctrlIdx(ctlID), nInspectorDef[cell.row]]) then value:='���������������'
                   else begin
                    BitsToBooleans(StrToInt(mDoc.ctrlProp[mDoc.ctrlIdx(ctlID), nInspectorDef[cell.row]]),FlagsArray);
                    SetLength(FlagsArray, 29);
                    FlagsArray[8]:=true;value:='���������';
                    BooleansToBits(x,FlagsArray);
                    mDoc.ctrlProp[mDoc.ctrlIdx(ctlID), nInspectorDef[cell.row]]:=x;
                   end;
                 end;

       t1cType : begin
                  if mdoc.ctrlType1C[mDoc.ctrlIdx(ctlID)].Type_<>ttVoid then
                   value:=mdoc.ctrlType1C[mDoc.ctrlIdx(ctlID)].FullName
                   Else
//                   if value='' then
                   value:='��������������';
                  end

          else
           if nInspectorDef[cell.row]=addpLength then
             value:=IntToStr(mdoc.ctrlType1C[mDoc.ctrlIdx(ctlID)].Length)
           else if nInspectorDef[cell.row]=addpPrecision then
             value:=IntToStr(mdoc.ctrlType1C[mDoc.ctrlIdx(ctlID)].Precision)
           else
            value:=mDoc.ctrlProp[mDoc.ctrlIdx(ctlID), nInspectorDef[cell.row]];
        end {case}
       end;
  end {case}
  end
   else

  case cell.Col of
    0: value:=hInspectorDef[cell.row];
    1: if  nInspectorDef[cell.row] in [fpTitle,fpWidth,fpHeight,fpFontName,fpBKColor] then
        value:=mDoc.formProp[nInspectorDef[cell.row]]
       else if tInspectorDef[cell.row] = t1cBool then
             if GetCheckingFormFlags(hInspectorDef[cell.row], mDoc.formProp[nInspectorDef[cell.row]])
               then value:='��'
               else value:='���'
       else if tInspectorDef[cell.row] = t1cAlign then
             begin
                   if GetCheckingFormFlags('���������',mDoc.formProp[nInspectorDef[cell.row]]) then value:='���������'
                   else if GetCheckingFormFlags('�� ������',mDoc.formProp[nInspectorDef[cell.row]]) then value:='�� ������'
                   else if GetCheckingFormFlags('���������������',mDoc.formProp[nInspectorDef[cell.row]]) then value:='���������������'
                   else begin
                    BitsToBooleans(StrToInt(mDoc.formProp[nInspectorDef[cell.row]]),FlagsArray);
                    SetLength(FlagsArray, 29);
                    FlagsArray[8]:=true;value:='���������';
                    BooleansToBits(x,FlagsArray);
                    mDoc.formProp[nInspectorDef[cell.row]]:=x;
                   end;
                 end;
        else if nInspectorDef[cell.row] = fpFontWeight then
            if mDoc.formProp[nInspectorDef[cell.row]]=700//800
                      then value:='��'
                      else value:='���'

        else if mDoc.formProp[nInspectorDef[cell.row]]=1
                      then value:='��'
                      else value:='���';
       end;{case}
end;

procedure TArtbear_ActiveFormX.PropertyInspectorGetCellText_Group(Sender: TObject;
  Cell: TGridCell; var Value: String);
var x: integer;
//    xx:Extended;
    FlagsArray: TBooleanArray;
    mDoc:IDialogDoc;
    ControlIdx0: integer;

begin
// if not flag then exit;
 mDoc:=((FConfigurator.Windows.ActiveWnd.Document as IWorkBook).Page[0] as IDialogDoc);
 ControlIdx0:= StrToInt(Copy(mDoc.Selection,1,1));
  case cell.Col of
    0: Begin value:=hInspectorDef[cell.row]; end;
    1: Begin
        Case tInspectorDef[cell.row] of

          t1cBool : begin
                    if nInspectorDef[cell.row]=cpFlags then
                     if GetCheckingFlags(hInspectorDef[cell.row],mDoc.ctrlProp[ControlIdx0, cpFlags])
                      then value:='��'
                      else value:='���'

                    else if nInspectorDef[cell.row] = cpFontWeight then
                     if mDoc.ctrlProp[ControlIdx0, nInspectorDef[cell.row]]=700
                      then value:='��'
                      else value:='���'

                    else if nInspectorDef[cell.row] in [cpFontItalic,cpFontUnderline] then
                     if Bool(mDoc.ctrlProp[ControlIdx0, nInspectorDef[cell.row]])
                      then value:='��'
                      else value:='���'

                    else if nInspectorDef[cell.row] = addpPositiveOnly then
                     if Bool(mdoc.ctrlType1C[ControlIdx0].PositiveOnly)
                      then value:='��'
                      else value:='���'

                    else if nInspectorDef[cell.row] = addpNumSeparated then
                     if Bool(mdoc.ctrlType1C[ControlIdx0].NumSeparated)
                      then value:='��'
                      else value:='���';
                   end;

          t1cAlign: if hInspectorDef[cell.row]='������������ ��������' then begin
                   if GetCheckingFlags('���������',mDoc.ctrlProp[ControlIdx0, nInspectorDef[cell.row]]) then value:='���������'
                   else if GetCheckingFlags('�� ������',mDoc.ctrlProp[ControlIdx0, nInspectorDef[cell.row]]) then value:='�� ������'
                   else if GetCheckingFlags('���������������',mDoc.ctrlProp[ControlIdx0, nInspectorDef[cell.row]]) then value:='���������������'
                   else begin
                    BitsToBooleans(StrToInt(mDoc.ctrlProp[ControlIdx0, nInspectorDef[cell.row]]),FlagsArray);
                    SetLength(FlagsArray, 29);
                    FlagsArray[8]:=true;value:='���������';
                    BooleansToBits(x,FlagsArray);
                    mDoc.ctrlProp[ControlIdx0, nInspectorDef[cell.row]]:=x;
                   end;
                 end;

       t1cType : begin
                  if mdoc.ctrlType1C[ControlIdx0].Type_<>ttVoid then
                   value:=mdoc.ctrlType1C[ControlIdx0].FullName
                   Else
//                   if value='' then
                   value:='��������������';
                  end

          else
           if nInspectorDef[cell.row]=addpLength then
             value:=IntToStr(mdoc.ctrlType1C[ControlIdx0].Length)
           else if nInspectorDef[cell.row]=addpPrecision then
             value:=IntToStr(mdoc.ctrlType1C[ControlIdx0].Precision)
           else
            value:=mDoc.ctrlProp[ControlIdx0, nInspectorDef[cell.row]];
        end {case}
//    value:='';
       end;
  end;{case}
end;

procedure TArtbear_ActiveFormX.PropertyInspectorSetEditText(Sender: TObject;
  Cell: TGridCell; var Value: String);
var
//ItemIndex:Integer;
    _Type, OldValue: String;
    ctlID: integer;
    mDoc:IDialogDoc;
    Type1C:IType1C;
begin
 if not Flag then exit;

 OldValue:=PropertyInspector.Cells[1,PropertyInspector.CellFocused.Row];
 if OldValue=Value then exit;


 if TabControl1.Tabs[tabControl1.TabIndex]='�������� �����' then begin

 mDoc:=((FConfigurator.Windows.ActiveWnd.Document as IWorkBook).Page[0] as IDialogDoc);
 ctlID:=Integer(ComboBox1.Items.Objects[ComboBox1.ItemIndex]);

 if cell.row<=Length(hInspectorDef) then
  case tInspectorDef[cell.row] of
   t1cAlign: begin
              if PropertyInspector.Cells[1,PropertyInspector.CellFocused.Row]<>Value then
                  CheckFlags(mDoc.ctrlType[mDoc.ctrlIdx(ctlID)],Value,cell.row,mDoc.ctrlIdx(ctlID));
               PropertyInspector.CancelEdit;
               exit;
            end;
   t1cBool: begin
              if PropertyInspector.Cells[1,PropertyInspector.CellFocused.Row]<>Value then
                  CheckFlags(mDoc.ctrlType[mDoc.ctrlIdx(ctlID)],Value,cell.row,mDoc.ctrlIdx(ctlID));
               PropertyInspector.CancelEdit;
               exit;
            end;
   t1cType: begin

               Type1C:=mdoc.ctrlType1C[mDoc.ctrlIdx(ctlID)];
                _Type:=copy(Value, 1,pos('.', Value)-1);

             if pos('.', Value)=0 then
               _Type:=Value
             else
               _Type:=copy(Value, 1,pos('.', Value)-1);

             If _Type='����������' then
               Type1C.Type_:=ttReference
             Else If _type='��������������' then
               Type1C.Type_:=ttVoid
             else if _type='������' then
               Type1C.Type_:=ttString
             else if _type='�����' then
               Type1C.Type_:=ttNumber
             else if _type='����' then
               Type1C.Type_:=ttDate
             else if _type='��������' then
               Type1C.Type_:=ttDocument
             else if _type='������������' then
               Type1C.Type_:=ttEnum;

             if _Type<>Value then
              Type1C.ID:=FConfigurator.MetaData.TaskDef.Childs[_Type][copy(Value, pos('.', Value)+1,Length(Value)-pos('.', Value)+1)].ID;

             mdoc.ctrlType1C[mDoc.ctrlIdx(ctlID)]:=Type1C;
             ShowInspector;
             exit;
            end;

   t1cInteger: begin
                mDoc.ctrlProp[mDoc.ctrlIdx(ctlID), nInspectorDef[cell.row]]:=StrToInt(value);
                exit;
               end;
  end;

{ if nInspectorDef[cell.Row]=12 then
  begin
   ItemIndex:=ComboBox1.ItemIndex;
     If ParamsList[12]<>'' then
      ComboBox1.Items[ComboBox1.ItemIndex]:='['+GetRussAlias(ParamsList[1])+'] - '+ParamsList[12]
     else if ParamsList[0] <>'' then
      ComboBox1.Items[ComboBox1.ItemIndex]:='['+GetRussAlias(ParamsList[1])+'] - "'+ParamsList[0]+'"'
     else
      ComboBox1.Items[ComboBox1.ItemIndex]:='['+GetRussAlias(ParamsList[1])+'] - <'+ParamsList[11]+'>';


   ComboBox1.ItemIndex:=ItemIndex;
  end;}
  mDoc:=((FConfigurator.Windows.ActiveWnd.Document as IWorkBook).Page[0] as IDialogDoc);
  ctlID:=Integer(ComboBox1.Items.Objects[ComboBox1.ItemIndex]);

  if nInspectorDef[cell.row]=addpLength then begin
   Type1C:=mdoc.ctrlType1C[mDoc.ctrlIdx(ctlID)];
   Type1C.Length:=StrToInt(value);
   mdoc.ctrlType1C[mDoc.ctrlIdx(ctlID)]:=Type1C
  end
  else if nInspectorDef[cell.row]=addpPrecision then begin
   Type1C:=mdoc.ctrlType1C[mDoc.ctrlIdx(ctlID)];
   Type1C.Precision:=StrToInt(value);
   mdoc.ctrlType1C[mDoc.ctrlIdx(ctlID)]:=Type1C
  end
  else
   if tInspectorDef[cell.row]=t1cInteger then
    mDoc.ctrlProp[mDoc.ctrlIdx(ctlID), nInspectorDef[cell.row]]:=StrToInt(value)
   else
    mDoc.ctrlProp[mDoc.ctrlIdx(ctlID), nInspectorDef[cell.row]]:=value;

 PropertyInspector.CancelEdit;
  if (tInspectorDef[cell.row]=t1cLayers)  // ��� ����� ���� ����������
//    or(tInspectorDef[cell.row]=t1cType)
    then
    ShowInspector;
 end
 else begin
  mDoc:=((FConfigurator.Windows.ActiveWnd.Document as IWorkBook).Page[0] as IDialogDoc);

  if nInspectorDef[cell.row] = fpFontWeight then
    if value='��'
     then  mDoc.formProp[nInspectorDef[cell.row]]:=700
     else mDoc.formProp[nInspectorDef[cell.row]]:=0
    else if nInspectorDef[cell.row] in [fpFontItalic, fpFontUnderline, fpUseAutoFont,fpAutoLayout,fpToolBar,fpAutoSize] then
     if value='��'
      then mDoc.formProp[nInspectorDef[cell.row]]:=1
      else mDoc.formProp[nInspectorDef[cell.row]]:=0

   else
    if tInspectorDef[cell.row] in [t1cInteger, t1cColor] then
     mDoc.formProp[nInspectorDef[cell.row]]:=StrToInt(value)
   else if tInspectorDef[cell.row] in [t1cBool, t1cAlign] then
         CheckFormFlags(Value,cell.row)
    else
     mDoc.formProp[nInspectorDef[cell.row]]:=value;

  PropertyInspector.CancelEdit;

 end;


end;

procedure TArtbear_ActiveFormX.PropertyInspectorSetEditText_Group(Sender: TObject;
  Cell: TGridCell; var Value: String);
var x,a:Integer;
//		ItemIndex:Integer;
//    _Type, OldValue: String;
//    ctlID: integer;
    mDoc:IDialogDoc;
//    Type1C:IType1C;
    ControlList : TStringList;
begin
 if not flag then exit;
// PropertyInspector.IsCategoryRow()
 if SelCell.Row<>cell.Row then Exit;
// OldValue:=PropertyInspector.Cells[1,PropertyInspector.CellFocused.Row];
// if OldValue = Value then  exit;

 flag:=false;

 ControlList := TStringList.Create;
 mDoc:=((FConfigurator.Windows.ActiveWnd.Document as IWorkBook).Page[0] as IDialogDoc);
 ControlList.CommaText:=mDoc.Selection;
 for x:=0 to ControlList.Count-1 do begin
  case tInspectorDef[cell.row] of
   t1cAlign: CheckFlags(mDoc.ctrlType[StrToInt(ControlList[x])],Value,cell.row,StrToInt(ControlList[x]));

   t1cBool: CheckFlags(mDoc.ctrlType[StrToInt(ControlList[x])],Value,cell.row,StrToInt(ControlList[x]));

   t1cInteger: begin
                if value[1]='+' then begin
                 a:=StrToInt(Copy(value,2,Length(value)-1));
                 mDoc.ctrlProp[StrToInt(ControlList[x]), nInspectorDef[cell.row]]:=mDoc.ctrlProp[StrToInt(ControlList[x]), nInspectorDef[cell.row]]+a;
                end else if value[1]='-' then begin
                 a:=StrToInt(Copy(value,2,Length(value)-1));
                 mDoc.ctrlProp[StrToInt(ControlList[x]), nInspectorDef[cell.row]]:=mDoc.ctrlProp[StrToInt(ControlList[x]), nInspectorDef[cell.row]]-a;
                end else mDoc.ctrlProp[StrToInt(ControlList[x]), nInspectorDef[cell.row]]:=StrToInt(value);
               end;
   t1cString : mDoc.ctrlProp[StrToInt(ControlList[x]), nInspectorDef[cell.row]]:=value;
   t1cStrings: mDoc.ctrlProp[StrToInt(ControlList[x]), nInspectorDef[cell.row]]:=value;
   t1cLayers : mDoc.ctrlProp[StrToInt(ControlList[x]), nInspectorDef[cell.row]]:=value;
   End;
 end;
 PropertyInspector.CancelEdit;
 flag:=true;
end;

procedure TArtbear_ActiveFormX.PropertyInspectorGetEditList(Sender: TObject;
  Cell: TGridCell; Items: TStrings);
  var ObjArray: IMetaDataObjArray;
  i:integer;
  mDoc:IDialogDoc;
begin
// if not flag then exit;

// if TabControl1.Tabs[tabControl1.TabIndex]='�������� �����' then exit;

  case tInspectorDef[Cell.row] of
   t1cBool    : begin
                 Items.Add('��');
                 Items.Add('���');
                end;
   t1cAlign   : begin
                 Items.Add('���������');
                 Items.Add('�� ������');
                 Items.Add('���������������');
                end;
   t1cFont    : Items.AddStrings(Screen.Fonts);

   t1cExec    : Items.AddStrings( GetFormulsList ); // ����� ������ ��� ������

   t1cLayers   : begin
                  mDoc:=((FConfigurator.Windows.ActiveWnd.Document as IWorkBook).Page[0] as IDialogDoc);
                  for i:=0 to mDoc.LayerCount-1 do
                   Items.Add(mDoc.LayerName[i]);
//                 Items.AddStrings(Layers.Tabs);
                end;
   t1cType    : begin
                 items.Add('��������������');
                 items.Add('������');
                 items.Add('�����');
                 items.Add('����');
                 items.Add('����������');
                 objArray := FConfigurator.MetaData.TaskDef.Childs['����������'];
                 for i := 0 to ObjArray.Count - 1 do
                  items.Add(ObjArray[i].FullName);
                 items.Add('��������');
                 objArray := FConfigurator.MetaData.TaskDef.Childs['��������'];
                 for i := 0 to ObjArray.Count - 1 do
                  items.Add(ObjArray[i].FullName);

                 objArray := FConfigurator.MetaData.TaskDef.Childs['������������'];
                 for i := 0 to ObjArray.Count - 1 do
                  items.Add(ObjArray[i].FullName);
                end;
  end;

end;

procedure TArtbear_ActiveFormX.PropertyInspectorGetEditStyle(Sender: TObject;
  Cell: TGridCell; var Style: TGridEditStyle);
begin
// if not flag then exit;

// if ComboBox1.Text='������ ���������' then exit;
 // if TabControl1.Tabs[tabControl1.TabIndex]='�������� �����' then exit;
 case tInspectorDef[Cell.row] of
 //  (geSimple, geEllipsis, gePickList, geDataList, geUserDefine)
   t1cString   : Style := geSimple;
   t1cStrings  : Style := geEllipsis;
   t1cInteger  : Style := geSimple;
   t1cBool     : Style := gePickList;
   t1cFont     : Style := gePickList;
   t1cColor: Style := geEllipsis;
   t1cExec     : Style := gePickList;
   t1cLayers    : Style := gePickList;
   t1cType     : Style := gePickList;
   t1cAlign    : Style := gePickList;
  end;

end;

// + Phoenix

function GetClassNameID(vClassName:string): Integer;
begin
  if UpperCase(vClassName) = UpperCase('������') then
    Result := 0;
  if UpperCase(vClassName) = UpperCase('�����') then
    Result := 1;
  if UpperCase(vClassName) = UpperCase('�������������') then
    Result := 2;
  if UpperCase(vClassName) = UpperCase('������') then
    Result := 3;
  if UpperCase(vClassName) = UpperCase('������') then
    Result := 4;
  if UpperCase(vClassName) = UpperCase('����������') then
    Result := 5;
  if UpperCase(vClassName) = UpperCase('���������������') then
    Result := 6;
  if UpperCase(vClassName) = UpperCase('��������') then
    Result := 7;
end;

function GetFormulaPrefix(vClassFrmCntrl : string):string;
begin
  Result := mPrefix[GetClassNameID(vClassFrmCntrl)];
end;

function GetFormulaPostfix(vClassFrmCntrl : string):string;
begin
  Result := mPostfix[GetClassNameID(vClassFrmCntrl)];
end;

function GetDividerString() : string;
var
  i : Integer;
  lStr : string;
begin
  lStr := '//';
  for i := 0 to mDividerCount-1 do begin
    lStr := lStr + mDividerSymb;
  end;
  Result := lStr;
end;

// - Phoenix


procedure TArtbear_ActiveFormX.PropertyInspectorDblClick(Sender: TObject);
var ctlID : Integer;
    mDoc  : IDialogDoc;
    Value : Variant;
begin


// Flag:=false;

 case tInspectorDef[PropertyInspector.CellFocused.Row] of
  t1cBool    : Begin
                if PropertyInspector.Cells[1,PropertyInspector.CellFocused.Row]='��'
                 then Value:='���'
                 else Value:='��';
               end;
  t1cFont    :
  // + Phoenix
  { TODO -c[+] -oPhoenix : �������� ����� ���� ��� ��������� ���������� ������ }
  begin
    {
      mDoc:=((FConfigurator.Windows.ActiveWnd.Document as IWorkBook).Page[0] as IDialogDoc);
      ctlID:=Integer(ComboBox1.Items.Objects[ComboBox1.ItemIndex]);
      with TfrmFontEdit.Create(nil) do begin

        // cpFontItalic - �������� �����
        if mDoc.ctrlProp[mdoc.ctrlIdx(ctlID), cpFontItalic] = 1 then
          chkUnderline.Checked := True
        else
          chkUnderline.Checked := False;
        // cpFontSize - �������� �����
        seFontSize.Value := mDoc.ctrlProp[mdoc.ctrlIdx(ctlID), cpFontSize];
        // cpFontName
        cbFont.FontName := mDoc.ctrlProp[mdoc.ctrlIdx(ctlID), cpFontName];

        //cpFontColor
        //  ����� �����, ��� ���� ��� �� ������

        // cpFontUnderline
        if mDoc.ctrlProp[mdoc.ctrlIdx(ctlID), cpFontUnderline] = 1 then
          chkItalic.Checked := True
        else
          chkItalic.Checked := False;



      // cpFontUnderline
      // cpFontWeight


        ShowModal;
        if ModalResult = mrOk then begin
          //ctlID:=Integer(ComboBox1.ItemIndex);
          // mDoc.ctrlIdx(ctlID)
          //  ������ ��� ������, �� ��-�� ���� �� ��� ������������� 
          if chkUnderline.Checked then
            mDoc.ctrlProp[mdoc.ctrlIdx(ctlID), cpFontItalic ]:= 1
          else
            mDoc.ctrlProp[mdoc.ctrlIdx(ctlID), cpFontItalic ]:= 0;
            
          mDoc.ctrlProp[mdoc.ctrlIdx(ctlID), cpFontSize] := seFontSize.Value;
          mDoc.ctrlProp[mdoc.ctrlIdx(ctlID), cpFontName] := cbFont.FontName; 

//    else if nInspectorDef[cell.row] in [fpFontItalic, fpFontUnderline, fpUseAutoFont,fpAutoLayout,fpToolBar,fpAutoSize] then
//     if value='��'
//      then mDoc.formProp[nInspectorDef[cell.row]]:=1
//      else mDoc.formProp[nInspectorDef[cell.row]]:=0
//
//   else
//    if tInspectorDef[cell.row] in [t1cInteger, t1cColor] then
//     mDoc.formProp[nInspectorDef[cell.row]]:=StrToInt(value)
//   else if tInspectorDef[cell.row] in [t1cBool, t1cAlign] then
//         CheckFormFlags(Value,cell.row)
//    else
//     mDoc.formProp[nInspectorDef[cell.row]]:=value;
        end;
      end;
      }
    end;
  // - Phoenix

  t1cExec    : begin
                mDoc:=((FConfigurator.Windows.ActiveWnd.Document as IWorkBook).Page[0] as IDialogDoc);
                ctlID:=Integer(ComboBox1.Items.Objects[ComboBox1.ItemIndex]);
                if PropertyInspector.Cells[1,PropertyInspector.CellFocused.Row]='' then
                    PropertyInspector.Cells[1,PropertyInspector.CellFocused.Row] :=
                        GetFormulaPrefix(mDoc.ctrlType[mDoc.ctrlIdx(ctlID)])
                        + mDoc.ctrlProp[mDoc.ctrlIdx(ctlID), cpStrID]
                        + GetFormulaPostfix(mDoc.ctrlType[mDoc.ctrlIdx(ctlID)])
                        + '()';
//                 Else Value:=PropertyInspector.Cells[1,PropertyInspector.CellFocused.Row];
                if mdoc.ctrlType[mDoc.ctrlIdx(ctlID)]='�����' then
                 GetProcFuncPos(false,
                               GetFormulaPrefix(mDoc.ctrlType[mDoc.ctrlIdx(ctlID)])
                               //+PropertyInspector.Cells[1,PropertyInspector.CellFocused.Row]
                                + mDoc.ctrlProp[mDoc.ctrlIdx(ctlID), cpStrID]
                               + GetFormulaPostfix(mDoc.ctrlType[mDoc.ctrlIdx(ctlID)])
                               + '()')

                else
                 GetProcFuncPos(true,
                              GetFormulaPrefix(mDoc.ctrlType[mDoc.ctrlIdx(ctlID)])
                              + mDoc.ctrlProp[mDoc.ctrlIdx(ctlID), cpStrID] //PropertyInspector.Cells[1,PropertyInspector.CellFocused.Row]
                               + GetFormulaPostfix(mDoc.ctrlType[mDoc.ctrlIdx(ctlID)])
                               + '()'

                              );

               end;

 end;
// Flag:=true;
 //, t1cExec

  if tInspectorDef[PropertyInspector.CellFocused.Row] in [t1cBool] then
    PropertyInspector.Cells[1,PropertyInspector.CellFocused.Row]:=String(Value);
end;

procedure TArtbear_ActiveFormX.ComboBox1Change(Sender: TObject);
begin
 VisibleProperty;
end;


procedure TArtbear_ActiveFormX.PropertyInspectorEditButtonPress(Sender: TObject;
  Cell: TGridCell);
begin
// if TabControl1.Tabs[tabControl1.TabIndex]='�������� �����' then exit;

 if tInspectorDef[Cell.Row]=t1cColor then begin

//  ColorDialog.Color:=RGBToColor(StrToInt(PropertyInspector.Cells[1,PropertyInspector.CellFocused.Row]));
  if ColorDialog.Execute then
   PropertyInspector.Cells[1,PropertyInspector.CellFocused.Row]:=IntToStr(  ColorToRGB(ColorDialog.Color));
 end
 else  begin
  Application.CreateForm(TForm2, Form2);
  PropertyInspector.Cells[1,PropertyInspector.CellFocused.Row]:=Form2.Execute(PropertyInspector.Cells[1,PropertyInspector.CellFocused.Row]);
 end;
end;                          

procedure TArtbear_ActiveFormX.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose:=False;
  Visible:=false;
  PropertyInspector.Rows.Count:=0;
end;

Function TArtbear_ActiveFormX.GetProcFuncPos(proc: boolean; Name: String):Integer;
Const
  ProcD = '���������';
  FuncD = '�������';

var i:integer;
    sText: string;
    ModuleText:TStringList;
    Doc:ITextDoc;
    wdoc:IWorkBook;

begin
 ModuleText:=TStringList.Create;
 Doc:=((FConfigurator.Windows.ActiveWnd.Document as IWorkBook).Page[1] as ITextDoc);
 wdoc:=(FConfigurator.Windows.ActiveWnd.Document as IWorkBook);
 wdoc.ActivePage := 0;
 wdoc.ActivePage := 1;

 doc.MoveCaret (0, 0, 0, 0);
 ModuleText.Text:=Doc.text;

// result:=0;
 {
 if proc then
  ProcFunc:='���������'
 else
  ProcFunc:='�������';
  }

 for i := 0 to ModuleText.Count-1 do//������ � ������ ���������/�������
 begin
  sText := AnsiUpperCase(ModuleText[i]);
   if ((not proc) and
       (Pos(AnsiUpperCase(FuncD)+' '+AnsiUpperCase(Copy(Name, 1, pos('(',Name)-1)),sText) = 1))
    or((Proc)And
       (Pos(AnsiUpperCase(ProcD)+' '+AnsiUpperCase(Copy(Name, 1, pos('(',Name)-1)),sText) = 1) or
       (Pos(AnsiUpperCase(FuncD)+' '+AnsiUpperCase(Copy(Name, 1, pos('(',Name)-1)),sText) = 1)
       )    then

               Begin

		doc.MoveCaret (i, 0, 0, 0);
		doc.MoveCaret (i,0,i,Length(sText)); //������� ������
                result:=i;
		Exit;
	       end;
 end;

 for i := ModuleText.Count-1 downto 0 do
 begin
  sText := AnsiUpperCase(ModuleText[i]);
   if (Pos('��������������',sText) = 1)
     or(Pos('������������',sText) = 1)  then
     break;
 end;
                if proc then
                 doc.Range[i,Length(sText),i,Length(sText)]:=#13#10
                  +GetDividerString()+#13#10
                    +ProcD+' '+Name+#13#10+'   '+#13#10
                    +'��������������'
                else
                 doc.Range[i,Length(sText),i,Length(sText)]:=#13#10
                 +GetDividerString()+#13#10+FuncD+' '+Name+#13#10+'   '+#13#10
                 +'������������';

                doc.MoveCaret (i+3,4,i+3,4);
                result:=i;
End;

Function GetProcFuncParams(SourseLine: String):TStringList;
var i:integer;
    paramsLine: string;
begin
 Result:=TStringList.Create;
 i:=Pos('(',SourseLine)+1;
 paramsLine:=Copy(SourseLine,i,Pos(')',SourseLine)-i);
 If paramsLine<>'' then
  begin
   Result.CommaText:=paramsLine;
  end;
End;

procedure TArtbear_ActiveFormX.LayersChange(Sender: TObject; NewTab: Integer;
  var AllowChange: Boolean);
var
  mDoc:IDialogDoc;
  i: integer;
begin
 if not flag then exit;

  mDoc:=((FConfigurator.Windows.ActiveWnd.Document as IWorkBook).Page[0] as IDialogDoc);
  For i:=0 to Layers.Tabs.Count-1 do
   mDoc.LayerVisible[Layers.Tabs[i]]:=false;

   mDoc.LayerVisible[Layers.Tabs[NewTab]]:=true;
   mDoc.ActiveLayer:=Layers.Tabs[NewTab];

  ShowInspector;
end;

//***********************************************

procedure TArtbear_ActiveFormX.Run;
begin
 TabControl1.Tabs.Clear;
 TabControl1.TabIndex:=0;
 TabControl1.Tabs.Add('�������� �����');
 TabControl1.Tabs.Add('�������� �����');
 AllFlags:=TStringList.Create();

 AllFlags.Add(''); //0
 AllFlags.Add(''); //1
 AllFlags.Add( '���������� ��� �����');//2
 AllFlags.Add( '' );//3
 AllFlags.Add( '������������ ��������');//4
 AllFlags.Add( '����� ������ ������' );//5
 AllFlags.Add( '����� �� ���������');//6
 AllFlags.Add( '������������ ���� ������ "����"');//7
 AllFlags.Add( '���������');//8
 AllFlags.Add( '���������');//9
 AllFlags.Add( '�� ������');//10
 AllFlags.Add( '���������������');//11
 AllFlags.Add( '�������������');//12
 AllFlags.Add( '������� ���������');//13
 AllFlags.Add( '������� �����������');//14
 AllFlags.Add( '' );//15
 AllFlags.Add( '���������� ���');//16
 AllFlags.Add( '����� �������');//17
 AllFlags.Add( '����� ��������');//18
 AllFlags.Add( '����� ����������');//19
 AllFlags.Add( '���������');//20
 AllFlags.Add( '' );//21
 AllFlags.Add( '�� ��������� ������');//22
 AllFlags.Add( '� ��� �� �������');//23
 AllFlags.Add( '��������� ��� ���� ���������');//24
 AllFlags.Add( '������ � ���������');//25
 AllFlags.Add( '������������� �������');//26
 AllFlags.Add( '�������� �����������');//27
 AllFlags.Add( '������ ��������������');//28

 ComboBox1.OnChange:=ComboBox1Change;
 Layers.OnChange:=LayersChange;

 TabControl1.Visible:=True;
 Layers.Visible:=True;

 PropertyInspector.Columns[0].Width:=130; // �����

 PropertyInspector.OnGetCellText:=PropertyInspectorGetCellText;
 PropertyInspector.OnDblClick:=PropertyInspectorDblClick;
 PropertyInspector.OnGetEditList:=PropertyInspectorGetEditList;
 PropertyInspector.OnGetEditStyle:=PropertyInspectorGetEditStyle;
 PropertyInspector.OnEditButtonPress:=PropertyInspectorEditButtonPress;
 PropertyInspector.OnSetEditText:=PropertyInspectorSetEditText;
// PropertyInspector.OnEditAcceptKey:=PropertyInspectorEditAcceptKey;
// PropertyInspector.OnKeyDown:=PropertyInspectorKeyDown;
// PropertyInspector.OnKeyPress:=PropertyInspectorKeyPress;

 ShowInspector;
end;

Procedure TArtbear_ActiveFormX.OnDialogChange (const Dialog: IDialogDoc);
begin
 Flag:=false;
 ShowInspector;
 Flag:=true;
end;

procedure TArtbear_ActiveFormX.OnActivateWindow(const Wnd: ICfgWindow; bActive: WordBool);
var
//obj: variant; newErt: ICfgWindow;
//	s:AnsiString;
	 fExit: Boolean;
begin
 fExit:=False;

 if not bActive or (Wnd.Caption = '') then fExit:=True;

 Try
  FConfigurator.Windows.ActiveWnd.Document.Type_;
 except
  fExit:=True;
 end;

 if (Wnd.Caption = '������������')
  or(Wnd.Caption = '����� �������') then fExit:=True;

 if fExit then
  begin
   ComboBox1.Text:='��� ���������';
   ComboBox1.Enabled:=false;
   TabControl1.Tabs.Clear;
   Layers.Visible:=False;
   TabControl1.Visible:=False;
   PropertyInspector.Rows.Count:=0;
   ComboBox1.Items.Clear;
   Layers.Tabs.Clear;
   Repaint;
   Exit;
  end;


 run;

end;



procedure TArtbear_ActiveFormX.OnIdle;
var SelectedProps :TStringList;
    Doc:IDialogDoc;
    i: integer;
//    ActiveLayer:String;
begin
 if not flag then Exit;
 if FConfigurator.Windows.ActiveWnd.Document.Type_<>docWorkBook then
  begin
    ComboBox1.Text:='��� ���������';
    ComboBox1.Enabled:=false;
    PropertyInspector.Rows.Count:=0;
    Repaint;
    Exit;
  end;

 Doc:=((FConfigurator.Windows.ActiveWnd.Document as IWorkBook).Page[0] as IDialogDoc);
 If PredSelections=Doc.Selection then exit;
 PredSelections:=Doc.Selection;

 { if Doc.Selection='' then begin
  ActiveLayer:=Doc.ActiveLayer;
  for i:=0 to doc.ctrlCount-1 do
   if doc.ctrlProp[i,cpLayer]=ActiveLayer then begin
    Doc.Selection:=IntToStr(i);
   end;
 end;
 }

 SelectedProps:=TStringList.Create;
 SelectedProps.CommaText:=Doc.Selection;

 if SelectedProps.Count=0 then begin
    TabControl1.TabIndex:= TabControl1.Tabs.IndexOf('�������� �����');
    ComboBox1.Text:='�������� �����';
    PropertyInspector.Rows.Count:=0;
    FormProperty;
  end
 else if SelectedProps.Count=1 then begin
//  if Doc.ctrlUID(strToInt(SelectedProps[0])) = Integer(ComboBox1.Items.Objects[ComboBox1.ItemIndex]) then exit;
  for i:=0 to ComboBox1.Items.Count-1 do
   if Doc.ctrlUID(strToInt(SelectedProps[0])) = Integer(ComboBox1.Items.Objects[i]) then begin
    ComboBox1.Enabled:=true;
    ComboBox1.ItemIndex:=i;
    VisibleProperty;
   end;
 end
 else begin
  VisibleControlGroup;
 end;


end;

procedure TArtbear_ActiveFormX.ComboBox1KeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  If not Key in [38,40] then Key:=0;
end;

procedure TArtbear_ActiveFormX.ComboBox1KeyPress(Sender: TObject;
  var Key: Char);
begin
  If not (Key in [#38,#40]) then Key:=#0;
end;

procedure TArtbear_ActiveFormX.TabControl1Change(Sender: TObject);
var
  mDoc:IDialogDoc;
//  i: integer;
begin
 if not flag then exit;

 mDoc:=((FConfigurator.Windows.ActiveWnd.Document as IWorkBook).Page[0] as IDialogDoc);
 if TabControl1.Tabs[TabControl1.TabIndex] = '�������� �����' then begin
  mDoc.Selection:='';
  FormProperty;
  end
 else if TabControl1.Tabs[TabControl1.TabIndex] = '�������� �����' then begin
  If ComboBox1.Items.Count=0 then begin
   ComboBox1.Text:='��� ���������';
   ComboBox1.Enabled:=false;
   PropertyInspector.Rows.Count:=0;
  end else begin
   ComboBox1.ItemIndex:=0;
   ComboBox1.Text:=ComboBox1.Items[0];
   VisibleProperty;
  end;
 end;

end;

procedure TArtbear_ActiveFormX.PropertyInspectorChanging(Sender: TObject;
  var Cell: TGridCell; var Selected: Boolean);
begin
 if Selected then
  SelCell:=Cell;
end;

// ����� - ��������� ������ ������/������� ��� ����������� � ���� �������
function TArtbear_ActiveFormX.GetFormulsList: TStrings;
var
	v: OleVariant;
  s: string;
begin
	result := TStringList.Create;
  if FEvents = nil then
  	Exit;

	s:= result.CommaText;
  v := s;
    try
	  	FEvents.OnGetMethodsList(v);
      s := v;
    except
      on E:Exception do begin
        s := '�������: ����� ������������ ������� GetFormulsList ��������'#13#10+
        '�������� ����������:'#13#10+E.Message;
      	ShowMessage(s);
      end;
    end;
		result.CommaText := s;
end;
// + Phoenix
procedure TArtbear_ActiveFormX.SetFormulaPostfix(const vClassName,
  vPostfix: WideString);
var
  s : string;
begin
 mPostfix[GetClassNameID(vClassName)] := vPostfix;
end;

procedure TArtbear_ActiveFormX.SetFormulaPrefix(const vClassName,
  vPrefix: WideString);
begin
  mPrefix[GetClassNameID(vClassName)] := vPrefix;
end;

procedure TArtbear_ActiveFormX.SetProcFuncDivider(vCount: SYSINT;
  const vDivider: WideString);
begin
  mDividerCount := vCount;
  mDividerSymb := vDivider;
end;
// - Phoenix
initialization
  TActiveFormFactory.Create(
    ComServer,
    TActiveFormControl,
    TArtbear_ActiveFormX,
    Class_Artbear_ActiveFormX,
    1,
    '',
    OLEMISC_SIMPLEFRAME or OLEMISC_ACTSLIKELABEL,
    tmSingle);
end.
