const std = @import("std");

const sqlite = @import("sqlite");
const httpz = @import("httpz");

const App = struct {
    db: *sqlite.Db,
};

pub fn main() !void {
    const allocator = std.heap.page_allocator;

    var sqldb = try sqlite.Db.init(.{
        .mode = sqlite.Db.Mode{ .File = "mydb.db" },
        .open_flags = .{
            .write = true,
            .create = true,
        },
        .threading_mode = .Serialized, // I cant use multi thread because the HTTP server is already multi-threaded under the hood, making one thread managing multiple connections thus not allowing sqlite MultiThread
    });

    var app = App{ .db = &sqldb };

    // Server config
    var server = try httpz.ServerApp(*App).init(allocator, .{ .port = 1950 }, &app);

    var router = server.router();

    router.get("/", getUser);

    try server.listen();
}

fn getUser(app: *App, req: *httpz.Request, res: *httpz.Response) !void {
    // Simulate work
    const query =
        \\ select id from player
    ;
    var stmt = try app.db.prepare(query);
    defer stmt.deinit();

    _ = try stmt.all(usize, req.arena, .{}, .{});
    try res.json(.{"bonjour"}, .{});
}
