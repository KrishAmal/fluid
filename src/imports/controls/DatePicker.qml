/*
 * This file is part of Fluid.
 *
 * Copyright (C) 2017 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
 *
 * $BEGIN_LICENSE:MPL2$
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/.
 *
 * $END_LICENSE$
 */

import QtQml 2.2
import QtQuick 2.3
import QtQuick.Controls 2.1
import QtQuick.Controls.Material 2.1
import QtQuick.Layouts 1.0
import Qt.labs.calendar 1.0
import Fluid.Controls 1.0 as FluidControls

/*!
    \qmltype DatePicker
    \inqmlmodule Fluid.Controls
    \ingroup fluidcontrols

    \brief Alert dialogs are urgent interruptions to inform the user about a situation.

    An alert dialog is used to interrupt the user's workflow to inform them about
    a situation that requires their acknowledgement.

    Most alert don't need a title and they summarize a decision in a sentence or two
    by either asking a question or making a statement related to the action buttons.
*/
Dialog {
    id: datePickerDialog

    /*
    property alias from: calendarModel.from
    property alias to: calendarModel.to

    property alias orientation: listView.orientation
    */
    property int orientation: Qt.LandscapeOrientation

    modal: true
    standardButtons: Dialog.Ok | Dialog.Cancel

    x: (parent.width - width) / 2
    y: (parent.height - height) / 2

    header: null

    padding: 0

    Control {
        id: datePicker

        implicitWidth: orientation === Qt.LandscapeOrientation ? 500 : 340
        implicitHeight: orientation === Qt.LandscapeOrientation ? 280 : 440

        Rectangle {
            id: navigationBar

            width: orientation === Qt.LandscapeOrientation ? parent.width / 3 : undefined
            height: orientation === Qt.LandscapeOrientation ? parent.height : 96
            color: Material.accentColor

            ColumnLayout {
                anchors.left: parent.left
                anchors.top: parent.top
                anchors.right: orientation === Qt.LandscapeOrientation ? undefined : parent.right
                anchors.bottom: orientation === Qt.LandscapeOrientation ? parent.bottom : undefined
                anchors.verticalCenter: orientation === Qt.LandscapeOrientation ? undefined : parent.verticalCenter
                anchors.leftMargin: orientation === Qt.LandscapeOrientation ? 16 : 24
                anchors.rightMargin: 36
                spacing: 0

                FluidControls.BodyLabel {
                    text: listView.currentItem.year
                    level: 2
                    color: Material.primaryTextColor
                    opacity: 0.7
                }

                Label {
                    Layout.fillWidth: true

                    text: listView.currentItem.dateFormatted
                    font.pixelSize: 36
                    lineHeight: 0.9
                    wrapMode: Text.Wrap
                }
            }
        }

        Item {
            id: dayOfWeekRow

            anchors.top: orientation === Qt.LandscapeOrientation ? parent.top : navigationBar.bottom
            anchors.left: orientation === Qt.LandscapeOrientation ? navigationBar.right : parent.left
            anchors.right: parent.right
            width: orientation === Qt.LandscapeOrientation ? parent.width / 2 : undefined
            height: orientation === Qt.LandscapeOrientation ? 72 : 80

            FluidControls.IconButton {
                id: prevMonthButton

                anchors.top: parent.top
                anchors.left: parent.left

                iconName: "navigation/chevron_left"
            }

            FluidControls.SubheadingLabel {
                anchors.verticalCenter: parent.verticalCenter
                anchors.verticalCenterOffset: -10
                anchors.horizontalCenter: parent.horizontalCenter

                text: datePicker.locale.standaloneMonthName(listView.model.month)
            }

            FluidControls.IconButton {
                id: nextMonthButton

                anchors.top: parent.top
                anchors.right: parent.right
                anchors.rightMargin: 16

                iconName: "navigation/chevron_right"
            }

            DayOfWeekRow {
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                anchors.leftMargin: 8
                anchors.rightMargin: 8

                locale: datePicker.locale
                delegate: Label {
                    text: model.shortName
                    font.weight: Font.DemiBold
                    font.pixelSize: 14
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    color: Material.secondaryTextColor
                }
            }
        }

        ListView {
            id: listView

            anchors.left: navigationBar.right
            anchors.top: dayOfWeekRow.bottom
            anchors.right: parent.right
            anchors.bottom: parent.bottom

            clip: true
            snapMode: ListView.SnapOneItem
            orientation: ListView.Horizontal
            highlightRangeMode: ListView.StrictlyEnforceRange
            currentIndex: 0

            model: CalendarModel {
                id: calendarModel

                from: new Date(2015, 0, 1)
                to: new Date(2015, 11, 31)
            }
            move: Transition {
                NumberAnimation { properties: "x,y"; duration: 1000 }
            }
            delegate: MonthGrid {
                id: monthGrid

                property string dateFormatted: model.date.toLocaleDateString(datePicker.locale, "ddd, MMM dd")

                locale: datePicker.locale
                month: model.month
                year: model.year
                delegate: Label {
                    text: model.day
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    opacity: model.month === monthGrid.month ? 1 : 0
                    color: model.today ? Material.secondaryTextColor : Material.primaryTextColor

                    Rectangle {
                        anchors.centerIn: parent
                        width: 24
                        height: width
                        radius: width
                        color: Material.accentColor
                        z: -1
                        visible: model.today
                    }
                }
            }
        }
    }
}
