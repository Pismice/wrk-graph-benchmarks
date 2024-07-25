const std = @import("std");
pub const c = @cImport({
    @cInclude("sqlite3.h");
});

var begin: i64 = undefined;
var count: i64 = 0;

pub fn main() !void {
    var db: ?*c.sqlite3 = undefined;
    var rc = c.sqlite3_open("lol.db", &db);
    if (rc > 0) {
        std.debug.print("Can't open database: {}\n", .{rc});
    }

    const query: []const u8 = "SELECT id FROM PLAYER;";

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
        var stmt: ?*c.sqlite3_stmt = null;
        rc = c.sqlite3_prepare_v2(db, query.ptr, @intCast(query.len), &stmt, null);

        if (rc != c.SQLITE_OK) {
            std.debug.print("Failed to prepare statement: {}\n", .{rc});
            break;
        }

        while (c.sqlite3_step(stmt) == c.SQLITE_ROW) {
            _ = c.sqlite3_column_int(stmt, 0);
        }

        count += 1;
        _ = c.sqlite3_finalize(stmt);
    }
}

fn signal_handler(_: c_int) align(1) callconv(.C) void {
    std.debug.print("Received SIGINT\n", .{});

    const elapsed = std.time.milliTimestamp() - begin;

    std.debug.print("Debit: {d}\n", .{@divTrunc(count, @divTrunc(elapsed, 1000))});

    std.process.exit(0); // important in order to kill all the pollings threads
}
