unit lazExt_extIDEM_prjOptionEdit;

{$mode objfpc}{$H+}
interface
{$I in0k_lazExt_extIDEM_INI.inc}
{$ifDef lazExt_extIDEM_DEBUG_mode}
    {$define _DEBUG_}
    {$define _TSTPRM_}
    {$define _TSTABS_}
{$else}
    {$define _INLINE_}
{$endIf}


uses IDEOptionsIntf,


lazExt_extIDEM,  extIDEM_McrPRM_NotDEF,
Graphics,
//lazExt_extIDEM_mcrPRM_NotDEF,

//lazExt_extIDEM__NDF_MACROS,
     Dialogs,    lazExt_extIDEM__NDF_MACROS,
//lazExt_extIDEM_maCRO_node,
extIDEM_coreObject,
//lazExt_extIDEM_preSet_node,
Classes,                    extIDEM_MACROS_node,extIDEM_McrPRM_node,
  SysUtils, FileUtil, Forms, Controls, StdCtrls, ExtCtrls, ComCtrls,
  lazExt_extIDEM_prjResource, lazExt_extIDEM_frm_nodeName, types;

type

 tLazExt_extIDEM_IDEOptions = class(TAbstractIDEOptions)
 public
   class function GetGroupCaption:string; override;
   class function GetInstance: TAbstractIDEOptions; override;
 end;


 { tLazExt_extIDEM_frmPrjOptionEdit }

 tLazExt_extIDEM_frmPrjOptionEdit = class(TAbstractIDEOptionsEditor)
   Button1: TButton;
   ui_ExtIDEM_LOGO: TLabel;
   ui_ExtIDEM_HINT: TLabel;
   ui_ExtIDEM_MustDEL: TCheckBox;
    ui_ExtIDEM_Enabled: TCheckBox;
    chb_nodeEnabled: TCheckBox;
    Label1: TLabel;
    Label2: TLabel;
    Label7: TLabel;
    frm_nodeName: TlazExt_extIDEM_nodeName_frm;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Splitter1: TSplitter;
    TreeView1: TTreeView;
    procedure chb_nodeEnabledChange(Sender: TObject);
    procedure chb_nodeEnabledClick(Sender: TObject);
    procedure ui_ExtIDEM_EnabledChange(Sender: TObject);
    procedure Label2Click(Sender: TObject);
    procedure lst_preSetDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure lst_preSetDrawItem(Control: TWinControl; Index: Integer;
      ARect: TRect; State: TOwnerDrawState);
    procedure lst_preSetSelectionChange(Sender: TObject; User: boolean);
    procedure TreeView1Change(Sender: TObject; Node: TTreeNode);
    procedure TreeView1Changing(Sender: TObject; Node: TTreeNode;
      var AllowChange: Boolean);
    procedure TreeView1Deletion(Sender: TObject; Node: TTreeNode);
    procedure ui_ExtIDEM_MustDELChange(Sender: TObject);

 private
   _ExtIDEM_:tExtIDEM_prjResources;
    procedure _ExtIDEM_SET_(const value:tExtIDEM_prjResources);
    procedure _ui_ExtIDEM_Enablede_eventCLR_;
    procedure _ui_ExtIDEM_Enablede_eventSET_;
 private
   _nodeTree_ :TtreeNode;
   _nodeFrame_:tExtIDEM_core_objEDIT;
    procedure _rePlace_setFRM_(const FRM:tExtIDEM_core_objEDIT);
//    function  _rePlace_getFRM_(const ITM:tLazExt_extIDEM_preSet_Node):tExtIDEM_core_objEDIT;
//    procedure _rePlace_setITM_(const ITM:tLazExt_extIDEM_preSet_Node);


    procedure _chb_nodeEnabled_eventCLR;
    procedure _chb_nodeEnabled_eventSET;

 private
    procedure _rePlace_TreeNODE_enblCh_(const treeNode:TTreeNode);
    procedure _rePlace_TreeNODE_Labels_(const treeNode:TTreeNode);
    procedure _rePlace_TreeNODE_Editor_(const treeNode:TTreeNode);
    procedure _rePlace_TreeNODE_(const treeNode:TTreeNode);

 private
    function  _treePreSets_node_is_PreSET(const treeNode:TTreeNode):boolean;
    function  _treePreSets_node_is_MACRO (const treeNode:TTreeNode):boolean;
    function  _treePreSets_node_get_IDENT(const treeNode:TTreeNode):string;

 private
    procedure  _treePreSets_clear_not_IDE;
    procedure  _treePreSets_clear_forFREE;
    procedure  _treePreSets_clear_wasLoad_;

    procedure  _treePreSets_setUp_ide_ideMCRs_(const treeNode:TTreeNode; const preSet:tLazExt_extIDEM_preSet_Node);
    procedure  _treePreSets_setUp_ide_preSETs_(const preSETsList:tLazExt_extIDEM_preSetsList_core);

    procedure  _treePreSets_setUp_prj_ideMCRs_(const treeNode:TTreeNode; const preSet:tLazExt_extIDEM_preSet_Node);
    procedure  _treePreSets_setUp_prj_preSETs_(const preSETsList:tLazExt_extIDEM_preSetsList_core);

    function   _treePreSets_find_preSET_(const idnt:string):TTreeNode;
    function   _treePreSets_find_ideMCR_(const prnt:TTreeNode; const idnt:string):TTreeNode;
 private
    procedure  _treePreSets_Settings_Read_;
    function   _treePreSets_Settings_Write_:boolean;
{ private
    procedure  _lstPreSets_clear_forFREE;
    procedure  _lstPreSets_clear_forREAD;
    function   _lstPreSets_Find_IDNT(const value:string):integer;
    function   _lstPreSets_Item_Frame_(const value:integer):tFrame;
    procedure  _lstPreSets_Show_Item_(const value:integer);}
  public
    constructor Create(AOwner: TComponent); override;
    destructor DESTROY; override;
  public
    class function SupportedOptionsClass: TAbstractIDEOptionsClass; override;
  public
    function GetTitle:string; override;
  public
    procedure Setup(ADialog:TAbstractOptionsEditorDialog);  override;
    procedure ReadSettings(AOptions:TAbstractIDEOptions);   override;
    procedure WriteSettings(AOptions:TAbstractIDEOptions);  override;
  end;

implementation

{$R *.lfm}

{%region -----------------------------------------------------------------}

type

 tNodeDATA=class
  strict private
   _node_ide_:tExtIDEM_core_objNODE; //< что предоставляет IDE
   _node_prj_:tExtIDEM_core_objNODE; //< что записано в ПРОЕКТ
   _edit_frm_:tExtIDEM_core_objEDIT; //< tLazExt_extIDEM_preSet_frmEdit;
    procedure _node_prj_set_(const value:tExtIDEM_core_objNODE);
    function  _node_getACTV_:tExtIDEM_core_objNODE; inline;
    //-------
    function  _node_is_MacroITM_:boolean;
    function  _node_is_MacroPRM_:boolean;
    function  _node_is_MacroNDF_:boolean;
    //-------
    function  _node_get_EDIT:tExtIDEM_core_objEditTYPE;
    function  _node_get_IDNT:string;
    function  _node_get_NAME:string;
    function  _node_get_DESC:string;
    function  _node_get_ENBL:boolean;
  strict private
   _was_load_:boolean;

  public
    constructor Create;
    destructor DESTROY; override;
  public
    class function Create_IDE(const node:tExtIDEM_core_objNODE):tNodeDATA;
    class function Create_PRJ(const node:tExtIDEM_core_objNODE):tNodeDATA;
  public
    property  Was_Loaded:boolean read _was_load_;
    procedure Was_Loaded_CLEAR;
  public
    function  IDE_based:boolean;
    function  PRJ_based:boolean;
    function  PRJ_exist:boolean;
    function  IS_Macros:boolean;
    function  IS_McrPRM:boolean;
    function  IS_NotDEF:boolean;
  public
    property  Node_EDT:tExtIDEM_core_objEDIT read _edit_frm_;
    property  Node_IDE:tExtIDEM_core_objNODE read _node_ide_;
    property  Node_PRJ:tExtIDEM_core_objNODE read _node_prj_;
  public
    procedure Node_PRJ_clean;
    procedure Node_PRJ_SET(const value:tExtIDEM_core_objNODE);
    procedure Node_EDT_SET(const value:tExtIDEM_core_objEDIT);
  public
    property  NodeTEDT:tExtIDEM_core_objEditTYPE read _node_get_EDIT;
    property  NodeENBL:boolean read _node_get_ENBL;
    property  NodeIDNT:string  read _node_get_IDNT;
    property  NodeNAME:string  read _node_get_NAME;
    property  NodeDESC:string  read _node_get_DESC;
  public
    procedure EDITOR_Settings_READ;
    function  EDITOR_Settings_WRITE:boolean;
  public
    procedure COPY_toPRJ_MacroITM(const prjMARCOSES:tLazExt_extIDEM_preSetsList_core);
    procedure COPY_toPRJ_MacroPRM(const prjMARCOSES:tLazExt_extIDEM_preSetsList_core; const MacroITM:tNodeDATA);
  end;

{todo: добавить проверку `if Assigned(_node_getACTV_)` в проверку в ASSERT}

//------------------------------------------------------------------------------

function _treeNodeDATA_(const TreeNode:tTreeNode):tNodeDATA;{$ifNdef _INLINE_}inline;{$endif}
begin
    result:=nil;
    if Assigned(TreeNode) then begin
        result:=tNodeDATA(TreeNode.Data);
    end;
end;

//------------------------------------------------------------------------------

constructor tNodeDATA.Create;
begin
  _node_ide_:=nil;
  _node_prj_:=nil;
  _edit_frm_:=nil;
  _was_load_:=false;
end;

destructor tNodeDATA.DESTROY;
begin
  _edit_frm_.FREE;
end;

//------------------------------------------------------------------------------

class function tNodeDATA.Create_IDE(const node:tExtIDEM_core_objNODE):tNodeDATA;
begin
    result:=tNodeDATA.Create;
    result._node_ide_:=node;
end;

class function tNodeDATA.Create_PRJ(const node:tExtIDEM_core_objNODE):tNodeDATA;
begin
    result:=tNodeDATA.Create;
    result._node_prj_:=node;
end;

//------------------------------------------------------------------------------

function tNodeDATA.IDE_based:boolean;
begin
    result:=Assigned(_node_ide_);
end;

function tNodeDATA.PRJ_based:boolean;
begin
    result:=not IDE_based;
end;

function tNodeDATA.PRJ_exist:boolean;
begin
    result:=Assigned(_node_prj_);
end;

//------------------------------------------------------------------------------

function tNodeDATA.IS_Macros:boolean;
begin
    result:=_node_is_MacroITM_;//   Assigned(_node_ACTIVE_) and (_node_ACTIVE_ is tLazExt_extIDEM_preSet_Node);
end;

function tNodeDATA.IS_McrPRM:boolean;
begin
    result:=_node_is_MacroPRM_;//    result:=Assigned(_node_ACTIVE_) and (_node_ACTIVE_ is tLazExt_extIDEM_node);
end;

function tNodeDATA.IS_NotDEF:boolean;
begin
    result:=_node_is_MacroNDF_;
end;

//------------------------------------------------------------------------------

function tNodeDATA._node_get_EDIT:tExtIDEM_core_objEditTYPE;
begin
    result:=nil;
    if Assigned(_node_getACTV_) then begin //< тут все сложнее
        result:=_node_getACTV_.nodeTEdit;
    end;
end;

function tNodeDATA._node_get_IDNT:string;
begin
    result:='nil';
    if Assigned(_node_getACTV_) then begin
        result:=_node_getACTV_.node_IDNT;
    end;
end;

function tNodeDATA._node_get_NAME:string;
begin
    result:='';
    if Assigned(_node_getACTV_) then begin
        result:=_node_getACTV_.node_Name;
    end;
end;

function tNodeDATA._node_get_DESC:string;
begin
    result:='';
    if Assigned(_node_getACTV_) then begin
        result:=_node_getACTV_.node_Desc;
    end;
end;

function tNodeDATA._node_get_ENBL:boolean;
begin
    if Assigned(_edit_frm_) and (_was_load_) then begin //< есть фрейм редактор и данные загружены,
        result:=_edit_frm_.NodeEnabled; //< то данные мы ДОЛЖНЫ брать из него
    end
    else begin //< иначе читаем прямо из объекта
        result:=Assigned(_node_prj_)and (not _node_is_MacroNDF_) and _node_prj_.Enabled;
    end;
end;

//------------------------------------------------------------------------------

procedure tNodeDATA._node_prj_set_(const value:tExtIDEM_core_objNODE);
begin
   _node_prj_:=value;
end;

//------------------------------------------------------------------------------

procedure tNodeDATA.Was_Loaded_CLEAR;
begin
   _was_load_:=FALSE;
end;

//------------------------------------------------------------------------------

// получить указатель на ТЕКУЩИЙ активный объект
function tNodeDATA._node_getACTV_:tExtIDEM_core_objNODE;
begin
    result:=_node_prj_;
    if not Assigned(result) then result:=_node_ide_;
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

function tNodeDATA._node_is_MacroITM_:boolean;
begin
    result:=false;
    if Assigned(_node_getACTV_) then begin
        result:=_node_getACTV_.InheritsFrom(tLazExt_extIDEM_preSet_Node);
    end;
end;

function tNodeDATA._node_is_MacroPRM_:boolean;
begin
    result:=false;
    if Assigned(_node_getACTV_) then begin
        result:=_node_getACTV_.InheritsFrom(tExtIDEM_McrPRM_node);
    end;
end;

function tNodeDATA._node_is_MacroNDF_:boolean;
begin
    if _node_is_MacroITM_ then begin
        result:=_node_getACTV_.InheritsFrom(tExtIDEM_NDF_MACROS_node);
    end
   else
    if _node_is_MacroPRM_ then begin
        result:=_node_getACTV_.InheritsFrom(tExtIDEM_McrPRM_NotDEF_node);
    end
   else begin
       result:=false;
   end;
end;

//------------------------------------------------------------------------------

procedure tNodeDATA.Node_PRJ_clean;
begin
   _node_prj_set_(nil);
   _was_load_:=FALSE;
end;

procedure tNodeDATA.Node_prj_SET(const value:tExtIDEM_core_objNODE);
begin
   _node_prj_set_(value);
end;

procedure tNodeDATA.Node_EDT_SET(const value:tExtIDEM_core_objEDIT);
begin
   _edit_frm_:=value;
end;

//------------------------------------------------------------------------------

procedure tNodeDATA.EDITOR_Settings_READ;
var tmpNode:tExtIDEM_core_objNODE;
begin
    tmpNode:=_node_getACTV_;
    if Assigned(tmpNode) and Assigned(_edit_frm_) then begin
        if not _was_load_ then begin //< если ещё не загружено, то грузим
           _edit_frm_.Settings_Read(tmpNode);
            //ShowMessage('EDITOR_Settings_READ');
           _was_load_:=TRUE;
        end;
    end
    else _was_load_:=FALSE;
end;

function tNodeDATA.EDITOR_Settings_WRITE:boolean;
var tmpNode:tExtIDEM_core_objNODE;
begin // !!! сохранение идет ТОЛЬКО в `_node_prj_`
    result:=false;
    //tmpNode:=_node_getACTV_;
    if Assigned(_node_prj_) and Assigned(_edit_frm_) then begin
       _edit_frm_.Settings_Write(_node_prj_);
        result:=_node_prj_.Changed;
        //if result
        //then ShowMessage('EDITOR_Settings_WRITE '+_node_prj_.node_IDNT+':TRUE')
        //else ShowMessage('EDITOR_Settings_WRITE '+_node_prj_.node_IDNT+':false');
    end;
end;

//------------------------------------------------------------------------------

procedure tNodeDATA.COPY_toPRJ_MacroITM(const prjMARCOSES:tLazExt_extIDEM_preSetsList_core);
begin
    if ( Assigned(prjMARCOSES)  )and(not Assigned(_node_prj_)) //< вообще есть смысл
        AND
       ( Assigned(_node_ide_) and (_node_ide_ is tLazExt_extIDEM_preSet_Node) and (not self.IS_NotDEF) )
    then begin
       _node_prj_:=tLazExt_extIDEM_preSet_NodeTYPE(_node_ide_.ClassType).Create;
        prjMARCOSES.PreSETs_ADD(tLazExt_extIDEM_preSet_Node(_node_prj_));
        tLazExt_extIDEM_preSet_Node(_node_prj_).Enabled:=TRUE;

        ShowMessage('COPY_toPRJ_MacroITM');
    end;
end;


procedure tNodeDATA.COPY_toPRJ_MacroPRM(const prjMARCOSES:tLazExt_extIDEM_preSetsList_core; const MacroITM:tNodeDATA);
//var tmpNode:tLazExt_extIDEM_node;
begin
    //ShowMessage('COPY_toPRJ_MacroPRM start');
    if ( Assigned(prjMARCOSES) and Assigned(MacroITM) and (not Assigned(_node_prj_)) ) //< вообще есть смысл
    then begin
        //ShowMessage('COPY_toPRJ_MacroPRM -1');
        if ( MacroITM.IS_Macros and (not MacroITM.IS_NotDEF) and MacroITM.PRJ_exist) then begin
            //ShowMessage('COPY_toPRJ_MacroPRM -2');

            if  ( Assigned(_node_ide_) and (_node_ide_ is tExtIDEM_McrPRM_node) and (not self.IS_NotDEF) )

    then begin
        //ShowMessage('COPY_toPRJ_MacroPRM -3');
        _node_prj_:=tLazExt_extIDEM_nodeTYPE(_node_ide_.ClassType).Create;
         tExtIDEM_McrPRM_node(_node_prj_).Copy(tExtIDEM_McrPRM_node(_node_ide_));
        // prjMARCOSES.PreSETs_ADD(tmpNode);
        tLazExt_extIDEM_preSet_Node(MacroITM.Node_PRJ).Param_INS(tExtIDEM_McrPRM_node(_node_prj_));
        tExtIDEM_McrPRM_node(_node_prj_).Enabled:=TRUE;
        ShowMessage('COPY_toPRJ_MacroPRM');
    end;


        end;

    end;
end;

{%endRegion}


{%region -----------------------------------------------------------------}

type

 tListNode=class
   _node_ide_:tLazExt_extIDEM_preSet_Node; //< что предоставляет IDE
   _node_prj_:tLazExt_extIDEM_preSet_Node; //< что записано в ПРОЕКТ
   _edit_frm_:tFrame;                      //tLazExt_extIDEM_preSet_frmEdit;
  public
    constructor Create;
    destructor DESTROY; override;
  public
    class function Create_IDE(const node:tLazExt_extIDEM_preSet_Node):tListNode;
    class function Create_PRJ(const node:tLazExt_extIDEM_preSet_Node):tListNode;
  end;

//------------------------------------------------------------------------------

constructor tListNode.Create;
begin
  _node_ide_:=nil;
  _node_prj_:=nil;
  _edit_frm_:=nil;
end;

destructor tListNode.DESTROY;
begin
  _edit_frm_.FREE;
end;

//------------------------------------------------------------------------------

class function tListNode.Create_IDE(const node:tLazExt_extIDEM_preSet_Node):tListNode;
begin
    result:=tListNode.Create;
    result._node_ide_:=node;
end;

class function tListNode.Create_PRJ(const node:tLazExt_extIDEM_preSet_Node):tListNode;
begin
    result:=tListNode.Create;
    result._node_prj_:=node;
end;

{%endRegion}



class function tLazExt_extIDEM_IDEOptions.GetGroupCaption:string;
begin
    result:='extIDEM';
end;

class function tLazExt_extIDEM_IDEOptions.GetInstance:TAbstractIDEOptions;
begin
    result:=nil;//TAbstractIDEOptions(self);
end;


//------------------------------------------------------------------------------

procedure tLazExt_extIDEM_frmPrjOptionEdit._treePreSets_setUp_ide_ideMCRs_(const treeNode:TTreeNode; const preSet:tLazExt_extIDEM_preSet_Node);
var tmp:tExtIDEM_McrPRM_node;
begin
    with preSet do begin
        tmp:=Param_First;
        while Assigned(tmp) do begin
            TreeView1.Items.AddChildObject(treeNode,tmp.node_IDNT,tNodeDATA.Create_IDE(tmp));
            tmp:=Param_Next(tmp);
        end;
    end;
end;

procedure tLazExt_extIDEM_frmPrjOptionEdit._treePreSets_setUp_ide_preSETs_(const preSETsList:tLazExt_extIDEM_preSetsList_core);
var tmp:tLazExt_extIDEM_preSet_Node;
    itm:TTreeNode;
begin
    with preSETsList do begin
        tmp:=PreSETs_enumFIRST;
        while Assigned(tmp) do begin
            itm:=TreeView1.Items.AddChildObject(nil,tmp.node_Name,tNodeDATA.Create_IDE(tmp));
           _treePreSets_setUp_ide_ideMCRs_(itm,tmp);
            tmp:=PreSETs_enum_NEXT(tmp);
        end;
    end;
end;

//------------------------------------------------------------------------------

procedure tLazExt_extIDEM_frmPrjOptionEdit._treePreSets_setUp_prj_ideMCRs_(const treeNode:TTreeNode; const preSet:tLazExt_extIDEM_preSet_Node);
var tmp:tExtIDEM_McrPRM_node;
  lNode:TTreeNode;
begin
    with preSet do begin
        tmp:=Param_First;
        while Assigned(tmp) do begin
            lNode:=_treePreSets_find_ideMCR_(treeNode,tmp.node_IDNT);
            if Assigned(lNode) and Assigned(lNode.Data) then begin
                tNodeDATA(lNode.Data).Node_PRJ_SET(tmp);
            end
            else begin
                TreeView1.Items.AddChildObject(treeNode,tmp.node_IDNT,tNodeDATA.Create_PRJ(tmp));
            end;
            //--->
            tmp:=Param_Next(tmp);
        end;
    end;
end;

procedure tLazExt_extIDEM_frmPrjOptionEdit._treePreSets_setUp_prj_preSETs_(const preSETsList:tLazExt_extIDEM_preSetsList_core);
var tmp:tLazExt_extIDEM_preSet_Node;
  lNode:TTreeNode;
begin
    with preSETsList do begin
        tmp:=PreSETs_enumFIRST;
        while Assigned(tmp) do begin
            lNode:=_treePreSets_find_preSET_(tmp.node_IDNT);
            if Assigned(lNode) and Assigned(lNode.Data) then begin
                tNodeDATA(lNode.Data).Node_PRJ_SET(tmp);
            end
            else begin
                lNode:=TreeView1.Items.AddChildObject(nil,tmp.node_Name,tNodeDATA.Create_PRJ(tmp));
            end;
            //---
           _treePreSets_setUp_prj_ideMCRs_(lNode,tmp);
            //--->
            tmp:=PreSETs_enum_NEXT(tmp);
        end;
    end;
end;


//------------------------------------------------------------------------------

procedure tLazExt_extIDEM_frmPrjOptionEdit._ExtIDEM_SET_(const value:tExtIDEM_prjResources);
begin
   _ui_ExtIDEM_Enablede_eventCLR_;
   _ExtIDEM_:=Value;
    if Assigned(_ExtIDEM_) then begin
        ui_ExtIDEM_Enabled.Checked:=_ExtIDEM_.Enabled;
        ui_ExtIDEM_MustDEL.Checked:=_ExtIDEM_.MustDEL;
        //---
        Panel2.Enabled:=_ExtIDEM_.Enabled;
        Panel3.Enabled:=_ExtIDEM_.Enabled;
        //--- ставим "ЛОГО"
        if _ExtIDEM_.Enabled
        then ui_ExtIDEM_LOGO.Font.Color:=clDefault
        else ui_ExtIDEM_LOGO.Font.Color:=clGrayText;
        if _ExtIDEM_.MustDEL
        then ui_ExtIDEM_LOGO.Font.Style:=ui_ExtIDEM_LOGO.Font.Style+[fsStrikeOut]
        else ui_ExtIDEM_LOGO.Font.Style:=ui_ExtIDEM_LOGO.Font.Style-[fsStrikeOut];
    end
    else begin //< чз ... надо ли вообще эту ветку
        Panel2.Enabled:=false;
        Panel3.Enabled:=false;
    end;
   _ui_ExtIDEM_Enablede_eventSET_;
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

procedure tLazExt_extIDEM_frmPrjOptionEdit.ui_ExtIDEM_EnabledChange(Sender: TObject);
begin
    if Assigned(_ExtIDEM_) then begin
       _ExtIDEM_.Enabled:=TCheckBox(Sender).Checked;
       _ExtIDEM_SET_(_ExtIDEM_);
    end;
end;

procedure tLazExt_extIDEM_frmPrjOptionEdit.ui_ExtIDEM_MustDELChange(Sender:TObject);
begin
    if Assigned(_ExtIDEM_) then begin
       _ExtIDEM_.MustDEL:=TCheckBox(Sender).Checked;
       _ExtIDEM_SET_(_ExtIDEM_);
    end;
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

procedure tLazExt_extIDEM_frmPrjOptionEdit._ui_ExtIDEM_Enablede_eventCLR_;
begin
    ui_ExtIDEM_Enabled.OnChange:=nil;
    ui_ExtIDEM_MustDEL.OnChange:=nil;
end;

procedure tLazExt_extIDEM_frmPrjOptionEdit._ui_ExtIDEM_Enablede_eventSET_;
begin
    ui_ExtIDEM_Enabled.OnChange:=@ui_ExtIDEM_EnabledChange;
    ui_ExtIDEM_MustDEL.OnChange:=@ui_ExtIDEM_MustDELChange;
end;

//------------------------------------------------------------------------------

procedure tLazExt_extIDEM_frmPrjOptionEdit.Setup(ADialog:TAbstractOptionsEditorDialog);
begin
   _ExtIDEM_SET_(nil);
   _treePreSets_clear_forFREE;  //< полная очистка
   _treePreSets_setUp_ide_preSETs_(extIDEM.preSets);
end;

procedure tLazExt_extIDEM_frmPrjOptionEdit.ReadSettings(AOptions:TAbstractIDEOptions);
begin
    // чистим от прощлых зависимостей проекта
   _treePreSets_clear_not_IDE;
   _treePreSets_clear_wasLoad_;
    // добавляем зависимости ТЕКУЩЕГО
   _ExtIDEM_SET_(ActiveProject_ExtIDEM_prjResources);
    if Assigned(_ExtIDEM_) and
       Assigned(_ExtIDEM_.preSets)
    then begin
      _treePreSets_setUp_prj_preSETs_(_ExtIDEM_.preSets);
    end;
    //---
   _treePreSets_Settings_Read_;
end;

procedure tLazExt_extIDEM_frmPrjOptionEdit.WriteSettings(AOptions:TAbstractIDEOptions);
var l:boolean;
begin
    l:=_treePreSets_Settings_Write_;
    if Assigned(_ExtIDEM_) and L then begin
        _ExtIDEM_.Modified:=TRUE;
    end;
   _ExtIDEM_.Modified:=TRUE;
end;

//------------------------------------------------------------------------------

procedure tLazExt_extIDEM_frmPrjOptionEdit.lst_preSetDragOver(Sender,
  Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean);
begin

end;

procedure tLazExt_extIDEM_frmPrjOptionEdit.Label2Click(Sender: TObject);
begin
    tLabel(Sender).ShowHelp;
end;

//------------------------------------------------------------------------------

procedure tLazExt_extIDEM_frmPrjOptionEdit.chb_nodeEnabledChange(Sender: TObject);
var nodeData:tNodeDATA;
begin
    if Assigned(_nodeFrame_) then begin //< изменяем данные в самом фрейме
        if not tCheckBox(Sender).Checked then begin
            // тут все просто, надо в самом фрейме поправить
           _nodeFrame_.NodeEnabled:=FALSE; //< отметили что неиспользуется
        end
        else begin //< а вот тут сложнее, возможно придется копировать
            if Assigned(_nodeTree_) then begin
                nodeData:=tNodeDATA(_nodeTree_.Data);
                if Assigned(nodeData) then begin
                    if nodeData.PRJ_exist then begin
                       _nodeFrame_.NodeEnabled:=TRUE;
                    end
                    else begin //< ну все, точно копировать
                       if Assigned(ActiveProject_ExtIDEM_prjResources) and
                          Assigned(ActiveProject_ExtIDEM_prjResources.preSets)
                       then begin
                            if nodeData.IS_Macros then begin
                                nodeData.COPY_toPRJ_MacroITM(ActiveProject_ExtIDEM_prjResources.preSets);
                               _nodeFrame_.NodeEnabled:=TRUE;
                            end
                           else
                            if nodeData.IS_McrPRM then begin
                                if Assigned(_nodeTree_.Parent) and Assigned(_nodeTree_.Parent.Data) then begin
                                    ShowMessage('chb_nodeEnabledChange -> COPY_toPRJ_MacroPRM');
                                    nodeData.COPY_toPRJ_MacroPRM(ActiveProject_ExtIDEM_prjResources.preSets, tNodeDATA(_nodeTree_.Parent.Data));
                                    //nodeData.e
                                   _nodeFrame_.NodeEnabled:=TRUE;
                                end;
                            end
                           else begin
                               _nodeFrame_.NodeEnabled:=FALSE;
                            end;
                            self._rePlace_TreeNODE_(_nodeTree_);
                        end;
                    end;
                end
                else begin
                   _nodeFrame_.NodeEnabled:=FALSE; //< отметили что неиспользуется
                end;
            end
            else begin
               _nodeFrame_.NodeEnabled:=FALSE; //< отметили что неиспользуется
            end;
        end;
       _nodeFrame_.NodeEnabled:=tCheckBox(Sender).Checked;
    end;
    if Assigned(_nodeTree_) then begin //< переустановим текстовки
      _rePlace_TreeNODE_Labels_(_nodeTree_);
      _rePlace_TreeNODE_enblCh_(_nodeTree_);
    end;
end;

procedure tLazExt_extIDEM_frmPrjOptionEdit.chb_nodeEnabledClick(Sender: TObject);
begin
end;


procedure tLazExt_extIDEM_frmPrjOptionEdit._chb_nodeEnabled_eventCLR;
begin
    with chb_nodeEnabled do begin
        OnChange:=nil;
        OnClick :=nil;
    end;
end;

procedure tLazExt_extIDEM_frmPrjOptionEdit._chb_nodeEnabled_eventSET;
begin
    with chb_nodeEnabled do begin
        OnChange:=@chb_nodeEnabledChange;
        OnClick :=@chb_nodeEnabledClick;
    end;
end;

//------------------------------------------------------------------------------

procedure tLazExt_extIDEM_frmPrjOptionEdit.lst_preSetDrawItem(
  Control: TWinControl; Index: Integer; ARect: TRect; State: TOwnerDrawState);
begin

end;


procedure tLazExt_extIDEM_frmPrjOptionEdit._rePlace_setFRM_(const FRM:tExtIDEM_core_objEDIT);
begin
    if FRM<>_nodeFrame_ then begin
        // сохраняем значение для СТАРОГО
        if Assigned(_nodeFrame_) and (_nodeFrame_.InheritsFrom(tExtIDEM_core_objEDIT))
        then begin
           _nodeFrame_.NodeEnabled:=chb_nodeEnabled.Checked;
        end;
        // готовим новый
        if Assigned(FRM) then begin

            {if FRM.NodeEnabled
            then ShowMessage(FRM.ClassName+' '+ IntToHex(integer(pointer(FRM)),8)+'FRM.NodeEnabled  - TRUE' )
            else ShowMessage(FRM.ClassName+' '+ IntToHex(integer(pointer(FRM)),8)+'FRM.NodeEnabled  - FALSE' );
            }
            chb_nodeEnabled.Checked:=FRM.NodeEnabled;
            FRM.Parent:=Panel3;
            FRM.Align:=alClient;
            FRM.SendToBack;
            FRM.Show;
        end;
        // убираем старый
        if Assigned(_nodeFrame_) then begin
           _nodeFrame_.Hide;
        end;
        // запомнили новый
       _nodeFrame_:=FRM;
    end;
end;

{function tLazExt_extIDEM_frmPrjOptionEdit._rePlace_getFRM_(const ITM:tLazExt_extIDEM_preSet_Node):tFrame;
begin
    result:=nil;
end;

procedure tLazExt_extIDEM_frmPrjOptionEdit._rePlace_setITM_(const ITM:tLazExt_extIDEM_preSet_Node);
begin
end;}

//------------------------------------------------------------------------------

function tLazExt_extIDEM_frmPrjOptionEdit._treePreSets_node_is_PreSET(const treeNode:TTreeNode):boolean;
begin
    result:=Assigned(treeNode) and Assigned(treeNode.Data);
    if result then with tNodeDATA(treeNode.Data) do begin
        if not(Assigned(Node_IDE) or Assigned(Node_PRJ)) then result:=FALSE
        else begin
            if tNodeDATA(treeNode.Data).PRJ_based
            then result:=tNodeDATA(treeNode.Data).Node_PRJ is tLazExt_extIDEM_preSet_Node
            else result:=tNodeDATA(treeNode.Data).Node_IDE is tLazExt_extIDEM_preSet_Node;
        end;
    end;
end;

function tLazExt_extIDEM_frmPrjOptionEdit._treePreSets_node_is_MACRO(const treeNode:TTreeNode):boolean;
begin
    result:=Assigned(treeNode) and Assigned(treeNode.Data);
    if result then with tNodeDATA(treeNode.Data) do begin
        if not(Assigned(Node_IDE) or Assigned(Node_PRJ)) then result:=FALSE
        else begin
            if tNodeDATA(treeNode.Data).PRJ_based
            then result:=tNodeDATA(treeNode.Data).Node_PRJ is tExtIDEM_McrPRM_node
            else result:=tNodeDATA(treeNode.Data).Node_IDE is tExtIDEM_McrPRM_node;
        end;
    end;
end;

function tLazExt_extIDEM_frmPrjOptionEdit._treePreSets_node_get_IDENT(const treeNode:TTreeNode):string;
begin
    result:='ndf';
    if _treePreSets_node_is_PreSET(treeNode)
    then
end;

//------------------------------------------------------------------------------

procedure tLazExt_extIDEM_frmPrjOptionEdit._treePreSets_clear_not_IDE;
var Enumerator:TTreeNodesEnumerator;
    node:TTreeNode;
    data:tNodeDATA;
begin
    //TreeView1.BeginUpdate;
    Enumerator:=TreeView1.Items.GetEnumerator; //< "указатель" стоит на -1 !!!
    if Enumerator.MoveNext then begin //< значит туть БОЛЬШЕ одного;
        node:=Enumerator.Current;
        while Assigned(node) do begin
            data:=tNodeDATA(node.Data);
            if Assigned(data) and (data.IDE_based) then begin
//                data.Node_PRJ_clean;
                if not Enumerator.MoveNext then break;
            end
            else begin
                node.Delete;
            end;
            try node:=Enumerator.Current; except BREAK; end;
        end;
    end;
    Enumerator.FREE;
    //TreeView1.EndUpdate;
end;

procedure tLazExt_extIDEM_frmPrjOptionEdit._treePreSets_clear_forFREE;
begin
    TreeView1.Items.Clear;
end;

procedure tLazExt_extIDEM_frmPrjOptionEdit._treePreSets_clear_wasLoad_;
var Enumerator:TTreeNodesEnumerator;
    node:TTreeNode;
    data:tNodeDATA;
begin
    Enumerator:=TreeView1.Items.GetEnumerator; //< "указатель" стоит на -1 !!!
    if Enumerator.MoveNext then begin //< значит туть БОЛЬШЕ одного;
        while Assigned(node) do begin
            node:=Enumerator.Current;
            data:=tNodeDATA(node.Data);
            if Assigned(data) then data.Was_Loaded_CLEAR;
            if not Enumerator.MoveNext then break;
        end;
    end;
    Enumerator.FREE;
end;

//------------------------------------------------------------------------------

function tLazExt_extIDEM_frmPrjOptionEdit._treePreSets_find_preSet_(const idnt:string):TTreeNode;
var data:tNodeDATA;
begin
    result:=TreeView1.Items.GetFirstNode;
    while Assigned(result) do begin
        data:=tNodeDATA(result.Data);
        if Assigned(data) and data.IDE_based then begin
            if tLazExt_extIDEM_preSet_Node(data.Node_IDE).node_IDNT=idnt
            then break
        end;
        result:=result.GetNextSibling;
    end;
end;

function tLazExt_extIDEM_frmPrjOptionEdit._treePreSets_find_ideMCR_(const prnt:TTreeNode; const idnt:string):TTreeNode;
var data:tNodeDATA;
begin
    result:=prnt.GetFirstChild;
    while Assigned(result) do begin
        data:=tNodeDATA(result.Data);
        if Assigned(data) and data.IDE_based then begin
            if tExtIDEM_McrPRM_node(data.Node_IDE).Node_IDNT=idnt
            then break
        end;
        result:=result.GetNextSibling;
    end;
end;

//------------------------------------------------------------------------------

procedure tLazExt_extIDEM_frmPrjOptionEdit._treePreSets_Settings_Read_;
var Enumerator:TTreeNodesEnumerator;
    node:TTreeNode;
    data:tNodeDATA;
begin
    Enumerator:=TreeView1.Items.GetEnumerator; //< "указатель" стоит на -1 !!!
    if Enumerator.MoveNext then begin //< значит туть БОЛЬШЕ одного;
        while Assigned(node) do begin
            node:=Enumerator.Current;
            data:=tNodeDATA(node.Data);
            if Assigned(data) then data.EDITOR_Settings_READ;
            if not Enumerator.MoveNext then break;
        end;
    end;
    Enumerator.FREE;
end;

function tLazExt_extIDEM_frmPrjOptionEdit._treePreSets_Settings_Write_:boolean;
var Enumerator:TTreeNodesEnumerator;
    node:TTreeNode;
    data:tNodeDATA;
begin
    result:=false;
    Enumerator:=TreeView1.Items.GetEnumerator; //< "указатель" стоит на -1 !!!
    if Enumerator.MoveNext then begin //< значит туть БОЛЬШЕ одного;
        while Assigned(node) do begin
            node:=Enumerator.Current;
            data:=tNodeDATA(node.Data);
            if Assigned(data) then begin
                result:=data.EDITOR_Settings_WRITE;
            end;
            if not Enumerator.MoveNext then break;
        end;
    end;
    Enumerator.FREE;
end;

//------------------------------------------------------------------------------

procedure tLazExt_extIDEM_frmPrjOptionEdit.lst_preSetSelectionChange(Sender:TObject; User:boolean);
begin
   //_lstPreSets_Show_Item_(TListBox(Sender).ItemIndex);
end;

procedure tLazExt_extIDEM_frmPrjOptionEdit.TreeView1Change(Sender:TObject; Node:TTreeNode);
begin
    if Assigned(node) then _rePlace_TreeNODE_(node);
   _nodeTree_:=Node;
end;

procedure tLazExt_extIDEM_frmPrjOptionEdit.TreeView1Changing(Sender: TObject;
  Node: TTreeNode; var AllowChange: Boolean);
begin
    //
end;

procedure tLazExt_extIDEM_frmPrjOptionEdit.TreeView1Deletion(Sender: TObject;
  Node: TTreeNode);
begin
    if Assigned(node) then begin
        if Assigned(node.Data) then begin
            tNodeDATA(node.Data).FREE;
            node.Data:=nil;
        end;
        //node.free;
    end;
end;



{procedure tLazExt_extIDEM_frmPrjOptionEdit._lstPreSets_clear_forFREE;
var tmp:tListNode;
    idx:integer;
begin
    for idx:=0 to lst_preSet.Items.Count-1 do begin
        tmp:=tListNode(lst_preSet.Items.Objects[idx]);
        lst_preSet.Items.Objects[idx]:=nil;
        tmp.FREE;
    end;
    lst_preSet.Clear;
end;}

{procedure tLazExt_extIDEM_frmPrjOptionEdit._lstPreSets_clear_forREAD;
var tmp:tListNode;
    idx:integer;
begin
    idx:=0;
    while idx<lst_preSet.Items.Count do begin
        tmp:=tListNode(lst_preSet.Items.Objects[idx]);
        if Assigned(tmp._node_ide_) then begin
            tmp._node_prj_:=nil;
            inc(idx);
        end
        else begin
            tmp.FREE;
            lst_preSet.Items.Objects[idx]:=nil;
            lst_preSet.Items.Delete(idx);
        end;
    end;
end;}

{function tLazExt_extIDEM_frmPrjOptionEdit._lstPreSets_Find_IDNT(const value:string):integer;
var tmp:tListNode;
    idx:integer;
begin
    result:=-1;
    for idx:=0 to lst_preSet.Items.Count-1 do begin
        tmp:=tListNode(lst_preSet.Items.Objects[idx]);
        if tmp._node_ide_.Obj_IDNT=value then begin
            result:=idx;
            BREAK;
        end;
    end;
end; }

{function tLazExt_extIDEM_frmPrjOptionEdit._lstPreSets_Item_Frame_(const value:integer):tFrame;
var tmp:tListNode;
begin
    result:=nil;
    tmp:=tListNode(lst_preSet.Items.Objects[value]);
    if Assigned(tmp) then begin
        result:=tmp._edit_frm_;
        if not Assigned(result) then begin
            if Assigned(tmp._node_ide_)and Assigned(tmp._node_ide_.def_frmEdtr)
            then result:=tmp._node_ide_.def_frmEdtr.Create(SELF)
           else
            if Assigned(tmp._node_prj_)and Assigned(tmp._node_prj_.def_frmEdtr)
            then result:=tmp._node_prj_.def_frmEdtr.Create(SELF);
            //
            tmp._edit_frm_:=result;
        end;
    end;
end;}

{procedure tLazExt_extIDEM_frmPrjOptionEdit._lstPreSets_Show_Item_(const value:integer);
var tmp:tListNode;
begin
    if (0<=value) then begin
      // _rePlace_setFRM_(_lstPreSets_Item_Frame_(idx));
        //---
     //   tmp:=tListNode(lst_preSet.Items.Objects[value]);
     //   label1.Caption:='';
     //   if Assigned(tmp._node_ide_) then label1.Caption:=label1.Caption+'+' else label1.Caption:=label1.Caption+'-';
     //   if Assigned(tmp._node_prj_) then label1.Caption:=label1.Caption+'+' else label1.Caption:=label1.Caption+'-';


    end
    else begin
       _rePlace_setFRM_(nil);
    end;
end;}


//------------------------------------------------------------------------------

constructor tLazExt_extIDEM_frmPrjOptionEdit.Create(AOwner: TComponent);
begin
    Inherited;
   _ExtIDEM_:=nil;
end;

destructor tLazExt_extIDEM_frmPrjOptionEdit.DESTROY;
begin
   _treePreSets_clear_forFREE;
    inherited;
end;

//------------------------------------------------------------------------------

procedure tLazExt_extIDEM_frmPrjOptionEdit._rePlace_TreeNODE_Editor_(const treeNode:TTreeNode);
var NodeDATA:tNodeDATA;
    NodeEdit:tExtIDEM_core_objEDIT;
begin
    NodeDATA:=_treeNodeDATA_(treeNode);
    if Assigned(NodeDATA) then begin
        //--- готовим фрейм
        NodeEdit:=NodeDATA.Node_EDT;
        if (not Assigned(NodeEdit))and(Assigned(NodeDATA.NodeTEDT))
        then begin
            NodeEdit:=NodeDATA.NodeTEDT.Create(SELF);
            //ShowMessage('NodeDATA.NodeTEDT.Create');
            NodeDATA.Node_EDT_SET(NodeEdit);
        end;
        //
        if Assigned(NodeEdit) then begin
            NodeDATA.EDITOR_Settings_READ;
        end;
    end;
    //--- показываем фрейм
    if Assigned(NodeEdit) then begin
       _rePlace_setFRM_(NodeEdit);
    end;
end;

procedure tLazExt_extIDEM_frmPrjOptionEdit._rePlace_TreeNODE_enblCh_(const treeNode:TTreeNode);
var nodeData:tNodeDATA;
begin
    if Assigned(treeNode)and Assigned(_nodeFrame_) then begin
        nodeData:=tNodeDATA(treeNode.Data);
        if Assigned(nodeData)and(not nodeData.IS_NotDEF) then begin
            chb_nodeEnabled.Checked:=nodeData.NodeENBL;
            if nodeData.IS_Macros then begin
                chb_nodeEnabled.Enabled:=true;
                Exit;
            end
           else
            if nodeData.IS_McrPRM then begin
                if Assigned(treeNode.Parent) and Assigned(treeNode.Parent.Data)
                then begin
                    chb_nodeEnabled.Enabled:=tNodeDATA(treeNode.Parent.Data).NodeENBL;
                end
                else begin
                    chb_nodeEnabled.Enabled:=false;
                end;
                Exit;
            end;
        end
    end;
    // !!! этот код сработает только если НЕ ВСТРЕТИТСЯ `exit` !!!
    chb_nodeEnabled.Enabled:=FALSE;
    chb_nodeEnabled.Checked:=FALSE;
end;

procedure tLazExt_extIDEM_frmPrjOptionEdit._rePlace_TreeNODE_Labels_(const treeNode:TTreeNode);
var nodeData:tNodeDATA;
begin
    if not (Assigned(treeNode) and Assigned(treeNode.Data)) then begin
        label1.Caption:='Not Default';
        Label7.Caption:='Not Default';
        frm_nodeName.setDELETED(true);
        frm_nodeName.setUsed   (false);
        frm_nodeName.setNames  ('','');
    end
    else begin
        nodeData:=tNodeDATA(treeNode.Data);
        label1.Caption:=nodeData.NodeNAME;
        label1.Hint   :=nodeData.NodeNAME;
        Label2.Hint   :=nodeData.NodeDESC;
        //--
        if nodeData.IS_Macros then begin
           //frm_nodeName.setDELETED(true);
           frm_nodeName.setUsed   (nodeData.NodeENBL);
           frm_nodeName.setNames  (nodeData.NodeIDNT,'');
        end
       else
        if nodeData.IS_McrPRM then begin
            if Assigned(treeNode.Parent) and Assigned(treeNode.Parent.Data)
            then begin
                frm_nodeName.setNames(tNodeDATA(treeNode.Parent.Data).NodeIDNT,nodeData.NodeIDNT);
                frm_nodeName.setUsed(nodeData.NodeENBL and tNodeDATA(treeNode.Parent.Data).NodeENBL);
            end
            else begin
                frm_nodeName.setNames('',nodeData.NodeIDNT);
                frm_nodeName.setUsed(_nodeFrame_.NodeEnabled{ nodeData.NodeENBL});
            end;
        end
       else begin
           frm_nodeName.setDELETED(false);
           frm_nodeName.setUsed   (false);
           frm_nodeName.setNames  ('nfd','nfd');
        end;
    end;
end;

// отображение соответстующего фрейма
procedure tLazExt_extIDEM_frmPrjOptionEdit._rePlace_TreeNODE_(const treeNode:TTreeNode);
begin
   _chb_nodeEnabled_eventCLR;
   _rePlace_TreeNODE_Editor_(treeNode);
   _rePlace_TreeNODE_Labels_(treeNode);
   _rePlace_TreeNODE_enblCh_(treeNode);
    //---
   _nodeTree_:=treeNode;
   _chb_nodeEnabled_eventSET;
end;

//------------------------------------------------------------------------------

//==============================================================================

function tLazExt_extIDEM_frmPrjOptionEdit.GetTitle:string;
begin
    result:='extIDEM';
end;

class function tLazExt_extIDEM_frmPrjOptionEdit.SupportedOptionsClass:TAbstractIDEOptionsClass;
begin
    result:=nil;
end;

end.

