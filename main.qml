import QtGraphicalEffects 1.0
import QtQuick 2.14
import QtQuick.Controls 2.3
import QtQuick.Window 2.14

Window {
    id: window
    visible: true
    flags: Qt.FramelessWindowHint | Qt.WindowStaysOnTopHint
    width: longestLength > minWidth - spacing ? longestLength + spacing * 2 : minWidth
    height: 180
    color: Qt.rgba(0, 0, 0, 0)
    property int minWidth: 280
    property int spacing: 10
    property int longestLength: (textFieldAccount.width > textFieldPassword.width) ? textFieldAccount.width : textFieldPassword.width

    Rectangle {
        id: rectangleMainView
        width: window.width
        height: window.height
        color: Qt.rgba(0.92, 0.92, 0.92, 0.8)
        layer.enabled: true
        layer.effect: OpacityMask {
            maskSource: Rectangle {
                width: rectangleMainView.width
                height: rectangleMainView.height
                radius: 10
            }
        }

        Item {
            id: itemFrame
            z: itemMainboard.z + 1
            width: rectangleMainView.width
            height: rectangleClose.height
            anchors.top: rectangleMainView.top

            MouseArea {
                anchors.fill: itemFrame
                acceptedButtons: Qt.LeftButton

                property point clickPosition: "0,0"

                onPressed: {
                    clickPosition = Qt.point(mouse.x,mouse.y)
                }
                onPositionChanged: {
                    var offset = Qt.point(mouse.x - clickPosition.x, mouse.y - clickPosition.y)
                    window.setX(window.x + offset.x)
                    window.setY(window.y + offset.y)
                }
            }
            Rectangle {
                id: rectangleClose
                z: 1
                width: 32
                height: 22
                color: Qt.rgba(0, 0, 0, 0)
                anchors.right: itemFrame.right

                Label {
                    id: labelClose
                    font {
                        family: "微软雅黑"
                        pointSize: 16
                    }
                    color: Qt.rgba(1, 0, 0, 1)
                    text: "×"
                    anchors.centerIn: rectangleClose
                }
                MouseArea {
                    anchors.fill: rectangleClose
                    hoverEnabled: true

                    onEntered: {
                        rectangleClose.color = Qt.rgba(0.6, 0.6, 0.6, 0.5)
                    }
                    onExited: {
                        rectangleClose.color = Qt.rgba(0, 0, 0, 0)
                    }
                    onPressed: {
                        rectangleClose.color = Qt.rgba(0.3, 0.3, 0.3, 0.5)
                    }
                    onClicked: {
                        Qt.quit()
                    }
                }
            }
        }
        Item {
            id: itemMainboard
            z: itemOthers.z + 1
            width: itemInput.width
            height: itemInput.height + itemLogin.height + spacing
            anchors.horizontalCenter: rectangleMainView.horizontalCenter
            anchors.verticalCenter: rectangleMainView.verticalCenter
            property int spacing: 10

            Item {
                id: itemInput
                width: (textFieldAccount.width > textFieldPassword.width ? textFieldAccount.width : textFieldPassword.width)
                height: textFieldAccount.height + textFieldPassword.height + spacing
                anchors.top: itemMainboard.top
                anchors.horizontalCenter: itemMainboard.horizontalCenter
                property int spacing: 10

                TextField {
                    id: textFieldAccount
                    background: Rectangle {
                        radius: 5
                        color: textFieldAccount.activeFocus ? Qt.rgba(1, 1, 1, 1) : Qt.rgba(0.85, 0.85, 0.85, 1)
                    }
                    font {
                        family: "微软雅黑"
                        pointSize: 12
                    }
                    leftPadding: 5
                    rightPadding: 5
                    placeholderText: qsTr("请输入账号")
                    selectByMouse: true
                    selectionColor: Qt.rgba(0.5, 0.5, 0.5, 1)
                    echoMode: TextInput.Normal
                    anchors.top: itemInput.top
                    anchors.horizontalCenter: itemInput.horizontalCenter
                }
                TextField {
                    id: textFieldPassword
                    background: Rectangle {
                        radius: 5
                        color: textFieldPassword.activeFocus ? Qt.rgba(1, 1, 1, 1) : Qt.rgba(0.85, 0.85, 0.85, 1)
                    }
                    font {
                        family: "微软雅黑"
                        pointSize: 12
                    }
                    leftPadding: 5
                    rightPadding: 5
                    placeholderText: qsTr("请输入密码")
                    selectByMouse: true
                    selectionColor: Qt.rgba(0.5, 0.5, 0.5, 1)
                    echoMode: TextInput.Password
                    anchors.bottom: itemInput.bottom
                    anchors.horizontalCenter: itemInput.horizontalCenter
                }
            }
            Item {
                id: itemLogin
                width: itemInput.width
                height: rectangleLogin.height
                anchors.bottom: itemMainboard.bottom
                anchors.horizontalCenter: itemMainboard.horizontalCenter

                Rectangle {
                    id: rectangleLogin
                    width: 120
                    height: 30
                    radius: 5
                    border.width: 0
                    border.color: Qt.rgba(0.8, 0.8, 0.2, 1)
                    color: Qt.rgba(1, 1, 1, 1)
                    anchors.centerIn: itemLogin

                    MouseArea {
                        anchors.fill: rectangleLogin
                        hoverEnabled: true

                        onEntered: {
                            rectangleLogin.border.width = 1
                        }
                        onExited: {
                            rectangleLogin.border.width = 0
                        }
                        onPressed: {
                            rectangleLogin.color = Qt.rgba(0.85, 0.85, 0.85, 0.4)
                        }
                        onReleased: {
                            rectangleLogin.color = Qt.rgba(1, 1, 1, 1)
                        }
                        onClicked: {
                            console.log("Login")
                        }
                    }
                    Label {
                        font {
                            family: "微软雅黑"
                            pointSize: 14
                        }
                        text: "登录"
                        anchors.centerIn: rectangleLogin
                    }
                }
            }
        }
        Item {
            id: itemOthers
            z: 1
            width: rectangleMainView.width
            height: rectangleRegister.height
            anchors.bottom: rectangleMainView.bottom
            anchors.horizontalCenter: rectangleMainView.horizontalCenter

            Rectangle {
                id: rectangleRegister
                width: labelRegister.width + horizontalPadding * 2
                height: labelRegister.height + verticalPadding * 2
                radius: 5
                color: Qt.rgba(0, 0, 0, 0)
                anchors.left: itemOthers.left
                anchors.verticalCenter: itemOthers.verticalCenter
                property int horizontalPadding: 6
                property int verticalPadding: 3

                Label {
                    id: labelRegister
                    font {
                        family: "微软雅黑"
                        pointSize: 10
                    }
                    color: Qt.rgba(0.4, 0.4, 0.4, 1)
                    text: "注册账号"
                    anchors.centerIn: rectangleRegister

                    MouseArea {
                        anchors.fill: labelRegister
                        hoverEnabled: true

                        onEntered: {
                            rectangleRegister.color = Qt.rgba(0.85, 0.85, 0.85, 1)
                        }
                        onExited: {
                            rectangleRegister.color = Qt.rgba(0, 0, 0, 0)
                        }
                        onClicked: {
                            console.log("Register")
                        }
                    }
                }
            }
            Rectangle {
                id: rectangleAuthor
                width: labelAuthor.width + horizontalPadding * 2
                height: labelAuthor.height + verticalPadding * 2
                radius: 5
                color: Qt.rgba(0, 0, 0, 0)
                anchors.horizontalCenter: itemOthers.horizontalCenter
                anchors.verticalCenter: itemOthers.verticalCenter
                property int horizontalPadding: 6
                property int verticalPadding: 3

                Label {
                    id: labelAuthor
                    font {
                        family: "微软雅黑"
                        pointSize: 10
                    }
                    color: Qt.rgba(0.4, 0.4, 0.4, 1)
                    text: "制作者：杨荣宝"
                    anchors.centerIn: rectangleAuthor

                    MouseArea {
                        anchors.fill: labelAuthor
                        hoverEnabled: true

                        onEntered: {
                            rectangleAuthor.color = Qt.rgba(0.85, 0.85, 0.85, 1)
                        }
                        onExited: {
                            rectangleAuthor.color = Qt.rgba(0, 0, 0, 0)
                        }
                        onClicked: {
                            console.log("Author")
                        }
                    }
                }
            }
            Rectangle {
                id: rectangleRetrieve
                width: labelRetrieve.width + horizontalPadding * 2
                height: labelRegister.height + verticalPadding * 2
                radius: 5
                color: Qt.rgba(0, 0, 0, 0)
                anchors.right: itemOthers.right
                anchors.verticalCenter: itemOthers.verticalCenter
                property int horizontalPadding: 6
                property int verticalPadding: 3

                Label {
                    id: labelRetrieve
                    font {
                        family: "微软雅黑"
                        pointSize: 10
                    }
                    color: Qt.rgba(0.4, 0.4, 0.4, 1)
                    text: "找回密码"
                    anchors.centerIn: rectangleRetrieve

                    MouseArea {
                        anchors.fill: labelRetrieve
                        hoverEnabled: true

                        onEntered: {
                            rectangleRetrieve.color = Qt.rgba(0.85, 0.85, 0.85, 1)
                        }
                        onExited: {
                            rectangleRetrieve.color = Qt.rgba(0, 0, 0, 0)
                        }
                        onClicked: {
                            console.log("Retrieve")
                        }
                    }
                }
            }
        }
    }
}
