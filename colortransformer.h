#ifndef COLORTRANSFORMER_H
#define COLORTRANSFORMER_H

#include <QObject>
#include <QColor>

class ColorTransFormer: public QObject
{
    Q_OBJECT
public:
    ColorTransFormer();
    ~ColorTransFormer();

    Q_INVOKABLE void set_hsv(int h,int s,int v){
        mcolor.setHsv(h,s,v);
    }

    Q_INVOKABLE int get_red(){
        return mcolor.red();
    }
    Q_INVOKABLE int get_blue(){
        return mcolor.blue();
    }
    Q_INVOKABLE int get_green(){
        return mcolor.green();
    }
    Q_INVOKABLE QColor get_rgb(){
        return mcolor.toRgb();
    }

    Q_INVOKABLE int get_h(){
        return mcolor.hue();
    }
    Q_INVOKABLE int get_s(){
        return mcolor.saturation();
    }
    Q_INVOKABLE void set_rgb(int r,int g,int b){
        mcolor.setRgb(r,g,b);
    }

private:
    QColor mcolor;

};

#endif // COLORTRANSFORMER_H
