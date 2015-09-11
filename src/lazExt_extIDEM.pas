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


procedure lazExt_extIDEM_CRT;
procedure lazExt_extIDEM_INT(const GRP,EDT:integer);
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
       _node_setID_(result,fIdeOI);
        RegisterIDEOptionsEditor(_ideGRP_Index_, Node.def_frmEdtr, fIdeOI,_ideEDT_Index_);
        result.set_def_maCROs;
    end;
end;

//==============================================================================

var _LazExt_extIDEM_:tLazExt_extIDEM;


procedure lazExt_extIDEM_CRT;
begin
    if not Assigned(_LazExt_extIDEM_) then begin
       _LazExt_extIDEM_:=tLazExt_extIDEM.Create;
    end;
end;

procedure lazExt_extIDEM_INT(const GRP,EDT:integer);
begin
    if not Assigned(_LazExt_extIDEM_) then lazExt_extIDEM_CRT;
   _LazExt_extIDEM_._ideGRP_Index_:=GRP;
   _LazExt_extIDEM_._ideEDT_Index_:=EDT;
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

