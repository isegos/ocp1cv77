{ *****************************************************************************
  WARNING: This component file was generated using the EventSinkImp utility.
           EventSinkImp is written by Binh Ly (bly@castle.net)
  *****************************************************************************}
unit SinkObject;

interface

uses
  Windows, ActiveX, Classes, ComObj;

type
  TBaseSink = class (TObject, IUnknown, IDispatch)
  protected
    { ������ IUnknown }
    function QueryInterface(const IID: TGUID; out Obj): HResult; stdcall;
    function _AddRef: Integer; stdcall;
    function _Release: Integer; stdcall;
    { ������ IDispatch }
    function GetIDsOfNames(const IID: TGUID; Names: Pointer;
      NameCount, LocaleID: Integer; DispIDs: Pointer): HResult; virtual; stdcall;
    function GetTypeInfo(Index, LocaleID: Integer; out TypeInfo): HResult; virtual; stdcall;
    function GetTypeInfoCount(out Count: Integer): HResult; virtual; stdcall;
    function Invoke(DispID: Integer; const IID: TGUID; LocaleID: Integer;
      Flags: Word; var Params; VarResult, ExcepInfo, ArgErr: Pointer): HResult; virtual; stdcall;
  protected
    FCookie : integer;
    FCP : IConnectionPoint;  
    FSinkIID : TGuid;
    FSource : IUnknown;
    function DoInvoke (DispID: Integer; const IID: TGUID; LocaleID: Integer;
      Flags: Word; var dps : TDispParams; pDispIds : PDispIdList;
      VarResult, ExcepInfo, ArgErr: Pointer): HResult; virtual; abstract;
  public
    destructor Destroy; override;
    procedure Connect (pSource : IUnknown);
    procedure Disconnect;
    property SinkIID : TGuid read FSinkIID;
    property Source : IUnknown read FSource;
  end;

implementation

uses
  SysUtils;

procedure BuildPositionalDispIds (pDispIds : PDispIdList; const dps : TDispParams);
var
  I : integer;
begin
  { �� ��������� �������� ��������� � �������� ������� }
  for I := 0 to dps.cArgs - 1 do
    pDispIds^ [I] := dps.cArgs - 1 - I;
  { ��������� ����������� ��������� }
  if (dps.cNamedArgs <= 0) then 
    Exit;
  { ������������  ����������� ��������� }
  for I := 0 to dps.cNamedArgs - 1 do
    pDispIds^ [dps.rgdispidNamedArgs^[I]] := I;
end;

{ TBaseSink }

function TBaseSink.Invoke(DispID: Integer; const IID: TGUID; LocaleID: Integer;
  Flags: Word; var Params; VarResult, ExcepInfo, ArgErr: Pointer): HResult;
var
  dps : TDispParams absolute Params;
  bHasParams : boolean;
  pDispIds : PDispIdList;
  iDispIdsSize : integer;
begin
  { �������� ������������ ������ }
  if (Flags AND DISPATCH_METHOD = 0) then
    raise Exception.Create(
      Format('%s only supports sinking of method calls!', [ClassName] ));
  { ���������� ������� pDispIds. ��� ����� ��������� ��������� ������
    �� ��������� ������������ ������ � ������������ �����������,
    �����, ��� AppEvents �� Excel � �.�. }
  pDispIds := NIL;
  iDispIdsSize := 0;
  bHasParams := (dps.cArgs > 0);
  if bHasParams then
  begin
    iDispIdsSize := dps.cArgs * SizeOf(TDispId);
    GetMem(pDispIds, iDispIdsSize);
  end;  
  try
    { ������������� DispIds }
{ TODO : ��� ������������� ��������� ����� "�� ��������� �������� ��������� � �������� �������" }
    if bHasParams then
      BuildPositionalDispIds(pDispIds, dps);

    Result := DoInvoke(DispId, IID, LocaleID, Flags, dps, pDispIds,
      VarResult, ExcepInfo, ArgErr);
  finally
    { ����������� ������ }
    if bHasParams then 
      FreeMem (pDispIds, iDispIdsSize);
  end; 
end;

function TBaseSink.QueryInterface(const IID: TGUID; out Obj): HResult;
begin
  Result := E_NOINTERFACE;
  Pointer(Obj) := NIL;
  if (GetInterface (IID, Obj)) then Result := S_OK;
  { ���� ������������� ��������� SinkIID - ���������� ����  IDispatch }
  if not Succeeded (Result) then
    if (IsEqualIID (IID, FSinkIID)) then
      if (GetInterface (IDispatch, Obj)) then
        Result := S_OK;
end;

{��������� ������ - ��������}

function TBaseSink.GetIDsOfNames(const IID: TGUID; Names: Pointer;
  NameCount, LocaleID: Integer; DispIDs: Pointer): HResult;
begin
  Result := E_NOTIMPL;
end;

function TBaseSink.GetTypeInfo(Index, LocaleID: Integer; out TypeInfo): HResult;
begin
  Result := E_NOTIMPL;
  pointer (TypeInfo) := NIL;
end;

function TBaseSink.GetTypeInfoCount(out Count: Integer): HResult;
begin
  Result := E_NOTIMPL;
  Count := 0;
end;

function TBaseSink._AddRef: Integer;
begin
  Result := 2;
end;

function TBaseSink._Release: Integer;
begin
  Result := 1;
end;

destructor TBaseSink.Destroy;
begin
  Disconnect;
  inherited;
end;

procedure TBaseSink.Connect(pSource : IUnknown);
var
  pcpc : IConnectionPointContainer;
begin
  Disconnect;
  try
    // ����������� ��������� IConnectionPointContainer
    OleCheck(pSource.QueryInterface (IConnectionPointContainer, pcpc));
    // ����������� ��������� IConnectionPoint
    OleCheck(pcpc.FindConnectionPoint (FSinkIID, FCP));
    // ������������ � ����������� �������
    OleCheck(FCP.Advise(Self, FCookie));
    // ��� ������ ������� - ������������� �������� Source
    FSource := pSource;
  except
    raise Exception.Create(Format('Unable to connect %s.'#13'%s',
      [ClassName, Exception (ExceptObject).Message]));
  end;  
end;

procedure TBaseSink.Disconnect;
begin
  if (FSource = NIL) then Exit;
  try
    OleCheck (FCP.Unadvise (FCookie));
    FCP := NIL;
    FSource := NIL;
  except
    pointer (FCP) := NIL;
    pointer (FSource) := NIL;
  end;  
end;

end.
