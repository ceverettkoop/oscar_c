const std = @import("std");

pub fn build(b: *std.Build) void {
    const windows = b.option(bool, "windows", "Target BW Windows") orelse false;
    const optimize = b.standardOptimizeOption(.{}); //user defined
    var target = b.standardTargetOptions(.{});
    if (windows){
        target = .{
            .cpu_arch = .x86, 
            .os_tag = .windows, 
            .abi = .msvc
        };
    }
    const lib = b.addSharedLibrary(.{
        .name = "oscar",
        .root_source_file = .{ .path = "src/bwapi_module.zig" },
        .target = target,
        .optimize = optimize,
    });

    lib.addIncludePath(.{ .path = "/include" });
    lib.addLibraryPath(.{ .path = "./lib" });
    lib.linkSystemLibrary("BWAPIC");
    if (!windows){
        lib.linkSystemLibrary("BWAPILIB"); 
    }

    b.installArtifact(lib);
}
