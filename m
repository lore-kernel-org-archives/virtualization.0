From: Isaku Yamahata <yamahata@valinux.co.jp>
Subject: [PATCH 37/50] ia64/pv_ops/xen: multi compile switch_leave.S and ivt.S
	for xen.
Date: Thu,  6 Mar 2008 03:18:52 +0900
Message-ID: <12047411462336-git-send-email-yamahata__5352.71861958808$1204754864$gmane$org@valinux.co.jp>
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
 arch/ia64/kernel/Makefile |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/arch/ia64/kernel/Makefile b/arch/ia64/kernel/Makefile
index 7849bc3..a80dd3f 100644
--- a/arch/ia64/kernel/Makefile
+++ b/arch/ia64/kernel/Makefile
@@ -83,3 +83,18 @@ $(obj)/gate-data.o: $(obj)/gate.so
 #
 AFLAGS_ivt.o += -D__IA64_ASM_PARAVIRTUALIZED_NATIVE
 AFLAGS_switch_leave.o += -D__IA64_ASM_PARAVIRTUALIZED_NATIVE
+
+# xen multi compile
+$(obj)/xen_%.o: $(src)/%.S FORCE
+	$(call if_changed_dep,as_o_S)
+
+#
+# xenivt.o, xen_switch_leave.o
+#
+obj-$(CONFIG_XEN) += xen_ivt.o xen_switch_leave.o
+ifeq ($(CONFIG_XEN), y)
+targets += xen_ivt.o xen_switch_leave.o
+$(obj)/build-in.o: xen_ivt.o xen_switch_leave.o
+endif
+AFLAGS_xen_ivt.o += -D__IA64_ASM_PARAVIRTUALIZED_XEN
+AFLAGS_xen_switch_leave.o += -D__IA64_ASM_PARAVIRTUALIZED_XEN
-- 
1.5.3
