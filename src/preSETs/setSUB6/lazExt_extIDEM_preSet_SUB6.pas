unit lazExt_extIDEM_preSet_SUB6;

{$mode objfpc}{$H+}

interface

uses lazExt_extIDEM_preSet_node,
     lazExt_extIDEM_preSet_edit,
     //---
     lazExt_extIDEM_maCRO_TextSL,
  Classes, SysUtils, FileUtil, Forms, Controls;

type

 tExtIDEM_preSet_SUB6_node=class(tLazExt_extIDEM_preSet_Node)
  public
    class function def_frmEdtr:tLazExt_extIDEM_preSet_frmEditTYPE; override;
    class function preSet_IDNT:string; override;
    class function preSet_Name:string; override;
    class function preSet_Desc:string; override;
  public
    procedure set_def_maCROs; override;
  end;

 tExtIDEM_preSet_SUB6_Edit=class(tLazExt_extIDEM_preSet_frmEdit)
  public
    function GetTitle:string; override;
  end;

implementation

{$R *.lfm}

procedure tExtIDEM_preSet_SUB6_node.set_def_maCROs;
begin
    Assert(false,'asdf');

    ADD('asd1', tLazExt_extIDEM_maCRO_TextSL_node);
    ADD('asd2', tLazExt_extIDEM_maCRO_TextSL_node);
    ADD('asd3', tLazExt_extIDEM_maCRO_TextSL_node);
end;

//------------------------------------------------------------------------------

class function tExtIDEM_preSet_SUB6_node.def_frmEdtr:tLazExt_extIDEM_preSet_frmEditTYPE;
begin
    result:=TextIDEM_preSet_SUB6_Edit;
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

class function tExtIDEM_preSet_SUB6_node.preSet_IDNT:string;
begin
    result:='Sub6';
end;

class function tExtIDEM_preSet_SUB6_node.preSet_Name:string;
begin
    result:='System Used block VI';
end;

class function tExtIDEM_preSet_SUB6_node.preSet_Desc:string;
begin
    result:='System Used block Version Info';
end;

//==============================================================================

function tExtIDEM_preSet_SUB6_Edit.GetTitle:string;
begin
    result:=tExtIDEM_preSet_SUB6_node.preSet_Name;
end;



end.

