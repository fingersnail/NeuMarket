#include "controllayertoolcs.h"
#include <QDebug>
/////////////////////////////////TheClassModel///////////////////////////////////////////////////////
TheClassModel::TheClassModel(QObject *parent,int tcvc)
    : QAbstractListModel(parent),theclassvarcount(tcvc)
{
}
void TheClassModel::addTheClass(const QVariantList &theclass)
{
    beginInsertRows(QModelIndex(), rowCount(), rowCount());
    m_theclasss << theclass;
    endInsertRows();
}

int TheClassModel::rowCount(const QModelIndex & parent) const {
    Q_UNUSED(parent);
    return m_theclasss.count();
}
QVariant TheClassModel::data(const QModelIndex & index, int role) const {

    if (index.row() < 0 || index.row() >= m_theclasss.count())
        return QVariant();
    const QVariantList &theclass = m_theclasss[index.row()];
    if(0<=role&&role<theclassvarcount){
        return theclass[role];
    }
    return QVariant();
}

QHash<int, QByteArray> TheClassModel::roleNames() const {
    QHash<int, QByteArray> roles;
    for(int i=0;i<theclassvarcount ;i++){
        roles[i] = QString("var%1").arg(i).toUtf8();
    }
    return roles;
}
int TheClassModel::colCount() const{
    return theclassvarcount;
}
QVariant TheClassModel::rowColData(int row, int col) const{
    if (row< 0 || row >= m_theclasss.count())
        return QVariant();
    if (col< 0 || col >=this->theclassvarcount)
        return QVariant();
    return m_theclasss[row][col];
}
QVariantList TheClassModel::colDatas(int col) const{
    if (col< 0 || col >=this->theclassvarcount)
        return QVariantList();
    QVariantList returndatas;
    for(int i=0;i<m_theclasss.count();i++){
        returndatas.append(m_theclasss[i][col]);
    }
    return returndatas;
}
QVariantList TheClassModel::rowDatas(int row) const{
    if (row< 0 || row >= m_theclasss.count())
        return QVariantList();
    return m_theclasss[row];
}
void TheClassModel::setTheclassVarCount(int tvc){
    this->theclassvarcount=tvc;
    m_theclasss.clear();
}
