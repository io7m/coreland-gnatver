with GNAT.Compiler_Version;
with GNAT.Regpat;

package body GNATver is
  package Ver is new GNAT.Compiler_Version;

  use type GNAT.Regpat.Match_Location;

  Regex_FSF : constant String := "^(GNAT Version: ){0,1}([0-9]).([0-9]).([0-9])";
  Regex_GPL : constant String := "^(GNAT Version: ){0,1}GPL [0-9]+ \(([0-9]{4})([0-9]{2})([0-9]{2})\)";
  Regex_GAP : constant String := "^(GNAT Version: ){0,1}GAP [0-9]+ \(([0-9]{4})([0-9]{2})([0-9]{2})\)";
  Regex_Pro : constant String := "^(GNAT Version: ){0,1}Pro ([0-9]).([0-9]).([0-9])";

  procedure Decode
    (Version : out Version_t;
     Image   : in String)
  is
    Matches : GNAT.Regpat.Match_Array (0 .. 4);
  begin
    -- check FSF
    GNAT.Regpat.Match
      (Expression => Regex_FSF,
       Data       => Image,
       Matches    => Matches);
    if Matches (0) /= GNAT.Regpat.No_Match then
      Version.Variant := GNAT_FSF;
      Version.Major   := Natural'Value (Image (Matches (2).First ..  Matches (2).Last));
      Version.Minor   := Natural'Value (Image (Matches (3).First ..  Matches (3).Last));
      Version.Patch   := Natural'Value (Image (Matches (4).First ..  Matches (4).Last));
    end if;

    -- check GPL
    GNAT.Regpat.Match
      (Expression => Regex_GPL,
       Data       => Image,
       Matches    => Matches);
    if Matches (0) /= GNAT.Regpat.No_Match then
      Version.Variant := GNAT_GPL;
      Version.Major   := Natural'Value (Image (Matches (2).First ..  Matches (2).Last));
      Version.Minor   := Natural'Value (Image (Matches (3).First ..  Matches (3).Last));
      Version.Patch   := Natural'Value (Image (Matches (4).First ..  Matches (4).Last));
    end if;

    -- check GAP
    GNAT.Regpat.Match
      (Expression => Regex_GAP,
       Data       => Image,
       Matches    => Matches);
    if Matches (0) /= GNAT.Regpat.No_Match then
      Version.Variant := GNAT_GAP;
      Version.Major   := Natural'Value (Image (Matches (2).First ..  Matches (2).Last));
      Version.Minor   := Natural'Value (Image (Matches (3).First ..  Matches (3).Last));
      Version.Patch   := Natural'Value (Image (Matches (4).First ..  Matches (4).Last));
    end if;

    -- check Pro
    GNAT.Regpat.Match
      (Expression => Regex_Pro,
       Data       => Image,
       Matches    => Matches);
    if Matches (0) /= GNAT.Regpat.No_Match then
      Version.Variant := GNAT_PRO;
      Version.Major   := Natural'Value (Image (Matches (2).First ..  Matches (2).Last));
      Version.Minor   := Natural'Value (Image (Matches (3).First ..  Matches (3).Last));
      Version.Patch   := Natural'Value (Image (Matches (4).First ..  Matches (4).Last));
    end if;
  end Decode;

  procedure Decode_Current
    (Version : out Version_t) is
  begin
    Decode
      (Version => Version,
       Image   => Ver.Version);
  end Decode_Current;

end GNATver;
