unit lazExt_extIDEM_preSet_NDF;

{$mode objfpc}{$H+}

interface

uses lazExt_extIDEM_preSet_node,
     lazExt_extIDEM_preSet_edit,
  Classes, SysUtils, FileUtil, Forms, Controls;

type

 tExtIDEM_preSet_NDF_node=class(tLazExt_extIDEM_preSet_Node)
  public
    class function defEditor:tLazExt_extIDEM_preSet_frmEditTYPE; override;
  end;

 TextIDEM_preSet_NDF_Edit=class(tLazExt_extIDEM_preSet_frmEdit)
  public
    function GetTitle:string; override;
  end;

implementation

{$R *.lfm}

class function tExtIDEM_preSet_NDF_node.defEditor:tLazExt_extIDEM_preSet_frmEditTYPE;
begin
    result:=TextIDEM_preSet_NDF_Edit;
end;


//==============================================================================

function TextIDEM_preSet_NDF_Edit.GetTitle:string;
begin
    result:='preSet_NDF';
end;

end.

