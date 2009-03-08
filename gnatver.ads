package gnatver is

  type variant_t is
    (GNAT_UNKNOWN,
     GNAT_FSF,
     GNAT_GPL,
     GNAT_PRO,
     GNAT_GAP);

  type version_t is record
    variant : variant_t := GNAT_UNKNOWN;
    major   : Natural   := 0;
    minor   : Natural   := 0;
    patch   : Natural   := 0;
  end record;

  procedure decode
    (version : out version_t;
     image   : in String);

  procedure decode_current
    (version : out version_t);

end gnatver;
