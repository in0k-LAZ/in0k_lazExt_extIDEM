unit lazExt_extIDEM__USER_mcrPRM__TEXT;

{$mode objfpc}{$H+}

interface

uses extIDEM_coreObject,
     ExtIDEM_frm_sub_valTEXT,
     ExtIDEM_frm_sub_RESULT,
     ExtIDEM_frm_sub_UserPrmName,
     extIDEM_McrPRM_Text_CORE,
  Classes, SysUtils, FileUtil, Forms, Controls;

type

  { tExtIDEM__USER_mcrPRM__TEXT_frm }

  tExtIDEM__USER_mcrPRM__TEXT_frm = class(TlazExt_extIDEM_maCRO_Text_CORE_edit)
    ExtIDEM_sub_UserPrmName_frm1: TExtIDEM_sub_UserPrmName_frm;
  private
    { private declarations }
  public
    { public declarations }
  end;

  tExtIDEM__USER_mcrPRM__TEXT_itm=class(tLazExt_extIDEM_maCRO_Text_CORE_node)
   public
     class function ObjTEdit:tExtIDEM_core_objEditTYPE; override;
//     class function Obj_IDNT:string;                    override;
//     class function Obj_Name:string;                    override;
//     class function Obj_Desc:string;                    override;
   end;



implementation

{$R *.lfm}

class function tExtIDEM__USER_mcrPRM__TEXT_itm.ObjTEdit:tExtIDEM_core_objEditTYPE;
begin
    result:=tExtIDEM__USER_mcrPRM__TEXT_frm;
end;

end.

