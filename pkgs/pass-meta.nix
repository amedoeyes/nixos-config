{
  lib,
  stdenv,
  fetchFromGitHub,
}:
stdenv.mkDerivation {
  pname = "pass-meta";
  version = "unstable-2021-04-26";

  src = fetchFromGitHub {
    owner = "rjekker";
    repo = "pass-extension-meta";
    rev = "2942bff7bc088422e780a96e5b1139db8508f386";
    sha256 = "sha256-O/YatXOA4EiGnGkemmGd6pVCNVwrtDeLoDq9PRSlGY4=";
  };

  dontBuild = true;

  installPhase = ''
    mkdir -p $out/lib/password-store/extensions
    cp src/meta.bash $out/lib/password-store/extensions/
  '';

  meta = with lib; {
    description = "password-store extension to retrieve meta-data properties from password files";
    homepage = "https://github.com/rjekker/pass-extension-meta";
    license = licenses.gpl3;
    maintainers = [ maintainers.amedoeyes ];
  };
}
