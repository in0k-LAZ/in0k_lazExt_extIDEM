unit lazExt_extIDEM_frm_sub_RESULT;

{$mode objfpc}{$H+}

interface

uses  lazExt_extIDEM_frm_sub,
  Classes, SysUtils, FileUtil, Forms, Controls, StdCtrls, ExtCtrls;

type

  { TextIDEM_sub_RESULT_frm }

  TextIDEM_sub_RESULT_frm = class(tExtIDEM_sub_frm)
    cmb_forIDE: TComboBox;
    cmb_forSRC: TComboBox;
    lbl_forIDE: TLabel;
    lbl_forSRC: TLabel;
    Shape1: TShape;
  protected
    function getFRM_caption:string; override;
  public
    procedure forIde_Enable(const value:boolean);
    procedure forSrc_Enable(const value:boolean);
  public
    constructor Create(AOwner:TComponent); override;
  end;

implementation

const _cTXT_frmCaption_='Результат';

{$R *.lfm}

function TextIDEM_sub_RESULT_frm.getFRM_caption:string;
begin
    result:=_cTXT_frmCaption_;
end;

constructor TextIDEM_sub_RESULT_frm.Create(AOwner:TComponent);
begin
    inherited;
    cmb_forIde.Clear;
    cmb_forSRC.Clear;
    forIde_Enable(false);
    forSrc_Enable(false);
end;

//------------------------------------------------------------------------------

procedure TextIDEM_sub_RESULT_frm.forIde_Enable(const value:boolean);
begin
    cmb_forIDE.Enabled:=value;
    lbl_forIDE.Enabled:=value;
end;

procedure TextIDEM_sub_RESULT_frm.forSrc_Enable(const value:boolean);
begin
    cmb_forSrc.Enabled:=value;
    lbl_forSrc.Enabled:=value;
end;

end.

