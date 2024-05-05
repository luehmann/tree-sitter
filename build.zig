const std = @import("std");

pub fn build(b: *std.Build) void {
    var lib = b.addStaticLibrary(.{
        .name = "tree-sitter",
        .target = b.standardTargetOptions(.{}),
        .optimize = b.standardOptimizeOption(.{}),
    });

    lib.linkLibC();
    lib.addCSourceFile(.{ .file = .{ .path = "lib/src/lib.c" }, .flags = &.{"-std=c11"} });
    lib.addIncludePath(.{ .path = "lib/include" });
    lib.addIncludePath(.{ .path = "lib/src" });

    lib.installHeadersDirectory(.{ .path = "lib/include/tree_sitter" }, "tree_sitter", .{});
    lib.installHeader(b.path("lib/src/parser.h"), "tree_sitter/parser.h");

    b.installArtifact(lib);
}
