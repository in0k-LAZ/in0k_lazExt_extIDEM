unit lazExt_extIDEM__USER_mcrPRM__FILE;

{$mode objfpc}{$H+}

interface

uses extIDEM_coreObject,
     ExtIDEM_frm_sub_valFILE,
     ExtIDEM_frm_sub_COMMENTs,
     ExtIDEM_frm_sub_RESULT,
     ExtIDEM_frm_sub_UserPrmName,
     //ExtIDEM_frm_sub_valFILE,

     extIDEM_McrPRM_FILE_CORE,
  Classes, SysUtils, FileUtil, Forms, Controls;

type

  { TExtIDEM__USER_mcrPRM__FILE_frm }

  TExtIDEM__USER_mcrPRM__FILE_frm = class(TlazExt_extIDEM_maCRO_File_CORE_edit)
    sub_UserPrmName: TExtIDEM_sub_UserPrmName_frm;
  private
    { private declarations }
  public
    { public declarations }
  end;

  tExtIDEM__USER_mcrPRM__FILE_itm=class(tLazExt_extIDEM_maCRO_File_CORE_node)
   public
     class function ObjTEdit:tExtIDEM_core_objEditTYPE; override;
//     class function Obj_IDNT:string;                    override;
//     class function Obj_Name:string;                    override;
//     class function Obj_Desc:string;                    override;
   end;



implementation

{$R *.lfm}


class function tExtIDEM__USER_mcrPRM__FILE_itm.ObjTEdit:tExtIDEM_core_objEditTYPE;
begin
    result:=TExtIDEM__USER_mcrPRM__FILE_frm;
end;


end.

