unit lazExt_extIDEM__SUB6_mcrPRM__Comments;

{$mode objfpc}{$H+}

interface

uses extIDEM_coreObject,
     lazExt_extIDEM_frm_sub_valFILE,
     lazExt_extIDEM_frm_sub_COMMENTs,
     lazExt_extIDEM_frm_sub_RESULT,
     lazExt_extIDEM_maCRO_File_CORE,
  Classes, SysUtils, FileUtil, Forms, Controls;

type

 tExtIDEM_SUB6_mcrPRM__Comments_frm = class(TlazExt_extIDEM_maCRO_File_CORE_edit)
  end;

 tExtIDEM_SUB6_mcrPRM__Comments_itm=class(tLazExt_extIDEM_maCRO_File_CORE_node)
  public
    class function ObjTEdit:tExtIDEM_core_objEditTYPE; override;
    class function Obj_IDNT:string;                    override;
    class function Obj_Name:string;                    override;
    class function Obj_Desc:string;                    override;
  end;

implementation

const
  _cTXT_Obj_IDNT_='Comments';
  _cTXT_Obj_Name_='Comments';
  _cTXT_Obj_Desc_='Additional information that should be displayed for diagnostic purposes.';

{$R *.lfm}

//==============================================================================

class function tExtIDEM_SUB6_mcrPRM__Comments_itm.ObjTEdit:tExtIDEM_core_objEditTYPE;
begin
    result:=tExtIDEM_SUB6_mcrPRM__Comments_frm;
end;

class function tExtIDEM_SUB6_mcrPRM__Comments_itm.Obj_IDNT:string;
begin
    result:=_cTXT_Obj_IDNT_;
end;

class function tExtIDEM_SUB6_mcrPRM__Comments_itm.Obj_Name:string;
begin
    result:=_cTXT_Obj_Name_;
end;

class function tExtIDEM_SUB6_mcrPRM__Comments_itm.Obj_Desc:string;
begin
    result:=_cTXT_Obj_Desc_;
end;

end.

