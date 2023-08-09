#!/bin/sh

TOPDIR=${TOPDIR:-$(git rev-parse --show-toplevel)}
SRCDIR=${SRCDIR:-$TOPDIR/src}
MANDIR=${MANDIR:-$TOPDIR/doc/man}

EUTOCOIND=${EUTOCOIND:-$SRCDIR/eutocoind}
EUTOCOINCLI=${EUTOCOINCLI:-$SRCDIR/eutocoin-cli}
EUTOCOINTX=${EUTOCOINTX:-$SRCDIR/eutocoin-tx}
EUTOCOINQT=${EUTOCOINQT:-$SRCDIR/qt/eutocoin-qt}

[ ! -x $EUTOCOIND ] && echo "$EUTOCOIND not found or not executable." && exit 1

# The autodetected version git tag can screw up manpage output a little bit
EUTOVER=($($EUTOCOINCLI --version | head -n1 | awk -F'[ -]' '{ print $6, $7 }'))

# Create a footer file with copyright content.
# This gets autodetected fine for eutocoind if --version-string is not set,
# but has different outcomes for eutocoin-qt and eutocoin-cli.
echo "[COPYRIGHT]" > footer.h2m
$EUTOCOIND --version | sed -n '1!p' >> footer.h2m

for cmd in $EUTOCOIND $EUTOCOINCLI $EUTOCOINTX $EUTOCOINQT; do
  cmdname="${cmd##*/}"
  help2man -N --version-string=${EUTOVER[0]} --include=footer.h2m -o ${MANDIR}/${cmdname}.1 ${cmd}
  sed -i "s/\\\-${EUTOVER[1]}//g" ${MANDIR}/${cmdname}.1
done

rm -f footer.h2m
