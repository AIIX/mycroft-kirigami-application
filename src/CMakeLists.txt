add_subdirectory(icons)
qt5_add_resources(mycroft_kirigami_application_SRCS qml.qrc)

add_executable(mycroft-kirigami-application ${mycroft_kirigami_application_SRCS}
    main.cpp
    mycroftinterface_dbus.cpp
    msmapp.cpp
)

target_link_libraries(mycroft-kirigami-application 
    Qt5::Quick
    Qt5::Gui 
    Qt5::Core 
    Qt5::Qml
    Qt5::DBus
    KF5::I18n
)

install(TARGETS mycroft-kirigami-application ${INSTALL_TARGETS_DEFAULT_ARGS})

set(DesktopNoDisplay "false")
set(DesktopMimeType "application/vnd.debian.binary-package;application/x-rpm;")
set(DesktopExec "mycroft-kirigami-application %F")
configure_file(org.mycroft.kirigami.desktop.cmake ${CMAKE_CURRENT_BINARY_DIR}/org.mycroft.kirigami.desktop)
install(PROGRAMS ${CMAKE_CURRENT_BINARY_DIR}/org.mycroft.kirigami.desktop DESTINATION ${XDG_APPS_INSTALL_DIR})
