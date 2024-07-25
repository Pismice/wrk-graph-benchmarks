const std = @import("std");
pub const c = @cImport({
    @cInclude("sqlite3.h");
});

pub fn main() !void {
    var db: ?*c.sqlite3 = undefined;
    var rc = c.sqlite3_open("mydb.db", &db);
    if (rc > 0) {
        std.debug.print("Can't open database: {}\n", .{rc});
    }

    const query: []const u8 = "SELECT id FROM PLAYER;";

    var stmt: ?*c.sqlite3_stmt = null;

    while (true) {
        rc = c.sqlite3_prepare_v2(db, query.ptr, @intCast(query.len), &stmt, null);

        if (rc != c.SQLITE_OK) {
            std.debug.print("Failed to prepare statement: {}\n", .{rc});
            break;
        }

        while (c.sqlite3_step(stmt) == c.SQLITE_ROW) {
            const id = c.sqlite3_column_int(stmt, 0);
            std.debug.print("ID: {}\n", .{id});
        }

        _ = c.sqlite3_finalize(stmt);
    }
}
