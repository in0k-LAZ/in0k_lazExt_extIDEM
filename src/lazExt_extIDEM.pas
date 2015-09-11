unit lazExt_extIDEM;

{$mode objfpc}{$H+}

interface

uses IDEOptionsIntf,
    lazExt_extIDEM_preSet_node,
    lazExt_extIDEM_preSet_edit,
     Classes, SysUtils;


type

 tLazExt_extIDEM=class(tLazExt_extIDEM_preSetsList_core)
  private
    _ideGRP_Index_:integer;
    _ideEDT_Index_:integer;

  public
    function  preSet_FiND(const INDX:integer):tLazExt_extIDEM_preSet_Node;
    function PreSETs_ADD_Node(const Node:tLazExt_extIDEM_preSet_NodeTYPE):tLazExt_extIDEM_preSet_Node;


  end;


procedure lazExt_extIDEM_INIT(const GRP,EDT:integer);
function  extIDEM:tLazExt_extIDEM;

implementation

function tLazExt_extIDEM.preSet_FiND(const INDX:integer):tLazExt_extIDEM_preSet_Node;
begin
    result:=_nodes_FND_(INDX);
end;

function tLazExt_extIDEM.PreSETs_ADD_Node(const Node:tLazExt_extIDEM_preSet_NodeTYPE):tLazExt_extIDEM_preSet_Node;
var fIdeOI:integer;
begin
    result:=_nodes_ADD_(Node);
    if Assigned(result) then begin
        fIdeOI:=GetFreeIDEOptionsIndex(_ideGRP_Index_,_ideGRP_Index_);
        RegisterIDEOptionsEditor(_ideGRP_Index_, Node.defEditor, fIdeOI,_ideEDT_Index_);

    end;
end;

//==============================================================================

var _LazExt_extIDEM_:tLazExt_extIDEM;

procedure lazExt_extIDEM_INIT(const GRP,EDT:integer);
begin
    if not Assigned(_LazExt_extIDEM_) then begin
      _LazExt_extIDEM_:=tLazExt_extIDEM.Create;
      _LazExt_extIDEM_._ideGRP_Index_:=GRP;
      _LazExt_extIDEM_._ideEDT_Index_:=EDT;
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

