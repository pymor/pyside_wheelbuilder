project(pyside)

include(PySideModules)

# Configure include based on platform
configure_file("${CMAKE_CURRENT_SOURCE_DIR}/global.h.in"
               "${CMAKE_CURRENT_BINARY_DIR}/pyside_global.h" @ONLY)

configure_file("${CMAKE_CURRENT_SOURCE_DIR}/__init__.py.in"
               "${CMAKE_CURRENT_BINARY_DIR}/__init__.py" @ONLY)

configure_file("${CMAKE_CURRENT_SOURCE_DIR}/_utils.py.in"
               "${CMAKE_CURRENT_BINARY_DIR}/_utils.py" @ONLY)

HAS_QT_MODULE(QT_QTCORE_FOUND QtCore)
HAS_QT_MODULE(QT_QTGUI_FOUND QtGui)
HAS_QT_MODULE(QT_QTNETWORK_FOUND QtNetwork)
HAS_QT_MODULE(QT_QTWEBKIT_FOUND QtWebKit)
HAS_QT_MODULE(QT_QTSVG_FOUND QtSvg)
HAS_QT_MODULE(QT_QTXML_FOUND QtXml)
HAS_QT_MODULE(QT_QTTEST_FOUND QtTest)
HAS_QT_MODULE(QT_QTOPENGL_FOUND QtOpenGL)
HAS_QT_MODULE(QT_QTSQL_FOUND QtSql)
if(QT_QTDESIGNER_FOUND)
    HAS_QT_MODULE(QT_QTUITOOLS_FOUND QtUiTools)
endif()
HAS_QT_MODULE(QT_QTHELP_FOUND QtHelp)
HAS_QT_MODULE(QT_QTXMLPATTERNS_FOUND QtXmlPatterns)
HAS_QT_MODULE(QT_QTMAEMO5_FOUND QtMaemo5)
HAS_QT_MODULE(QT_QTSCRIPT_FOUND QtScript)
HAS_QT_MODULE(QT_QTSCRIPTTOOLS_FOUND QtScriptTools)
HAS_QT_MODULE(QT_QTMULTIMEDIA_FOUND QtMultimedia)
HAS_QT_MODULE(QT_PHONON_FOUND phonon)
HAS_QT_MODULE(QT_QTDECLARATIVE_FOUND QtDeclarative)

# install
install(FILES "${CMAKE_CURRENT_BINARY_DIR}/__init__.py"
        DESTINATION "${SITE_PACKAGE}/${BINDING_NAME}${pyside_SUFFIX}")
install(FILES ${CMAKE_CURRENT_BINARY_DIR}/_utils.py
        DESTINATION "${SITE_PACKAGE}/${BINDING_NAME}${pyside_SUFFIX}")
install(FILES ${CMAKE_CURRENT_SOURCE_DIR}/typesystem_templates.xml
        DESTINATION share/PySide${pyside_SUFFIX}/typesystems)
install(FILES ${CMAKE_CURRENT_BINARY_DIR}/pyside_global.h
        DESTINATION include/${BINDING_NAME}${pyside_SUFFIX})

