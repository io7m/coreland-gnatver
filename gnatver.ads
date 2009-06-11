package Gnatver is

  type Variant_t is
    (GNAT_UNKNOWN,
     GNAT_FSF,
     GNAT_GPL,
     GNAT_PRO,
     GNAT_GAP);

  type Version_t is record
    Variant : Variant_t := GNAT_UNKNOWN;
    Major   : Natural   := 0;
    Minor   : Natural   := 0;
    Patch   : Natural   := 0;
  end record;

  procedure Decode
    (Version : out Version_t;
     Image   : in String);

  procedure Decode_Current
    (Version : out Version_t);

end Gnatver;
