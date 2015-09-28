unit lazExt_extIDEM_frm_sub_COMMENTs;

{$mode objfpc}{$H+}

interface

uses lazExt_extIDEM_frm_sub,
  Classes, SysUtils, FileUtil, Forms, Controls, StdCtrls, ExtCtrls;

type

  { TextIDEM_sub_COMMENTs_frm }

  TextIDEM_sub_COMMENTs_frm = class(tExtIDEM_sub_frm)
    chb_Enabled: TCheckBox;
    edt_CmntSMB: TEdit;
    procedure chb_EnabledChange(Sender: TObject);

  protected
    procedure _CmntSMB_set_(const value:string);
    function  _CmntSMB_get_:string;
    procedure _CmntUSE_set_(const value:boolean);
    function  _CmntUSE_get_:boolean;
  protected
    function getFRM_caption:string; override;
  public
    constructor Create(AOwner:TComponent); override;
  public
    property CmntUsed:boolean read _CmntUSE_get_ write _CmntUSE_set_;
    property CmntSMBs:string  read _CmntSMB_get_ write _CmntSMB_set_;
  end;

implementation

const _cTXT_frmCaption_='Комментарии';

{$R *.lfm}

constructor TextIDEM_sub_COMMENTs_frm.Create(AOwner:TComponent);
begin
    inherited;
    chb_Enabled.Checked:=false;
    chb_EnabledChange(chb_Enabled);
end;

//------------------------------------------------------------------------------

procedure TextIDEM_sub_COMMENTs_frm._CmntSMB_set_(const value:string);
begin
    edt_CmntSMB.Text:=value;
end;

function TextIDEM_sub_COMMENTs_frm._CmntSMB_get_:string;
begin
    result:=edt_CmntSMB.Text;
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

procedure TextIDEM_sub_COMMENTs_frm._CmntUSE_set_(const value:boolean);
begin
    chb_Enabled.Checked:=value;
end;

function TextIDEM_sub_COMMENTs_frm._CmntUSE_get_:boolean;
begin
    result:=chb_Enabled.Checked;
end;

//------------------------------------------------------------------------------

procedure TextIDEM_sub_COMMENTs_frm.chb_EnabledChange(Sender: TObject);
begin
    edt_CmntSMB.Enabled:=TCheckBox(sender).Checked;
end;

function TextIDEM_sub_COMMENTs_frm.getFRM_caption:string;
begin
    result:=_cTXT_frmCaption_;
end;

end.

