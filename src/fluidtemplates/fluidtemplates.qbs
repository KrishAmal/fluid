import qbs 1.0

LiriModule {
    name: targetName
    targetName: "FluidTemplates"
    version: "0.0.0"
    createCMake: false
    createPkgConfig: false

    Depends { name: "Qt"; submodules: ["core", "quicktemplates2-private"]; versionAtLeast: "5.8" }

    cpp.defines: base.concat([
        "FLUID_VERSION=" + project.version,
        "FLUID_BUILD_FLUIDTEMPLATES"
    ])

    files: ["*.cpp"]

    Group {
        name: "Headers"
        files: ["*.h"]
        excludeFiles: ["*_p.h"]
        fileTags: ["public_headers"]
    }

    Group {
        name: "Private Headers"
        files: ["*_p.h"]
        fileTags: ["private_headers"]
    }

    Export {
        Depends { name: "cpp" }
        Depends { name: "Qt"; submodules: ["core", "quicktemplates2-private"]; versionAtLeast: "5.8" }

        cpp.includePaths: product.generatedHeadersDir
    }
}
