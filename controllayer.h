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
//0requesttype,1workernum,2password
//0loginstate,1workertype
//人事管理相关控制层
rt_listAllWorker,//1
//requesttype
//0id(int),1name,2tel(string),3address,4isPosition(bool),5email,6sex(bool)
rt_getSupplierList,//2
//requesttype
//0suppliername,1phone,2pic,3id,4addr,5descrip
rt_getSupplierDetail,//3
//requesttype,Supplierid
//0suppliername,1phone,2pic,3id,4addr,5descrip
rt_getWorkerDetail,//4
//requesttype,Workerid
//0name,1telephone,2gender,3employee_id,4address,5email,6group_id
rt_saveWorker,//5
//0requesttype,1id,2athority=-1,3sex,4name,5tel,6address,7email,8isPosition
//ok
rt_deleteWorker,//6
//requesttype,Workerid
//ok
rt_addWorker,//7
//0requesttype,1sex,2name,3tel,4address,5email,6isPosition
//ok
rt_saveSupplier,//8
//0requesttype,1id,2suppliername,3addr,4phone,5descrip,6pic
//ok
rt_deleteSupplier,//9
//requesttype,Supplierid
//ok
rt_addSupplier,//10
//0requesttype,1suppliername,2addr,3phone,4descrip,5pic
//ok
rt_changePositionState,//11
//requesttype,userId,isPosition
//ok
//销售相关控制层
rt_getSaleStatistic,//12
//requesttype
//月，销售额
rt_getSaleCatagoryStatistic,//13
//requesttype,startYMD,endYMD
//商品类别，库存
rt_getSaleRecords,//14
//requesttype,startYMD,endYMD
//记录id，商品id，数量，销售额，时间
rt_getSaleRecords2,//15
//0requesttype,1product_id,2startYMD,3endYMD
//0product_id,1product_name,2price,num,3sale_time(string)
rt_getAllRecords,//16
//requesttype
//0product_id ,1product_name,2price,3num,4sale_time(string)
rt_addSaleRecord,//17
//0requesttype,1product_id,2num,3totalprice
//ok
rt_getProductName,//18
//requesttype,product_id,
//0id(int), 1name, 2catagory(string), 3num ,4price ,5info ,6image(string)
//库存相关控制层
rt_getRepertoryStatistic,//19
//requesttype
//商品类别，库存量
rt_getAllProducts,//20
//requesttype
//0id(int),1name, 2catagory(string), 3num ,4price ,5info ,6image(string)
rt_saveProduct,//21
//0id,1price,2name,3picture,4description,5num,6kind
//ok
rt_deleteProduct,//22
//requesttype,id
//ok
rt_addProduct,//23
//0price,1name,2picture,3description,4num,5kind
//ok
//进货相关控制层
rt_getStockPlans,//24
//requesttype
//0purchase_id，4product_id，2plan_employee_id，3purchase_employee_id,4supplier_name，5purchase_date，6quantity，7money_amount，8is_finish，9comment,10product_name
rt_getSupplierNames,//25
//requesttype
//SupplierId,SupplierNames
rt_savePlan,//26
//0requesttype,1purchase_id，2product_id，3supplier_id，4purchase_date,5quantity，6money_amount，7comment
//ok
rt_addPlan,//27
//0product_id,1makeplanworkerid,2doplanworkerid=-1,3supplier_id，4purchase_date,5quantity，6money_amount，7is_finish，8comment
//ok
rt_deletePlan,//28
//requesttype,planId
//ok
rt_changePlanState,//29
//0requesttype,1planId,2doplanworkerid,3isfinished
//ok
//系统管理相关控制层
rt_getStuffMainInfo,//30
//requesttype
//id(int) name password(string)
rt_saveStuffMainInfo, //31
//requesttype,id(int) password(string)
//ok
rt_getAllUsers,//32
//requesttype
//0id(int),1name,2tel(string),3address,4authority(int),5email,6sex(bool)
rt_saveUser,//33
//0requesttype,1id,2athority,3sex,4name,5tel,6address,7email
//ok
rt_addUser,//34
//0requesttype,1id,2athority,3sex,4name,5tel,6address,7email
//ok
rt_deleteUser,//35
//requesttype,user_id
//ok
rt_getOneUser,//36
//requesttype,user_id
//0id(int),1name,2tel(string),3address,4authority(int),5email,6sex(bool)
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
    void productName(QString name,double price);
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
Q_INVOKABLE void getOneUser(int user_id);
private:

signals:
void stuffMainInfo(TheClassModel *theclassmodel);
void stuffMainInfoSaved(bool ok);
void allUsers(TheClassModel *theclassmodel);
void userSaved(bool ok);
void userAdded(bool ok);
void userDeleted(bool ok);
void oneUser(QVariantList one);

};

#endif // CONTROLLAYER_H
