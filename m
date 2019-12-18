From: Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH net-next v3 06/11] VSOCK: add send_byte()/recv_byte() test
 utilities
Date: Wed, 18 Dec 2019 19:07:03 +0100
Message-ID: <20191218180708.120337-7-sgarzare__25156.9868925557$1576692479$gmane$org@redhat.com>
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

From: Stefan Hajnoczi <stefanha@redhat.com>

Test cases will want to transfer data.  This patch adds utility
functions to do this.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
v3:
 * check the byte received in the recv_byte()
 * use send(2)/recv(2) instead of write(2)/read(2) to test also flags
   (e.g. MSG_PEEK)
---
 tools/testing/vsock/util.c | 103 +++++++++++++++++++++++++++++++++++++
 tools/testing/vsock/util.h |   2 +
 2 files changed, 105 insertions(+)

diff --git a/tools/testing/vsock/util.c b/tools/testing/vsock/util.c
index 4280a56ba677..6026ef3ce512 100644
--- a/tools/testing/vsock/util.c
+++ b/tools/testing/vsock/util.c
@@ -9,6 +9,7 @@
 
 #include <errno.h>
 #include <stdio.h>
+#include <stdint.h>
 #include <stdlib.h>
 #include <signal.h>
 #include <unistd.h>
@@ -149,6 +150,108 @@ int vsock_stream_accept(unsigned int cid, unsigned int port,
 	return client_fd;
 }
 
+/* Transmit one byte and check the return value.
+ *
+ * expected_ret:
+ *  <0 Negative errno (for testing errors)
+ *   0 End-of-file
+ *   1 Success
+ */
+void send_byte(int fd, int expected_ret, int flags)
+{
+	const uint8_t byte = 'A';
+	ssize_t nwritten;
+
+	timeout_begin(TIMEOUT);
+	do {
+		nwritten = send(fd, &byte, sizeof(byte), flags);
+		timeout_check("write");
+	} while (nwritten < 0 && errno == EINTR);
+	timeout_end();
+
+	if (expected_ret < 0) {
+		if (nwritten != -1) {
+			fprintf(stderr, "bogus send(2) return value %zd\n",
+				nwritten);
+			exit(EXIT_FAILURE);
+		}
+		if (errno != -expected_ret) {
+			perror("write");
+			exit(EXIT_FAILURE);
+		}
+		return;
+	}
+
+	if (nwritten < 0) {
+		perror("write");
+		exit(EXIT_FAILURE);
+	}
+	if (nwritten == 0) {
+		if (expected_ret == 0)
+			return;
+
+		fprintf(stderr, "unexpected EOF while sending byte\n");
+		exit(EXIT_FAILURE);
+	}
+	if (nwritten != sizeof(byte)) {
+		fprintf(stderr, "bogus send(2) return value %zd\n", nwritten);
+		exit(EXIT_FAILURE);
+	}
+}
+
+/* Receive one byte and check the return value.
+ *
+ * expected_ret:
+ *  <0 Negative errno (for testing errors)
+ *   0 End-of-file
+ *   1 Success
+ */
+void recv_byte(int fd, int expected_ret, int flags)
+{
+	uint8_t byte;
+	ssize_t nread;
+
+	timeout_begin(TIMEOUT);
+	do {
+		nread = recv(fd, &byte, sizeof(byte), flags);
+		timeout_check("read");
+	} while (nread < 0 && errno == EINTR);
+	timeout_end();
+
+	if (expected_ret < 0) {
+		if (nread != -1) {
+			fprintf(stderr, "bogus recv(2) return value %zd\n",
+				nread);
+			exit(EXIT_FAILURE);
+		}
+		if (errno != -expected_ret) {
+			perror("read");
+			exit(EXIT_FAILURE);
+		}
+		return;
+	}
+
+	if (nread < 0) {
+		perror("read");
+		exit(EXIT_FAILURE);
+	}
+	if (nread == 0) {
+		if (expected_ret == 0)
+			return;
+
+		fprintf(stderr, "unexpected EOF while receiving byte\n");
+		exit(EXIT_FAILURE);
+	}
+	if (nread != sizeof(byte)) {
+		fprintf(stderr, "bogus recv(2) return value %zd\n", nread);
+		exit(EXIT_FAILURE);
+	}
+	if (byte != 'A') {
+		fprintf(stderr, "unexpected byte read %c\n", byte);
+		exit(EXIT_FAILURE);
+	}
+}
+
 /* Run test cases.  The program terminates if a failure occurs. */
 void run_tests(const struct test_case *test_cases,
 	       const struct test_opts *opts)
diff --git a/tools/testing/vsock/util.h b/tools/testing/vsock/util.h
index 1786305cfddd..4df12e4b5ebe 100644
--- a/tools/testing/vsock/util.h
+++ b/tools/testing/vsock/util.h
@@ -36,6 +36,8 @@ unsigned int parse_cid(const char *str);
 int vsock_stream_connect(unsigned int cid, unsigned int port);
 int vsock_stream_accept(unsigned int cid, unsigned int port,
 			struct sockaddr_vm *clientaddrp);
+void send_byte(int fd, int expected_ret, int flags);
+void recv_byte(int fd, int expected_ret, int flags);
 void run_tests(const struct test_case *test_cases,
 	       const struct test_opts *opts);
 
-- 
2.24.1
