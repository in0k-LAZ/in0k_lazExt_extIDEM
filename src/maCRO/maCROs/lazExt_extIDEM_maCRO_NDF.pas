unit lazExt_extIDEM_maCRO_NDF;

{$mode objfpc}{$H+}

interface

uses
lazExt_extIDEM_maCRO_Text,

lazExt_extIDEM_maCRO_node,lazExt_extIDEM_maCRO_edit,
  Classes, SysUtils, FileUtil, Forms, Controls, StdCtrls;

type

 { TlazExt_extIDEM_maCRO_NDF_edit }

 TlazExt_extIDEM_maCRO_NDF_edit=class(TlazExt_extIDEM_maCRO_Text_edit)
  end;

 tLazExt_extIDEM_maCRO_NDF_node=class(tLazExt_extIDEM_maCRO_Text_node)
  public
    class function defEditor    :tLazExt_extIDEM_frmEditTYPE; override;
    //class function NodeTYPE_Name:string; override;
    //class function NodeTYPE_Desc:string; override;
  end;


implementation

{$R *.lfm}

//==============================================================================

class function tLazExt_extIDEM_maCRO_NDF_node.defEditor:tLazExt_extIDEM_frmEditTYPE;
begin
    result:=TlazExt_extIDEM_maCRO_NDF_edit;
end;

end.

