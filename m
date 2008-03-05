From: Isaku Yamahata <yamahata@valinux.co.jp>
Subject: [PATCH 02/50] xen: add missing VIRQ_ARCH_[0-7] definitions which
	ia64/xen needs.
Date: Thu,  6 Mar 2008 03:18:17 +0900
Message-ID: <1204741145564-git-send-email-yamahata__24512.6365255148$1204741678$gmane$org@valinux.co.jp>
References: <12047411453864-git-send-email-yamahata@valinux.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <12047411453864-git-send-email-yamahata@valinux.co.jp>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-ia64@vger.kernel.org
Cc: yamahata@valinux.co.jp, virtualization@lists.linux-foundation.org, kvm-ia64-devel@lists.sourceforge.net, xen-ia64-devel@lists.xensource.com
List-Id: virtualization@lists.linuxfoundation.org

Signed-off-by: Isaku Yamahata <yamahata@valinux.co.jp>
---
 include/xen/interface/xen.h |   12 +++++++++++-
 1 files changed, 11 insertions(+), 1 deletions(-)

diff --git a/include/xen/interface/xen.h b/include/xen/interface/xen.h
index 87ad143..9b018da 100644
--- a/include/xen/interface/xen.h
+++ b/include/xen/interface/xen.h
@@ -78,8 +78,18 @@
 #define VIRQ_CONSOLE    2  /* (DOM0) Bytes received on emergency console. */
 #define VIRQ_DOM_EXC    3  /* (DOM0) Exceptional event for some domain.   */
 #define VIRQ_DEBUGGER   6  /* (DOM0) A domain has paused for debugging.   */
-#define NR_VIRQS        8
 
+/* Architecture-specific VIRQ definitions. */
+#define VIRQ_ARCH_0    16
+#define VIRQ_ARCH_1    17
+#define VIRQ_ARCH_2    18
+#define VIRQ_ARCH_3    19
+#define VIRQ_ARCH_4    20
+#define VIRQ_ARCH_5    21
+#define VIRQ_ARCH_6    22
+#define VIRQ_ARCH_7    23
+
+#define NR_VIRQS       24
 /*
  * MMU-UPDATE REQUESTS
  *
-- 
1.5.3
