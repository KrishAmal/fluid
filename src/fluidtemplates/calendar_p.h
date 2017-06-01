
#pragma once

//
//  W A R N I N G
//  -------------
//
// This file is not part of the Fluid API.  It exists purely as an
// implementation detail.  This header file may change from version to
// version without notice, or even be removed.
//
// We mean it.
//

#include <QtQuickTemplates2/private/qquickcontrol_p.h>

class CalendarPrivate;

class Calendar : public QQuickControl
{
    Q_OBJECT
    Q_PROPERTY(QQuickItem *header READ header WRITE setHeader NOTIFY headerChanged FINAL)
    Q_PROPERTY(QQuickItem *footer READ footer WRITE setFooter NOTIFY footerChanged FINAL)
    Q_PROPERTY(QQuickItem *dayOfWeek READ dayOfWeek WRITE setDayOfWeek NOTIFY dayOfWeekChanged FINAL)
    Q_PROPERTY(QQuickItem *weekNumbers READ weekNumbers WRITE setWeekNumbers NOTIFY weekNumbersChanged FINAL)
    Q_PROPERTY(QQuickItem *monthGrid READ monthGrid WRITE setMonthGrid NOTIFY monthGridChanged FINAL)
public:
    explicit Calendar(QQuickItem *parent = nullptr);

    QQuickItem *header() const;
    void setHeader(QQuickItem *header);

    QQuickItem *footer() const;
    void setFooter(QQuickItem *footer);

    QQuickItem *dayOfWeek() const;
    void setDayOfWeek(QQuickitem *dayOfWeek);

    QQuickItem *weekNumbers() const;
    void setWeekNumbers(QQuickItem *weekNumbers);

    QQuickItem *monthGrid() const;
    void setMonthGrid(QQuickItem *monthGrid);

Q_SIGNALS:
    void headerChanged();
    void footerChanged();
    void dayOfWeekChanged();
    void weekNumbersChanged();
    void monthGridChanged();

private:
    Q_DISABLE_COPY(Calendar)
    Q_DECLARE_PRIVATE(Calendar)
};

QML_DECLARE_TYPE(Calendar)
