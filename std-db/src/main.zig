const std = @import("std");
const sqlite = @import("sqlite");

var actives_threads: usize = 0;
var m = std.Thread.Mutex{};

pub fn main() !void {
    const addr = try std.net.Address.parseIp("127.0.0.1", 4242);
    var server: std.net.Server = try std.net.Address.listen(addr, .{ .reuse_address = true, .reuse_port = true });

    std.debug.print("Server up and running !\n", .{});

    // Thread pool
    const allocator = std.heap.page_allocator;

    var sqldb = try sqlite.Db.init(.{
        .mode = sqlite.Db.Mode{ .File = "mydb.db" },
        .open_flags = .{
            .write = true,
            .create = true,
        },
        .threading_mode = .Serialized, // I cant use multi thread because the HTTP server is already multi-threaded under the hood, making one thread managing multiple connections thus not allowing sqlite MultiThread
    });

    while (true) {
        try handleClient(&server, &sqldb, allocator);
    }
}

fn handleClient(server: *std.net.Server, db: *sqlite.Db, allocator: std.mem.Allocator) !void {
    const conn = server.*.accept() catch {
        std.debug.print("Boulette\n", .{});
        return;
    }; // Blocking call
    var buffer: [1024]u8 = undefined; // Buffer size does not affect performance
    var http_server_with_client = std.http.Server.init(conn, &buffer);
    defer conn.stream.close();

    // Simulate work
    const query =
        \\ select id from player
    ;
    var stmt = try db.prepare(query);
    defer stmt.deinit();

    _ = try stmt.all(usize, allocator, .{}, .{});

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
