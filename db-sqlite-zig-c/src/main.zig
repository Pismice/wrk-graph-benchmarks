const std = @import("std");

const sqlite = @import("sqlite");

var begin: i64 = undefined;
var count: i64 = 0;

pub fn main() !void {
    const allocator = std.heap.page_allocator;
    _ = allocator;
    var sqldb = try sqlite.Db.init(.{
        .mode = sqlite.Db.Mode{ .File = "mydb.db" },
        .open_flags = .{
            .write = true,
            .create = true,
        },
        .threading_mode = .Serialized, // I cant use multi thread because the HTTP server is already multi-threaded under the hood, making one thread managing multiple connections thus not allowing sqlite MultiThread
        .shared_cache = true,
    });

    // Simulate work
    const query =
        \\ select id from player
    ;

    var sa = std.posix.Sigaction{
        .handler = .{
            .handler = &signal_handler,
        },
        .mask = std.posix.empty_sigset,
        .flags = 0,
    };
    try std.posix.sigaction(std.posix.SIG.INT, &sa, null);

    begin = std.time.milliTimestamp();
    while (true) {
        count += 1;
        var stmt = try sqldb.prepare(query);
        defer stmt.deinit();

        //        _ = try stmt.all(usize, allocator, .{}, .{});
        _ = try stmt.one(usize, .{}, .{});
    }
}

// Equivalent to a defer for the main function
fn signal_handler(_: c_int) align(1) callconv(.C) void {
    std.debug.print("Received SIGINT\n", .{});

    const elapsed = std.time.milliTimestamp() - begin;

    std.debug.print("Debit: {d}\n", .{@divTrunc(count, @divTrunc(elapsed, 1000))});

    std.process.exit(0); // important in order to kill all the pollings threads
}
