#!/bin/sh
# create standalone copy of gnatver

cat <<EOF
-- auto generated, do not edit

with gnat.compiler_version;
with gnat.regpat;
with ada.text_io;
with ada.strings.fixed;
with ada.strings;

procedure ver_gnat is

  --
  -- gnatver.ads
  --
EOF

cat gnatver.ads | sed 's/end gnatver;//g;' | sed 's/package gnatver is//g;'

cat <<EOF
  --
  -- gnatver.adb
  --

EOF

./grep-range 'package body gnatver is' 'end gnatver;' gnatver.adb | \
  tail -n +2 | sed 's/end gnatver;//g'

cat <<EOF

  -- ver_gnat.adb

  function to_string (num : integer) return string is
  begin
    return ada.strings.fixed.trim (integer'image (num), ada.strings.left);
  end to_string;

  version : version_t;
begin
  decode_current (version);
  ada.text_io.put_line
    (variant_t'image (version.variant) & " " &
     to_string (version.major) & "." &
     to_string (version.minor) & "." &
     to_string (version.patch));
end ver_gnat;
EOF
