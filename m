From: Juergen Gross <jgross@suse.com>
Subject: [PATCH v2 5/6] virt,
	sched: add cpu pinning to smp_call_sync_on_phys_cpu()
Date: Mon, 21 Mar 2016 13:24:34 +0100
Message-ID: <1458563075-30298-6-git-send-email-jgross__43170.9833363586$1458563182$gmane$org@suse.com>
References: <1458563075-30298-1-git-send-email-jgross@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1458563075-30298-1-git-send-email-jgross@suse.com>
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
Cc: Juergen Gross <jgross@suse.com>, jeremy@goop.org, jdelvare@suse.com, konrad.wilk@oracle.com, peterz@infradead.org, hpa@zytor.com, akataria@vmware.com, x86@kernel.org, virtualization@lists.linux-foundation.org, chrisw@sous-sol.org, mingo@redhat.com, david.vrabel@citrix.com, Douglas_Warzecha@dell.com, pali.rohar@gmail.com, boris.ostrovsky@oracle.com, tglx@linutronix.de, linux@roeck-us.net
List-Id: virtualization@lists.linuxfoundation.org

Add generic virtualization support for pinning the current vcpu to a
specified physical cpu. As this operation isn't performance critical
(a very limited set of operations like BIOS calls and SMIs is expected
to need this) just add a hypervisor specific indirection.

Such a pinning should last as short as possible as it might block
sensible vcpu scheduling and maybe other hypervisor functions like
suspending the system which rely on scheduling. To ensure this don't
let the current thread be preempted while the vcpu is pinned in
smp_call_sync_on_phys_cpu().

Signed-off-by: Juergen Gross <jgross@suse.com>
---
V2: adapt to using workqueues
    add include/linux/hypervisor.h to hide architecture specific stuff
    from generic kernel code

In case paravirt maintainers don't want to be responsible for
include/linux/hypervisor.h I could take it.
---
 MAINTAINERS                       |  1 +
 arch/x86/include/asm/hypervisor.h |  9 +++++++++
 include/linux/hypervisor.h        | 17 +++++++++++++++++
 kernel/smp.c                      |  6 ++++++
 kernel/up.c                       | 11 ++++++++++-
 5 files changed, 43 insertions(+), 1 deletion(-)
 create mode 100644 include/linux/hypervisor.h

diff --git a/MAINTAINERS b/MAINTAINERS
index da636ea..62c2371 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8271,6 +8271,7 @@ S:	Supported
 F:	Documentation/virtual/paravirt_ops.txt
 F:	arch/*/kernel/paravirt*
 F:	arch/*/include/asm/paravirt.h
+F:	include/linux/hypervisor.h
 
 PARIDE DRIVERS FOR PARALLEL PORT IDE DEVICES
 M:	Tim Waugh <tim@cyberelk.net>
diff --git a/arch/x86/include/asm/hypervisor.h b/arch/x86/include/asm/hypervisor.h
index 055ea99..13f80a2 100644
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
@@ -56,6 +59,12 @@ extern const struct hypervisor_x86 x86_hyper_kvm;
 extern void init_hypervisor(struct cpuinfo_x86 *c);
 extern void init_hypervisor_platform(void);
 extern bool hypervisor_x2apic_available(void);
+
+static inline void hypervisor_pin_vcpu(int cpu)
+{
+	if (x86_hyper->pin_vcpu)
+		x86_hyper->pin_vcpu(cpu);
+}
 #else
 static inline void init_hypervisor(struct cpuinfo_x86 *c) { }
 static inline void init_hypervisor_platform(void) { }
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
index 62da74b..673242b 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -14,6 +14,7 @@
 #include <linux/smp.h>
 #include <linux/cpu.h>
 #include <linux/sched.h>
+#include <linux/hypervisor.h>
 
 #include "smpboot.h"
 
@@ -758,9 +759,14 @@ struct smp_sync_call_struct {
 static void smp_call_sync_callback(struct work_struct *work)
 {
 	struct smp_sync_call_struct *sscs;
+	unsigned int cpu = smp_processor_id();
 
 	sscs = container_of(work, struct smp_sync_call_struct, work);
+	preempt_disable();
+	hypervisor_pin_vcpu(cpu);
 	sscs->ret = sscs->func(sscs->data);
+	hypervisor_pin_vcpu(-1);
+	preempt_enable();
 
 	complete(&sscs->done);
 }
diff --git a/kernel/up.c b/kernel/up.c
index afd395c..725ec44 100644
--- a/kernel/up.c
+++ b/kernel/up.c
@@ -6,6 +6,7 @@
 #include <linux/kernel.h>
 #include <linux/export.h>
 #include <linux/smp.h>
+#include <linux/hypervisor.h>
 
 int smp_call_function_single(int cpu, void (*func) (void *info), void *info,
 				int wait)
@@ -85,9 +86,17 @@ EXPORT_SYMBOL(on_each_cpu_cond);
 
 int smp_call_sync_on_phys_cpu(unsigned int cpu, int (*func)(void *), void *par)
 {
+	int ret;
+
 	if (cpu != 0)
 		return -EINVAL;
 
-	return func(par);
+	preempt_disable();
+	hypervisor_pin_vcpu(0);
+	ret = func(par);
+	hypervisor_pin_vcpu(-1);
+	preempt_enable();
+
+	return ret;
 }
 EXPORT_SYMBOL_GPL(smp_call_sync_on_phys_cpu);
-- 
2.6.2
