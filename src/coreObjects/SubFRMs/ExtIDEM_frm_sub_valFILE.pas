unit ExtIDEM_frm_sub_valFILE;

{$mode objfpc}{$H+}

interface

uses extIDEM_frm_sub, StringsPropEditDlg,
  Classes, SysUtils, FileUtil, Forms, Controls, StdCtrls, ExtCtrls, Buttons;

type

  { TextIDEM_sub_valFILE_frm }

  TextIDEM_sub_valFILE_frm=class(tExtIDEM_sub_frm)
    edt_fileName: TEdit;
    edt_altText: TEdit;
    lbl_file: TLabel;
    rdb_Halt: TRadioButton;
    rdb_Alt: TRadioButton;
    spb_fileDialog: TSpeedButton;
    spb_textDialog: TSpeedButton;
    procedure spb_textDialogClick(Sender: TObject);
  protected
    procedure _fileName_set_(const value:string);
    function  _fileName_get_:string;
    procedure _Alt_Text_set_(const value:string);
    function  _Alt_Text_get_:string;
    procedure _Alt_Used_set_(const value:boolean);
    function  _Alt_Used_get_:boolean;
  protected
    function getFRM_caption:string; override;
  public
    property FileName:string  read _fileName_get_ write _fileName_set_;
    property Alt_Used:boolean read _Alt_Used_get_ write _Alt_Used_set_;
    property Alt_Text:string  read _Alt_Text_get_ write _Alt_Text_set_;
  public
    constructor Create(AOwner:TComponent); override;
  end;

implementation

const _cTXT_frmCaption_='Значение';

{$R *.lfm}

constructor TextIDEM_sub_valFILE_frm.Create(AOwner:TComponent);
begin
    inherited;
    rdb_Halt.Enabled:=false; //< пока так,
    rdb_Alt .Checked:=TRUE;
end;

//------------------------------------------------------------------------------

procedure TextIDEM_sub_valFILE_frm._fileName_set_(const value:string);
begin
    edt_fileName.Text:=value;
end;

function TextIDEM_sub_valFILE_frm._fileName_get_:string;
begin
    result:=edt_fileName.Text;
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

procedure TextIDEM_sub_valFILE_frm._Alt_Text_set_(const value:string);
begin
    edt_altText.Text:=value;
end;

function TextIDEM_sub_valFILE_frm._Alt_Text_get_:string;
begin
    result:=edt_altText.Text;
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

procedure TextIDEM_sub_valFILE_frm._Alt_Used_set_(const value:boolean);
begin
    if value then rdb_Alt.Checked:=TRUE
             else rdb_Halt.Checked:=TRUE;
end;

function TextIDEM_sub_valFILE_frm._Alt_Used_get_:boolean;
begin
    result:=rdb_Alt.Checked;
end;

//------------------------------------------------------------------------------

procedure TextIDEM_sub_valFILE_frm.spb_textDialogClick(Sender: TObject);
begin
    with TStringsPropEditorFrm.Create(Application) do begin
        Memo.Text:=edt_altText.Text;
        if mrOK=ShowModal then begin
            edt_altText.Text:=Memo.Text;
        end;
        FREE;
    end;
end;

function TextIDEM_sub_valFILE_frm.getFRM_caption:string;
begin
    result:=_cTXT_frmCaption_;
end;

end.

