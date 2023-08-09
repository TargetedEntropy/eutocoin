// Copyright (c) 2011-2014 The Bitcoin Core developers
// Copyright (c) 2017-2019 The Raven Core developers
// Copyright (c) 2020-2021 The EutoCoin Core developers
// Distributed under the MIT software license, see the accompanying
// file COPYING or http://www.opensource.org/licenses/mit-license.php.

#ifndef EUTOCOIN_QT_EUTOCOINADDRESSVALIDATOR_H
#define EUTOCOIN_QT_EUTOCOINADDRESSVALIDATOR_H

#include <QValidator>

/** Base58 entry widget validator, checks for valid characters and
 * removes some whitespace.
 */
class EutoCoinAddressEntryValidator : public QValidator
{
    Q_OBJECT

public:
    explicit EutoCoinAddressEntryValidator(QObject *parent);

    State validate(QString &input, int &pos) const;
};

/** EutoCoin address widget validator, checks for a valid eutocoin address.
 */
class EutoCoinAddressCheckValidator : public QValidator
{
    Q_OBJECT

public:
    explicit EutoCoinAddressCheckValidator(QObject *parent);

    State validate(QString &input, int &pos) const;
};

#endif // EUTOCOIN_QT_EUTOCOINADDRESSVALIDATOR_H
