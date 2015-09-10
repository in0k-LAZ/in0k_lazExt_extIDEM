unit lazExt_extIDEM_Group_edit;

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


uses lazExt_extIDEM_node,  IDEOptionsIntf,
  Classes, SysUtils, FileUtil, Forms, Controls;

type

 tLazExt_extIDEM_preSet_edtNode=class(tLazExt_extIDEM_nodesList_core)
  public
    class function preSet_Name:string; virtual; {$ifNdef _TSTABS_} abstract; {$endif}
    class function preSet_Desc:string; virtual; {$ifNdef _TSTABS_} abstract; {$endif}
  end;

 tLazExt_extIDEM_preSet_frmEdit = class(TAbstractIDEOptionsEditor)
  private
   _preSet_:tLazExt_extIDEM_preSet_edtNode;
  public
    class function SupportedOptionsClass: TAbstractIDEOptionsClass; override;
  public
    function GetTitle:string; override;
  public
    procedure Setup(ADialog:TAbstractOptionsEditorDialog);  override;
    procedure ReadSettings(AOptions:TAbstractIDEOptions);   override;
    procedure WriteSettings(AOptions:TAbstractIDEOptions);  override;
  public
    procedure preSet_SET(preSet:tLazExt_extIDEM_preSet_edtNode);
  public
    constructor Create(AOwner: TComponent); override;
  end;

implementation

{$R *.lfm}

constructor tLazExt_extIDEM_preSet_frmEdit.Create(AOwner:TComponent);
begin
    inherited Create(AOwner);
   _preSet_:=nil;
end;

procedure tLazExt_extIDEM_preSet_frmEdit.preSet_SET(preSet:tLazExt_extIDEM_preSet_edtNode);
begin
  _preSet_:=preSet;
   self.Name:=name+preSet.ClassName;
end;

function tLazExt_extIDEM_preSet_frmEdit.GetTitle:string;
begin
    result:='preSet';
end;

//------------------------------------------------------------------------------

procedure tLazExt_extIDEM_preSet_frmEdit.Setup(ADialog:TAbstractOptionsEditorDialog);
begin

end;

procedure tLazExt_extIDEM_preSet_frmEdit.ReadSettings(AOptions:TAbstractIDEOptions);
begin

end;

procedure tLazExt_extIDEM_preSet_frmEdit.WriteSettings(AOptions:TAbstractIDEOptions);
begin

end;

//------------------------------------------------------------------------------

class function tLazExt_extIDEM_preSet_frmEdit.SupportedOptionsClass:TAbstractIDEOptionsClass;
begin
    result:=nil;
end;

//==============================================================================

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

