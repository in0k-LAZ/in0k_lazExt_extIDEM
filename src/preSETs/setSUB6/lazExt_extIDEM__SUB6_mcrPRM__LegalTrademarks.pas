unit lazExt_extIDEM__SUB6_mcrPRM__LegalTrademarks;

{$mode objfpc}{$H+}

interface

uses extIDEM_coreObject,
     extIDEM_frm_sub_valFILE,
     extIDEM_frm_sub_COMMENTs,
     extIDEM_frm_sub_RESULT,
     extIDEM_McrPRM_File_CORE,
  Classes, SysUtils, FileUtil, Forms, Controls, StdCtrls, ExtCtrls;

type

 TextIDEM_SUB6_mcrPRM__LegalTrademarks_frm = class(TlazExt_extIDEM_maCRO_File_CORE_edit)
  end;

 tExtIDEM_SUB6_mcrPRM__LegalTrademarks_itm=class(tLazExt_extIDEM_maCRO_File_CORE_node)
  public
    class function ObjTEdit:tExtIDEM_core_objEditTYPE; override;
    class function Obj_IDNT:string;                    override;
    class function Obj_Name:string;                    override;
    class function Obj_Desc:string;                    override;
  end;

implementation

const
  _cTXT_Obj_IDNT_='LegalTrademarks';
  _cTXT_Obj_Name_='Legal Trademarks';
  _cTXT_Obj_Desc_='Trademarks and registered trademarks that apply to the file. This should include the full text of all notices, legal symbols, trademark numbers, and so on. This string is optional.';

{$R *.lfm}

//==============================================================================

class function tExtIDEM_SUB6_mcrPRM__LegalTrademarks_itm.ObjTEdit:tExtIDEM_core_objEditTYPE;
begin
    result:=TextIDEM_SUB6_mcrPRM__LegalTrademarks_frm;
end;

class function tExtIDEM_SUB6_mcrPRM__LegalTrademarks_itm.Obj_IDNT:string;
begin
    result:=_cTXT_Obj_IDNT_;
end;

class function tExtIDEM_SUB6_mcrPRM__LegalTrademarks_itm.Obj_Name:string;
begin
    result:=_cTXT_Obj_Name_;
end;

class function tExtIDEM_SUB6_mcrPRM__LegalTrademarks_itm.Obj_Desc:string;
begin
    result:=_cTXT_Obj_Desc_;
end;

end.

