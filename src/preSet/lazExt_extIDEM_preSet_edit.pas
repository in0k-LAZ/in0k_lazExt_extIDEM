unit lazExt_extIDEM_preSet_edit;

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


uses lazExt_extIDEM_maCRO_node,  IDEOptionsIntf, lazExt_extIDEM_maCRO_edit,  extIDEM_coreObject,  Dialogs,
  Classes, SysUtils, FileUtil, Forms, Controls, Grids, StdCtrls, ExtCtrls;

type

 tLazExt_extIDEM_preSet_edtNode=class(tExtIDEM_core_objNODE)
  private
   _param_list_:tLazExt_extIDEM_nodesList_core;
  protected
    class function ObjTEdit:tExtIDEM_core_objEditTYPE; {$ifDef _TSTABS_}override;{$endif}
    class function Obj_IDNT:string;                    {$ifDef _TSTABS_}override;{$endif}
    class function Obj_Name:string;                    {$ifDef _TSTABS_}override;{$endif}
    class function Obj_Desc:string;                    {$ifDef _TSTABS_}override;{$endif}
  public
    constructor Create; virtual;
    destructor DESTROY; override;
  public
    function Param_ADD(const prmName:string; const prmType:tLazExt_extIDEM_nodeTYPE; const prmEdit:tExtIDEM_core_objEditTYPE):boolean;
    function Param_ADD(const prmName:string; const prmType:tLazExt_extIDEM_nodeTYPE):boolean;
    function Param_ADD(const prmType:tLazExt_extIDEM_nodeTYPE):boolean;
    function Param_First:tLazExt_extIDEM_node;
    function Param_Next(const node:tLazExt_extIDEM_node):tLazExt_extIDEM_node;
  end;

 { tLazExt_extIDEM_preSet_frmEdit }

 tLazExt_extIDEM_preSet_frmEdit=class(tExtIDEM_core_objEDIT)
   // procedure ListBox1SelectionChange(Sender: TObject; User: boolean);
  private
   {_preSet_:tLazExt_extIDEM_preSet_edtNode;
    procedure _preSet_SET_(preSet:tLazExt_extIDEM_preSet_edtNode);
    function  _preSet_FND_:tLazExt_extIDEM_preSet_edtNode; }
  protected
   { function  _preSet_GET_:tLazExt_extIDEM_preSet_edtNode; }
  private
    //procedure _Rec_set_(value:PIDEOptionsEditorRec);
    //function  _Rec_get_:PIDEOptionsEditorRec;
  protected
    procedure _ENBL_SET_(const value:boolean); override;

   { function  _nodesList_Present_:boolean;
    function  _nodesList_mstReCrt:boolean;
    procedure _nodesList_ReCreate;
    procedure _nodesList_settings_read_;
    procedure _nodesList_settings_write_;
  protected
    function  _nodeFrame_CRT_(const node:tLazExt_extIDEM_node):tLazExt_extIDEM_frmEdit;
    function  _nodeFrame_GET_:tLazExt_extIDEM_frmEdit;
    procedure _nodeFrame_rePlace_(const oldEdit,newEdit:tLazExt_extIDEM_frmEdit);
    //procedure _nodeFrame_show_();

  public
    class function SupportedOptionsClass:TAbstractIDEOptionsClass; override;
  public
    {$ifDef _TSTABS_}
    function GetTitle:string; override;
    {$endif}
  public
    procedure Setup(ADialog:TAbstractOptionsEditorDialog);  override;
    procedure ReadSettings(AOptions:TAbstractIDEOptions);   override;
    procedure WriteSettings(AOptions:TAbstractIDEOptions);  override;
  public
  public    }
    constructor Create(AOwner: TComponent); override;
  public
    //property Rec:PIDEOptionsEditorRec read _Rec_get_ write _Rec_set_;
  end;
 tLazExt_extIDEM_preSet_frmEditTYPE=class of tLazExt_extIDEM_preSet_frmEdit;


implementation
uses lazExt_extIDEM;

{$R *.lfm}

constructor tLazExt_extIDEM_preSet_frmEdit.Create(AOwner:TComponent);
begin
    inherited Create(AOwner);
   //_preSet_:=nil;
end;


procedure tLazExt_extIDEM_preSet_frmEdit._ENBL_SET_(const value:boolean);
begin
    inherited;
    if value
    then ShowMessage(self.ClassName+' '+ IntToHex(integer(pointer(self)),8)+'_ENBL_SET_ - TRUE' )
    else ShowMessage(self.ClassName+' '+ IntToHex(integer(pointer(self)),8)+'_ENBL_SET_ - FALSE' );
end;

//------------------------------------------------------------------------------
{
procedure tLazExt_extIDEM_preSet_frmEdit._preSet_SET_(preSet:tLazExt_extIDEM_preSet_edtNode);
begin
   _preSet_:=preSet;
    if Assigned(_preSet_) then self.Name:=self.Name+_preSet_.ClassName;
end;

function tLazExt_extIDEM_preSet_frmEdit._preSet_FND_:tLazExt_extIDEM_preSet_edtNode;
begin
    if Assigned(REC) then result:=extIDEM.preSet_FiND(self.Rec^.Index)
    else result:=nil;
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

function tLazExt_extIDEM_preSet_frmEdit._preSet_GET_:tLazExt_extIDEM_preSet_edtNode;
begin
    result:=_preSet_;
    if not Assigned(result) then begin
        result:=_preSet_FND_;
       _preSet_SET_(result);
    end;
end;

//------------------------------------------------------------------------------

{$ifDef _TSTABS_}
function tLazExt_extIDEM_preSet_frmEdit.GetTitle:string;
begin // нифига эта схема пока не работает, потому что при содании и отображении
      // этого фрейма установка `Rec` идет ПОСЛЕ вызова этого метода
      // в методе `TIDEOptionsDialog.CreateEditors`
    if Assigned(_preSet_GET_) then result:=_preSet_GET_.preSet_Name
    else result:=self.ClassName;
      {todo: в каждой версии проверять изменилось ли что-ниб в `TIDEOptionsDialog.CreateEditors`}
      {done: 1.4.2 `TIDEOptionsDialog.CreateEditors` изменений НЕТ}
      {todo: 1.4.2 `TIDEOptionsDialog.CreateEditors` изменений }
end;
{$endIf}

//------------------------------------------------------------------------------

procedure tLazExt_extIDEM_preSet_frmEdit.Setup(ADialog:TAbstractOptionsEditorDialog);
begin

end;


type

 tASD=class
   _node_:tLazExt_extIDEM_node;
   _edit_:tLazExt_extIDEM_frmEdit;
  public
    constructor Create(const node:tLazExt_extIDEM_node);
  end;


constructor tASD.Create(const node:tLazExt_extIDEM_node);
begin
  _node_:=node;
  _edit_:=nil;
end;


function tLazExt_extIDEM_preSet_frmEdit._nodesList_Present_:boolean;
begin
    result:=ListBox1.Count>0;
end;

function tLazExt_extIDEM_preSet_frmEdit._nodesList_mstReCrt:boolean;
begin
    result:=0=self.ListBox1.Count;
end;

procedure tLazExt_extIDEM_preSet_frmEdit._nodesList_ReCreate;
var tmp:tLazExt_extIDEM_node;
begin
    if Assigned(_preSet_GET_) then begin
        tmp:=_preSet_GET_.Nodes_First;
        while Assigned(tmp) do begin
            self.ListBox1.Items.AddObject(tmp.Node_Name,tASD.Create(tmp));
            //--->
            tmp:=_preSet_GET_.Nodes_Next(tmp);
        end;
    end;
end;

procedure tLazExt_extIDEM_preSet_frmEdit._nodesList_settings_read_;
var i:integer;
  tmp:tASD;
begin
    for i:=0 to ListBox1.Count-1 do begin
        tmp:=tAsd(ListBox1.Items.Objects[i]);
        if Assigned(tmp)and Assigned(tmp._node_)and Assigned(tmp._edit_) then begin
            tmp._edit_.Settings_Read(tmp._node_);
        end;
    end;
end;

procedure tLazExt_extIDEM_preSet_frmEdit._nodesList_settings_write_;
var i:integer;
  tmp:tASD;
begin
    for i:=0 to ListBox1.Count-1 do begin
        tmp:=tAsd(ListBox1.Items.Objects[i]);
        if Assigned(tmp)and Assigned(tmp._node_)and Assigned(tmp._edit_) then begin
            tmp._edit_.Settings_Write(tmp._node_);
        end;
    end;
end;



procedure tLazExt_extIDEM_preSet_frmEdit.ReadSettings(AOptions:TAbstractIDEOptions);
begin
    if _nodesList_mstReCrt then _nodesList_ReCreate;
    //
    if _nodesList_Present_ then _nodesList_settings_read_;
end;

procedure tLazExt_extIDEM_preSet_frmEdit.WriteSettings(AOptions:TAbstractIDEOptions);
begin
    if _nodesList_Present_ then _nodesList_settings_write_;
end;

//------------------------------------------------------------------------------

function tLazExt_extIDEM_preSet_frmEdit._nodeFrame_CRT_(const node:tLazExt_extIDEM_node):tLazExt_extIDEM_frmEdit;
begin
    result:=nil;
    if Assigned(node) then result:=tLazExt_extIDEM_frmEdit(node.ObjTEdit.Create(SELF));
    result.Settings_Read(node);
end;

procedure tLazExt_extIDEM_preSet_frmEdit._nodeFrame_rePlace_(const oldEdit,newEdit:tLazExt_extIDEM_frmEdit);
begin
    // готовим новый
    if Assigned(newEdit) then begin
        newEdit.Parent:=Panel1;
        newEdit.Align:=alClient;
        newEdit.SendToBack;
        newEdit.Show;
    end;
    // убираем старый
    if Assigned(oldEdit) then oldEdit.Hide;
end;

function tLazExt_extIDEM_preSet_frmEdit._nodeFrame_GET_:tLazExt_extIDEM_frmEdit;
var i:integer;
begin
    result:=nil;
    for i:=0 to panel1.ControlCount-1 do begin
        if panel1.Controls[i] is tLazExt_extIDEM_frmEdit then begin
            result:=tLazExt_extIDEM_frmEdit(panel1.Controls[i]);
            break
        end;
    end;
end;

//------------------------------------------------------------------------------

procedure tLazExt_extIDEM_preSet_frmEdit.ListBox1SelectionChange(Sender:TObject; User:boolean);
var i:integer;
var tmp:tASD;
begin
    i:=ListBox1.ItemIndex;
    if i>=0 then begin
        tmp:=tASD(ListBox1.Items.Objects[i]);
        if not Assigned(tmp._edit_) then tmp._edit_:=_nodeFrame_CRT_(tmp._node_);
        //---
       _nodeFrame_rePlace_(_nodeFrame_GET_,tmp._edit_);
    end;
end;


//------------------------------------------------------------------------------

{procedure tLazExt_extIDEM_preSet_frmEdit._Rec_set_(value:PIDEOptionsEditorRec);
begin
    inherited Rec:=value;
   _preSet_SET_(_preSet_FND_);
end;

function tLazExt_extIDEM_preSet_frmEdit._Rec_get_:PIDEOptionsEditorRec;
begin
    result:=inherited Rec;
end; }

//------------------------------------------------------------------------------

class function tLazExt_extIDEM_preSet_frmEdit.SupportedOptionsClass:TAbstractIDEOptionsClass;
begin
    result:=nil;
end;

}
//==============================================================================

constructor tLazExt_extIDEM_preSet_edtNode.Create;
begin
   _param_list_:=tLazExt_extIDEM_nodesList_core.Create;
end;

destructor tLazExt_extIDEM_preSet_edtNode.DESTROY;
begin
   _param_list_.FREE;
    inherited;
end;

//------------------------------------------------------------------------------

function tLazExt_extIDEM_preSet_edtNode.Param_ADD(const prmName:string; const prmType:tLazExt_extIDEM_nodeTYPE; const prmEdit:tExtIDEM_core_objEditTYPE):boolean;
begin
     result:=_param_list_.ADD(prmName,prmType,prmEdit);
end;

function tLazExt_extIDEM_preSet_edtNode.Param_ADD(const prmName:string; const prmType:tLazExt_extIDEM_nodeTYPE):boolean;
begin
    result:=Param_ADD(prmName,prmType,nil);
end;

function tLazExt_extIDEM_preSet_edtNode.Param_ADD(const prmType:tLazExt_extIDEM_nodeTYPE):boolean;
begin
    result:=Param_ADD('',prmType,nil);
end;

//------------------------------------------------------------------------------

function tLazExt_extIDEM_preSet_edtNode.Param_First:tLazExt_extIDEM_node;
begin
    result:=_param_list_.Nodes_First;
end;

function tLazExt_extIDEM_preSet_edtNode.Param_Next(const node:tLazExt_extIDEM_node):tLazExt_extIDEM_node;
begin
    result:=_param_list_.Nodes_Next(node);
end;

//------------------------------------------------------------------------------

{$ifDef _TSTABS_}
class function tLazExt_extIDEM_preSet_edtNode.ObjTEdit:tExtIDEM_core_objEditTYPE;
begin
    result:=tLazExt_extIDEM_preSet_frmEdit;
end;
{$endif}

{$ifDef _TSTABS_}
class function tLazExt_extIDEM_preSet_edtNode.Obj_IDNT:string;
begin
    result:='Obj_IDNT='+self.ClassName;
    Assert(false,self.ClassName+'.Obj_IDNT mast by OVERRIDE');
end;
{$endif}

{$ifDef _TSTABS_}
class function tLazExt_extIDEM_preSet_edtNode.Obj_Name:string;
begin
    result:='Obj_Name='+self.ClassName;
    Assert(false,self.ClassName+'.Obj_Name mast by OVERRIDE');
end;
{$endif}

{$ifDef _TSTABS_}
class function tLazExt_extIDEM_preSet_edtNode.Obj_Desc:string;
begin
    result:='Obj_Desc='+self.ClassName;
    Assert(false,self.ClassName+'.Obj_Desc mast by OVERRIDE');
end;
{$endif}

{

{$ifDef _TSTABS_}
class function tLazExt_extIDEM_preSet_edtNode.preSet_IDNT:string;
begin
    result:=self.ClassName;
    Assert(false,self.ClassName+'.preSet_IDNT mast by OVERRIDE');
end;
{$endif}

{$ifDef _TSTABS_}
class function tLazExt_extIDEM_preSet_edtNode.preSet_Name:string;
begin
    result:=self.ClassName;
    Assert(false,self.ClassName+'.preSet_Name mast by OVERRIDE');
end;
{$endif}

{$ifDef _TSTABS_}
class function tLazExt_extIDEM_preSet_edtNode.preSet_Desc:string;
begin
    result:=self.ClassName;
    Assert(false,self.ClassName+'.preSet_Desc mast by OVERRIDE');
end;
{$endif}
               }
end.

