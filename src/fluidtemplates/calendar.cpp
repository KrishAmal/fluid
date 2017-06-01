#include "calendar_p.h"

class CalendarPrivate : public QQuickControlPrivate
{
    Q_DECLARE_PUBLIC(Calendar)
public:
    CalendarPrivate()
        : header(nullptr)
    {
    }
};

Calendar::Calendar(QQuickItem *parent)
{

}

QQuickItem *Calendar::header() const
{

}

void Calendar::setHeader(QQuickItem *header)
{

}
