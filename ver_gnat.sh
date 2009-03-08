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

cat gnatver.ads | \
  sed 's/end gnatver;//g;' | sed 's/package gnatver is//g;' | grep -v '^ *$'

cat <<EOF
  --
  -- gnatver.adb
  --
EOF

./grep-range 'package body gnatver is' 'end gnatver;' gnatver.adb | \
  tail -n +2 | sed 's/end gnatver;//g' | grep -v '^ *$'

cat <<EOF
  -- ver_GNAT.adb
  function To_String (num : Integer) return String is
  begin
    return Ada.Strings.Fixed.Trim (Integer'Image (num), Ada.Strings.Left);
  end To_String;
  version : version_t;
begin
  decode_current (version);
  Ada.Text_IO.Put_Line
    (variant_t'Image (version.variant) & " " &
     To_String (version.major) & "." &
     To_String (version.minor) & "." &
     To_String (version.patch));
end ver_GNAT;
EOF
