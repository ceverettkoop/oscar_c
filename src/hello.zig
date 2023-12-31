const std = @import("std");
const expect = std.testing.expect;

pub fn main() !u8 {
    const allocator = std.heap.page_allocator;
    const memory = try allocator.alloc(u8, 100);
    memory[0] = 6;
    defer allocator.free(memory);
    std.debug.print("{d}!\n", .{memory[0]});
    return 0;
}

test "allocation" {
    const allocator = std.heap.page_allocator;

    const memory = try allocator.alloc(u8, 100);
    defer allocator.free(memory);

    try expect(memory.len == 100);
    try expect(@TypeOf(memory) == []u8);
}
