{ stdenv, fetchFromGitHub, which, autoreconfHook, ncurses, perl
, openssl, lmdb }:

stdenv.mkDerivation rec {
  version = "20170428";
  name = "neomutt-${version}";

  src = fetchFromGitHub {
    owner  = "neomutt";
    repo   = "neomutt";
    rev    = "neomutt-${version}";
    sha256 = "1p6214agfv9plskkzalh03r5naiiyg1habrnknnjgck3nypb78ik";
  };

  nativeBuildInputs = [ which autoreconfHook ];
  buildInputs =
    [ ncurses openssl perl lmdb ];

  configureFlags = [
    "--enable-imap"
    "--enable-sidebar"
    "--enable-smtp"
    "--enable-compressed"
    "--with-homespool=mailbox"
    "--with-ssl"
    "--with-curses"
    "--with-lmdb"

    # Look in $PATH at runtime, instead of hardcoding /usr/bin/sendmail
    "ac_cv_path_SENDMAIL=sendmail"
  ];

  configureScript = "./prepare";

  meta = with stdenv.lib; {
    description = "A small but very powerful text-based mail client";
    homepage = http://www.neomutt.org;
    license = stdenv.lib.licenses.gpl2Plus;
    platforms = platforms.unix;
    maintainers = with maintainers; [ cstrahan vrthra erikryb ];
  };
}
