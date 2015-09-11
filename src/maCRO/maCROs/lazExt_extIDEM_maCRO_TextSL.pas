unit lazExt_extIDEM_maCRO_TextSL;

{$mode objfpc}{$H+}

interface

uses lazExt_extIDEM_maCRO_node,lazExt_extIDEM_maCRO_edit,
  Classes, SysUtils, FileUtil, Forms, Controls, StdCtrls;

type

 { tLazExt_extIDEM_maCRO_TextSL_edit }

 tLazExt_extIDEM_maCRO_TextSL_edit=class(tLazExt_extIDEM_frmEdit)
    Memo1: TMemo;
  end;

 tLazExt_extIDEM_maCRO_TextSL_node=class(tLazExt_extIDEM_node)
  public
    class function defEditor    :tLazExt_extIDEM_frmEditTYPE; override;
    //class function NodeTYPE_Name:string; override;
    //class function NodeTYPE_Desc:string; override;
  end;


implementation

{$R *.lfm}

//==============================================================================

class function tLazExt_extIDEM_maCRO_TextSL_node.defEditor:tLazExt_extIDEM_frmEditTYPE;
begin
    result:=tLazExt_extIDEM_maCRO_TextSL_edit;
end;

{class function tLazExt_extIDEM_maCRO_TextSL_node.NodeTYPE_Name:string;
begin
    result:=tLazExt_extIDEM_maCRO_TextSL_edit;
end;

class function tLazExt_extIDEM_maCRO_TextSL_node.NodeTYPE_Desc:string;
begin
    result:=tLazExt_extIDEM_maCRO_TextSL_edit;
end;
}

end.

