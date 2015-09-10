unit lazExt_extIDEM_edit;

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




uses
  Classes, SysUtils, FileUtil, Forms, Controls;

type


 tlazExt_extIDEM_edtNode=class
  public
    class function NodeTYPE_Name:string; virtual; {$ifNdef _TSTABS_} abstract; {$endif}
    class function NodeTYPE_Desc:string; virtual; {$ifNdef _TSTABS_} abstract; {$endif}
  end;

 tLazExt_extIDEM_frmEdit = class(TFrame)
  private
    { private declarations }
  public
    { public declarations }
  end;
 tLazExt_extIDEM_frmEditTYPE=class of TlazExt_extIDEM_frmEdit;

implementation

{$R *.lfm}

//==============================================================================

{$ifDef _TSTABS_}
class function tlazExt_extIDEM_edtNode.NodeTYPE_Name:string;
begin
    Assert(false,self.ClassName+'.Node_Name mast by OVERRIDE');
end;
{$endif}

{$ifDef _TSTABS_}
class function tlazExt_extIDEM_edtNode.NodeTYPE_Desc:string;
begin
    Assert(false,self.ClassName+'.Node_Desc mast by OVERRIDE');
end;
{$endif}

end.

