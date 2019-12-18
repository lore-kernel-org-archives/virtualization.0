From: Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH net-next v3 09/11] testing/vsock: add parameters to list and
 skip tests
Date: Wed, 18 Dec 2019 19:07:06 +0100
Message-ID: <20191218180708.120337-10-sgarzare@redhat.com>
References: <20191218180708.120337-1-sgarzare@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20191218180708.120337-1-sgarzare@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: davem@davemloft.net
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org, Dexuan Cui <decui@microsoft.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Stefan Hajnoczi <stefanha@redhat.com>, Jorgen Hansen <jhansen@vmware.com>
List-Id: virtualization@lists.linuxfoundation.org

Some tests can fail with transports that have a slightly
different behavior, so let's add the possibility to specify
which tests to skip.

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 tools/testing/vsock/control.c         | 15 +++++-
 tools/testing/vsock/control.h         |  1 +
 tools/testing/vsock/util.c            | 76 +++++++++++++++++++++------
 tools/testing/vsock/util.h            |  6 ++-
 tools/testing/vsock/vsock_diag_test.c | 19 ++++++-
 tools/testing/vsock/vsock_test.c      | 20 ++++++-
 6 files changed, 117 insertions(+), 20 deletions(-)

diff --git a/tools/testing/vsock/control.c b/tools/testing/vsock/control.c
index 45f328c6ff23..4874872fc5a3 100644
--- a/tools/testing/vsock/control.c
+++ b/tools/testing/vsock/control.c
@@ -205,11 +205,22 @@ void control_expectln(const char *str)
 	char *line;
 
 	line = control_readln();
-	if (strcmp(str, line) != 0) {
+
+	control_cmpln(line, str, true);
+
+	free(line);
+}
+
+bool control_cmpln(char *line, const char *str, bool fail)
+{
+	if (strcmp(str, line) == 0)
+		return true;
+
+	if (fail) {
 		fprintf(stderr, "expected \"%s\" on control socket, got \"%s\"\n",
 			str, line);
 		exit(EXIT_FAILURE);
 	}
 
-	free(line);
+	return false;
 }
diff --git a/tools/testing/vsock/control.h b/tools/testing/vsock/control.h
index dac3964a891d..51814b4f9ac1 100644
--- a/tools/testing/vsock/control.h
+++ b/tools/testing/vsock/control.h
@@ -10,5 +10,6 @@ void control_cleanup(void);
 void control_writeln(const char *str);
 char *control_readln(void);
 void control_expectln(const char *str);
+bool control_cmpln(char *line, const char *str, bool fail);
 
 #endif /* CONTROL_H */
diff --git a/tools/testing/vsock/util.c b/tools/testing/vsock/util.c
index b132c96c87fc..b290fa78405f 100644
--- a/tools/testing/vsock/util.c
+++ b/tools/testing/vsock/util.c
@@ -299,32 +299,78 @@ void run_tests(const struct test_case *test_cases,
 
 	for (i = 0; test_cases[i].name; i++) {
 		void (*run)(const struct test_opts *opts);
+		char *line;
 
-		printf("%s...", test_cases[i].name);
+		printf("%d - %s...", i, test_cases[i].name);
 		fflush(stdout);
 
-		if (opts->mode == TEST_MODE_CLIENT) {
-			/* Full barrier before executing the next test.  This
-			 * ensures that client and server are executing the
-			 * same test case.  In particular, it means whoever is
-			 * faster will not see the peer still executing the
-			 * last test.  This is important because port numbers
-			 * can be used by multiple test cases.
-			 */
-			control_expectln("NEXT");
+		/* Full barrier before executing the next test.  This
+		 * ensures that client and server are executing the
+		 * same test case.  In particular, it means whoever is
+		 * faster will not see the peer still executing the
+		 * last test.  This is important because port numbers
+		 * can be used by multiple test cases.
+		 */
+		if (test_cases[i].skip)
+			control_writeln("SKIP");
+		else
 			control_writeln("NEXT");
 
-			run = test_cases[i].run_client;
-		} else {
-			control_writeln("NEXT");
-			control_expectln("NEXT");
+		line = control_readln();
+		if (control_cmpln(line, "SKIP", false) || test_cases[i].skip) {
 
-			run = test_cases[i].run_server;
+			printf("skipped\n");
+
+			free(line);
+			continue;
 		}
 
+		control_cmpln(line, "NEXT", true);
+		free(line);
+
+		if (opts->mode == TEST_MODE_CLIENT)
+			run = test_cases[i].run_client;
+		else
+			run = test_cases[i].run_server;
+
 		if (run)
 			run(opts);
 
 		printf("ok\n");
 	}
 }
+
+void list_tests(const struct test_case *test_cases)
+{
+	int i;
+
+	printf("ID\tTest name\n");
+
+	for (i = 0; test_cases[i].name; i++)
+		printf("%d\t%s\n", i, test_cases[i].name);
+
+	exit(EXIT_FAILURE);
+}
+
+void skip_test(struct test_case *test_cases, size_t test_cases_len,
+	       const char *test_id_str)
+{
+	unsigned long test_id;
+	char *endptr = NULL;
+
+	errno = 0;
+	test_id = strtoul(test_id_str, &endptr, 10);
+	if (errno || *endptr != '\0') {
+		fprintf(stderr, "malformed test ID \"%s\"\n", test_id_str);
+		exit(EXIT_FAILURE);
+	}
+
+	if (test_id >= test_cases_len) {
+		fprintf(stderr, "test ID (%lu) larger than the max allowed (%lu)\n",
+			test_id, test_cases_len - 1);
+		exit(EXIT_FAILURE);
+	}
+
+	test_cases[test_id].skip = true;
+}
+
diff --git a/tools/testing/vsock/util.h b/tools/testing/vsock/util.h
index 331e945f3ae6..e53dd09d26d9 100644
--- a/tools/testing/vsock/util.h
+++ b/tools/testing/vsock/util.h
@@ -29,6 +29,8 @@ struct test_case {
 
 	/* Called when test mode is TEST_MODE_SERVER */
 	void (*run_server)(const struct test_opts *opts);
+
+	bool skip;
 };
 
 void init_signals(void);
@@ -41,5 +43,7 @@ void send_byte(int fd, int expected_ret, int flags);
 void recv_byte(int fd, int expected_ret, int flags);
 void run_tests(const struct test_case *test_cases,
 	       const struct test_opts *opts);
-
+void list_tests(const struct test_case *test_cases);
+void skip_test(struct test_case *test_cases, size_t test_cases_len,
+	       const char *test_id_str);
 #endif /* UTIL_H */
diff --git a/tools/testing/vsock/vsock_diag_test.c b/tools/testing/vsock/vsock_diag_test.c
index abd7dc2a9631..b82483627259 100644
--- a/tools/testing/vsock/vsock_diag_test.c
+++ b/tools/testing/vsock/vsock_diag_test.c
@@ -463,6 +463,16 @@ static const struct option longopts[] = {
 		.has_arg = required_argument,
 		.val = 'p',
 	},
+	{
+		.name = "list",
+		.has_arg = no_argument,
+		.val = 'l',
+	},
+	{
+		.name = "skip",
+		.has_arg = required_argument,
+		.val = 's',
+	},
 	{
 		.name = "help",
 		.has_arg = no_argument,
@@ -473,7 +483,7 @@ static const struct option longopts[] = {
 
 static void usage(void)
 {
-	fprintf(stderr, "Usage: vsock_diag_test [--help] [--control-host=<host>] --control-port=<port> --mode=client|server --peer-cid=<cid>\n"
+	fprintf(stderr, "Usage: vsock_diag_test [--help] [--control-host=<host>] --control-port=<port> --mode=client|server --peer-cid=<cid> [--list] [--skip=<test_id>]\n"
 		"\n"
 		"  Server: vsock_diag_test --control-port=1234 --mode=server --peer-cid=3\n"
 		"  Client: vsock_diag_test --control-host=192.168.0.1 --control-port=1234 --mode=client --peer-cid=2\n"
@@ -528,6 +538,13 @@ int main(int argc, char **argv)
 		case 'P':
 			control_port = optarg;
 			break;
+		case 'l':
+			list_tests(test_cases);
+			break;
+		case 's':
+			skip_test(test_cases, ARRAY_SIZE(test_cases) - 1,
+				  optarg);
+			break;
 		case '?':
 		default:
 			usage();
diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
index 629d7ce58202..3ac56651f3f9 100644
--- a/tools/testing/vsock/vsock_test.c
+++ b/tools/testing/vsock/vsock_test.c
@@ -13,6 +13,7 @@
 #include <string.h>
 #include <errno.h>
 #include <unistd.h>
+#include <linux/kernel.h>
 
 #include "timeout.h"
 #include "control.h"
@@ -222,6 +223,16 @@ static const struct option longopts[] = {
 		.has_arg = required_argument,
 		.val = 'p',
 	},
+	{
+		.name = "list",
+		.has_arg = no_argument,
+		.val = 'l',
+	},
+	{
+		.name = "skip",
+		.has_arg = required_argument,
+		.val = 's',
+	},
 	{
 		.name = "help",
 		.has_arg = no_argument,
@@ -232,7 +243,7 @@ static const struct option longopts[] = {
 
 static void usage(void)
 {
-	fprintf(stderr, "Usage: vsock_test [--help] [--control-host=<host>] --control-port=<port> --mode=client|server --peer-cid=<cid>\n"
+	fprintf(stderr, "Usage: vsock_test [--help] [--control-host=<host>] --control-port=<port> --mode=client|server --peer-cid=<cid> [--list] [--skip=<test_id>]\n"
 		"\n"
 		"  Server: vsock_test --control-port=1234 --mode=server --peer-cid=3\n"
 		"  Client: vsock_test --control-host=192.168.0.1 --control-port=1234 --mode=client --peer-cid=2\n"
@@ -287,6 +298,13 @@ int main(int argc, char **argv)
 		case 'P':
 			control_port = optarg;
 			break;
+		case 'l':
+			list_tests(test_cases);
+			break;
+		case 's':
+			skip_test(test_cases, ARRAY_SIZE(test_cases) - 1,
+				  optarg);
+			break;
 		case '?':
 		default:
 			usage();
-- 
2.24.1
