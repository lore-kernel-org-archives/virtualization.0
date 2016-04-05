From: Juergen Gross <jgross@suse.com>
Subject: [PATCH v4 2/6] virt, sched: add generic vcpu pinning support
Date: Tue,  5 Apr 2016 07:10:03 +0200
Message-ID: <1459833007-11618-3-git-send-email-jgross__17500.7585356527$1459833074$gmane$org@suse.com>
References: <1459833007-11618-1-git-send-email-jgross@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1459833007-11618-1-git-send-email-jgross@suse.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org
Cc: Juergen Gross <jgross@suse.com>, jeremy@goop.org, jdelvare@suse.com, peterz@infradead.org, hpa@zytor.com, akataria@vmware.com, x86@kernel.org, virtualization@lists.linux-foundation.org, chrisw@sous-sol.org, mingo@redhat.com, david.vrabel@citrix.com, Douglas_Warzecha@dell.com, pali.rohar@gmail.com, boris.ostrovsky@oracle.com, tglx@linutronix.de, linux@roeck-us.net
List-Id: virtualization@lists.linuxfoundation.org

Add generic virtualization support for pinning the current vcpu to a
specified physical cpu. As this operation isn't performance critical
(a very limited set of operations like BIOS calls and SMIs is expected
to need this) just add a hypervisor specific indirection.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
V4: move this patch some places up in the series
    WARN_ONCE in case platform doesn't support pinning as requested by
    Peter Zijlstra

V3: use getc_cpu()/put_cpu() as suggested by David Vrabel

V2: adapt to using workqueues
    add include/linux/hypervisor.h to hide architecture specific stuff
    from generic kernel code

In case paravirt maintainers don't want to be responsible for
include/linux/hypervisor.h I could take it.
---
 MAINTAINERS                       |  1 +
 arch/x86/include/asm/hypervisor.h |  4 ++++
 arch/x86/kernel/cpu/hypervisor.c  | 11 +++++++++++
 include/linux/hypervisor.h        | 17 +++++++++++++++++
 kernel/smp.c                      |  1 +
 kernel/up.c                       |  1 +
 6 files changed, 35 insertions(+)
 create mode 100644 include/linux/hypervisor.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 2ec5079..959173e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8330,6 +8330,7 @@ S:	Supported
 F:	Documentation/virtual/paravirt_ops.txt
 F:	arch/*/kernel/paravirt*
 F:	arch/*/include/asm/paravirt.h
+F:	include/linux/hypervisor.h
 
 PARIDE DRIVERS FOR PARALLEL PORT IDE DEVICES
 M:	Tim Waugh <tim@cyberelk.net>
diff --git a/arch/x86/include/asm/hypervisor.h b/arch/x86/include/asm/hypervisor.h
index 055ea99..67942b6 100644
--- a/arch/x86/include/asm/hypervisor.h
+++ b/arch/x86/include/asm/hypervisor.h
@@ -43,6 +43,9 @@ struct hypervisor_x86 {
 
 	/* X2APIC detection (run once per boot) */
 	bool		(*x2apic_available)(void);
+
+	/* pin current vcpu to specified physical cpu (run rarely) */
+	void		(*pin_vcpu)(int);
 };
 
 extern const struct hypervisor_x86 *x86_hyper;
@@ -56,6 +59,7 @@ extern const struct hypervisor_x86 x86_hyper_kvm;
 extern void init_hypervisor(struct cpuinfo_x86 *c);
 extern void init_hypervisor_platform(void);
 extern bool hypervisor_x2apic_available(void);
+extern void hypervisor_pin_vcpu(int cpu);
 #else
 static inline void init_hypervisor(struct cpuinfo_x86 *c) { }
 static inline void init_hypervisor_platform(void) { }
diff --git a/arch/x86/kernel/cpu/hypervisor.c b/arch/x86/kernel/cpu/hypervisor.c
index 73d391a..ff108f8 100644
--- a/arch/x86/kernel/cpu/hypervisor.c
+++ b/arch/x86/kernel/cpu/hypervisor.c
@@ -85,3 +85,14 @@ bool __init hypervisor_x2apic_available(void)
 	       x86_hyper->x2apic_available &&
 	       x86_hyper->x2apic_available();
 }
+
+void hypervisor_pin_vcpu(int cpu)
+{
+	if (!x86_hyper)
+		return;
+
+	if (x86_hyper->pin_vcpu)
+		x86_hyper->pin_vcpu(cpu);
+	else
+		WARN_ONCE(1, "vcpu pinning requested but not supported!\n");
+}
diff --git a/include/linux/hypervisor.h b/include/linux/hypervisor.h
new file mode 100644
index 0000000..3fa5ef2
--- /dev/null
+++ b/include/linux/hypervisor.h
@@ -0,0 +1,17 @@
+#ifndef __LINUX_HYPEVISOR_H
+#define __LINUX_HYPEVISOR_H
+
+/*
+ *	Generic Hypervisor support
+ *		Juergen Gross <jgross@suse.com>
+ */
+
+#ifdef CONFIG_HYPERVISOR_GUEST
+#include <asm/hypervisor.h>
+#else
+static inline void hypervisor_pin_vcpu(int cpu)
+{
+}
+#endif
+
+#endif /* __LINUX_HYPEVISOR_H */
diff --git a/kernel/smp.c b/kernel/smp.c
index 7416544..9388064 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -14,6 +14,7 @@
 #include <linux/smp.h>
 #include <linux/cpu.h>
 #include <linux/sched.h>
+#include <linux/hypervisor.h>
 
 #include "smpboot.h"
 
diff --git a/kernel/up.c b/kernel/up.c
index 1760bf3..3ccee2b 100644
--- a/kernel/up.c
+++ b/kernel/up.c
@@ -6,6 +6,7 @@
 #include <linux/kernel.h>
 #include <linux/export.h>
 #include <linux/smp.h>
+#include <linux/hypervisor.h>
 
 int smp_call_function_single(int cpu, void (*func) (void *info), void *info,
 				int wait)
-- 
2.6.2
