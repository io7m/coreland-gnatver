with Ada.Text_IO;
with Ada.Command_Line;
with GNATver;

procedure gv_test is
  package IO renames Ada.Text_IO;
  Version : GNATver.Version_t;
begin
  GNATver.Decode (Version, Ada.Command_Line.Argument (1));
  IO.Put_Line (Ada.Command_Line.Argument (1));
  IO.Put_Line
    ("-- " & GNATver.Variant_t'Image (Version.Variant) & " " &
     Natural'Image (Version.Major) & " " &
     Natural'Image (Version.Minor) & " " &
     Natural'Image (Version.Patch));
end gv_test;
