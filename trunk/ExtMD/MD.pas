unit MD;

{$WARN SYMBOL_PLATFORM OFF}

interface

uses
  ComObj, ActiveX, ExtMD_TLB, StdVcl, ComCtrls, FormExtMD, Classes, ParsingMD,
  SysUtils, AxCtrls, Windows, Dialogs, FileCtrl, listUsers;

type
  TMD = class(TAutoObject, IMD)
  protected
  private
    vRootNode: TTreeNode;
  public
    // variables
    frm: TfrmExtMD;
    FileName: WideString;
    RootStorage: IStorage;
    vMetadata: TStringList;

    constructor CreateObj(frmSS: TfrmExtMD);
    destructor Destroy;

    procedure ReadStrct;
    procedure CreateNodes;
    procedure GrfNode(vNode: TTreeNode; vImg: Integer);
    function CreateData(vID, vClass, vPart, vModule: string): pTreeData;
    procedure InsertObjItem(MDNodes: TTreeNodes; vParent: TTreeNode;
      PromList, Lst, Lst2: TStringlist);
    //procedure InsertStrctItem(vName: string; vNode: TTreeNode);
    procedure InsertStrctItem(vName: string; vNode: TTreeNode; vImgID: Integer =
      69);

    function GetInterfacesNamesList: WideString; safecall;
    function GetRightsNamesList: WideString; safecall;
    procedure CloseFile; safecall;
    procedure OpenFile(var vFileName: WideString); safecall;
    procedure TextOpen; safecall;
    procedure TextSaveInFile(var vFileName: WideString); safecall;
  end;

var
  // ���������� ���������� �� �������� ������� ������ ������������
  vNodeConsts, vNodeRefs, vNodeDocs, vNodeJournals, vNodeEnums,
    vNodeReps, vNodeCalcVars, vNodeAccLists, vNodeSubcnts, vNodeOper,
    vNodeProv, vNodeRegs, vNodeCJ, vNodeKindCalcs, vNodeGprCalcs,
    vNodeCalndars, vNodeNums, vNodePosled, vNodeDocSelRefObj,
    vNodeGenJrnlFldDef,
    vNodeRulesCalc, vNodeRecAccLst, vNodeFrmAcclSt, vNodeOperation,
    vNodeRecOper, vNodeRecProv, vNodeGrfJO, vNodeFrmJO, vNodeFrmPorv,
    vErNode: TTreeNode;

const
  iDocForm = 0;
  iRecForm = 1;
  iNoteForm = 2;
  iObj = 100;
  //
  GrfConsts = 28;
  GrfConst = 29; //!
  GrfConstPeriod = 76; //!

  GrfRefs = 30;
  GrfRef = 31;

  GrfDocs = 32;
  GrfDoc = 33;
  GrfObRecs = 34;
  GrfObRec = 35;

  GrfJrns = 36;
  GrfJrn = 37;
  GrfJrnGrOtb = 38;

  GrfEnums = 39; //!
  GrfEnum = 40; //!

  GrfReps = 41;
  GrfRep = 42;

  GrfCalcVars = 43;
  GrfCalcVar = 44; //!

  GrfAccLists = 45;
  GrfAccList = 46;

  GrfSubcnts = 0;
  GrfSubcnt = 0;

  GrfOpers = 62;
  GrfProv = 63;

  GrfRegs = 47;
  GrfReg = 48;
  GrfRegIzm = 49;
  GrfRegRess = 50;
  GrfRegRecs = 35;
  GrfRegRec = 24;

  GrfCJs = 51;
  GrfCJ = 52;

  GrfKindCalcs = 53;
  GrfKindCalc = 54;

  GrfGrpCalc = 55;

  GrfCalndars = 56;
  GrfCalndar = 57;

  GrfFrmEdit = 67;
  GrfFrmNote = 68;
  GrfFldr = 4;
  GrfElement = 69;
  GrfFrmList = 67;
  GrfFrmModule = 18;

  GrfRecPeriod = 74;
  GrfRecSort = 75;
  GrfRecFilter = 73;

  GrfRecFrm = 85;
  GrfRecTxt = 86;

  GrfCfg = 58;

  GrfRights = 90;
  GrfInterfaces = 91;
  GrfUsers = 92;

implementation

uses ComServ;

constructor TMD.CreateObj(frmSS: TfrmExtMD);
begin
  inherited Create;
  frm := frmSS;
end;

destructor TMD.Destroy;
begin
end;
//------------------------------------------------------------------------------

procedure TMD.InsertStrctItem(vName: string; vNode: TTreeNode; vImgID:
  Integer = 69);
//var
//  LItem: TListItem;
begin
  //  LItem := vListStrct.Items.Add;
  //  LItem.Caption := UpperCase(vName);
  //  LItem.Data := Pointer(vNode);
  GrfNode(vNode, vImgID);
end;

//------------------------------------------------------------------------------

function TMD.CreateData(vID, vClass, vPart, vModule: string): pTreeData;
var
  vTrDt: pTreeData;
begin
  New(vTrDt);
  //  vTrDt.Root := RootStorage;
    //vTrDt.Doc := Self;
  vTrDt.ID := vID;
  vTrDt.FolderClass := vClass;
  vTrDt.Part := vPart;
  vTrDt.Module := vModule;
  Result := vTrDt;
end;

procedure TMD.GrfNode(vNode: TTreeNode; vImg: Integer);
begin
  vNode.ImageIndex := vImg;
  vNode.SelectedIndex := vImg;
end;
//------------------------------------------------------------------------------

procedure TMD.CreateNodes;
var
  vTreeItems: TTreeNodes;
begin
  // ������� ����� ������, ����������� ������ �� ��� � ������
  // ���������� ����� ���������� ���������� ���� ������
  // ����������� ����� ������� ������ �� �������� �������� ������ ������������
  vTreeItems := frm.TreeViewMD.Items;
  vNodeConsts := vTreeItems.AddChildObject(vRootNode, '���������',
    nil);
  GrfNode(vNodeConsts, GrfConsts);
  vNodeRefs := vTreeItems.AddChildObject(vRootNode, '�����������',
    nil);
  GrfNode(vNodeRefs, GrfRefs);
  vNodeDocs := vTreeItems.AddChildObject(vRootNode, '���������',
    nil);
  GrfNode(vNodeDocs, GrfDocs);
  vNodeNums := vTreeItems.AddChildObject(vNodeDocs, '���������',
    nil);
  GrfNode(vNodeNums, GrfDocs);
  vNodePosled := vTreeItems.AddChildObject(vNodeDocs,
    '������������������', nil);
  GrfNode(vNodePosled, GrfDocs);
  vNodeGenJrnlFldDef := vTreeItems.AddChildObject(vNodeDocs,
    '����� ���������', nil);
  GrfNode(vNodeGenJrnlFldDef, GrfObRecs);
  vNodeJournals := vTreeItems.AddChildObject(vRootNode,
    '������� ����������', nil);
  GrfNode(vNodeJournals, GrfJrns);
  vNodeDocSelRefObj := vTreeItems.AddChildObject(vNodeJournals,
    '����� ������', nil);
  GrfNode(vNodeDocSelRefObj, GrfObRecs);
  vNodeEnums := vTreeItems.AddChildObject(vRootNode, '������������',
    nil);
  GrfNode(vNodeEnums, GrfEnums);
  vNodeReps := vTreeItems.AddChildObject(vRootNode, '������', nil);
  GrfNode(vNodeReps, GrfReps);
  vNodeCalcVars := vTreeItems.AddChildObject(vRootNode, '���������',
    nil);
  GrfNode(vNodeCalcVars, GrfCalcVars);
  vNodeRegs := vTreeItems.AddChildObject(vRootNode, '��������',
    nil);
  GrfNode(vNodeRegs, GrfRegs);
  vNodeCalndars := vTreeItems.AddChildObject(vRootNode, '���������',
    nil);
  GrfNode(vNodeCalndars, GrfCalndars);
  vNodeKindCalcs := vTreeItems.AddChildObject(vRootNode,
    '���� ��������',
    nil);
  GrfNode(vNodeKindCalcs, GrfKindCalcs);
  vNodeRulesCalc := vTreeItems.AddChildObject(vNodeKindCalcs,
    '������� ���������', nil);
  GrfNode(vNodeRulesCalc, GrfObRecs);
  vNodeGprCalcs := vTreeItems.AddChildObject(vRootNode,
    '������ ��������',
    nil);
  GrfNode(vNodeGprCalcs, GrfGrpCalc);
  vNodeCJ := vTreeItems.AddChildObject(vRootNode,
    '������� ��������',
    nil);
  GrfNode(vNodeCJ, GrfCJs);
  vNodeAccLists := vTreeItems.AddChildObject(vRootNode,
    '����� ������',
    nil);
  GrfNode(vNodeAccLists, GrfAccLists);
  vNodeRecAccLst := vTreeItems.AddChildObject(vNodeAccLists,
    '��������� ����� ������', nil);
  GrfNode(vNodeRecAccLst, GrfObRecs);
  vNodeFrmAcclSt := vTreeItems.AddChildObject(vNodeAccLists,
    '����� ������ ����� ������', nil);
  GrfNode(vNodeFrmAcclSt, GrfDoc);
  vNodeSubcnts := vTreeItems.AddChildObject(vRootNode, '��������',
    nil);
  GrfNode(vNodeSubcnts, GrfObRecs);
  vNodeOperation := vTreeItems.AddChildObject(vRootNode, '��������',
    nil);
  GrfNode(vNodeOperation, GrfOpers);
  vNodeRecOper := vTreeItems.AddChildObject(vNodeOperation,
    '��������� ���������', nil);
  GrfNode(vNodeRecOper, GrfOpers);
  vNodeRecProv := vTreeItems.AddChildObject(vNodeOperation,
    '��������� ��������', nil);
  GrfNode(vNodeRecProv, GrfObRecs);
  vNodeGrfJO := vTreeItems.AddChildObject(vNodeOperation,
    '����� ������� ��������', nil);
  GrfNode(vNodeGrfJO, GrfObRecs);
  vNodeFrmJO := vTreeItems.AddChildObject(vNodeOperation,
    '����� ������� ��������', nil);
  GrfNode(vNodeFrmJO, GrfDoc);
  vNodeFrmPorv := vTreeItems.AddChildObject(vNodeOperation,
    '����� ������� ��������', nil);
  GrfNode(vNodeFrmPorv, GrfDoc);
end;
//------------------------------------------------------------------------------

procedure TMD.InsertObjItem(
  MDNodes: TTreeNodes;
  vParent: TTreeNode;
  PromList, Lst, Lst2: TStringlist
  );
var
  q: integer;
begin
  for q := 1 to Lst.Count - 1 do
  begin
    Lst2 := ParseString(Lst.Values['Param' + IntToStr(q)]);
    GrfNode(
      MDNodes.AddChildObject(vParent, _GetNameByID(PromList,
      Lst2.Values['Param0'], 0), nil), GrfElement);
  end;
end;
//-----------------------------------------------------------------------------------

procedure TMD.ReadStrct;
var
  MDStream: IStream;
  DocStorage: IStorage;
  MemoStream: TStream;
  Ole: TOleStream;
  Contents, IDList, PromList, PList1, PList2, PList3, PList4,
    PList5, PList6: TStringList;
  s: WideString;
  i, j, k, q: integer;
  B: Char;
  BakupNum: integer;
  MDFilePath, SbCnts, vIDElementForm, vIDGroupForm: string;
  vStr: string;
  vNodeDoc, vParentDoc, vParent, vNodeRec, vParent2: TTreeNode;
  MDNodeRoot: TTreeNode;
  MDNodes: TTreeNodes;
  vCurNode: TTreeNode;
  MDInfo: TFileMD;
  vLstUsers: IListUsers;
begin
  try
    MDInfo := TFileMD.Create;
    MDInfo.MDFile := Self;

    MDNodeRoot := frm.TreeViewMD.Items.AddObject(nil, FileName,
      Pointer(MDInfo));

    vParent := frm.TreeViewMD.Items.AddChildObject(MDNodeRoot,
      '���������� ������',
      CreateData('1', 'TypedText', 'ModuleText', 'Module'));
    GrfNode(vParent, GrfFrmModule);

    GrfNode(MDNodeRoot, GrfCfg);
    vRootNode := MDNodeRoot;
    CreateNodes;
    MDNodes := frm.TreeViewMD.Items;
    MDNodes.BeginUpdate;
    // ������ ���������� ���� ��������
    if RootStorage.OpenStorage('Metadata', nil,
      STGM_DIRECT or STGM_READ or STGM_SHARE_EXCLUSIVE,
      nil, 0, DocStorage) <> S_OK then
      Exit;
    if DocStorage.OpenStream('Main MetaData Stream', nil,
      STGM_DIRECT or STGM_READ or STGM_SHARE_EXCLUSIVE,
      0, MDStream) <> S_OK then
      Exit;

    Ole := TOleStream.Create(MDStream);
    IDList := TStringList.Create;
    frm.ProgressBar1.Step := 1;
    try
      PromList := TStringList.Create;
      try
        Ole.Position := 0;
        k := 0;
        repeat
          Ole.Read(B, 1);
          k := k + 1;
        until B <> #255;
        for i := 2 to k do
          Ole.Read(B, 1);
        with TStringList.Create do
        try
          LoadFromStream(Ole);
          PromList := ParseString(Text);
        finally
          Free;
        end;
        with frm.ProgressBar1 do
        begin
          Position := 0;
          Max := PromList.Count;
          Min := 0;
        end;
        for i := 0 to PromList.Count - 1 do
        begin
          PList1 := ParseString(PromList.Values[PromList.Names[i]]);
          if PList1.Count <> 0 then
          begin
            //******************************************************************
            // ************** ����� ��������� *************
            //******************************************************************
            if PList1.Values[PList1.Names[0]] = 'GenJrnlFldDef' then
            begin
              for j := 1 to PList1.Count - 1 do
              begin
                PList2 := ParseString(PList1.Values[PList1.Names[j]]);
                GrfNode(MDNodes.AddChildObject(vNodeGenJrnlFldDef,
                  PList2.Values['Param1'], nil), GrfObRec);
              end;
            end;
          end;
          //******************************************************************
          // ************** ����� ������ *************
          //******************************************************************
          if PList1.Values[PList1.Names[0]] = 'DocSelRefObj' then
          begin
            for j := 1 to PList1.Count - 1 do
            begin
              PList2 := ParseString(PList1.Values[PList1.Names[j]]);

              vParent := MDNodes.AddChildObject(vNodeDocSelRefObj,
                PList2.Values['Param1'], nil);
              GrfNode(vParent, GrfJrnGrOtb);
              //               get substr
              //              if PList2.Count <> 0 then
              //              begin
              //                PList3 := ParseString(PList2.Values['Param7']);
              //                InsertObjItem(MDNodes, vParent, PromList, PList3, PList5);
              //              end;
            end;
          end;
          //******************************************************************
          // *************** ��������� *****************
          //******************************************************************
          if PList1.Values[PList1.Names[0]] = 'Consts' then
          begin
            for j := 1 to PList1.Count - 1 do
            begin
              PList2 := ParseString(PList1.Values[PList1.Names[j]]);
              GrfNode(
                MDNodes.AddChildObject(vNodeConsts, PList2.Values['Param1'],
                nil), GrfConst);
            end;
          end;
          //******************************************************************
          // ************* ����������� *******************
          //******************************************************************
          if PList1.Values[PList1.Names[0]] = 'SbCnts' then
          begin

            for j := 1 to PList1.Count - 1 do
            begin
              PList2 := ParseString(PList1.Values[PList1.Names[j]]);
              // add reference
              vParent := MDNodes.AddChildObject(vNodeRefs,
                PList2.Values['Param1'], nil);
              GrfNode(vParent, GrfRef);
              //18
              vParentDoc := MDNodes.AddChildObject(vParent,
                '���������', nil);
              GrfNode(vParentDoc, GrfFldr);
              if PList2.Count <> 0 then
              begin
                PList3 := ParseString(PList2.Values['Param18']);
                InsertObjItem(MDNodes, vParentDoc, PromList, PList3, PList5);
              end;

              vParentDoc := MDNodes.AddChildObject(vParent,
                '����� ������', nil);
              GrfNode(vParentDoc, GrfFldr);
              if PList2.Count <> 0 then
              begin
                PList3 := ParseString(PList2.Values['Param19']);
                for q := 1 to PList3.Count - 1 do
                begin
                  PList5 := ParseString(PList3.Values['Param' + IntToStr(q)]);
                  vParent2 := MDNodes.AddChildObject(vParentDoc,
                    _GetNameByID(PromList, PList5.Values['Param0'], 0), nil);
                  GrfNode(vParent2, GrfFrmList);

                  InsertStrctItem('����������.' +
                    UpperCase(PList2.Values['Param1']) +
                    '.�����������.�����',
                    MDNodes.AddChildObject(vParent2, '�����',
                    CreateData(PList5.Values['Param0'], 'SubList', 'SubList',
                    'Form')), GrfFrmEdit);

                  InsertStrctItem('����������.' +
                    UpperCase(PList2.Values['Param1']) +
                    '.�����������.������',
                    MDNodes.AddChildObject(vParent2, '������ �����',
                    CreateData(PList5.Values['Param0'], 'SubList', 'SubList',
                    'Module')), GrfFrmModule);

                end;
              end;
              //--------
              vParentDoc := MDNodes.AddChildObject(vParent,
                '����� ��������', nil);
              GrfNode(vParentDoc, GrfFldr);
              InsertStrctItem('����������.' +
                UpperCase(PList2.Values['Param1']) +
                '.�������������.�����',
                MDNodes.AddChildObject(vParentDoc, '�����',
                CreateData(PList2.Values['Param0'], 'Subconto', 'Subconto',
                'Form')), GrfFrmEdit);

              InsertStrctItem('����������.' +
                UpperCase(PList2.Values['Param1']) +
                '.�������������.������',
                MDNodes.AddChildObject(vParentDoc, '������ �����',
                CreateData(PList2.Values['Param0'], 'Subconto', 'Subconto',
                'Module')), GrfFrmModule);
              //---------
              vParentDoc := MDNodes.AddChildObject(vParent,
                '����� ������', nil);

              GrfNode(vParentDoc, GrfFldr);

              InsertStrctItem('����������.' +
                UpperCase(PList2.Values['Param1']) +
                '.�����������.�����',
                MDNodes.AddChildObject(vParentDoc, '�����',
                CreateData(PList2.Values['Param0'], 'SubFolder', 'SubFolder',
                'Form')), GrfFrmEdit);

              InsertStrctItem('����������.' +
                UpperCase(PList2.Values['Param1']) +
                '.�����������.������',
                MDNodes.AddChildObject(vParentDoc, '������ �����',
                CreateData(PList2.Values['Param0'], 'SubFolder', 'SubFolder',
                'Module')), GrfFrmModule);
            end;
          end;
          //********************************************************************
          // **************** �������� ******************
          //********************************************************************
          if PList1.Values[PList1.Names[0]] = 'Registers' then
          begin
            for j := 1 to PList1.Count - 1 do
            begin
              PList2 := ParseString(PList1.Values[PList1.Names[j]]);

              vParent := MDNodes.AddChildObject(vNodeRegs,
                PList2.Values['Param1'], nil);
              GrfNode(vParent, GrfReg);
              //~~~~~~~~~~~~~~~~~~~~~
              vNodeRec := MDNodes.AddChildObject(vParent, '���������',
                nil);
              GrfNode(vNodeRec, GrfFldr);
              if PList2.Count <> 0 then
              begin
                PList3 := ParseString(PList2.Values['Param8']);
                InsertObjItem(MDNodes, vNodeRec, PromList, PList3, PList5);
              end;
              //~~~~~~~~~~~~~~~~~~~~~
              vNodeRec := MDNodes.AddChildObject(vParent, '�������',
                nil);
              GrfNode(vNodeRec, GrfFldr);
              if PList2.Count <> 0 then
              begin
                PList3 := ParseString(PList2.Values['Param9']);
                InsertObjItem(MDNodes, vNodeRec, PromList, PList3, PList5);
              end;
              //~~~~~~~~~~~~~~~~~~~~~
              vNodeRec := MDNodes.AddChildObject(vParent, '���������',
                nil);
              GrfNode(vNodeRec, GrfFldr);
              if PList2.Count <> 0 then
              begin
                PList3 := ParseString(PList2.Values['Param10']);
                InsertObjItem(MDNodes, vNodeRec, PromList, PList3, PList5);
              end;
            end;
          end;
          //********************************************************************
          // ************** ��������� ***************
          //********************************************************************
          if PList1.Values[PList1.Names[0]] = 'Documents' then
          begin

            for j := 1 to PList1.Count - 1 do
            begin
              PList2 := ParseString(PList1.Values[PList1.Names[j]]);

              vParentDoc := MDNodes.AddChildObject(vNodeDocs,
                PList2.Values['Param1'], nil);
              GrfNode(vParentDoc, GrfDoc);
              if PList2.Count <> 0 then
              begin
                // �������� ���������� ���
                PList3 := ParseString(PList2.Values['Param15']);
                PList4 := ParseString(PList3.Values['Param4']);
                vParent := MDNodes.AddChildObject(vParentDoc,
                  '�������� ����������', nil);
                GrfNode(vParent, GrfFldr);
                InsertObjItem(MDNodes, vParent, PList1, PList4, PList5);
                // ��������� �����
                PList3 := ParseString(PList2.Values['Param22']);
                vParent := MDNodes.AddChildObject(vParentDoc,
                  '��������� �����', nil);
                GrfNode(vParent, GrfFldr);
                for q := 1 to PList3.Count - 1 do
                begin
                  PList4 := ParseString(PList3.Values['Param' + IntToStr(q)]);
                  GrfNode(
                    MDNodes.AddChildObject(vParent, PList4.Values['Param1'],
                    nil), GrfElement);
                end;
                // ��������� �������
                PList3 := ParseString(PList2.Values['Param23']);
                vParent := MDNodes.AddChildObject(vParentDoc,
                  '��������� ���������� �����', nil);
                GrfNode(vParent, GrfFldr);
                for q := 1 to PList3.Count - 1 do
                begin
                  PList4 := ParseString(PList3.Values['Param' + IntToStr(q)]);
                  GrfNode(
                    MDNodes.AddChildObject(vParent, PList4.Values['Param1'],
                    nil), GrfElement);
                end;

                InsertStrctItem('��������.' +
                  UpperCase(PList2.Values['Param1']) +
                  '.�����',
                  MDNodes.AddChildObject(vParentDoc, '�����',
                  CreateData(PList2.Values['Param0'], 'Document', 'Document',
                  'Form')
                  ), GrfFrmEdit);

                InsertStrctItem('��������.' +
                  UpperCase(PList2.Values['Param1']) +
                  '.�����������',
                  MDNodes.AddChildObject(vParentDoc, '������ �����',
                  CreateData(PList2.Values['Param0'], 'Document', 'Document',
                  'Module')
                  ), GrfFrmModule);

                InsertStrctItem('��������.' +
                  UpperCase(PList2.Values['Param1']) +
                  '.����������������',
                  MDNodes.AddChildObject(vParentDoc,
                  '������ ���������',
                  CreateData(PList2.Values['Param0'], 'TypedText', 'Transact',
                  'Module')
                  ), GrfFrmModule);
              end; // if
              PList2.Free;
            end;
          end;
          //********************************************************************
          // *********** ������� ***********************
          //********************************************************************
          if PList1.Values[PList1.Names[0]] = 'Journalisters' then
          begin
            for j := 1 to PList1.Count - 1 do
            begin
              PList2 := ParseString(PList1.Values[PList1.Names[j]]);
              vParent := MDNodes.AddChildObject(vNodeJournals,
                PList2.Values['Param1'], nil);
              GrfNode(vParent, GrfJrn);
              vNodeRec := MDNodes.AddChildObject(vParent, '���������',
                nil);
              GrfNode(vNodeRec, GrfFldr);

              if PList2.Count <> 0 then
              begin
                PList3 := ParseString(PList2.Values['Param10']);
                  // ���������
                for q := 1 to PList3.Count - 1 do
                begin
                  PList5 := ParseString(PList3.Values['Param' + IntToStr(q)]);
                  vParentDoc := MDNodes.AddChildObject(vNodeRec,
                    _GetNameByID(PromList, PList5.Values['Param0'], 0), nil);
                  GrfNode(vParentDoc, GrfElement);
                  //                  if PList3.Count <> 0 then
                  //                  begin
                  //                    PList4 := ParseString(PList3.Values['Param4']);
                  //                    PList5 := ParseString(PList4.Values['Param2']);
                  //                    InsertObjItem(MDNodes, vParentDoc, PromList, PList5,
                  //                      PList6);
                  //                  end;
                end;

                vNodeRec := MDNodes.AddChildObject(vParent, '�����', nil);
                GrfNode(vNodeRec, GrfFldr);

                PList3 := ParseString(PList2.Values['Param11']);
                for q := 1 to PList3.Count - 1 do
                begin
                  PList5 := ParseString(PList3.Values['Param' + IntToStr(q)]);
                  vParentDoc := MDNodes.AddChildObject(vNodeRec,
                    _GetNameByID(PromList, PList5.Values['Param0'], 0), nil);
                  GrfNode(vParentDoc, GrfFrmList);

                  InsertStrctItem('����������.' +
                    UpperCase(PList2.Values['Param1']) +
                    '.�����������.�����',
                    MDNodes.AddChildObject(vParentDoc, '�����',
                    CreateData(PList5.Values['Param0'], 'Journal', 'Journal',
                    'Form')), GrfFrmEdit);

                  InsertStrctItem('����������.' +
                    UpperCase(PList2.Values['Param1']) +
                    '.�����������.������',
                    MDNodes.AddChildObject(vParentDoc,
                    '������ �����',
                    CreateData(PList5.Values['Param0'], 'Journal', 'Journal',
                    'Module')), GrfFrmModule);

                end;
                //********
              end;
            end;
          end;

          //********************************************************************
          // ********** ������������ ***************
          //********************************************************************
          if PList1.Values[PList1.Names[0]] = 'EnumList' then
          begin

            for j := 1 to PList1.Count - 1 do
            begin
              PList2 := ParseString(PList1.Values[PList1.Names[j]]);
              vParent := MDNodes.AddChildObject(vNodeEnums,
                PList2.Values['Param1'], nil);
              GrfNode(vParent, GrfEnum);
              if PList2.Count <> 0 then
              begin
                PList3 := ParseString(PList2.Values['Param4']);
                InsertObjItem(MDNodes, vParent, PromList, PList3, PList5);
              end;
            end;
          end;
          //********************************************************************
          // ************* ������ *****************
          //********************************************************************
          if PList1.Values[PList1.Names[0]] = 'ReportList' then
          begin
            for j := 1 to PList1.Count - 1 do
            begin
              PList2 := ParseString(PList1.Values[PList1.Names[j]]);
              vParent := MDNodes.AddChildObject(vNodeReps,
                PList2.Values['Param1'], nil);
              GrfNode(vParent, GrfRep);

              InsertStrctItem('�����.' +
                UpperCase(PList2.Values['Param1']) +
                '.�����',
                MDNodes.AddChildObject(vParent, '�����',
                CreateData(PList2.Values['Param0'], 'Report', 'Report', 'Form')
                ), GrfFrmEdit);

              InsertStrctItem('�����.' +
                UpperCase(PList2.Values['Param1']) +
                '.������',
                MDNodes.AddChildObject(vParent, '������',
                CreateData(PList2.Values['Param0'], 'Report', 'Report', 'Module')
                ), GrfFrmModule);
            end;
          end;
          //********************************************************************
          // ****************** ������� �������� ***************
          //********************************************************************
          if PList1.Values[PList1.Names[0]] = 'CJ' then
          begin

            for j := 1 to PList1.Count - 1 do
            begin
              PList2 := ParseString(PList1.Values[PList1.Names[j]]);

              vParent := MDNodes.AddChildObject(vNodeCJ,
                PList2.Values['Param1'], nil);
              GrfNode(vParent, GrfCJ);

              vParentDoc := MDNodes.AddChildObject(vParent,
                '���������', nil);
              GrfNode(vParentDoc, GrfFldr);

              if PList2.Count <> 0 then
              begin // ���������
                PList3 := ParseString(PList2.Values['Param7']);
                for q := 1 to PList3.Count - 1 do
                begin
                  PList4 := ParseString(PList3.Values['Param' + IntToStr(q)]);
                  GrfNode(
                    MDNodes.AddChildObject(vParentDoc, PList4.Values['Param1'],
                    nil), GrfElement);
                end;
              end;

//              vParentDoc := MDNodes.AddChildObject(vParent,
//                '����� ������', nil);
//              GrfNode(vParentDoc, GrfFldr);
//              if PList2.Count <> 0 then
//              begin // ����� ������
//                PList3 := ParseString(PList2.Values['Param11']);
//                InsertObjItem(MDNodes, vParent, PromList, PList3, PList4);
//              end;

              vParentDoc := MDNodes.AddChildObject(vParent,
                '����� ������', nil);
              GrfNode(vParentDoc, GrfFldr);
              if PList2.Count <> 0 then
              begin
                PList3 := ParseString(PList2.Values['Param12']);
                for q := 1 to PList3.Count - 1 do
                begin
                  PList4 := ParseString(PList3.Values['Param' + IntToStr(q)]);
                  vParent := MDNodes.AddChildObject(vParentDoc,
                    PList4.Values['Param1'], nil);
                  GrfNode(vParent, GrfFrmList);

                  InsertStrctItem('�������������.' +
                    UpperCase(PList2.Values['Param1']) +
                    '.�����������.�����',
                    MDNodes.AddChildObject(vParent, '�����',
                    CreateData(PList4.Values['Param0'], 'CalcJournal',
                    'CalcJournal', 'Form')
                    ), GrfFrmEdit);

                  InsertStrctItem('�������������.' +
                    UpperCase(PList2.Values['Param1']) +
                    '.�����������.������',
                    MDNodes.AddChildObject(vParent, '������',
                    CreateData(PList4.Values['Param0'], 'CalcJournal',
                    'CalcJournal', 'Module')
                    ), GrfFrmModule);
                end;
              end;
            end;
          end;
          //********************************************************************
          // ************* ��������� ***********
          //********************************************************************
          if PList1.Values[PList1.Names[0]] = 'Calendars' then
          begin
            for j := 1 to PList1.Count - 1 do
            begin
              PList2 := ParseString(PList1.Values[PList1.Names[j]]);
              GrfNode(
                MDNodes.AddChildObject(vNodeCalndars, PList2.Values['Param1'],
                nil), GrfCalndar);
            end;
          end;
          //********************************************************************
          //************** ���� �������� *************
          //********************************************************************
          if PList1.Values[PList1.Names[0]] = 'Algorithms' then
          begin

            for j := 1 to PList1.Count - 1 do
            begin
              PList2 := ParseString(PList1.Values[PList1.Names[j]]);
              vParent := MDNodes.AddChildObject(vNodeKindCalcs,
                PList2.Values['Param1'], nil);
              GrfNode(vParent, GrfKindCalc);

              InsertStrctItem('����������.' +
                UpperCase(PList2.Values['Param1']) +
                '.������',
                MDNodes.AddChildObject(vParent, '������',
                CreateData(PList2.Values['Param0'], 'TypedText', 'CalcAlg',
                'Module')
                ), GrfFrmModule);
            end; // for
          end; // ���� ��������

          // ************** ������� ��������� *************
          if PList1.Values[PList1.Names[0]] = 'RecalcRules' then
          begin

            for j := 1 to PList1.Count - 1 do
            begin
              PList2 := ParseString(PList1.Values[PList1.Names[j]]);
              GrfNode(
                MDNodes.AddChildObject(vNodeRulesCalc, PList2.Values['Param1'],
                nil), GrfElement);
            end;
          end;

          // ************** ��������� *************
          if PList1.Values[PList1.Names[0]] = 'CalcVars' then
          begin

            for j := 1 to PList1.Count - 1 do
            begin
              PList2 := ParseString(PList1.Values[PList1.Names[j]]);
              vParent := MDNodes.AddChildObject(vNodeCalcVars,
                PList2.Values['Param1'], nil);
              GrfNode(vParent, GrfCalcVar);

              InsertStrctItem('���������.' +
                UpperCase(PList2.Values['Param1']) +
                '.�����',
                MDNodes.AddChildObject(vParent, '�����',
                CreateData(PList2.Values['Param0'], 'CalcVar', 'CalcVar', 'Form')
                ), GrfFrmEdit);

              InsertStrctItem('���������.' +
                UpperCase(PList2.Values['Param1']) +
                '.������',
                MDNodes.AddChildObject(vParent, '������',
                CreateData(PList2.Values['Param0'], 'CalcVar', 'CalcVar',
                'Module')
                ), GrfFrmModule);
            end;
          end;

          // ************** ������ �������� *************
          { TODO : �������� ����������� ����� �������� }
          if PList1.Values[PList1.Names[0]] = 'Groups' then
          begin
            for j := 1 to PList1.Count - 1 do
            begin
              PList2 := ParseString(PList1.Values[PList1.Names[j]]);
              GrfNode(
                MDNodes.AddChildObject(vNodeGprCalcs, PList2.Values['Param1'],
                nil), GrfGrpCalc);
            end;
          end;

          // ************** ������������������ ���������� *************
          if PList1.Values[PList1.Names[0]] = 'Document Streams' then
          begin

            for j := 1 to PList1.Count - 1 do
            begin
              PList2 := ParseString(PList1.Values[PList1.Names[j]]);
              GrfNode(
                MDNodes.AddChildObject(vNodePosled, PList2.Values['Param1'],
                nil), GrfElement);
            end; // for
          end; // ���� ��������

          PList1.Free;
          //Application.ProcessMessages;
          //if StopFlag then Exit;
          frm.ProgressBar1.StepIt;
        end;
      finally
        PromList.Free;
      end;
    finally
      Ole.Free;
    end;
  finally

    // insert Rights
    vParent := MDNodes.AddChildObject(MDNodeRoot, '������ ����', nil);
    GrfNode(vParent, GrfRights);
    Contents := TStringList.Create;
    Contents.Text := stringReplace(GetRightsNamesList, ',', #13#10,
      [rfReplaceAll]);
    for i := 0 to Contents.Count - 1 do
    begin
      GrfNode(MDNodes.AddChildObject(vParent, Contents[i], nil), GrfRights);
    end;
    // insert interfaces
    vParent := MDNodes.AddChildObject(MDNodeRoot, '����������', nil);
    GrfNode(vParent, GrfInterfaces);
    Contents := TStringList.Create;
    Contents.Text := stringReplace(GetInterfacesNamesList, ',', #13#10,
      [rfReplaceAll]);
    for i := 0 to Contents.Count - 1 do
    begin
      GrfNode(MDNodes.AddChildObject(vParent, Contents[i], nil), GrfInterfaces);
    end;

    s := IncludeTrailingBackslash(ExtractFileDir(FileName));
    s := s + 'usrdef\users.usr';
    if FileExists(s) then
    begin
      // insert users
      vLstUsers := frm.GetListUsers;
      vLstUsers.OpenFile(s);

      vParent := MDNodes.AddChildObject(MDNodeRoot, '������������',
        nil);
      GrfNode(vParent, GrfUsers);
      Contents := TStringList.Create;
      Contents.Text := stringReplace(vLstUsers.ReadNamesList, ',', #13#10,
        [rfReplaceAll]);
      for i := 0 to Contents.Count - 1 do
      begin
        GrfNode(MDNodes.AddChildObject(vParent, Contents[i], nil), GrfUsers);
      end;
      vLstUsers.CloseFile;
    end;

    MDNodes.EndUpdate;
    frm.ProgressBar1.Position := 0;
  end;
end;

function TMD.GetInterfacesNamesList: WideString;
var
  DocStorage, Docs: IStorage;
begin
  if RootStorage.OpenStorage('UserDef', nil,
    STGM_DIRECT or STGM_READ or STGM_SHARE_EXCLUSIVE,
    nil, 0, DocStorage) <> S_OK then
    Exit;
  if DocStorage.OpenStorage('Page.1', nil,
    STGM_DIRECT or STGM_READ or STGM_SHARE_EXCLUSIVE,
    nil, 0, Docs) <> S_OK then
    Exit;

  Result := ReadNamesFromContainerContents(Docs);
end;

function TMD.GetRightsNamesList: WideString;
var
  DocStorage, Docs: IStorage;
begin
  if RootStorage.OpenStorage('UserDef', nil,
    STGM_DIRECT or STGM_READ or STGM_SHARE_EXCLUSIVE,
    nil, 0, DocStorage) <> S_OK then
    Exit;
  if DocStorage.OpenStorage('Page.2', nil,
    STGM_DIRECT or STGM_READ or STGM_SHARE_EXCLUSIVE,
    nil, 0, Docs) <> S_OK then
    Exit;

  Result := ReadNamesFromContainerContents(Docs);
end;

procedure TMD.CloseFile;
begin
  if vRootNode = nil then
    exit;
  RootStorage.Commit(0);
  RootStorage._Release();
  //RootStorage := nil;
  vRootNode.Delete;
end;

procedure TMD.OpenFile(var vFileName: WideString);
begin
  vMetadata := TStringList.create;
  FileName := vFileName;
  if StgIsStorageFile(StringToOleStr(FileName)) = S_FALSE then
  begin
    ShowMessage('���� �� �������� ��');
    exit;
  end;
  if StgOpenStorage(StringToOleStr(FileName),
    nil,
    STGM_DIRECT or STGM_READ or STGM_SHARE_DENY_WRITE,
    nil,
    0,
    RootStorage) <> S_OK then
    Exit;
  if RootStorage = nil then
    Exit;
  // write MD struct in list
  ReadStrct;
end;

procedure TMD.TextOpen;
var
  vCurNode: TTreeNode;
  TMPFileName: array[0..261] of Char;
  TMPDir: array[0..261] of Char;
  TMPFile: TextFile;
  vL: TStringList;
  vFileNametest: string;
begin

  Windows.GetTempPath(SizeOf(TMPDir), TMPDir);
  if GetTempFileName(TMPDir, 'tmp', 0, TMPFileName) = 0 then
  begin
    Exit;
  end;

  vCurNode := frm.TreeViewMD.Selected;
  if vCurNode = nil then
    exit;
  if vCurNode.Data = nil then
    exit;
  if vCurNode.Parent = nil then
    exit;
  vFileNametest := TMPFileName;

  ReadModules(
    RootStorage,
    pTreeData(vCurNode.Data).FolderClass,
    pTreeData(vCurNode.Data).Part,
    pTreeData(vCurNode.Data).ID,
    pTreeData(vCurNode.Data).Module,
    TMPFileName
    );
  frm.FConfigurator.Documents.Open(TMPFileName);
end;

procedure TMD.TextSaveInFile(var vFileName: WideString);
var
  vCurNode: TTreeNode;
  TMPFileName: array[0..261] of Char;
  TMPDir: array[0..261] of Char;
  TMPFile: TextFile;
  vL: TStringList;
begin

  vCurNode := frm.TreeViewMD.Selected;
  if vCurNode = nil then
    exit;
  if vCurNode.Data = nil then
    exit;

  if vFileName = '' then
  begin
    if frm.SaveDialog1.Execute then
    begin
      vFileName := frm.SaveDialog1.FileName;
      ReadModules(
        RootStorage,
        pTreeData(vCurNode.Data).FolderClass,
        pTreeData(vCurNode.Data).Part,
        pTreeData(vCurNode.Data).ID,
        pTreeData(vCurNode.Data).Module,
        vFileName
        );
    end;
  end;
end;

initialization
  TAutoObjectFactory.Create(ComServer, TMD, Class_MD,
    ciMultiInstance, tmApartment);
end.

