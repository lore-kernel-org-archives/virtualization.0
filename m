From: Anthony Liguori <aliguori@us.ibm.com>
Subject: [PATCH 2/3] KVM paravirt-ops implementation (v2)
Date: Mon, 27 Aug 2007 14:42:02 -0500
Message-ID: <11882437252643-git-send-email-aliguori__35606.2536164702$1188244811$gmane$org@us.ibm.com>
References: <1188243723984-git-send-email-aliguori@us.ibm.com>
	<11882437243411-git-send-email-aliguori@us.ibm.com>
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <11882437243411-git-send-email-aliguori@us.ibm.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: kvm-devel@lists.sourceforge.net
Cc: Anthony Liguori <aliguori@us.ibm.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

A very simple paravirt_ops implementation for KVM.  Future patches will add
more sophisticated optimizations.  The goal of having this presenting this now
is to validate the new hypercall infrastructure and to make my patch queue
smaller.

Signed-off-by: Anthony Liguori <aliguori@us.ibm.com>

diff --git a/arch/i386/Kconfig b/arch/i386/Kconfig
index f952493..ceacc66 100644
--- a/arch/i386/Kconfig
+++ b/arch/i386/Kconfig
@@ -237,6 +237,13 @@ config VMI
 	  at the moment), by linking the kernel to a GPL-ed ROM module
 	  provided by the hypervisor.
 
+config KVM_GUEST
+	bool "KVM paravirt-ops support"
+	depends on PARAVIRT
+	help
+	  This option enables various optimizations for running under the KVM
+          hypervisor.
+
 config ACPI_SRAT
 	bool
 	default y
diff --git a/arch/i386/kernel/Makefile b/arch/i386/kernel/Makefile
index 9d33b00..6308fcf 100644
--- a/arch/i386/kernel/Makefile
+++ b/arch/i386/kernel/Makefile
@@ -42,6 +42,7 @@ obj-$(CONFIG_K8_NB)		+= k8.o
 obj-$(CONFIG_MGEODE_LX)		+= geode.o
 
 obj-$(CONFIG_VMI)		+= vmi.o vmiclock.o
+obj-$(CONFIG_KVM_GUEST)		+= kvm.o
 obj-$(CONFIG_PARAVIRT)		+= paravirt.o
 obj-y				+= pcspeaker.o
 
diff --git a/arch/i386/kernel/kvm.c b/arch/i386/kernel/kvm.c
new file mode 100644
index 0000000..26585a4
--- /dev/null
+++ b/arch/i386/kernel/kvm.c
@@ -0,0 +1,46 @@
+/*
+ * KVM paravirt_ops implementation
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
+ *
+ * Copyright IBM Corporation, 2007
+ *   Authors: Anthony Liguori <aliguori@us.ibm.com>
+ */
+
+#include <linux/kernel.h>
+#include <linux/kvm_para.h>
+
+/*
+ * No need for any "IO delay" on KVM
+ */
+static void kvm_io_delay(void)
+{
+}
+
+static __init void paravirt_setup(void)
+{
+	paravirt_ops.name = "KVM";
+
+	if (kvm_para_has_feature(KVM_PARA_FEATURE_NOP_IO_DELAY))
+		paravirt_ops.io_delay = kvm_io_delay;
+
+	paravirt_ops.paravirt_enabled = 1;
+}
+
+void __init kvm_guest_init(void)
+{
+	if (kvm_para_available())
+		paravirt_setup();
+}
diff --git a/include/linux/kvm_para.h b/include/linux/kvm_para.h
index 0f94138..10b2e7a 100644
--- a/include/linux/kvm_para.h
+++ b/include/linux/kvm_para.h
@@ -4,6 +4,14 @@
 #ifdef __KERNEL__
 #include <asm/processor.h>
 
+#ifdef CONFIG_KVM_GUEST
+void __init kvm_guest_init(void);
+#else
+static inline void kvm_guest_init(void)
+{
+}
+#endif
+
 #define KVM_HYPERCALL ".byte 0x0f,0x01,0xc1"
 
 static inline long kvm_hypercall0(unsigned int nr)
diff --git a/init/main.c b/init/main.c
index d3bcb3b..b224905 100644
--- a/init/main.c
+++ b/init/main.c
@@ -55,6 +55,7 @@
 #include <linux/pid_namespace.h>
 #include <linux/device.h>
 #include <linux/kthread.h>
+#include <linux/kvm_para.h>
 
 #include <asm/io.h>
 #include <asm/bugs.h>
@@ -569,6 +570,7 @@ asmlinkage void __init start_kernel(void)
 	}
 	sort_main_extable();
 	trap_init();
+	kvm_guest_init();
 	rcu_init();
 	init_IRQ();
 	pidhash_init();
