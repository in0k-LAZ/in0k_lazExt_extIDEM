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
  public
    procedure Settings_Read (const node:tExtIDEM_core_objNODE);  override;
    procedure Settings_Write(const node:tExtIDEM_core_objNODE);  override;
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

procedure tExtIDEM__USER_mcrPRM__TEXT_frm.Settings_Read (const node:tExtIDEM_core_objNODE);
begin
    inherited;
end;

procedure tExtIDEM__USER_mcrPRM__TEXT_frm.Settings_Write(const node:tExtIDEM_core_objNODE);
begin
    inherited;
end;

//------------------------------------------------------------------------------


class function tExtIDEM__USER_mcrPRM__TEXT_itm.ObjTEdit:tExtIDEM_core_objEditTYPE;
begin
    result:=tExtIDEM__USER_mcrPRM__TEXT_frm;
end;

end.

