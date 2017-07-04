#ifndef CONTROLLAYER_H
#define CONTROLLAYER_H
#include <QObject>
#include <QTcpSocket>
#include <QJsonDocument>
#include <QJsonObject>
#include <QJsonArray>
#include <QDebug>
#include <QMap>
#include <QVariantMap>
#include <QDate>
#include <QFile>
#include <QDataStream>
#include "qjson/include/qjson-qt5/serializer.h"
#include "qjson/include/qjson-qt5/parser.h"
#include "qjson/include/qjson-qt5/qobjecthelper.h"
#include "controllayertoolcs.h"
class ControlLayer: public QObject
{
    Q_OBJECT
    Q_ENUMS(LoginState)

public:
    ControlLayer(QObject* parent = 0):QObject(parent){}



//控制层共用
public:
enum RequestType{
//登陆相关控制层
rt_login,//loginstate,workertype
//人事管理相关控制层
rt_listAllWorker,//employee_id,group_id,gender,name,telephone,address,email
rt_getSupplierList,//suppliername,phone,pic,id,addr,descrip
rt_getSupplierDetail,//suppliername,phone,pic,id,addr,descrip
rt_saveSupplier,//ok
rt_deleteSupplier,//ok
rt_addSupplier,//ok
//销售相关控制层
rt_getSaleStatistic,//年月，销售额
rt_getSaleCatagoryStatistic,//商品类别，库存
rt_getSaleRecords,//记录id，商品id，数量，销售额，时间
//库存相关控制层
rt_getRepertoryStatistic,//商品类别，库存量
//进货相关控制层
rt_getStockPlans,//purchase_id，product_id，plan_employee_id，purchase_employee_id，
//supplier_name，purchase_date，quantity，money_amount，is_finish，comment,product_name
rt_getSupplierNames,//SupplierId,SupplierNames
rt_savePlan,//ok
rt_addPlan,//ok
rt_deletePlan,//ok
rt_changePlanState,//ok

};
private:
RequestType requestype;
QTcpSocket *socket=new QTcpSocket(this);
QJson::Parser parser;
QJson::Serializer serializer;
void connectServer();
int theclassvarcount;
TheClassModel *theclassmodel=nullptr;
void loadByteArray2Model(QByteArray recdatabytearray);
int eachPageCount;
int pageNum;
QVariantList reqdatavarlist;
QString picpath="G:/qt/NeuMarket20170703/bug.png";

signals:
void loadModelFinished(TheClassModel* theclassmodel);
private slots:
void writeMesg();
void readMesg();
//登陆相关控制层
public:
enum LoginState {
    SUCCESS,
    USERNAME_WRONG,
    PASSWORD_WRONG,
    NO_CONNECTION,
    INVALID_INPUT
};
Q_INVOKABLE void login(int workernum, QString password);
void loginQml(QByteArray recdatabytearray);
private:
int workernum=-1;
QString password;
LoginState loginstate;
int workertype;
signals:
void loginFinish(const LoginState loginstate,const int workertype);
//人事管理相关控制层
public:
Q_INVOKABLE void listAllWorker();
Q_INVOKABLE void getSupplierList();
Q_INVOKABLE void getSupplierDetail(int id);
Q_INVOKABLE void saveSupplier(QVariantList);
Q_INVOKABLE void deleteSupplier(int id);
Q_INVOKABLE void addSupplier(QVariantList data);
private:


signals:
void listAllWorker(const QVariantList,const QVariantList);
void supplierList(TheClassModel *theclassmodel);
void supplierDetail(const QVariantList);
void supplierSaved(bool ok);
void supplierDeleted(bool ok);
void supplierAdded(bool ok);

//销售相关控制层
public:
    Q_INVOKABLE void getSaleStatistic();
    Q_INVOKABLE void getSaleCatagoryStatistic(QDate from, QDate end);
    Q_INVOKABLE void getSaleRecords(QDate from, QDate end);
private:
    QDate startYMD;
    QDate endYMD;
signals:
    void saleStatistic(const QVariantList month,const QVariantList amount);
    void saleCatagoryStatistic(const QVariantList cat,const QVariantList amount);
    void saleRecords(TheClassModel* theclassmodel);
//库存相关控制层
public:
Q_INVOKABLE void getRepertoryStatistic();
private:

signals:
void repertoryStatistic(const QVariantList cat,const QVariantList amount);


//进货相关控制层
public:
    Q_INVOKABLE void getStockPlans();
    Q_INVOKABLE void getSupplierNames();
    Q_INVOKABLE void savePlan(QVariantList);
    Q_INVOKABLE void addPlan(QVariantList);
    Q_INVOKABLE void deletePlan(int planId);
    Q_INVOKABLE void changePlanState(int planId, bool isFinish);
private:

signals:
    void stockPlans(TheClassModel *theclassmodel);
    void supplierNames(QVariantList ids,QVariantList names);
    void planSaved(bool ok);
    void planAdded(bool ok);
    void planDeleted(bool ok);
    void planStateChanged(bool ok);
};

#endif // CONTROLLAYER_H
                                                        #ifndef CONTROLLAYER_H
                                                        #define CONTROLLAYER_H
                                                        #include <QObject>
                                                        #include <QTcpSocket>
                                                        #include <QJsonDocument>
                                                        #include <QJsonObject>
                                                        #include <QJsonArray>
                                                        #include <QDebug>
                                                        #include <QMap>
                                                        #include <QVariantMap>
                                                        #include<QDate>
                                                        #include "qjson/include/qjson-qt5/serializer.h"
                                                        #include "qjson/include/qjson-qt5/parser.h"
                                                        #include "qjson/include/qjson-qt5/qobjecthelper.h"
                                                        #include "controllayertoolcs.h"
                                                        class ControlLayer: public QObject
                                                        {
                                                            Q_OBJECT
                                                            Q_ENUMS(LoginState)

                                                        public:
                                                            ControlLayer(QObject* parent = 0):QObject(parent){}



//控制层共用
public:
    enum RequestType{
        //登陆相关控制层
        rt_login,
        //人事管理相关控制层
        rt_listAllWorker,
        rt_getSupplierList,
        rt_getSupplierDetail,
        rt_saveSupplier,
        rt_deleteSupplier,
        rt_addSupplier,
        //销售相关控制层
        rt_getSaleStatistic,
        rt_getSaleCatagoryStatistic,
        rt_getSaleRecords,
        //库存相关控制层
        rt_getRepertoryStatistic,



    };
private:
    RequestType requestype;
    QTcpSocket *socket=new QTcpSocket(this);
    QJson::Parser parser;
    QJson::Serializer serializer;
    void connectServer();
    int theclassvarcount;
    TheClassModel *theclassmodel=nullptr;
    void loadByteArray2Model(QByteArray recdatabytearray);
    int eachPageCount;
    int pageNum;
    QVariantList reqdatavarlist;

signals:
    void loadModelFinished(TheClassModel* theclassmodel);
private slots:
void writeMesg();
void readMesg();
                                                    //登陆相关控制层
                                                    public:
                                                        enum LoginState {
                                                            SUCCESS,
                                                            USERNAME_WRONG,
                                                            PASSWORD_WRONG,
                                                            NO_CONNECTION,
                                                            INVALID_INPUT
                                                        };
                                                        Q_INVOKABLE void login(QString workernum, QString password);
                                                        void loginQml(QByteArray recdatabytearray);
                                                    private:
                                                        QString workernum;
                                                        QString password;
                                                        LoginState loginstate;
                                                        int workertype;
                                                    signals:
                                                        void loginFinish(const LoginState loginstate,const int workertype);
//人事管理相关控制层
public:
    Q_INVOKABLE void listAllWorker();
    Q_INVOKABLE void getSupplierList();
    Q_INVOKABLE void getSupplierDetail(int id);
    Q_INVOKABLE void saveSupplier(QVariantList);
    Q_INVOKABLE void deleteSupplier(int id);
    Q_INVOKABLE void addSupplier(QVariantList data);
private:


signals:
    void listAllWorker(const QVariantList,const QVariantList);
    void supplierList(TheClassModel *theclassmodel);
    void supplierDetail(const QVariantList);
    void supplierSaved(bool ok);
    void supplierDeleted(bool ok);
    void supplierAdded(bool ok);

                                                        //销售相关控制层
                                                        public:
                                                            Q_INVOKABLE void getSaleStatistic();
                                                            Q_INVOKABLE void getSaleCatagoryStatistic(QDate from, QDate end);
                                                            Q_INVOKABLE void getSaleRecords(QDate from, QDate end);
                                                        private:
                                                            QDate startYMD;
                                                            QDate endYMD;
                                                        signals:
                                                            void saleStatistic(const QVariantList month,const QVariantList amount);
                                                            void saleCatagoryStatistic(const QVariantList cat,const QVariantList amount);
                                                            void saleRecords(TheClassModel* theclassmodel);
//库存相关控制层
public:
Q_INVOKABLE void getRepertoryStatistic();
private:

signals:
void repertoryStatistic(const QVariantList cat,const QVariantList amount);


};

#endif // CONTROLLAYER_H
