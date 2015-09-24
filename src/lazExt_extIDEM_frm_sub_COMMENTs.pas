unit lazExt_extIDEM_frm_sub_COMMENTs;

{$mode objfpc}{$H+}

interface

uses lazExt_extIDEM_frm_sub,
  Classes, SysUtils, FileUtil, Forms, Controls, StdCtrls, ExtCtrls;

type

  { TextIDEM_sub_COMMENTs_frm }

  TextIDEM_sub_COMMENTs_frm = class(tExtIDEM_sub_frm)
    CheckBox1: TCheckBox;
    Edit2: TEdit;
  protected
    function getFRM_caption:string; override;
  end;

implementation

const _cTXT_frmCaption_='Комментарии';

{$R *.lfm}

function TextIDEM_sub_COMMENTs_frm.getFRM_caption:string;
begin
    result:=_cTXT_frmCaption_;
end;


end.

