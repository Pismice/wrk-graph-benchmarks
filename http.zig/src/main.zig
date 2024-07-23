const std = @import("std");
const httpz = @import("httpz");

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();

    var server = try httpz.Server().init(allocator, .{ .port = 5882 });

    var router = server.router();

    router.get("/", hello);

    try server.listen();
}

fn hello(req: *httpz.Request, res: *httpz.Response) !void {
    _ = req;
    try res.json(.{ .message = "hello" }, .{});
}
