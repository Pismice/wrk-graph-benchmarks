const std = @import("std");

var actives_threads: usize = 0;
var m = std.Thread.Mutex{};

pub fn main() !void {
    const addr = try std.net.Address.parseIp("127.0.0.1", 4242);
    var server: std.net.Server = try std.net.Address.listen(addr, .{ .reuse_address = true, .reuse_port = true });
    var idx: usize = 0;

    std.debug.print("Server up and running !\n", .{});

    while (true) {
        var buffer: [524288]u8 = undefined; // Buffer size does not affect performance
        var conn = try server.accept(); // Blocking call
        idx += 1;
        defer conn.stream.close();

        var http_server_with_client = std.http.Server.init(conn, &buffer);

        while (http_server_with_client.state == .ready) {
            // Read request
            var req = http_server_with_client.receiveHead() catch |err| switch (err) {
                error.HttpConnectionClosing => break,
                else => {
                    std.debug.print("Unhandled error {any}", .{err});
                    return;
                },
            };
            _ = try req.reader();

            // Send response
            try req.respond("bonjour", .{});
        }
    }
}
