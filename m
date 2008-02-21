From: yamahata@valinux.co.jp
Subject: [PATCH 20/28] ia64/xen: domU xen machine vector without dma api.
Date: Thu, 21 Feb 2008 18:17:51 +0900
Message-ID: <20080221091904.811793000__31615.7241388739$1203633842$gmane$org@ls.local.valinux.co.jp>
References: <20080221091731.641745000@ls.local.valinux.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Resent-Message-ID: <20080221223141.GU17530%yamahata@valinux.co.jp>
Resent-To: linux-ia64@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        kvm-ia64-devel@lists.sourceforge.net
Content-Disposition: inline;
	filename=0020-ia64-xen-domU-xen-machine-vector-without-dma-api.patch
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
Cc: xen-ia64-devel@lists.xensource.com, kvm-ia64-devel@lists.sourceforge.net, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org


Signed-off-by: Isaku Yamahata <yamahata@valinux.co.jp>
---
 arch/ia64/kernel/acpi.c        |    6 ++++++
 arch/ia64/xen/machvec.c        |    4 ++++
 include/asm-ia64/machvec.h     |    2 ++
 include/asm-ia64/machvec_xen.h |   22 ++++++++++++++++++++++
 4 files changed, 34 insertions(+), 0 deletions(-)
 create mode 100644 arch/ia64/xen/machvec.c
 create mode 100644 include/asm-ia64/machvec_xen.h

diff --git a/arch/ia64/kernel/acpi.c b/arch/ia64/kernel/acpi.c
index 78f28d8..9c17a46 100644
--- a/arch/ia64/kernel/acpi.c
+++ b/arch/ia64/kernel/acpi.c
@@ -118,6 +118,10 @@ acpi_get_sysname(void)
 		return "hpzx1";
 	} else if (!strcmp(hdr->oem_id, "SGI")) {
 		return "sn2";
+#ifdef CONFIG_XEN
+	} else if (is_running_on_xen() && !strcmp(hdr->oem_id, "XEN")) {
+		return "xen";
+#endif
 	}
 
 	return "dig";
@@ -132,6 +136,8 @@ acpi_get_sysname(void)
 	return "sn2";
 # elif defined (CONFIG_IA64_DIG)
 	return "dig";
+# elif defined (CONFIG_IA64_XEN)
+	return "xen";
 # else
 #	error Unknown platform.  Fix acpi.c.
 # endif
diff --git a/arch/ia64/xen/machvec.c b/arch/ia64/xen/machvec.c
new file mode 100644
index 0000000..4ad588a
--- /dev/null
+++ b/arch/ia64/xen/machvec.c
@@ -0,0 +1,4 @@
+#define MACHVEC_PLATFORM_NAME           xen
+#define MACHVEC_PLATFORM_HEADER         <asm/machvec_xen.h>
+#include <asm/machvec_init.h>
+
diff --git a/include/asm-ia64/machvec.h b/include/asm-ia64/machvec.h
index c201a20..cea8d63 100644
--- a/include/asm-ia64/machvec.h
+++ b/include/asm-ia64/machvec.h
@@ -120,6 +120,8 @@ extern void machvec_tlb_migrate_finish (struct mm_struct *);
 #  include <asm/machvec_hpzx1_swiotlb.h>
 # elif defined (CONFIG_IA64_SGI_SN2)
 #  include <asm/machvec_sn2.h>
+# elif defined (CONFIG_IA64_XEN)
+#  include <asm/machvec_xen.h>
 # elif defined (CONFIG_IA64_GENERIC)
 
 # ifdef MACHVEC_PLATFORM_HEADER
diff --git a/include/asm-ia64/machvec_xen.h b/include/asm-ia64/machvec_xen.h
new file mode 100644
index 0000000..ed0f84d
--- /dev/null
+++ b/include/asm-ia64/machvec_xen.h
@@ -0,0 +1,22 @@
+#ifndef _ASM_IA64_MACHVEC_XEN_h
+#define _ASM_IA64_MACHVEC_XEN_h
+
+extern ia64_mv_setup_t			xen_setup;
+extern ia64_mv_cpu_init_t		xen_cpu_init;
+extern ia64_mv_irq_init_t		xen_irq_init;
+extern ia64_mv_send_ipi_t		xen_platform_send_ipi;
+
+/*
+ * This stuff has dual use!
+ *
+ * For a generic kernel, the macros are used to initialize the
+ * platform's machvec structure.  When compiling a non-generic kernel,
+ * the macros are used directly.
+ */
+#define platform_name				"xen"
+#define platform_setup				xen_setup
+#define platform_cpu_init			xen_cpu_init
+#define platform_irq_init			xen_irq_init
+#define platform_send_ipi			xen_platform_send_ipi
+
+#endif /* _ASM_IA64_MACHVEC_XEN_h */
-- 
1.5.3

-- 
yamahata
