#!/bin/sh
# create standalone copy of gnatver

cat <<EOF
-- auto generated, do not edit

with GNAT.Compiler_Version;
with GNAT.Regpat;
with Ada.Text_IO;
with Ada.Strings.Fixed;
with Ada.Strings;

procedure ver_GNAT is

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

  -- ver_GNAT.adb

  function to_string (num : integer) return string is
  begin
    return Ada.Strings.Fixed.Trim (integer'Image (num), Ada.Strings.Left);
  end to_string;

  version : version_t;
begin
  decode_current (version);
  Ada.Text_IO.Put_Line
    (variant_t'Image (version.variant) & " " &
     to_string (version.major) & "." &
     to_string (version.minor) & "." &
     to_string (version.patch));
end ver_GNAT;
EOF
