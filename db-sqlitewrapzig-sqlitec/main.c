#include <signal.h>
#include <sqlite3.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/time.h>

sqlite3 *db;
long long begin = 0;
long long count = 0;

void signal_handler(int signum) {
  struct timeval end_time;
  gettimeofday(&end_time, NULL);

  long long elapsed =
      (end_time.tv_sec * 1000LL + end_time.tv_usec / 1000) - begin;

  printf("Received SIGINT\n");
  printf("Elapsed Time: %lld ms\n", elapsed);
  printf("Queries Executed: %lld\n", count);
  printf("Queries per Second: %lld\n", (count * 1000) / elapsed);

  if (db)
    sqlite3_close(db);
  exit(0);
}

int main() {
  struct timeval start_time;
  gettimeofday(&start_time, NULL);
  begin = start_time.tv_sec * 1000LL + start_time.tv_usec / 1000;

  // Register the signal handler for SIGINT
  signal(SIGINT, signal_handler);

  int rc = sqlite3_open("mydb.db", &db);
  if (rc) {
    fprintf(stderr, "Can't open database: %s\n", sqlite3_errmsg(db));
    return 1;
  }

  const char *sql = "SELECT id FROM player";
  sqlite3_stmt *stmt;

  while (1) {
    rc = sqlite3_prepare_v2(db, sql, -1, &stmt, NULL);
    if (rc != SQLITE_OK) {
      fprintf(stderr, "Failed to execute query: %s\n", sqlite3_errmsg(db));
      break;
    }

    while (sqlite3_step(stmt) == SQLITE_ROW) {
      // Access column data here if needed
      int id = sqlite3_column_int(stmt, 0); // 0 is the index of the column 'id'
    }

    sqlite3_finalize(stmt);
    count++;
  }

  sqlite3_close(db);
  return 0;
}
