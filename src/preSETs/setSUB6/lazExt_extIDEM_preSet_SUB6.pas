unit lazExt_extIDEM_preSet_SUB6;

{$mode objfpc}{$H+}

interface

uses lazExt_extIDEM_preSet_node,
     lazExt_extIDEM_preSet_edit,
  Classes, SysUtils, FileUtil, Forms, Controls;

type

 tExtIDEM_preSet_SUB6_node=class(tLazExt_extIDEM_preSet_Node)
  public
    class function defEditor:tLazExt_extIDEM_preSet_frmEditTYPE; override;
  end;

 TextIDEM_preSet_SUB6_Edit=class(tLazExt_extIDEM_preSet_frmEdit)
  private
    { private declarations }
  public
    { public declarations }
  end;

implementation

{$R *.lfm}

class function tExtIDEM_preSet_SUB6_node.defEditor:tLazExt_extIDEM_preSet_frmEditTYPE;
begin
    result:=TextIDEM_preSet_SUB6_Edit;
end;

end.

