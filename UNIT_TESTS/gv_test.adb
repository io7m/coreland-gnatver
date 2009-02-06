with ada.text_io;
with ada.command_line;
with gnatver;

procedure gv_test is
  package io renames ada.text_io;
  version : gnatver.version_t;
begin
  gnatver.decode (version, ada.command_line.argument (1));
  io.put_line (ada.command_line.argument (1));
  io.put_line
    (gnatver.variant_t'image (version.variant) & " " &
     natural'image (version.major) & " " &
     natural'image (version.minor) & " " &
     natural'image (version.patch));
end gv_test;
