From: Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH v2 08/11] VSOCK: add vsock_get_local_cid() test utility
Date: Thu,  1 Aug 2019 17:25:38 +0200
Message-ID: <20190801152541.245833-9-sgarzare__44656.7013439321$1564673273$gmane$org@redhat.com>
References: <20190801152541.245833-1-sgarzare@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190801152541.245833-1-sgarzare@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: netdev@vger.kernel.org
Cc: kvm@vger.kernel.org, Dexuan Cui <decui@microsoft.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Stefan Hajnoczi <stefanha@redhat.com>, "David S. Miller" <davem@davemloft.net>, Jorgen Hansen <jhansen@vmware.com>
List-Id: virtualization@lists.linuxfoundation.org

This patch adds utility to get local CID, useful to
understand if we are in the host or guest.

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 tools/testing/vsock/util.c | 17 +++++++++++++++++
 tools/testing/vsock/util.h |  1 +
 2 files changed, 18 insertions(+)

diff --git a/tools/testing/vsock/util.c b/tools/testing/vsock/util.c
index d46a6e079b96..41b94495ecb1 100644
--- a/tools/testing/vsock/util.c
+++ b/tools/testing/vsock/util.c
@@ -13,6 +13,7 @@
 #include <stdlib.h>
 #include <signal.h>
 #include <unistd.h>
+#include <assert.h>
 
 #include "timeout.h"
 #include "control.h"
@@ -44,6 +45,22 @@ unsigned int parse_cid(const char *str)
 	return n;
 }
 
+/* Get the local CID */
+unsigned int vsock_get_local_cid(int fd)
+{
+	struct sockaddr_vm svm;
+	socklen_t svm_len = sizeof(svm);
+
+	if (getsockname(fd, (struct sockaddr *) &svm, &svm_len)) {
+		perror("getsockname");
+		exit(EXIT_FAILURE);
+	}
+
+	assert(svm.svm_family == AF_VSOCK);
+
+	return svm.svm_cid;
+}
+
 /* Connect to <cid, port> and return the file descriptor. */
 int vsock_stream_connect(unsigned int cid, unsigned int port)
 {
diff --git a/tools/testing/vsock/util.h b/tools/testing/vsock/util.h
index fe524d393d67..379e02ab59bb 100644
--- a/tools/testing/vsock/util.h
+++ b/tools/testing/vsock/util.h
@@ -36,6 +36,7 @@ unsigned int parse_cid(const char *str);
 int vsock_stream_connect(unsigned int cid, unsigned int port);
 int vsock_stream_accept(unsigned int cid, unsigned int port,
 			struct sockaddr_vm *clientaddrp);
+unsigned int vsock_get_local_cid(int fd);
 void send_byte(int fd, int expected_ret);
 void recv_byte(int fd, int expected_ret);
 void run_tests(const struct test_case *test_cases,
-- 
2.20.1
