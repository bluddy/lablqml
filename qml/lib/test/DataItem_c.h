/*
 * Generated at 2013-03-30 14:13:59.894599
 */
#ifndef DataItem_c_H
#define DataItem_c_H
#include "kamlo.h"
#include <QtCore/QDebug>
#include <QtCore/QObject>

class DataItem: public QObject {
  Q_OBJECT
public:
  DataItem();
  Q_INVOKABLE QString name();
  Q_INVOKABLE QString sort();
};
#endif // DataItem_H
