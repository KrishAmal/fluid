
import QtQuick 2.6
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.0
import QtQuick.Controls.Material 2.0
import Qt.labs.calendar 1.0
import QtQml 2.2
import Fluid.Controls 1.0 as FluidControls

T.Calendar {
    id: root

    implicitWidth: implicitHeight

    function updateDate() {
        var date = new Date()
        grid.month = date.getMonth()
        grid.date = date.getDate()
        grid.year = date.getFullYear()
    }

    header: RowLayout {
        FluidControls.IconButton {
            id: previousMonth
            iconName: "navigation/chevron_left"
            onClicked: {
                if (grid.month === Calendar.January) {
                    grid.year--;
                    grid.month = Calendar.December;
                    return;
                }
                grid.month--;
            }
        }

        Item {
            Layout.fillWidth: true
            height: previousMonth.height

            FluidControls.SubheadingLabel {
                id: title
                text: Qt.locale().monthName(grid.month, Locale.LongFormat) + " " + grid.year
                anchors.fill: parent
                font.weight: Font.Black
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }
        }
        FluidControls.IconButton {
            id: nextMonth
            Layout.preferredWidth: height
            iconName: "navigation/chevron_right"
            visible: enabled
            onClicked: {
                if (grid.month === Calendar.December) {
                    grid.year++
                    grid.month = Calendar.January
                }
                grid.month++
            }
        }
    }

    dayOfWeek: DayOfWeekRow {
        locale: grid.locale
        Layout.column: 1
        Layout.fillWidth: true
        Layout.alignment: Qt.AlignTop
        delegate: Label {
            text: model.narrowName.charAt(0)
            font.weight: Font.DemiBold
            font.pixelSize: 14
            font.capitalization: Font.AllUppercase
            color: Material.secondaryTextColor
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }
    }

    monthGrid: MonthGrid {
        id: grid
        Layout.alignment: Qt.AlignTop
        Layout.fillWidth: true
        property int date: -1
        property Item currentItem: null
        delegate: Label {
            id: gridDelegate
            objectName: "gridDelegate"
            text: delegateDay
            topPadding: 8
            bottomPadding: 8
            opacity: model.month === grid.month ? 1 : .2
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.bold: delegateDay === grid.date && delegateMonth === grid.month
            //color: grid.currentItem ? Material.primaryHighlightedTextColor : delegateDay === grid.date && delegateMonth === grid.month && enabled ? Material.secondaryTextColor : Material.primaryTextColor
            color: grid.currentItem == gridDelegate
                   ? Material.primaryHighlightedTextColor
                   : delegateDay === grid.date && delegateMonth === grid.month && enabled ? Material.accentColor : Material.primaryTextColor
            property int delegateDay: model.day
            property int delegateMonth: model.month
        }
        Component.onCompleted: updateDate()

        Rectangle {
            z: -1
            id: highlight
            x: grid.currentItem ? grid.currentItem.x + grid.currentItem.width / 2 - width / 2: 0
            y: grid.currentItem ? grid.currentItem.y + grid.currentItem.height / 2- height / 2: 0
            width: grid.currentItem ? grid.currentItem.paintedWidth + 16 : 0
            visible: grid.currentItem
            height: width
            color: Material.accentColor // enabled? "#80c342" : "#d6d6d6"
            radius: width / 2
        }

        onMonthChanged: updateHighlightPosition()
        onYearChanged: updateHighlightPosition()
        onDateChanged: updateHighlightPosition()

        function updateHighlightPosition() {
            var date = new Date()

            date.setFullYear(grid.year)
            date.setMonth(grid.month)
            date.setDate(grid.date)

            var index = grid.source.indexOf(date)
            var delegate = grid.contentItem.children[index]

            if (delegate)
                grid.currentItem = delegate
        }

        MouseArea {
            anchors.fill: parent

            onClicked: {
                var item = grid.contentItem.childAt(mouse.x, mouse.y)

                if (item) {
                    if (item.objectName !== "gridDelegate")
                        item = grid.contentItem.children[0]

                    if (!item)
                        return;

                    grid.currentItem = item
                    grid.date = item.delegateDay
                    grid.month = item.delegateMonth

                    var currentTime = TimeManager.time;
                    var newDate = new Date();

                    newDate.setFullYear(grid.year)
                    newDate.setMonth(grid.month)
                    newDate.setDate(grid.date)
                    newDate.setHours(currentTime.getHours());
                    newDate.setMinutes(currentTime.getMinutes());
                    newDate.setSeconds(currentTime.getSeconds());
                    TimeManager.time = newDate;
                }
            }
        }
    }
}
