#!/bin/bash
# Builds everything inside a pandoc/latex Docker image (used by the GitHub
# workflow). Run from the repository root, e.g.:
#   docker run --rm -v "$PWD:/work" -w /work --entrypoint bash \
#     pandoc/latex:latest-ubuntu .github/build-in-docker.sh
set -e

PKGS="koma-script qrcode footnotebackref needspace enumitem xkeyval"
YEAR=$(tlmgr --version | sed -n 's/.*version \([0-9]\{4\}\).*/\1/p')
# two mirrors of the frozen (historic) TeX Live repositories
HISTORIC="https://ftp.math.utah.edu/pub/tex/historic/systems/texlive/$YEAR/tlnet-final
https://ftp.tu-chemnitz.de/pub/tug/historic/systems/texlive/$YEAR/tlnet-final"

# The online TeX Live repository only serves the current TeX Live year. If the
# image is older (or a new year was just released), use the frozen repository
# of the image's year instead.
if ! { tlmgr update --self && tlmgr install $PKGS; }; then
  echo "::warning::Online TeX Live repository does not match TeX Live $YEAR in the image, using the frozen $YEAR repository."
  ok=
  for repo in $HISTORIC; do
    tlmgr option repository "$repo"
    if tlmgr update --self && tlmgr install $PKGS; then ok=1; break; fi
  done
  [ -n "$ok" ] || { echo "::error::Installing LaTeX packages failed."; exit 1; }
fi

apt-get update -qq
DEBIAN_FRONTEND=noninteractive apt-get install -y -qq --no-install-recommends make zip

rm -rf build
make all
