unit ExtIDEM_frm_sub_NotDEF;

{$mode objfpc}{$H+}

interface

uses  ExtIDEM_frm_sub,
  Classes, SysUtils, FileUtil, Forms, Controls, StdCtrls, ExtCtrls;

type

 { tExtIDEM_sub_NotDEF_frm }

 tExtIDEM_sub_NotDEF_frm = class(tExtIDEM_sub_frm)
    Memo1: TMemo;
  protected
    procedure _xmlNode_Text_SET_(const value:string);
    function  _xmlNode_Text_GET_:string;
  protected
    function getFRM_caption:string; override;
  public
    property xmlNode_Text:string read _xmlNode_Text_GET_ write _xmlNode_Text_SET_;
  end;

implementation

{$R *.lfm}

procedure tExtIDEM_sub_NotDEF_frm._xmlNode_Text_SET_(const value:string);
begin
    Memo1.Text:=value;
end;

function tExtIDEM_sub_NotDEF_frm._xmlNode_Text_GET_:string;
begin
    result:=Memo1.Text;
end;

function tExtIDEM_sub_NotDEF_frm.getFRM_caption:string;
begin
    result:='XML node value';
end;

end.

