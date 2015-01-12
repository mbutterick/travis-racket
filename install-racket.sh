# IMPORTANT: Your .travis.yml must pipe this to bash (not to sh)!
# In the Travis CI environment a #!/bin/bash shebang here won't help.

set -e

if [[ "$RACKET_VERSION" = "HEAD" ]]; then
    URL="http://plt.eecs.northwestern.edu/snapshots/current/installers/racket-test-current-x86_64-linux-precise.sh"
elif [[ "$RACKET_VERSION" = 5.9* ]]; then
    URL="http://download.racket-lang.org/installers/${RACKET_VERSION}/racket-${RACKET_VERSION}-x86_64-linux-ubuntu-quantal.sh"
elif [[ "$RACKET_VERSION" = 6.* ]]; then
    URL="http://download.racket-lang.org/installers/${RACKET_VERSION}/racket-${RACKET_VERSION}-x86_64-linux-ubuntu-precise.sh"
else
    URL="http://download.racket-lang.org/installers/${RACKET_VERSION}/racket/racket-${RACKET_VERSION}-bin-x86_64-linux-debian-squeeze.sh"
fi

# For backward compatability with older .travis.yml files that do not
# set the Racket install directory explicitly, and expect it to be
# /usr/racket.
if [[ "$RACKET" = "" ]]; then
    RACKET=/usr/racket
fi

INSTALL="./racket-${RACKET_VERSION}.sh"

echo "Downloading $URL to $INSTALL:"
curl -L -o $INSTALL $URL

echo "Running $INSTALL to install Racket:"
chmod u+rx "$INSTALL"
"$INSTALL" <<EOF
no
"$RACKET"

EOF

exit 0
