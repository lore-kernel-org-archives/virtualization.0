From: Juergen Gross <jgross@suse.com>
Subject: [PATCH 05/10] paravirt: add new PARAVIRT_FULL config item
Date: Fri, 19 May 2017 17:47:41 +0200
Message-ID: <20170519154746.29389-6-jgross@suse.com>
References: <20170519154746.29389-1-jgross@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20170519154746.29389-1-jgross@suse.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org, x86@kernel.org, virtualization@lists.linux-foundation.org
Cc: Juergen Gross <jgross@suse.com>, jeremy@goop.org, chrisw@sous-sol.org, mingo@redhat.com, tglx@linutronix.de, hpa@zytor.com, akataria@vmware.com, boris.ostrovsky@oracle.com
List-Id: virtualization@lists.linuxfoundation.org

Add a new config item PARAVIRT_FULL. It will be used to guard the
pv_*_ops functions used by fully paravirtualized guests (Xen pv-guests
and lguest) only.

Kernels not meant to support those guest types will be able to use many
operations without paravirt abstraction while still supporting all the
other paravirt features.

For now just add the new Kconfig option and select it for XEN_PV and
LGUEST_GUEST. Add paravirt_full.c, paravirt_full.h and
paravirt_types_full.h which will contain the necessary implementation
parts of the pv guest specific paravirt functions.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
 MAINTAINERS                                |  2 +-
 arch/x86/Kconfig                           |  4 ++++
 arch/x86/include/asm/paravirt.h            |  8 ++++++++
 arch/x86/include/asm/paravirt_full.h       |  4 ++++
 arch/x86/include/asm/paravirt_types.h      |  4 ++++
 arch/x86/include/asm/paravirt_types_full.h |  4 ++++
 arch/x86/kernel/Makefile                   |  1 +
 arch/x86/kernel/paravirt_full.c            | 16 ++++++++++++++++
 arch/x86/lguest/Kconfig                    |  1 +
 arch/x86/xen/Kconfig                       |  1 +
 10 files changed, 44 insertions(+), 1 deletion(-)
 create mode 100644 arch/x86/include/asm/paravirt_full.h
 create mode 100644 arch/x86/include/asm/paravirt_types_full.h
 create mode 100644 arch/x86/kernel/paravirt_full.c

diff --git a/MAINTAINERS b/MAINTAINERS
index f7d568b8f133..8f22d1cd10a8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9644,7 +9644,7 @@ L:	virtualization@lists.linux-foundation.org
 S:	Supported
 F:	Documentation/virtual/paravirt_ops.txt
 F:	arch/*/kernel/paravirt*
-F:	arch/*/include/asm/paravirt.h
+F:	arch/*/include/asm/paravirt*.h
 F:	include/linux/hypervisor.h
 
 PARIDE DRIVERS FOR PARALLEL PORT IDE DEVICES
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index cd18994a9555..4d032ed27ce7 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -738,6 +738,10 @@ config PARAVIRT_SPINLOCKS
 
 	  If you are unsure how to answer this question, answer Y.
 
+config PARAVIRT_FULL
+	bool
+	depends on PARAVIRT
+
 config QUEUED_LOCK_STAT
 	bool "Paravirt queued spinlock statistics"
 	depends on PARAVIRT_SPINLOCKS && DEBUG_FS
diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index 55fa56fe4e45..419a3b991e72 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -15,6 +15,10 @@
 #include <linux/cpumask.h>
 #include <asm/frame.h>
 
+#ifdef CONFIG_PARAVIRT_FULL
+#include <asm/paravirt_full.h>
+#endif
+
 static inline void load_sp0(struct tss_struct *tss,
 			     struct thread_struct *thread)
 {
@@ -916,6 +920,10 @@ extern void default_banner(void);
 #define PARA_INDIRECT(addr)	*%cs:addr
 #endif
 
+#ifdef CONFIG_PARAVIRT_FULL
+#include <asm/paravirt_full.h>
+#endif
+
 #define INTERRUPT_RETURN						\
 	PARA_SITE(PARA_PATCH(pv_cpu_ops, PV_CPU_iret), CLBR_NONE,	\
 		  jmp PARA_INDIRECT(pv_cpu_ops+PV_CPU_iret))
diff --git a/arch/x86/include/asm/paravirt_full.h b/arch/x86/include/asm/paravirt_full.h
new file mode 100644
index 000000000000..1cabcfff6791
--- /dev/null
+++ b/arch/x86/include/asm/paravirt_full.h
@@ -0,0 +1,4 @@
+#ifndef _ASM_X86_PARAVIRT_FULL_H
+#define _ASM_X86_PARAVIRT_FULL_H
+
+#endif /* _ASM_X86_PARAVIRT_FULL_H */
diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/paravirt_types.h
index 7a5de42cb465..dbb0e69cd5c6 100644
--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@ -60,6 +60,10 @@ struct paravirt_callee_save {
 	void *func;
 };
 
+#ifdef CONFIG_PARAVIRT_FULL
+#include <asm/paravirt_types_full.h>
+#endif
+
 /* general info */
 struct pv_info {
 	unsigned int kernel_rpl;
diff --git a/arch/x86/include/asm/paravirt_types_full.h b/arch/x86/include/asm/paravirt_types_full.h
new file mode 100644
index 000000000000..69c048324e70
--- /dev/null
+++ b/arch/x86/include/asm/paravirt_types_full.h
@@ -0,0 +1,4 @@
+#ifndef _ASM_X86_PARAVIRT_TYPES_FULL_H
+#define _ASM_X86_PARAVIRT_TYPES_FULL_H
+
+#endif  /* _ASM_X86_PARAVIRT_TYPES_FULL_H */
diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index 4b994232cb57..80fe640e9b63 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -107,6 +107,7 @@ obj-$(CONFIG_KVM_GUEST)		+= kvm.o kvmclock.o
 obj-$(CONFIG_PARAVIRT)		+= paravirt.o paravirt_patch_$(BITS).o
 obj-$(CONFIG_PARAVIRT_SPINLOCKS)+= paravirt-spinlocks.o
 obj-$(CONFIG_PARAVIRT_CLOCK)	+= pvclock.o
+obj-$(CONFIG_PARAVIRT_FULL)	+= paravirt_full.o
 obj-$(CONFIG_X86_PMEM_LEGACY_DEVICE) += pmem.o
 
 obj-$(CONFIG_PCSPKR_PLATFORM)	+= pcspeaker.o
diff --git a/arch/x86/kernel/paravirt_full.c b/arch/x86/kernel/paravirt_full.c
new file mode 100644
index 000000000000..0c7de64129c5
--- /dev/null
+++ b/arch/x86/kernel/paravirt_full.c
@@ -0,0 +1,16 @@
+/*
+    Paravirtualization interfaces for fully paravirtualized guests
+    Copyright (C) 2017 Juergen Gross SUSE Linux GmbH
+
+    This program is free software; you can redistribute it and/or modify
+    it under the terms of the GNU General Public License as published by
+    the Free Software Foundation; either version 2 of the License, or
+    (at your option) any later version.
+
+    This program is distributed in the hope that it will be useful,
+    but WITHOUT ANY WARRANTY; without even the implied warranty of
+    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+    GNU General Public License for more details.
+*/
+
+#include <asm/paravirt.h>
diff --git a/arch/x86/lguest/Kconfig b/arch/x86/lguest/Kconfig
index 08f41caada45..ce2c6ee56921 100644
--- a/arch/x86/lguest/Kconfig
+++ b/arch/x86/lguest/Kconfig
@@ -1,6 +1,7 @@
 config LGUEST_GUEST
 	bool "Lguest guest support"
 	depends on X86_32 && PARAVIRT && PCI
+	select PARAVIRT_FULL
 	select TTY
 	select VIRTUALIZATION
 	select VIRTIO
diff --git a/arch/x86/xen/Kconfig b/arch/x86/xen/Kconfig
index 027987638e98..c4177773df81 100644
--- a/arch/x86/xen/Kconfig
+++ b/arch/x86/xen/Kconfig
@@ -17,6 +17,7 @@ config XEN_PV
 	bool "Xen PV guest support"
 	default y
 	depends on XEN
+	select PARAVIRT_FULL
 	select XEN_HAVE_PVMMU
 	select XEN_HAVE_VPMU
 	help
-- 
2.12.0
