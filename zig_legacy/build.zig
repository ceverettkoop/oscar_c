const std = @import("std");

pub fn build(b: *std.Build) void {
    const windows_option = b.option(bool, "windows", "Target BW Windows") orelse false;
    const optimize = b.standardOptimizeOption(.{}); //user defined
    var target = b.standardTargetOptions(.{});
    if (windows_option){
        target = b.resolveTargetQuery(.{
            .cpu_arch = .x86, 
            .os_tag = .windows, 
            .abi = .msvc});
    }
    
    const lib = b.addLibrary(.{
        .name = "oscar",
        .linkage = .dynamic,
        .root_module = b.createModule(.{
            .root_source_file = b.path("src/bwapi_module.zig"),
            .target = target,
            .optimize = optimize
        })
    });

    lib.root_module.addIncludePath(b.path("./include"));
    lib.root_module.addLibraryPath(b.path("./lib"));

    if (!windows_option){
        lib.linkSystemLibrary("BWAPILIB");
        lib.linkSystemLibrary("BWAPIC");
    }else{
        lib.addObjectFile(b.path("./lib/BWAPIC.lib"));
    }
    
    b.installArtifact(lib);
}
