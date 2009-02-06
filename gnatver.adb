with gnat.compiler_version;
with gnat.regpat;

package body gnatver is
  package ver is new gnat.compiler_version;

  use type gnat.regpat.match_location;

  regex_FSF : constant string := "^GNAT Version: ([0-9]).([0-9]).([0-9])";
  regex_GPL : constant string := "^GNAT Version: GPL [0-9]+ \(([0-9]{4})([0-9]{2})([0-9]{2})\)";
  regex_GAP : constant string := "^GNAT Version: GAP [0-9]+ \(([0-9]{4})([0-9]{2})([0-9]{2})\)";
  regex_Pro : constant string := "^GNAT Version: Pro ([0-9]).([0-9]).([0-9])";

  procedure decode
    (version : out version_t;
     image   : in string) is
  begin
    -- check FSF
    declare
      matches : gnat.regpat.match_array (0 .. 3);
    begin
      gnat.regpat.match
        (expression => regex_FSF,
         data       => image,
         matches    => matches);
      if matches (0) /= gnat.regpat.no_match then
        version.variant := GNAT_FSF;
        version.major   := natural'value (image (matches (1).first ..  matches (1).last));
        version.minor   := natural'value (image (matches (2).first ..  matches (2).last));
        version.patch   := natural'value (image (matches (3).first ..  matches (3).last));
      end if;
    end;

    -- check GPL
    declare
      matches : gnat.regpat.match_array (0 .. 3);
    begin
      gnat.regpat.match
        (expression => regex_GPL,
         data       => image,
         matches    => matches);
      if matches (0) /= gnat.regpat.no_match then
        version.variant := GNAT_GPL;
        version.major   := natural'value (image (matches (1).first ..  matches (1).last));
        version.minor   := natural'value (image (matches (2).first ..  matches (2).last));
        version.patch   := natural'value (image (matches (3).first ..  matches (3).last));
      end if;
    end;

    -- check GAP
    declare
      matches : gnat.regpat.match_array (0 .. 3);
    begin
      gnat.regpat.match
        (expression => regex_GAP,
         data       => image,
         matches    => matches);
      if matches (0) /= gnat.regpat.no_match then
        version.variant := GNAT_GAP;
        version.major   := natural'value (image (matches (1).first ..  matches (1).last));
        version.minor   := natural'value (image (matches (2).first ..  matches (2).last));
        version.patch   := natural'value (image (matches (3).first ..  matches (3).last));
      end if;
    end;

    -- check Pro
    declare
      matches : gnat.regpat.match_array (0 .. 3);
    begin
      gnat.regpat.match
        (expression => regex_Pro,
         data       => image,
         matches    => matches);
      if matches (0) /= gnat.regpat.no_match then
        version.variant := GNAT_PRO;
        version.major   := natural'value (image (matches (1).first ..  matches (1).last));
        version.minor   := natural'value (image (matches (2).first ..  matches (2).last));
        version.patch   := natural'value (image (matches (3).first ..  matches (3).last));
      end if;
    end;
  end decode;

  procedure decode_current
    (version : out version_t) is
  begin
    decode
      (version => version,
       image   => ver.version);
  end decode_current;

end gnatver;
