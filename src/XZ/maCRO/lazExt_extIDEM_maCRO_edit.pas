unit lazExt_extIDEM_maCRO_edit;

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




uses windows, extIDEM_coreObject,
  Classes, SysUtils, FileUtil, Forms, Controls;

type


 tlazExt_extIDEM_edtNode=class(tExtIDEM_core_objNODE)
  end;

 tLazExt_extIDEM_frmEdit = class(tExtIDEM_core_objEDIT)
  end;
// tLazExt_extIDEM_frmEditTYPE=class of TlazExt_extIDEM_frmEdit;

implementation

{$R *.lfm}

{constructor tLazExt_extIDEM_frmEdit.Create(TheOwner:TComponent);
begin
    inherited Create(TheOwner);
    sleep(100);
    self.Name:=self.Name+inttostr(GetTickCount64);
end;

//------------------------------------------------------------------------------

procedure tLazExt_extIDEM_frmEdit.Settings_Read(const node:tlazExt_extIDEM_edtNode);
begin
    //
end;

procedure tLazExt_extIDEM_frmEdit.Settings_Write(const node:tlazExt_extIDEM_edtNode);
begin
    //
end;

//==============================================================================

{$ifDef _TSTABS_}
class function tlazExt_extIDEM_edtNode.NodeTYPE_Name:string;
begin
    Assert(false,self.ClassName+'.Node_Name mast by OVERRIDE');
    result:=self.ClassName;
end;
{$endif}

{$ifDef _TSTABS_}
class function tlazExt_extIDEM_edtNode.NodeTYPE_Desc:string;
begin
    Assert(false,self.ClassName+'.Node_Desc mast by OVERRIDE');
    result:=self.ClassName;
end;
{$endif}  }

end.

