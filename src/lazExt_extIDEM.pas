unit lazExt_extIDEM;

{$mode objfpc}{$H+}

interface

uses lazExt_extIDEM_preSet_node,
  Classes, SysUtils;


type

 tLazExt_extIDEM=class(tLazExt_extIDEM_preSetsList_core)


  //

  end;


procedure lazExt_extIDEM_INIT;
function  extIDEM:tLazExt_extIDEM;

implementation

var _LazExt_extIDEM_:tLazExt_extIDEM;

procedure lazExt_extIDEM_INIT;
begin
    if not Assigned(_LazExt_extIDEM_) then begin
      _LazExt_extIDEM_:=tLazExt_extIDEM.Create;
    end;
end;

function extIDEM:tLazExt_extIDEM;
begin
    result:=_LazExt_extIDEM_;
end;


initialization
   _LazExt_extIDEM_:=nil;

finalization
   _LazExt_extIDEM_.FREE;

end.

