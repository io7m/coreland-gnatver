#!/bin/sh
# create standalone copy of GNATver

cat <<EOF
-- auto generated, do not edit
with GNAT.Compiler_Version;
with GNAT.Regpat;
with Ada.Text_IO;
with Ada.Strings.Fixed;
with Ada.Strings;
procedure Ver_GNAT is
  --
  -- gnatver.ads
  --
EOF

cat gnatver.ads | \
  sed 's/end GNATver;//g;' | sed 's/package GNATver is//g;' | grep -v '^ *$'

cat <<EOF
  --
  -- gnatver.adb
  --
EOF

./grep-range 'package body GNATver is' 'end GNATver;' gnatver.adb | \
  tail -n +2 | sed 's/end GNATver;//g' | grep -v '^ *$'

cat <<EOF
  -- ver_gnat.adb
  function To_String (Number : Integer) return String is
  begin
    return Ada.Strings.Fixed.Trim (Integer'Image (Number), Ada.Strings.Left);
  end To_String;
  Version : Version_t;
begin
  Decode_Current (Version);
  Ada.Text_IO.Put_Line
    (Variant_t'Image (Version.Variant) & " " &
     To_String (Version.Major) & "." &
     To_String (Version.Minor) & "." &
     To_String (Version.Patch));
end Ver_GNAT;
EOF
