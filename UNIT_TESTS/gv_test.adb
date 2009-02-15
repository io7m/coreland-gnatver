with Ada.Text_IO;
with Ada.Command_Line;
with gnatver;

procedure gv_test is
  package IO renames Ada.Text_IO;
  version : gnatver.version_t;
begin
  gnatver.decode (version, Ada.Command_Line.Argument (1));
  IO.Put_Line (Ada.Command_Line.Argument (1));
  IO.Put_Line
    ("-- " & gnatver.variant_t'Image (version.variant) & " " &
     natural'Image (version.major) & " " &
     natural'Image (version.minor) & " " &
     natural'Image (version.patch));
end gv_test;
