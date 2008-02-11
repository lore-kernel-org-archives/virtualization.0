From: Glauber Costa <gcosta@redhat.com>
Subject: [PATCH 4/5] [PATCH] introduce paravirt helpers
Date: Mon, 11 Feb 2008 17:16:04 -0200
Message-ID: <1202757365-18634-4-git-send-email-gcosta__23802.0607423552$1202770763$gmane$org@redhat.com>
References: <1202757365-18634-1-git-send-email-gcosta@redhat.com>
	<1202757365-18634-2-git-send-email-gcosta@redhat.com>
	<1202757365-18634-3-git-send-email-gcosta@redhat.com>
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1202757365-18634-3-git-send-email-gcosta@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org
Cc: ehabkost@redhat.com, shai@scalemp.com, ak@suse.de, virtualization@lists.linux-foundation.org, chrisw@sous-sol.org, tglx@linutronix.de, kiran@scalemp.com, anthony@codemonkey.ws, akpm@linux-foundation.org, Glauber Costa <gcosta@redhat.com>, mingo@elte.hu
List-Id: virtualization@lists.linuxfoundation.org

Signed-off-by: Glauber Costa <gcosta@redhat.com>
Signed-off-by: Ravikiran Thirumalai <kiran@scalemp.com>
Acked-by: Shai Fultheim <shai@scalemp.com>
---
 arch/x86/Kconfig          |    3 ++
 arch/x86/kernel/vsmp_64.c |   56 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 58 insertions(+), 1 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 9d0aced..0c4134b 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -323,7 +323,8 @@ config X86_RDC321X
 config X86_VSMP
 	bool "Support for ScaleMP vSMP"
 	depends on X86_64 && PCI
-	 help
+	select PARAVIRT
+	help
 	  Support for ScaleMP vSMP systems.  Say 'Y' here if this kernel is
 	  supposed to run on these EM64T-based machines.  Only choose this option
 	  if you have one of these machines.
diff --git a/arch/x86/kernel/vsmp_64.c b/arch/x86/kernel/vsmp_64.c
index fdf9fba..b93ed66 100644
--- a/arch/x86/kernel/vsmp_64.c
+++ b/arch/x86/kernel/vsmp_64.c
@@ -8,6 +8,8 @@
  *
  * Ravikiran Thirumalai <kiran@scalemp.com>,
  * Shai Fultheim <shai@scalemp.com>
+ * Paravirt ops integration: Glauber de Oliveira Costa <gcosta@redhat.com>,
+ *			     Ravikiran Thirumalai <kiran@scalemp.com>
  */
 
 #include <linux/init.h>
@@ -15,6 +17,60 @@ #include <linux/pci_ids.h>
 #include <linux/pci_regs.h>
 #include <asm/pci-direct.h>
 #include <asm/io.h>
+#include <asm/paravirt.h>
+
+/*
+ * Interrupt control on vSMPowered systems:
+ * ~AC is a shadow of IF.  If IF is 'on' AC should be 'off'
+ * and vice versa.
+ */
+
+static unsigned long vsmp_save_fl(void)
+{
+	unsigned long flags = native_save_fl();
+
+	if (!(flags & X86_EFLAGS_IF) || (flags & X86_EFLAGS_AC))
+		flags &= ~X86_EFLAGS_IF;
+	return flags;
+}
+
+static void vsmp_restore_fl(unsigned long flags)
+{
+	if (flags & X86_EFLAGS_IF)
+		flags &= ~X86_EFLAGS_AC;
+	else
+		flags |= X86_EFLAGS_AC;
+	native_restore_fl(flags);
+}
+
+static void vsmp_irq_disable(void)
+{
+	unsigned long flags = native_save_fl();
+
+	native_restore_fl((flags & ~X86_EFLAGS_IF) | X86_EFLAGS_AC);
+}
+
+static void vsmp_irq_enable(void)
+{
+	unsigned long flags = native_save_fl();
+
+	native_restore_fl((flags | X86_EFLAGS_IF) & (~X86_EFLAGS_AC));
+}
+
+static unsigned __init vsmp_patch(u8 type, u16 clobbers, void *ibuf,
+				  unsigned long addr, unsigned len)
+{
+	switch (type) {
+	case PARAVIRT_PATCH(pv_irq_ops.irq_enable):
+	case PARAVIRT_PATCH(pv_irq_ops.irq_disable):
+	case PARAVIRT_PATCH(pv_irq_ops.save_fl):
+	case PARAVIRT_PATCH(pv_irq_ops.restore_fl):
+		return paravirt_patch_default(type, clobbers, ibuf, addr, len);
+	default:
+		return native_patch(type, clobbers, ibuf, addr, len);
+	}
+
+}
 
 void __init vsmp_init(void)
 {
-- 
1.4.2
