From: Anthony Liguori <anthony-rdkfGonbjUSkNkDKm+mE6A@public.gmane.org>
Subject: [PATCH 2/5] KVM: paravirt time source
Date: Wed, 20 Jun 2007 22:06:36 -0500
Message-ID: <4679EB3C.4080605@codemonkey.ws>
References: <4679EAAF.2060103@codemonkey.ws>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------030408000201010704070900"
Return-path: <kvm-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <4679EAAF.2060103-rdkfGonbjUSkNkDKm+mE6A@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/kvm-devel>,
	<mailto:kvm-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=kvm-devel>
List-Post: <mailto:kvm-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:kvm-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/kvm-devel>,
	<mailto:kvm-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: kvm-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: kvm-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: kvm-devel <kvm-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Cc: virtualization <virtualization-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>
List-Id: virtualization@lists.linuxfoundation.org

This is a multi-part message in MIME format.
--------------030408000201010704070900
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This helps a lot on modern kernels where Linux is much more finicky 
about using the TSC as a time source.

Regards,

Anthony Liguori

--------------030408000201010704070900
Content-Type: text/x-patch;
 name="kvm-paravirt-time.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="kvm-paravirt-time.diff"

Subject: [PATCH] KVM: paravirt time source
Author: Anthony Liguori <aliguori-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>

This patch implements a paravirtual time source based on a new field added to
the VMCA.  The host provides time in nanoseconds to the guest.

Signed-off-by: Anthony Liguori <aliguori-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>

diff --git a/arch/i386/kernel/kvm.c b/arch/i386/kernel/kvm.c
index 22ea647..62c3b5b 100644
--- a/arch/i386/kernel/kvm.c
+++ b/arch/i386/kernel/kvm.c
@@ -26,6 +26,18 @@
 #include <linux/cpu.h>
 #include <linux/mm.h>
 
+#include <linux/clocksource.h>
+#include <linux/workqueue.h>
+#include <linux/cpufreq.h>
+#include <linux/jiffies.h>
+#include <linux/init.h>
+#include <linux/dmi.h>
+#include <linux/acpi_pmtmr.h>
+
+#include "mach_timer.h"
+
+#define KVM_SCALE 22
+
 struct kvm_paravirt_state
 {
 	struct kvm_vmca *vmca;
@@ -38,6 +50,7 @@ struct kvm_paravirt_state
 static DEFINE_PER_CPU(struct kvm_paravirt_state *, paravirt_state);
 
 static int do_nop_io_delay;
+static int do_paravirt_clock;
 static u64 msr_set_vmca;
 
 static long kvm_hypercall(unsigned int nr, unsigned long p1,
@@ -62,6 +75,28 @@ static long kvm_hypercall(unsigned int nr, unsigned long p1,
 	return ret;
 }
 
+static cycle_t kvm_clocksource_read(void)
+{
+	struct kvm_paravirt_state *state = get_cpu_var(paravirt_state);
+	cycle_t ret;
+
+	kvm_hypercall(KVM_HYPERCALL_UPDATE_TIME, 0, 0, 0, 0);
+	ret = state->vmca->real_nsecs;
+	put_cpu_var(paravirt_state);
+
+	return ret;
+}
+
+static struct clocksource clocksource_kvm = {
+	.name			= "kvm",
+	.rating			= 200,
+	.read			= kvm_clocksource_read,
+	.mask			= CLOCKSOURCE_MASK(64),
+	.mult			= 1 << KVM_SCALE,
+	.shift			= KVM_SCALE,
+	.flags			= CLOCK_SOURCE_IS_CONTINUOUS,
+};
+
 /*
  * No need for any "IO delay" on KVM
  */
@@ -76,6 +111,14 @@ static void paravirt_ops_setup(void)
 	if (do_nop_io_delay)
 		paravirt_ops.io_delay = kvm_io_delay;
 
+	if (do_paravirt_clock) {
+		int err;
+
+		err = clocksource_register(&clocksource_kvm);
+		WARN_ON(err);
+		printk(KERN_INFO "KVM: using paravirt clock source\n");
+	}
+
 	paravirt_ops.paravirt_enabled = 1;
 
 	apply_paravirt(__parainstructions, __parainstructions_end);
@@ -114,6 +157,9 @@ static int paravirt_initialize(void)
 	if ((edx & KVM_FEATURE_NOP_IO_DELAY))
 		do_nop_io_delay = 1;
 
+	if ((edx & KVM_FEATURE_PARAVIRT_CLOCK))
+		do_paravirt_clock = 1;
+
 	on_each_cpu(paravirt_activate, NULL, 0, 1);
 
 	return 0;
diff --git a/drivers/kvm/kvm_main.c b/drivers/kvm/kvm_main.c
index 1369310..e455fca 100644
--- a/drivers/kvm/kvm_main.c
+++ b/drivers/kvm/kvm_main.c
@@ -44,6 +44,7 @@
 #include <linux/cpumask.h>
 #include <linux/smp.h>
 #include <linux/kvm_para.h>
+#include <linux/delay.h>
 
 #include "x86_emulate.h"
 #include "segment_descriptor.h"
@@ -93,7 +94,8 @@ struct vfsmount *kvmfs_mnt;
 #define EFER_RESERVED_BITS 0xfffffffffffff2fe
 
 #define KVM_PARAVIRT_FEATURES \
-	(KVM_FEATURE_VMCA | KVM_FEATURE_NOP_IO_DELAY)
+	(KVM_FEATURE_VMCA | KVM_FEATURE_NOP_IO_DELAY | \
+	 KVM_FEATURE_PARAVIRT_CLOCK)
 
 #define KVM_MSR_SET_VMCA	0x87655678
 
@@ -1346,10 +1348,34 @@ int kvm_emulate_halt(struct kvm_vcpu *vcpu)
 }
 EXPORT_SYMBOL_GPL(kvm_emulate_halt);
 
+static int kvm_hypercall_update_time(struct kvm_vcpu *vcpu)
+{
+	struct kvm_vmca *vmca;
+	struct timespec now;
+
+	if (unlikely(!vcpu->para_state_page))
+		return -KVM_EINVAL;
+
+	ktime_get_ts(&now);
+
+	vmca = kmap(vcpu->para_state_page);
+
+	vmca->real_nsecs = now.tv_nsec + now.tv_sec * (cycles_t)1e9;
+
+	mark_page_dirty(vcpu->kvm, vcpu->para_state_gpa >> PAGE_SHIFT);
+	kunmap(vcpu->para_state_page);
+
+	return 0;
+}
+
 static int dispatch_hypercall(struct kvm_vcpu *vcpu, unsigned long nr,
 			      unsigned long p1, unsigned long p2,
 			      unsigned long p3, unsigned long p4)
 {
+	switch (nr) {
+	case KVM_HYPERCALL_UPDATE_TIME:
+		return kvm_hypercall_update_time(vcpu);
+	}
 	return -KVM_ENOSYS;
 }
 
diff --git a/include/linux/kvm_para.h b/include/linux/kvm_para.h
index 11ebad8..4f27fb1 100644
--- a/include/linux/kvm_para.h
+++ b/include/linux/kvm_para.h
@@ -15,10 +15,12 @@
 
 #define KVM_FEATURE_VMCA		(1UL << 0)
 #define KVM_FEATURE_NOP_IO_DELAY	(1UL << 1)
+#define KVM_FEATURE_PARAVIRT_CLOCK	(1UL << 2)
 
 struct kvm_vmca
 {
 	u64 hypercall_gpa;
+	u64 real_nsecs;
 };
 
 /*
@@ -33,5 +35,8 @@ struct kvm_vmca
  */
 
 #define KVM_ENOSYS	ENOSYS
+#define KVM_EINVAL	EINVAL
+
+#define KVM_HYPERCALL_UPDATE_TIME	0
 
 #endif

--------------030408000201010704070900
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--------------030408000201010704070900
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kvm-devel mailing list
kvm-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
https://lists.sourceforge.net/lists/listinfo/kvm-devel

--------------030408000201010704070900--
