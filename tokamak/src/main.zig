const tk = @import("tokamak");
const std = @import("std");

pub fn main() !void {
    const allocator = std.heap.page_allocator;
    const r = tk.get("/", hello);
    const routes = [_]tk.Route{r};
    var server = try tk.Server.init(allocator, &routes, .{});
    try server.listen(.{ .port = 8080 });
}

fn hello() ![]const u8 {
    return "Hello";
}
