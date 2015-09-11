unit lazExt_extIDEM_preSet_NDF;

{$mode objfpc}{$H+}

interface

uses lazExt_extIDEM_preSet_node,
     lazExt_extIDEM_preSet_edit,
  Classes, SysUtils, FileUtil, Forms, Controls;

type


 TextIDEM_preSet_NDF_Edit=class(tLazExt_extIDEM_preSet_frmEdit)
  public
    function GetTitle:string; override;
  end;

 tExtIDEM_preSet_NDF_node=class(tLazExt_extIDEM_preSet_Node)
  public
    class function def_frmEdtr:tLazExt_extIDEM_preSet_frmEditTYPE; override;
    class function preSet_IDNT:string; override;
    class function preSet_Name:string; override;
    class function preSet_Desc:string; override;
  end;



implementation

{$R *.lfm}

function TextIDEM_preSet_NDF_Edit.GetTitle:string;
begin
    result:=tExtIDEM_preSet_NDF_node.preSet_Name;
end;

//==============================================================================

class function tExtIDEM_preSet_NDF_node.def_frmEdtr:tLazExt_extIDEM_preSet_frmEditTYPE;
begin
    result:=TextIDEM_preSet_NDF_Edit;
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

class function tExtIDEM_preSet_NDF_node.preSet_IDNT:string;
begin
    result:='extIDEM_NDF';
end;

class function tExtIDEM_preSet_NDF_node.preSet_Name:string;
begin
    result:='NOT define';
end;

class function tExtIDEM_preSet_NDF_node.preSet_Desc:string;
begin
    result:='NOT found or NOT define preSet.';
end;


end.

