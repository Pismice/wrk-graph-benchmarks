const std = @import("std");

var actives_threads: usize = 0;
var m = std.Thread.Mutex{};

pub fn main() !void {
    const addr = try std.net.Address.parseIp("127.0.0.1", 4242);
    var server: std.net.Server = try std.net.Address.listen(addr, .{ .reuse_address = true, .reuse_port = true });

    std.debug.print("Server up and running !\n", .{});

    // Thread pool
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();
    var pool: std.Thread.Pool = undefined;
    std.debug.print("{any}", .{std.Thread.getCpuCount()});
    try pool.init(.{ .allocator = allocator, .n_jobs = 12 });
    defer pool.deinit();

    while (true) {
        if (actives_threads < 12) {
            m.lock();
            actives_threads += 1;
            m.unlock();

            // Version GOOD
            const conn = try server.accept();
            try pool.spawn(handleClient2, .{conn});

            // Version BAD
            //handleClient(&server);
            //try pool.spawn(handleClient, .{&server});
        }
    }
}

fn handleClient2(conn: std.net.Server.Connection) void {
    var buffer: [1024]u8 = undefined; // Buffer size does not affect performance
    var http_server_with_client = std.http.Server.init(conn, &buffer);
    defer conn.stream.close();

    defer {
        m.lock();
        actives_threads -= 1;
        m.unlock();
    }

    // Simulate work

    while (http_server_with_client.state == .ready) {
        // Read request
        var req = http_server_with_client.receiveHead() catch |err| switch (err) { // Blocking call
            error.HttpConnectionClosing => break,
            else => {
                std.debug.print("Unhandled error {any}\n", .{err}); // FAILING HERE
                return;
            },
        };

        _ = req.reader() catch |err| {
            std.debug.print("Error while reading request: {any}\n", .{err});
            return;
        };

        // Send response
        req.respond("bonjour", .{}) catch |err| {
            std.debug.print("Error while sending response: {any}\n", .{err});
            return;
        };
    }
}
