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


uses lazExt_extIDEM_maCRO_node,  IDEOptionsIntf,
  Classes, SysUtils, FileUtil, Forms, Controls, Grids, StdCtrls;

type

 tLazExt_extIDEM_preSet_edtNode=class(tLazExt_extIDEM_nodesList_core)
  public
    class function preSet_IDNT:string; virtual; {$ifNdef _TSTABS_} abstract; {$endif}
    class function preSet_Name:string; virtual; {$ifNdef _TSTABS_} abstract; {$endif}
    class function preSet_Desc:string; virtual; {$ifNdef _TSTABS_} abstract; {$endif}
  end;

 { tLazExt_extIDEM_preSet_frmEdit }

 tLazExt_extIDEM_preSet_frmEdit=class(TAbstractIDEOptionsEditor)
    ListBox1: TListBox;
    StringGrid1: TStringGrid;
  private
   _preSet_:tLazExt_extIDEM_preSet_edtNode;
    procedure _preSet_SET_(preSet:tLazExt_extIDEM_preSet_edtNode);
    function  _preSet_FND_:tLazExt_extIDEM_preSet_edtNode;
  protected
    function _preSet_GET_:tLazExt_extIDEM_preSet_edtNode;
  private
    procedure _Rec_set_(value:PIDEOptionsEditorRec);
    function  _Rec_get_:PIDEOptionsEditorRec;
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
  public
    constructor Create(AOwner: TComponent); override;
  public
    property Rec:PIDEOptionsEditorRec read _Rec_get_ write _Rec_set_;
  end;
 tLazExt_extIDEM_preSet_frmEditTYPE=class of tLazExt_extIDEM_preSet_frmEdit;


implementation
uses lazExt_extIDEM;

{$R *.lfm}

constructor tLazExt_extIDEM_preSet_frmEdit.Create(AOwner:TComponent);
begin
    inherited Create(AOwner);
   _preSet_:=nil;
end;

//------------------------------------------------------------------------------

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

procedure tLazExt_extIDEM_preSet_frmEdit.ReadSettings(AOptions:TAbstractIDEOptions);
var tmp:tLazExt_extIDEM_node;
begin
    self.ListBox1.Items.Add('sadf');
    if Assigned(_preSet_GET_) then begin
        tmp:=_preSet_GET_.Nodes_First;
        while Assigned(tmp) do begin
            self.ListBox1.Items.AddObject(tmp.maCRO_Name,tmp);
            //--->
            tmp:=_preSet_GET_.Nodes_Next(tmp);
        end;
    end;
end;

procedure tLazExt_extIDEM_preSet_frmEdit.WriteSettings(AOptions:TAbstractIDEOptions);
begin

end;

//------------------------------------------------------------------------------

procedure tLazExt_extIDEM_preSet_frmEdit._Rec_set_(value:PIDEOptionsEditorRec);
begin
    inherited Rec:=value;
   _preSet_SET_(_preSet_FND_);
end;

function tLazExt_extIDEM_preSet_frmEdit._Rec_get_:PIDEOptionsEditorRec;
begin
    result:=inherited Rec;
end;

//------------------------------------------------------------------------------

class function tLazExt_extIDEM_preSet_frmEdit.SupportedOptionsClass:TAbstractIDEOptionsClass;
begin
    result:=nil;
end;

//==============================================================================

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

end.

