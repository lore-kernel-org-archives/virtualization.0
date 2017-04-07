From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Subject: [RFC PATCH kvmtool 02/15] FDT: (re)introduce a dynamic phandle
	allocator
Date: Fri,  7 Apr 2017 20:24:42 +0100
Message-ID: <20170407192455.26814-3-jean-philippe.brucker__30939.9940925234$1491593094$gmane$org@arm.com>
References: <20170407191747.26618-1-jean-philippe.brucker@arm.com>
	<20170407192455.26814-1-jean-philippe.brucker@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20170407192455.26814-1-jean-philippe.brucker@arm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: iommu@lists.linux-foundation.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org
Cc: cdall@linaro.org, lorenzo.pieralisi@arm.com, mst@redhat.com, marc.zyngier@arm.com, joro@8bytes.org, will.deacon@arm.com, robin.murphy@arm.com
List-Id: virtualization@lists.linuxfoundation.org

The phandle allocator was removed because static values were sufficient
for creating a common irqchip. With adding multiple virtual IOMMUs to the
device-tree, there is a need for a dynamic allocation of phandles. Add a
simple allocator that returns values above the static ones.

Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
---
 Makefile                          |  1 +
 arm/include/arm-common/fdt-arch.h |  2 +-
 fdt.c                             | 15 +++++++++++++++
 include/kvm/fdt.h                 | 13 +++++++++++++
 mips/include/kvm/fdt-arch.h       |  2 +-
 powerpc/include/kvm/fdt-arch.h    |  2 +-
 x86/include/kvm/fdt-arch.h        |  2 +-
 7 files changed, 33 insertions(+), 4 deletions(-)
 create mode 100644 fdt.c

diff --git a/Makefile b/Makefile
index 6d5f5d9d..3e21c597 100644
--- a/Makefile
+++ b/Makefile
@@ -303,6 +303,7 @@ ifeq (y,$(ARCH_WANT_LIBFDT))
 		CFLAGS_STATOPT	+= -DCONFIG_HAS_LIBFDT
 		LIBS_DYNOPT	+= -lfdt
 		LIBS_STATOPT	+= -lfdt
+		OBJS		+= fdt.o
 	endif
 endif
 
diff --git a/arm/include/arm-common/fdt-arch.h b/arm/include/arm-common/fdt-arch.h
index 60c2d406..ed4ff3d4 100644
--- a/arm/include/arm-common/fdt-arch.h
+++ b/arm/include/arm-common/fdt-arch.h
@@ -1,6 +1,6 @@
 #ifndef ARM__FDT_H
 #define ARM__FDT_H
 
-enum phandles {PHANDLE_RESERVED = 0, PHANDLE_GIC, PHANDLE_MSI, PHANDLES_MAX};
+enum phandles {PHANDLE_RESERVED = 0, PHANDLE_GIC, PHANDLE_MSI, ARCH_PHANDLES_MAX};
 
 #endif /* ARM__FDT_H */
diff --git a/fdt.c b/fdt.c
new file mode 100644
index 00000000..6db03d4e
--- /dev/null
+++ b/fdt.c
@@ -0,0 +1,15 @@
+/*
+ * Commonly used FDT functions.
+ */
+
+#include "kvm/fdt.h"
+
+static u32 next_phandle = PHANDLE_RESERVED;
+
+u32 fdt_alloc_phandle(void)
+{
+	if (next_phandle == PHANDLE_RESERVED)
+		next_phandle = ARCH_PHANDLES_MAX;
+
+	return next_phandle++;
+}
diff --git a/include/kvm/fdt.h b/include/kvm/fdt.h
index beadc7f3..503887f9 100644
--- a/include/kvm/fdt.h
+++ b/include/kvm/fdt.h
@@ -35,4 +35,17 @@ enum irq_type {
 		}							\
 	} while (0)
 
+#ifdef CONFIG_HAS_LIBFDT
+
+u32 fdt_alloc_phandle(void);
+
+#else
+
+static inline u32 fdt_alloc_phandle(void)
+{
+	return PHANDLE_RESERVED;
+}
+
+#endif /* CONFIG_HAS_LIBFDT */
+
 #endif /* KVM__FDT_H */
diff --git a/mips/include/kvm/fdt-arch.h b/mips/include/kvm/fdt-arch.h
index b0302457..3d004117 100644
--- a/mips/include/kvm/fdt-arch.h
+++ b/mips/include/kvm/fdt-arch.h
@@ -1,6 +1,6 @@
 #ifndef KVM__KVM_FDT_H
 #define KVM__KVM_FDT_H
 
-enum phandles {PHANDLE_RESERVED = 0, PHANDLES_MAX};
+enum phandles {PHANDLE_RESERVED = 0, ARCH_PHANDLES_MAX};
 
 #endif /* KVM__KVM_FDT_H */
diff --git a/powerpc/include/kvm/fdt-arch.h b/powerpc/include/kvm/fdt-arch.h
index d48c0554..4ae4d3a0 100644
--- a/powerpc/include/kvm/fdt-arch.h
+++ b/powerpc/include/kvm/fdt-arch.h
@@ -1,6 +1,6 @@
 #ifndef KVM__KVM_FDT_H
 #define KVM__KVM_FDT_H
 
-enum phandles {PHANDLE_RESERVED = 0, PHANDLE_XICP, PHANDLES_MAX};
+enum phandles {PHANDLE_RESERVED = 0, PHANDLE_XICP, ARCH_PHANDLES_MAX};
 
 #endif /* KVM__KVM_FDT_H */
diff --git a/x86/include/kvm/fdt-arch.h b/x86/include/kvm/fdt-arch.h
index eebd73f9..aba06ad8 100644
--- a/x86/include/kvm/fdt-arch.h
+++ b/x86/include/kvm/fdt-arch.h
@@ -1,6 +1,6 @@
 #ifndef X86__FDT_ARCH_H
 #define X86__FDT_ARCH_H
 
-enum phandles {PHANDLE_RESERVED = 0, PHANDLES_MAX};
+enum phandles {PHANDLE_RESERVED = 0, ARCH_PHANDLES_MAX};
 
 #endif /* KVM__KVM_FDT_H */
-- 
2.12.1
