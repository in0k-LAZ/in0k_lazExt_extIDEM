unit ExtIDEM_frm_sub_UserPrmName;

{$mode objfpc}{$H+}

interface

uses extIDEM_frm_sub,
  Classes, SysUtils, FileUtil, Forms, Controls, StdCtrls, ExtCtrls, Buttons;

type

 { tExtIDEM_sub_UserPrmName_frm }

 tExtIDEM_sub_UserPrmName_frm = class(tExtIDEM_sub_frm)
    Edit1: TEdit;
    Edit2: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    SpeedButton1: TSpeedButton;
  private
    { private declarations }
  public
    { public declarations }
  end;

implementation

{$R *.lfm}

end.

