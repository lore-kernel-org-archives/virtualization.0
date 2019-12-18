From: Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH net-next v3 08/11] vsock_test: wait for the remote to close
 the connection
Date: Wed, 18 Dec 2019 19:07:05 +0100
Message-ID: <20191218180708.120337-9-sgarzare__36370.2845688508$1576692488$gmane$org@redhat.com>
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

Before check if a send returns -EPIPE, we need to make sure the
connection is closed.
To do that, we use epoll API to wait EPOLLRDHUP or EPOLLHUP events
on the socket.

Reported-by: Jorgen Hansen <jhansen@vmware.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
v3:
 - removed unnecessary control_expectln("CLOSED") [Stefan]
---
 tools/testing/vsock/util.c       | 39 ++++++++++++++++++++++++++++++++
 tools/testing/vsock/util.h       |  1 +
 tools/testing/vsock/vsock_test.c | 12 ++++++----
 3 files changed, 48 insertions(+), 4 deletions(-)

diff --git a/tools/testing/vsock/util.c b/tools/testing/vsock/util.c
index 6026ef3ce512..b132c96c87fc 100644
--- a/tools/testing/vsock/util.c
+++ b/tools/testing/vsock/util.c
@@ -13,6 +13,8 @@
 #include <stdlib.h>
 #include <signal.h>
 #include <unistd.h>
+#include <assert.h>
+#include <sys/epoll.h>
 
 #include "timeout.h"
 #include "control.h"
@@ -44,6 +46,43 @@ unsigned int parse_cid(const char *str)
 	return n;
 }
 
+/* Wait for the remote to close the connection */
+void vsock_wait_remote_close(int fd)
+{
+	struct epoll_event ev;
+	int epollfd, nfds;
+
+	epollfd = epoll_create1(0);
+	if (epollfd == -1) {
+		perror("epoll_create1");
+		exit(EXIT_FAILURE);
+	}
+
+	ev.events = EPOLLRDHUP | EPOLLHUP;
+	ev.data.fd = fd;
+	if (epoll_ctl(epollfd, EPOLL_CTL_ADD, fd, &ev) == -1) {
+		perror("epoll_ctl");
+		exit(EXIT_FAILURE);
+	}
+
+	nfds = epoll_wait(epollfd, &ev, 1, TIMEOUT * 1000);
+	if (nfds == -1) {
+		perror("epoll_wait");
+		exit(EXIT_FAILURE);
+	}
+
+	if (nfds == 0) {
+		fprintf(stderr, "epoll_wait timed out\n");
+		exit(EXIT_FAILURE);
+	}
+
+	assert(nfds == 1);
+	assert(ev.events & (EPOLLRDHUP | EPOLLHUP));
+	assert(ev.data.fd == fd);
+
+	close(epollfd);
+}
+
 /* Connect to <cid, port> and return the file descriptor. */
 int vsock_stream_connect(unsigned int cid, unsigned int port)
 {
diff --git a/tools/testing/vsock/util.h b/tools/testing/vsock/util.h
index 4df12e4b5ebe..331e945f3ae6 100644
--- a/tools/testing/vsock/util.h
+++ b/tools/testing/vsock/util.h
@@ -36,6 +36,7 @@ unsigned int parse_cid(const char *str);
 int vsock_stream_connect(unsigned int cid, unsigned int port);
 int vsock_stream_accept(unsigned int cid, unsigned int port,
 			struct sockaddr_vm *clientaddrp);
+void vsock_wait_remote_close(int fd);
 void send_byte(int fd, int expected_ret, int flags);
 void recv_byte(int fd, int expected_ret, int flags);
 void run_tests(const struct test_case *test_cases,
diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
index fae8ddc3ef72..629d7ce58202 100644
--- a/tools/testing/vsock/vsock_test.c
+++ b/tools/testing/vsock/vsock_test.c
@@ -66,7 +66,6 @@ static void test_stream_client_close_client(const struct test_opts *opts)
 
 	send_byte(fd, 1, 0);
 	close(fd);
-	control_writeln("CLOSED");
 }
 
 static void test_stream_client_close_server(const struct test_opts *opts)
@@ -79,7 +78,10 @@ static void test_stream_client_close_server(const struct test_opts *opts)
 		exit(EXIT_FAILURE);
 	}
 
-	control_expectln("CLOSED");
+	/* Wait for the remote to close the connection, before check
+	 * -EPIPE error on send.
+	 */
+	vsock_wait_remote_close(fd);
 
 	send_byte(fd, -EPIPE, 0);
 	recv_byte(fd, 1, 0);
@@ -97,7 +99,10 @@ static void test_stream_server_close_client(const struct test_opts *opts)
 		exit(EXIT_FAILURE);
 	}
 
-	control_expectln("CLOSED");
+	/* Wait for the remote to close the connection, before check
+	 * -EPIPE error on send.
+	 */
+	vsock_wait_remote_close(fd);
 
 	send_byte(fd, -EPIPE, 0);
 	recv_byte(fd, 1, 0);
@@ -117,7 +122,6 @@ static void test_stream_server_close_server(const struct test_opts *opts)
 
 	send_byte(fd, 1, 0);
 	close(fd);
-	control_writeln("CLOSED");
 }
 
 /* With the standard socket sizes, VMCI is able to support about 100
-- 
2.24.1
