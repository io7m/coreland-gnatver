package gnatver is

  type variant_t is
    (GNAT_UNKNOWN,
     GNAT_FSF,
     GNAT_GPL,
     GNAT_PRO,
     GNAT_GAP);

  type version_t is record
    variant : variant_t := GNAT_UNKNOWN;
    major   : natural   := 0;
    minor   : natural   := 0;
    patch   : natural   := 0;
  end record;

  procedure decode
    (version : out version_t;
     image   : in string);

  procedure decode_current
    (version : out version_t);

end gnatver;
