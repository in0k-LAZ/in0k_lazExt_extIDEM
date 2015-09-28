unit wndMain;

{$mode objfpc}{$H+}

interface

uses wndTestCORE,
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  TmainWnd = class(TForm)
    Button1: TButton;
    ListBox1: TListBox;
    procedure Button1Click(Sender: TObject);
  public
    constructor Create(TheOwner: TComponent); override;
  public
    procedure ListTest_add_Frame(const tFRM:TCustomFrameClass; NameItem:string='');
  end;

var
  mainWnd: TmainWnd;

implementation
uses SetUpListTests;

{$R *.lfm}

procedure TmainWnd.ListTest_add_Frame(const tFRM:TCustomFrameClass; NameItem:string='');
var tmpName:string;
begin
    if assigned(tFRM) then begin
        if NameItem='' then NameItem:=tFRM.ClassName;
        ListBox1.AddItem(NameItem,tObject(tFRM));
    end;
end;

constructor TmainWnd.Create(TheOwner:TComponent);
begin
    inherited;
    ListBox1.Clear;
    SetUpListTest_DO;
end;

procedure TmainWnd.Button1Click(Sender: TObject);
var tmp:TCustomFrameClass;
begin

    tmp:=TCustomFrameClass(ListBox1.Items.Objects[ListBox1.ItemIndex]);
    if Assigned(tmp) then begin
        if true{(tmp is TCustomFrameClass)} then begin
            with TTestCOREwnd.Create(Application,TCustomFrameClass(tmp)) do begin
                Show;
            end;
        end;
    end;
end;

end.

