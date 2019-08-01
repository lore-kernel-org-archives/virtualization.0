From: Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH v2 01/11] VSOCK: fix header include in vsock_diag_test
Date: Thu,  1 Aug 2019 17:25:31 +0200
Message-ID: <20190801152541.245833-2-sgarzare__32474.5878855296$1564673203$gmane$org@redhat.com>
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

From: Stefan Hajnoczi <stefanha@redhat.com>

The vsock_diag_test program directly included ../../../include/uapi/
headers from the source tree.  Tests are supposed to use the
usr/include/linux/ headers that have been prepared with make
headers_install instead.

Suggested-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 tools/testing/vsock/Makefile          | 2 +-
 tools/testing/vsock/README            | 2 +-
 tools/testing/vsock/vsock_diag_test.c | 5 ++---
 3 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/tools/testing/vsock/Makefile b/tools/testing/vsock/Makefile
index 5be687b1e16c..d41a4e13960a 100644
--- a/tools/testing/vsock/Makefile
+++ b/tools/testing/vsock/Makefile
@@ -3,7 +3,7 @@ all: test
 test: vsock_diag_test
 vsock_diag_test: vsock_diag_test.o timeout.o control.o
 
-CFLAGS += -g -O2 -Werror -Wall -I. -I../../include/uapi -I../../include -Wno-pointer-sign -fno-strict-overflow -fno-strict-aliasing -fno-common -MMD -U_FORTIFY_SOURCE -D_GNU_SOURCE
+CFLAGS += -g -O2 -Werror -Wall -I. -I../../include -I../../../usr/include -Wno-pointer-sign -fno-strict-overflow -fno-strict-aliasing -fno-common -MMD -U_FORTIFY_SOURCE -D_GNU_SOURCE
 .PHONY: all test clean
 clean:
 	${RM} *.o *.d vsock_diag_test
diff --git a/tools/testing/vsock/README b/tools/testing/vsock/README
index 2cc6d7302db6..cf7dc64273bf 100644
--- a/tools/testing/vsock/README
+++ b/tools/testing/vsock/README
@@ -10,7 +10,7 @@ The following tests are available:
 The following prerequisite steps are not automated and must be performed prior
 to running tests:
 
-1. Build the kernel and these tests.
+1. Build the kernel, make headers_install, and build these tests.
 2. Install the kernel and tests on the host.
 3. Install the kernel and tests inside the guest.
 4. Boot the guest and ensure that the AF_VSOCK transport is enabled.
diff --git a/tools/testing/vsock/vsock_diag_test.c b/tools/testing/vsock/vsock_diag_test.c
index c481101364a4..fc391e041954 100644
--- a/tools/testing/vsock/vsock_diag_test.c
+++ b/tools/testing/vsock/vsock_diag_test.c
@@ -21,12 +21,11 @@
 #include <linux/list.h>
 #include <linux/net.h>
 #include <linux/netlink.h>
+#include <linux/vm_sockets.h>
 #include <linux/sock_diag.h>
+#include <linux/vm_sockets_diag.h>
 #include <netinet/tcp.h>
 
-#include "../../../include/uapi/linux/vm_sockets.h"
-#include "../../../include/uapi/linux/vm_sockets_diag.h"
-
 #include "timeout.h"
 #include "control.h"
 
-- 
2.20.1
