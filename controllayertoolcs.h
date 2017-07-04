#ifndef CONTROLLAYERTOOLCS_H
#define CONTROLLAYERTOOLCS_H
///////////////////////////定义此类便于宏定义识别//////////////////////////////////////
class controllayertoolcs
{
public:
    controllayertoolcs();
};
/////////////////////////////////TheClassModel///////////////////////////////////////////////////////
#include <QAbstractListModel>
#include <QString>
class TheClassModel : public QAbstractListModel
{
    Q_OBJECT
public:
    TheClassModel(QObject *parent = 0,int theclassvarcount=1);
    void addTheClass(const QVariantList &theclass);
    int rowCount(const QModelIndex & parent = QModelIndex()) const;
    QVariant data(const QModelIndex & index, int role = Qt::DisplayRole) const;


    Q_INVOKABLE int colCount() const;
    Q_INVOKABLE QVariant rowColData(int row, int col) const;
    Q_INVOKABLE QVariantList colDatas(int col) const;
    Q_INVOKABLE QVariantList rowDatas(int row) const;
    Q_INVOKABLE void setTheclassVarCount(int tvc);
protected:
   QHash<int, QByteArray> roleNames() const;
private:
   QList<QVariantList> m_theclasss;
   int theclassvarcount=0;
};
#endif // CONTROLLAYERTOOLCS_H
