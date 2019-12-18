From: Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH net-next v3 10/11] testing/vsock: print list of options and
 description
Date: Wed, 18 Dec 2019 19:07:07 +0100
Message-ID: <20191218180708.120337-11-sgarzare__16210.8138481685$1576692496$gmane$org@redhat.com>
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

Since we now have several options, in the help we print the list
of all supported options and a brief description of them.

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 tools/testing/vsock/vsock_diag_test.c | 13 ++++++++++++-
 tools/testing/vsock/vsock_test.c      | 13 ++++++++++++-
 2 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/tools/testing/vsock/vsock_diag_test.c b/tools/testing/vsock/vsock_diag_test.c
index b82483627259..cec6f5a738e1 100644
--- a/tools/testing/vsock/vsock_diag_test.c
+++ b/tools/testing/vsock/vsock_diag_test.c
@@ -497,7 +497,18 @@ static void usage(void)
 		"listen address and the client requires an address to\n"
 		"connect to.\n"
 		"\n"
-		"The CID of the other side must be given with --peer-cid=<cid>.\n");
+		"The CID of the other side must be given with --peer-cid=<cid>.\n"
+		"\n"
+		"Options:\n"
+		"  --help                 This help message\n"
+		"  --control-host <host>  Server IP address to connect to\n"
+		"  --control-port <port>  Server port to listen on/connect to\n"
+		"  --mode client|server   Server or client mode\n"
+		"  --peer-cid <cid>       CID of the other side\n"
+		"  --list                 List of tests that will be executed\n"
+		"  --skip <test_id>       Test ID to skip;\n"
+		"                         use multiple --skip options to skip more tests\n"
+		);
 	exit(EXIT_FAILURE);
 }
 
diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
index 3ac56651f3f9..a63e05d6a0f9 100644
--- a/tools/testing/vsock/vsock_test.c
+++ b/tools/testing/vsock/vsock_test.c
@@ -257,7 +257,18 @@ static void usage(void)
 		"listen address and the client requires an address to\n"
 		"connect to.\n"
 		"\n"
-		"The CID of the other side must be given with --peer-cid=<cid>.\n");
+		"The CID of the other side must be given with --peer-cid=<cid>.\n"
+		"\n"
+		"Options:\n"
+		"  --help                 This help message\n"
+		"  --control-host <host>  Server IP address to connect to\n"
+		"  --control-port <port>  Server port to listen on/connect to\n"
+		"  --mode client|server   Server or client mode\n"
+		"  --peer-cid <cid>       CID of the other side\n"
+		"  --list                 List of tests that will be executed\n"
+		"  --skip <test_id>       Test ID to skip;\n"
+		"                         use multiple --skip options to skip more tests\n"
+		);
 	exit(EXIT_FAILURE);
 }
 
-- 
2.24.1
