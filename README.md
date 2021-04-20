# Home

Home screen for Ubuntu Touch

![screenshot.jpg](_resources/screenshot.jpg)

Sometimes it is necessary to minimize the active application to the tray. So that the next time you turn on the screen, it would be active, but not occupy an active place. **uHome**, a home screen with widgets support, will help you with this task.

The application has its own built-in widgets. In addition, you can download other widgets to customize your home screen more.
- **An analog clock** will always show you the current time, and a variety of themes allow you to customize it to your liking.
- **Stickers** will help you remind you of the most important things. And their striking design attracts attention.
- **The link** can create an internet link or launch an application with URLdispatcher support.

## For developers
Widgets are able to receive information from the Internet, receive and send files from the Content Hub.

To write temporary files, the directory is used:
*/home/phablet/.cache/uhome.pavelprosto/*
Custom widgets are located at:
*/home/phablet/.local/share/uhome.pavelprosto/*

**Widgets can't!**
- Have access to user files
- Have access to a camera or microphone
- Have access to location
- Launch and access application files (only URLdispatcher available)
- Have access to sms, calendar and phone book

You can create your own widgets using **QML** and **PyOtherSide**. See examples of [standard widgets](https://github.com/pavelprosto94/uHome/tree/main/src) and example of [weather widget](https://github.com/pavelprosto94/openweatermapwidget).

### Create link for your programm
If you would like to add your application to the home screen using the URLDispatcher

    onClicked: {
      Qt.openUrlExternally("uhome://createlink/?name=VideoPlayer&url=uvideo://&backgroundcolor=#00000000&icon=img/uVideo.svg")
    }

**name** link name
**url** if your program support URLDispatcher paste link there
**backgroundcolor** color in ARGB(alpha, red, green, blue) format. If the icon does not have a transparent background, then this parameter will not be visible
**icon** You can set icon for standard path "img/{iconname}.svg", or set the icon in BASE64 format



## Build
In the terminal, go to our directory with the project and enter the command:
    
    clickable
    
The project will compile and run on our phone
## License

Copyright (C) 2021  Pavel Prosto

This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License version 3, as published
by the Free Software Foundation.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranties of MERCHANTABILITY, SATISFACTORY QUALITY, or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.
