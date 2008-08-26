From: Isaku Yamahata <yamahata@valinux.co.jp>
Subject: [PATCH 02/30] ia64/xen: reserve "break" numbers used for xen
	hypercalls.
Date: Tue, 26 Aug 2008 14:58:14 +0900
Message-ID: <1219730322-11687-3-git-send-email-yamahata__40574.2231094793$1219730499$gmane$org@valinux.co.jp>
References: <1219730322-11687-1-git-send-email-yamahata@valinux.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1219730322-11687-1-git-send-email-yamahata@valinux.co.jp>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: tony.luck@intel.com, linux-ia64@vger.kernel.org
Cc: yamahata@valinux.co.jp, xen-ia64-devel@lists.xensource.com, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

reserve "break" numbers used for xen hypercalls to avoid
reuse for something else.

Cc: "Luck, Tony" <tony.luck@intel.com>
Signed-off-by: Isaku Yamahata <yamahata@valinux.co.jp>
---
 arch/ia64/include/asm/break.h |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/arch/ia64/include/asm/break.h b/arch/ia64/include/asm/break.h
index f034020..e90c40e 100644
--- a/arch/ia64/include/asm/break.h
+++ b/arch/ia64/include/asm/break.h
@@ -20,4 +20,13 @@
  */
 #define __IA64_BREAK_SYSCALL		0x100000
 
+/*
+ * Xen specific break numbers:
+ */
+#define __IA64_XEN_HYPERCALL		0x1000
+/* [__IA64_XEN_HYPERPRIVOP_START, __IA64_XEN_HYPERPRIVOP_MAX] is used
+   for xen hyperprivops */
+#define __IA64_XEN_HYPERPRIVOP_START	0x1
+#define __IA64_XEN_HYPERPRIVOP_MAX	0x1a
+
 #endif /* _ASM_IA64_BREAK_H */
-- 
1.6.0.rc0.42.g186458
