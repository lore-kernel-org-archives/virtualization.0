From: Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH v2 10/11] vsock_test: skip read() in test_stream*close tests
	on a VMCI host
Date: Thu,  1 Aug 2019 17:25:40 +0200
Message-ID: <20190801152541.245833-11-sgarzare__44707.7553298854$1564673295$gmane$org@redhat.com>
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

When VMCI transport is used, if the guest closes a connection,
all data is gone and EOF is returned, so we should skip the read
of data written by the peer before closing the connection.

Reported-by: Jorgen Hansen <jhansen@vmware.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 tools/testing/vsock/vsock_test.c | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
index cb606091489f..64adf45501ca 100644
--- a/tools/testing/vsock/vsock_test.c
+++ b/tools/testing/vsock/vsock_test.c
@@ -71,6 +71,7 @@ static void test_stream_client_close_client(const struct test_opts *opts)
 
 static void test_stream_client_close_server(const struct test_opts *opts)
 {
+	unsigned int local_cid;
 	int fd;
 
 	fd = vsock_stream_accept(VMADDR_CID_ANY, 1234, NULL);
@@ -79,16 +80,27 @@ static void test_stream_client_close_server(const struct test_opts *opts)
 		exit(EXIT_FAILURE);
 	}
 
+	local_cid = vsock_get_local_cid(fd);
+
 	control_expectln("CLOSED");
 
 	send_byte(fd, -EPIPE);
-	recv_byte(fd, 1);
+
+	/* Skip the read of data wrote by the peer if we are on VMCI and
+	 * we are on the host side, because when the guest closes a
+	 * connection, all data is gone and EOF is returned.
+	 */
+	if (!(opts->transport == TEST_TRANSPORT_VMCI &&
+	    local_cid == VMADDR_CID_HOST))
+		recv_byte(fd, 1);
+
 	recv_byte(fd, 0);
 	close(fd);
 }
 
 static void test_stream_server_close_client(const struct test_opts *opts)
 {
+	unsigned int local_cid;
 	int fd;
 
 	fd = vsock_stream_connect(opts->peer_cid, 1234);
@@ -97,10 +109,20 @@ static void test_stream_server_close_client(const struct test_opts *opts)
 		exit(EXIT_FAILURE);
 	}
 
+	local_cid = vsock_get_local_cid(fd);
+
 	control_expectln("CLOSED");
 
 	send_byte(fd, -EPIPE);
-	recv_byte(fd, 1);
+
+	/* Skip the read of data wrote by the peer if we are on VMCI and
+	 * we are on the host side, because when the guest closes a
+	 * connection, all data is gone and EOF is returned.
+	 */
+	if (!(opts->transport == TEST_TRANSPORT_VMCI &&
+	    local_cid == VMADDR_CID_HOST))
+		recv_byte(fd, 1);
+
 	recv_byte(fd, 0);
 	close(fd);
 }
-- 
2.20.1
