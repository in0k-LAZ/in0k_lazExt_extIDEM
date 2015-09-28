unit extIDEM_MACROS_Intf;

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


uses extIDEM_coreObject, extIDEM_MACROS_node;


{extIDEM_McrPRM_node,  IDEOptionsIntf, lazExt_extIDEM_maCRO_edit,  extIDEM_coreObject,  Dialogs,
  Classes, SysUtils, FileUtil, Forms, Controls, Grids, StdCtrls, ExtCtrls;}

type

 tExtIDEM_MACROS_node_custom=class(tLazExt_extIDEM_preSet_Node)
  protected
    class function ObjTEdit:tExtIDEM_core_objEditTYPE; {$ifDef _TSTABS_}override;{$endif}
    class function Obj_IDNT:string;                    {$ifDef _TSTABS_}override;{$endif}
    class function Obj_Name:string;                    {$ifDef _TSTABS_}override;{$endif}
    class function Obj_Desc:string;                    {$ifDef _TSTABS_}override;{$endif}
  end;

 { TExtIDEM_MACROS_edit_custom }

 TExtIDEM_MACROS_edit_custom=class(tExtIDEM_core_objEDIT)
   // procedure ListBox1SelectionChange(Sender: TObject; User: boolean);
  private
   {_preSet_:tExtIDEM_MACROS_node_custom;
    procedure _preSet_SET_(preSet:tExtIDEM_MACROS_node_custom);
    function  _preSet_FND_:tExtIDEM_MACROS_node_custom; }
  protected
   { function  _preSet_GET_:tExtIDEM_MACROS_node_custom; }
  private
    //procedure _Rec_set_(value:PIDEOptionsEditorRec);
    //function  _Rec_get_:PIDEOptionsEditorRec;
  protected
    //procedure _ENBL_SET_(const value:boolean); override;

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
    //constructor Create(AOwner: TComponent); override;
  public
    //property Rec:PIDEOptionsEditorRec read _Rec_get_ write _Rec_set_;
  end;
 tLazExt_extIDEM_preSet_frmEditTYPE=class of TExtIDEM_MACROS_edit_custom;


implementation
uses lazExt_extIDEM;

{$R *.lfm}

{constructor TExtIDEM_MACROS_edit_custom.Create(AOwner:TComponent);
begin
    inherited Create(AOwner);
   //_preSet_:=nil;
end;}

{
procedure TExtIDEM_MACROS_edit_custom._ENBL_SET_(const value:boolean);
begin
    inherited;
    if value
    then ShowMessage(self.ClassName+' '+ IntToHex(integer(pointer(self)),8)+'_ENBL_SET_ - TRUE' )
    else ShowMessage(self.ClassName+' '+ IntToHex(integer(pointer(self)),8)+'_ENBL_SET_ - FALSE' );
end;
 }
//------------------------------------------------------------------------------
{
procedure TExtIDEM_MACROS_edit_custom._preSet_SET_(preSet:tExtIDEM_MACROS_node_custom);
begin
   _preSet_:=preSet;
    if Assigned(_preSet_) then self.Name:=self.Name+_preSet_.ClassName;
end;

function TExtIDEM_MACROS_edit_custom._preSet_FND_:tExtIDEM_MACROS_node_custom;
begin
    if Assigned(REC) then result:=extIDEM.preSet_FiND(self.Rec^.Index)
    else result:=nil;
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

function TExtIDEM_MACROS_edit_custom._preSet_GET_:tExtIDEM_MACROS_node_custom;
begin
    result:=_preSet_;
    if not Assigned(result) then begin
        result:=_preSet_FND_;
       _preSet_SET_(result);
    end;
end;

//------------------------------------------------------------------------------

{$ifDef _TSTABS_}
function TExtIDEM_MACROS_edit_custom.GetTitle:string;
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

procedure TExtIDEM_MACROS_edit_custom.Setup(ADialog:TAbstractOptionsEditorDialog);
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


function TExtIDEM_MACROS_edit_custom._nodesList_Present_:boolean;
begin
    result:=ListBox1.Count>0;
end;

function TExtIDEM_MACROS_edit_custom._nodesList_mstReCrt:boolean;
begin
    result:=0=self.ListBox1.Count;
end;

procedure TExtIDEM_MACROS_edit_custom._nodesList_ReCreate;
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

procedure TExtIDEM_MACROS_edit_custom._nodesList_settings_read_;
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

procedure TExtIDEM_MACROS_edit_custom._nodesList_settings_write_;
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



procedure TExtIDEM_MACROS_edit_custom.ReadSettings(AOptions:TAbstractIDEOptions);
begin
    if _nodesList_mstReCrt then _nodesList_ReCreate;
    //
    if _nodesList_Present_ then _nodesList_settings_read_;
end;

procedure TExtIDEM_MACROS_edit_custom.WriteSettings(AOptions:TAbstractIDEOptions);
begin
    if _nodesList_Present_ then _nodesList_settings_write_;
end;

//------------------------------------------------------------------------------

function TExtIDEM_MACROS_edit_custom._nodeFrame_CRT_(const node:tLazExt_extIDEM_node):tLazExt_extIDEM_frmEdit;
begin
    result:=nil;
    if Assigned(node) then result:=tLazExt_extIDEM_frmEdit(node.ObjTEdit.Create(SELF));
    result.Settings_Read(node);
end;

procedure TExtIDEM_MACROS_edit_custom._nodeFrame_rePlace_(const oldEdit,newEdit:tLazExt_extIDEM_frmEdit);
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

function TExtIDEM_MACROS_edit_custom._nodeFrame_GET_:tLazExt_extIDEM_frmEdit;
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

procedure TExtIDEM_MACROS_edit_custom.ListBox1SelectionChange(Sender:TObject; User:boolean);
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

{procedure TExtIDEM_MACROS_edit_custom._Rec_set_(value:PIDEOptionsEditorRec);
begin
    inherited Rec:=value;
   _preSet_SET_(_preSet_FND_);
end;

function TExtIDEM_MACROS_edit_custom._Rec_get_:PIDEOptionsEditorRec;
begin
    result:=inherited Rec;
end; }

//------------------------------------------------------------------------------

class function TExtIDEM_MACROS_edit_custom.SupportedOptionsClass:TAbstractIDEOptionsClass;
begin
    result:=nil;
end;

}
//==============================================================================


//------------------------------------------------------------------------------


//------------------------------------------------------------------------------

{$ifDef _TSTABS_}
class function tExtIDEM_MACROS_node_custom.ObjTEdit:tExtIDEM_core_objEditTYPE;
begin
    result:=TExtIDEM_MACROS_edit_custom;
end;
{$endif}

{$ifDef _TSTABS_}
class function tExtIDEM_MACROS_node_custom.Obj_IDNT:string;
begin
    result:='Obj_IDNT='+self.ClassName;
    Assert(false,self.ClassName+'.Obj_IDNT mast by OVERRIDE');
end;
{$endif}

{$ifDef _TSTABS_}
class function tExtIDEM_MACROS_node_custom.Obj_Name:string;
begin
    result:='Obj_Name='+self.ClassName;
    Assert(false,self.ClassName+'.Obj_Name mast by OVERRIDE');
end;
{$endif}

{$ifDef _TSTABS_}
class function tExtIDEM_MACROS_node_custom.Obj_Desc:string;
begin
    result:='Obj_Desc='+self.ClassName;
    Assert(false,self.ClassName+'.Obj_Desc mast by OVERRIDE');
end;
{$endif}

{

{$ifDef _TSTABS_}
class function tExtIDEM_MACROS_node_custom.preSet_IDNT:string;
begin
    result:=self.ClassName;
    Assert(false,self.ClassName+'.preSet_IDNT mast by OVERRIDE');
end;
{$endif}

{$ifDef _TSTABS_}
class function tExtIDEM_MACROS_node_custom.preSet_Name:string;
begin
    result:=self.ClassName;
    Assert(false,self.ClassName+'.preSet_Name mast by OVERRIDE');
end;
{$endif}

{$ifDef _TSTABS_}
class function tExtIDEM_MACROS_node_custom.preSet_Desc:string;
begin
    result:=self.ClassName;
    Assert(false,self.ClassName+'.preSet_Desc mast by OVERRIDE');
end;
{$endif}
               }
end.

