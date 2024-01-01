const std = @import("std");

// Although this function looks imperative, note that its job is to
// declaratively construct a build graph that will be executed by an external
// runner.
pub fn build(b: *std.Build) void {
    // x86-windows-msvc
    const optimize = b.standardOptimizeOption(.{}); //user defined

    const lib = b.addSharedLibrary(.{
        .name = "oscar",
        // In this case the main source file is merely a path, however, in more
        // complicated build scripts, this could be a generated file.
        .root_source_file = .{ .path = "src/oscar_module.zig" },
        .target = .{ .cpu_arch = .x86, .os_tag = .windows, .abi = .msvc },
        .optimize = optimize,
    });

    lib.addIncludePath(.{ .path = "/include" });
    lib.addLibraryPath(.{ .path = "./lib" });
    lib.linkSystemLibrary("BWAPIC");

    b.installArtifact(lib);
}
