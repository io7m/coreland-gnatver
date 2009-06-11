with Ada.Text_IO;
with Ada.Command_Line;
with Gnatver;

procedure gv_test is
  package IO renames Ada.Text_IO;
  Version : Gnatver.Version_t;
begin
  Gnatver.Decode (Version, Ada.Command_Line.Argument (1));
  IO.Put_Line (Ada.Command_Line.Argument (1));
  IO.Put_Line
    ("-- " & Gnatver.Variant_t'Image (Version.Variant) & " " &
     Natural'Image (Version.Major) & " " &
     Natural'Image (Version.Minor) & " " &
     Natural'Image (Version.Patch));
end gv_test;
