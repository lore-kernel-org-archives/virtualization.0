From: Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH net-next v3 05/11] VSOCK: add full barrier between test cases
Date: Wed, 18 Dec 2019 19:07:02 +0100
Message-ID: <20191218180708.120337-6-sgarzare__23510.4080451251$1576692480$gmane$org@redhat.com>
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

See code comment for details.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 tools/testing/vsock/util.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/tools/testing/vsock/util.c b/tools/testing/vsock/util.c
index f838bcee3589..4280a56ba677 100644
--- a/tools/testing/vsock/util.c
+++ b/tools/testing/vsock/util.c
@@ -161,10 +161,24 @@ void run_tests(const struct test_case *test_cases,
 		printf("%s...", test_cases[i].name);
 		fflush(stdout);
 
-		if (opts->mode == TEST_MODE_CLIENT)
+		if (opts->mode == TEST_MODE_CLIENT) {
+			/* Full barrier before executing the next test.  This
+			 * ensures that client and server are executing the
+			 * same test case.  In particular, it means whoever is
+			 * faster will not see the peer still executing the
+			 * last test.  This is important because port numbers
+			 * can be used by multiple test cases.
+			 */
+			control_expectln("NEXT");
+			control_writeln("NEXT");
+
 			run = test_cases[i].run_client;
-		else
+		} else {
+			control_writeln("NEXT");
+			control_expectln("NEXT");
+
 			run = test_cases[i].run_server;
+		}
 
 		if (run)
 			run(opts);
-- 
2.24.1
