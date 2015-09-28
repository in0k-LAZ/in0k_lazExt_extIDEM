unit extIDEM_McrPRM_Intf;

{$mode objfpc}{$H+}

interface

uses extIDEM_coreObject, extIDEM_McrPRM_node;

type

 TExtIDEM_McrPRM_edit_custom = class(tExtIDEM_core_objEDIT)
  end;
                              //
 tExtIDEM_McrPRM_node_custom = class(tExtIDEM_McrPRM_node)
  end;

implementation

{$R *.lfm}

end.

