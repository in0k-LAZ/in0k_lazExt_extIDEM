unit lazExt_extIDEM_frm_sub_valTEXT;

{$mode objfpc}{$H+}

interface

uses lazExt_extIDEM_frm_sub,
  Classes, SysUtils, FileUtil, Forms, Controls, StdCtrls, ExtCtrls, Buttons;

type

  { TextIDEM_sub_valTEXT_frm }

  TextIDEM_sub_valTEXT_frm = class(tExtIDEM_sub_frm)
    Edit1: TEdit;
    Label6: TLabel;
    SpeedButton1: TSpeedButton;
  protected
    function getFRM_caption:string; override;
  end;

implementation

const _cTXT_frmCaption_='Значение';

{$R *.lfm}

function TextIDEM_sub_valTEXT_frm.getFRM_caption:string;
begin
    result:=_cTXT_frmCaption_;
end;

end.

