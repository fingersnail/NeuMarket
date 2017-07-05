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
rt_login,//0
//requesttype,workernum,password
//loginstate,workertype
//人事管理相关控制层
rt_listAllWorker,//1
//requesttype
//id(int),name,tel(string),address,isPosition(bool),email,sex(bool)
rt_getSupplierList,//2
//requesttype
//suppliername,phone,pic,id,addr,descrip
rt_getSupplierDetail,//3
//requesttype,Supplierid
//suppliername,phone,pic,id,addr,descrip
rt_getWorkerDetail,//4
//requesttype,Workerid
//name,telephone,gender,employee_id,address,email,group_id
rt_saveWorker,//5
//requesttype,id,athority=-1,sex,name,tel,address,email,isPosition
//ok
rt_deleteWorker,//6
//requesttype,Workerid
//ok
rt_addWorker,//7
//requesttype,sex,name,tel,address,email,isPosition
//ok
rt_saveSupplier,//8
//requesttype,id,suppliername,addr,phone,descrip,pic
//ok
rt_deleteSupplier,//9
//requesttype,Supplierid
//ok
rt_addSupplier,//10
//requesttype,suppliername,addr,phone,descrip,pic
//ok
rt_changePositionState,//11
//requesttype,userId,isPosition
//ok
//销售相关控制层
rt_getSaleStatistic,//12
//requesttype
//年月，销售额
rt_getSaleCatagoryStatistic,//13
//requesttype,startYMD,endYMD
//商品类别，库存
rt_getSaleRecords,//14
//requesttype,startYMD,endYMD
//记录id，商品id，数量，销售额，时间
rt_getSaleRecords2,//15
//requesttype,product_id,startYMD,endYMD
//product_id,product_name,price,num,sale_time(string)
rt_getAllRecords,//16
//requesttype
//product_id product_name price num sale_time(string)
rt_addSaleRecord,//17
//requesttype,product_id,num,price
//ok
rt_getProductName,//18
//requesttype,product_id
//Qstring
//库存相关控制层
rt_getRepertoryStatistic,//19
//requesttype
//商品类别，库存量
rt_getAllProducts,//20
//requesttype
//id(int), name, catagory(string), num ,price ,info ,image(string)
rt_saveProduct,//21
//requesttype,id(int),name,catagory(string),num,price,info,image(string)
//ok
rt_deleteProduct,//22
//requesttype,id
//ok
rt_addProduct,//23
//name catagory(string) num price info image(string)
//ok
//进货相关控制层
rt_getStockPlans,//24
//requesttype
//purchase_id，product_id，plan_employee_id，purchase_employee_id,supplier_name，purchase_date，quantity，money_amount，is_finish，comment,product_name
rt_getSupplierNames,//25
//requesttype
//SupplierId,SupplierNames
rt_savePlan,//26
//requesttype,purchase_id，product_id，supplier_id，purchase_date,quantity，money_amount，comment
//ok
rt_addPlan,//27
//requesttype,product_id，supplier_id，purchase_date,quantity，money_amount，is_finish，comment
//ok
rt_deletePlan,//28
//requesttype,planId
//ok
rt_changePlanState,//29
//requesttype,planId,isfinished
//ok
//系统管理相关控制层
rt_getStuffMainInfo,//30
//requesttype
//id(int) name password(string)
rt_saveStuffMainInfo, //31
//requesttype,id(int) name password(string)
//ok
rt_getAllUsers,//32
//requesttype
//id(int) name tel(string) address authority(int) email sex(bool)
rt_saveUser,//33
//requesttype,id,athority,sex,name,tel,address,email
//ok
rt_addUser,//34
//requesttype,athority,sex,name,tel,address,email
//ok
rt_deleteUser,//35
//requesttype,user_id
//ok

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
Q_INVOKABLE void getWorkerDetail(int id);
Q_INVOKABLE void saveWorker(QVariantList);
Q_INVOKABLE void deleteWorker(int id);
Q_INVOKABLE void addWorker(QVariantList data);
Q_INVOKABLE void saveSupplier(QVariantList);
Q_INVOKABLE void deleteSupplier(int id);
Q_INVOKABLE void addSupplier(QVariantList data);
Q_INVOKABLE void changePositionState(int userId, bool isPosition);
private:


signals:
void allWorkers(TheClassModel *theclassmodel);
void workerDetail(const QVariantList);
void workerSaved(bool ok);
void workerDeleted(bool ok);
void workerAdded(bool ok);
void supplierList(TheClassModel *theclassmodel);
void supplierDetail(const QVariantList);
void supplierSaved(bool ok);
void supplierDeleted(bool ok);
void supplierAdded(bool ok);
void positionChanged(bool ok);

//销售相关控制层
public:
    Q_INVOKABLE void getSaleStatistic();
    Q_INVOKABLE void getSaleCatagoryStatistic(QDate from, QDate end);
    Q_INVOKABLE void getSaleRecords(QDate from, QDate end);
    Q_INVOKABLE void getSaleRecords(int product_id, QDate from_date, QDate end_date);
    Q_INVOKABLE void getAllRecords();
    Q_INVOKABLE void addSaleRecord(QVariantList record);
    Q_INVOKABLE void getProductName(int product_id);
private:
    QDate startYMD;
    QDate endYMD;
signals:
    void saleStatistic(const QVariantList month,const QVariantList amount);
    void saleCatagoryStatistic(const QVariantList cat,const QVariantList amount);
    void saleRecords(TheClassModel* theclassmodel);
    //void saleRecords2(TheClassModel *theclassmodel);
    void allSaleRecords(TheClassModel *theclassmodel);
    void saleRecordAdded(bool ok);
    void productName(QString name);
//库存相关控制层
public:
Q_INVOKABLE void getRepertoryStatistic();
Q_INVOKABLE void getAllProducts();
Q_INVOKABLE void saveProduct(QVariantList);
Q_INVOKABLE void deleteProduct(int id);
Q_INVOKABLE void addProduct(QVariantList data);
private:

signals:
void repertoryStatistic(const QVariantList cat,const QVariantList amount);
void allProducts(TheClassModel *theclassmodel);
void productSaved(bool ok);
void productDeleted(bool ok);
void productAdded(bool ok);


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
//系统管理相关控制层
public:
Q_INVOKABLE void getStuffMainInfo();
Q_INVOKABLE void saveStuffMainInfo(QVariantList info);
Q_INVOKABLE void getAllUsers();
Q_INVOKABLE void saveUser(QVariantList user);
Q_INVOKABLE void addUser(QVariantList user);
Q_INVOKABLE void deleteUser(int user_id);
private:

signals:
void stuffMainInfo(TheClassModel *theclassmodel);
void stuffMainInfoSaved(bool ok);
void allUsers(TheClassModel *theclassmodel);
void userSaved(bool ok);
void userAdded(bool ok);
void userDeleted(bool ok);
};

#endif // CONTROLLAYER_H
