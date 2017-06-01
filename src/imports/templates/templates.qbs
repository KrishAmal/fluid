import qbs 1.0

LiriDynamicLibrary {
    name: targetName
    targetName: "fluidtemplatesplugin"

    Depends { name: "lirideployment" }
    Depends { name: "cpp" }
    Depends { name: "Qt"; submodules: ["gui", "qml", "quick"] }

    Depends { name: "FluidTemplates" }

    cpp.defines: base.concat(['FLUID_VERSION="' + project.version + '"'])

    files: ["*.cpp", "*.h"]

    Group {
        name: "QML Files"
        files: [
            "qmldir",
        ]
        fileTags: ["qml"]
    }

    Group {
        qbs.install: true
        qbs.installDir: lirideployment.qmlDir + "/Fluid/Templates"
        fileTagsFilter: ["dynamiclibrary", "qml"]
    }
}
