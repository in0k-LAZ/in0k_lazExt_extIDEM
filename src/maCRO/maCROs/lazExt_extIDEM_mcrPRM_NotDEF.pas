unit lazExt_extIDEM_mcrPRM_NotDEF;

{$mode objfpc}{$H+}

interface

uses
extIDEM_coreObject, lazExt_extIDEM_maCRO_node,


  StdCtrls;

type

 { TlazExt_extIDEM_maCRO_NDF_edit }

 TlazExt_extIDEM_maCRO_NDF_edit=class(tExtIDEM_core_objEDIT)
   Label1: TLabel;
   Label2: TLabel;
   Memo1: TMemo;
  end;

 tLazExt_extIDEM_maCRO_NDF_node=class(tLazExt_extIDEM_node)
  protected
    class function PUBLISED:boolean;                   override;
    class function ObjTEdit:tExtIDEM_core_objEditTYPE; override;
    class function Obj_IDNT:string;                    override;
    class function Obj_Name:string;                    override;
    class function Obj_Desc:string;                    override;
  end;


implementation

{$R *.lfm}

//==============================================================================

class function tLazExt_extIDEM_maCRO_NDF_node.PUBLISED:boolean;
begin
    result:=FALSE;
end;

class function tLazExt_extIDEM_maCRO_NDF_node.ObjTEdit:tExtIDEM_core_objEditTYPE;
begin
    result:=TlazExt_extIDEM_maCRO_NDF_edit;
end;

class function tLazExt_extIDEM_maCRO_NDF_node.Obj_IDNT:string;
begin
    result:='ndf';
end;

class function tLazExt_extIDEM_maCRO_NDF_node.Obj_Name:string;
begin
    result:='Not Define';
end;

class function tLazExt_extIDEM_maCRO_NDF_node.Obj_Desc:string;
begin
    result:='sdf asdf asdf asdf asdf ';
end;

end.

