From: Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH v2 09/11] vsock_test: add --transport parameter
Date: Thu,  1 Aug 2019 17:25:39 +0200
Message-ID: <20190801152541.245833-10-sgarzare__4728.03422469355$1564673283$gmane$org@redhat.com>
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

Add new --transport parameter to skip some tests or checks
not supported by a specific transport.

Suggested-by: Jorgen Hansen <jhansen@vmware.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 tools/testing/vsock/util.h       |  8 ++++++++
 tools/testing/vsock/vsock_test.c | 20 +++++++++++++++++++-
 2 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/tools/testing/vsock/util.h b/tools/testing/vsock/util.h
index 379e02ab59bb..7fdb8100f035 100644
--- a/tools/testing/vsock/util.h
+++ b/tools/testing/vsock/util.h
@@ -12,9 +12,17 @@ enum test_mode {
 	TEST_MODE_SERVER
 };
 
+enum test_transport {
+	TEST_TRANSPORT_UNSET,
+	TEST_TRANSPORT_VMCI,
+	TEST_TRANSPORT_VIRTIO,
+	TEST_TRANSPORT_HYPERV
+};
+
 /* Test runner options */
 struct test_opts {
 	enum test_mode mode;
+	enum test_transport transport;
 	unsigned int peer_cid;
 };
 
diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
index 06099d037405..cb606091489f 100644
--- a/tools/testing/vsock/vsock_test.c
+++ b/tools/testing/vsock/vsock_test.c
@@ -218,6 +218,11 @@ static const struct option longopts[] = {
 		.has_arg = required_argument,
 		.val = 'p',
 	},
+	{
+		.name = "transport",
+		.has_arg = required_argument,
+		.val = 't',
+	},
 	{
 		.name = "help",
 		.has_arg = no_argument,
@@ -228,7 +233,7 @@ static const struct option longopts[] = {
 
 static void usage(void)
 {
-	fprintf(stderr, "Usage: vsock_test [--help] [--control-host=<host>] --control-port=<port> --mode=client|server --peer-cid=<cid>\n"
+	fprintf(stderr, "Usage: vsock_test [--help] [--control-host=<host>] --control-port=<port> --mode=client|server --peer-cid=<cid> [--transport=vmci|virtio|hyperv]\n"
 		"\n"
 		"  Server: vsock_test --control-port=1234 --mode=server --peer-cid=3\n"
 		"  Client: vsock_test --control-host=192.168.0.1 --control-port=1234 --mode=client --peer-cid=2\n"
@@ -252,6 +257,7 @@ int main(int argc, char **argv)
 	const char *control_port = NULL;
 	struct test_opts opts = {
 		.mode = TEST_MODE_UNSET,
+		.transport = TEST_TRANSPORT_UNSET,
 		.peer_cid = VMADDR_CID_ANY,
 	};
 
@@ -283,6 +289,18 @@ int main(int argc, char **argv)
 		case 'P':
 			control_port = optarg;
 			break;
+		case 't':
+			if (strcmp(optarg, "vmci") == 0)
+				opts.transport = TEST_TRANSPORT_VMCI;
+			else if (strcmp(optarg, "virtio") == 0)
+				opts.transport = TEST_TRANSPORT_VIRTIO;
+			else if (strcmp(optarg, "hyperv") == 0)
+				opts.transport = TEST_TRANSPORT_HYPERV;
+			else {
+				fprintf(stderr, "--transport must be \"vmci\" or \"virtio\" or \"hyperv\"\n");
+				return EXIT_FAILURE;
+			}
+			break;
 		case '?':
 		default:
 			usage();
-- 
2.20.1
