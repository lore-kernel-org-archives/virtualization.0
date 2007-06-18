From: Anthony Liguori <anthony-rdkfGonbjUSkNkDKm+mE6A@public.gmane.org>
Subject: [PATCH 5/5] KVM: paravirt time source
Date: Sun, 17 Jun 2007 22:03:29 -0500
Message-ID: <4675F601.3090706@codemonkey.ws>
References: <4675F462.1010708@codemonkey.ws>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------030007010008020504090905"
Return-path: <kvm-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <4675F462.1010708-rdkfGonbjUSkNkDKm+mE6A@public.gmane.org>
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
--------------030007010008020504090905
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Regards,

Anthony Liguori

--------------030007010008020504090905
Content-Type: text/x-patch;
 name="kvm-paravirt-time.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="kvm-paravirt-time.diff"

Subject: [PATCH] KVM: paravirt time source
Author: Anthony Liguori <aliguori-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>

This is a paravirt time source for KVM based on Ingo Molnars similar patch.
A very different patch will probably be needed that takes advantage of hrtimers
but I have to learn a bit more about that first.

Signed-off-by: Anthony Liguori <aliguori-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>

diff --git a/arch/i386/kernel/kvm.c b/arch/i386/kernel/kvm.c
index 77c36f4..25fb2c1 100644
--- a/arch/i386/kernel/kvm.c
+++ b/arch/i386/kernel/kvm.c
@@ -26,6 +26,16 @@
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
 #define CR0_TS_MASK (1ULL << 3)
 
 struct kvm_paravirt_state
@@ -48,6 +58,7 @@ static int do_hypercall_batching;
 static int do_mmu_write;
 static int do_cr_read_caching;
 static int do_nop_io_delay;
+static int do_paravirt_clock;
 static u64 msr_set_vmca;
 
 static long _kvm_hypercall(struct kvm_paravirt_state *state,
@@ -120,6 +131,27 @@ static long kvm_hypercall(unsigned int nr, unsigned long p1,
 	return ret;
 }
 
+static cycle_t read_hyper(void)
+{
+	struct timespec now;
+	int ret;
+
+	ret = kvm_hypercall(KVM_HYPERCALL_GET_KTIME, (u32)&now, 0, 0, 0);
+	WARN_ON(ret);
+
+	return now.tv_nsec + now.tv_sec * (cycles_t)1e9;
+}
+
+static struct clocksource clocksource_hyper = {
+	.name			= "hyper",
+	.rating			= 200,
+	.read			= read_hyper,
+	.mask			= CLOCKSOURCE_MASK(64),
+	.mult			= 1,
+	.shift			= 0,
+	.flags			= CLOCK_SOURCE_IS_CONTINUOUS,
+};
+
 /*
  * No need for any "IO delay" on KVM
  */
@@ -317,6 +349,14 @@ static void kvm_paravirt_ops_setup(void)
 	if (do_hypercall_batching)
 		paravirt_ops.set_lazy_mode = kvm_set_lazy_mode;
 
+	if (do_paravirt_clock) {
+		int err;
+
+		err = clocksource_register(&clocksource_hyper);
+		WARN_ON(err);
+		printk(KERN_INFO "KVM: using paravirt clock source\n");
+	}
+
 	paravirt_ops.paravirt_enabled = 1;
 
 	apply_paravirt(__parainstructions, __parainstructions_end);
@@ -364,6 +404,9 @@ static int kvm_paravirt_initialize(void)
 	if ((edx & KVM_FEATURE_HYPERCALL_BATCHING))
 		do_hypercall_batching = 1;
 
+	if ((edx & KVM_FEATURE_PARAVIRT_CLOCK))
+		do_paravirt_clock = 1;
+
 	on_each_cpu(kvm_paravirt_activate, NULL, 0, 1);
 
 	return 0;
diff --git a/drivers/kvm/kvm_main.c b/drivers/kvm/kvm_main.c
index 55711a0..b8a0811 100644
--- a/drivers/kvm/kvm_main.c
+++ b/drivers/kvm/kvm_main.c
@@ -44,6 +44,7 @@
 #include <linux/cpumask.h>
 #include <linux/smp.h>
 #include <linux/kvm_para.h>
+#include <linux/delay.h>
 
 #include "x86_emulate.h"
 #include "segment_descriptor.h"
@@ -95,7 +96,7 @@ struct vfsmount *kvmfs_mnt;
 #define KVM_PARAVIRT_FEATURES \
 	(KVM_FEATURE_VMCA | KVM_FEATURE_NOP_IO_DELAY | \
 	 KVM_FEATURE_CR_READ_CACHE | KVM_FEATURE_MMU_WRITE | \
-	 KVM_FEATURE_HYPERCALL_BATCHING)
+	 KVM_FEATURE_HYPERCALL_BATCHING | KVM_FEATURE_PARAVIRT_CLOCK)
 
 #define KVM_MSR_SET_VMCA	0x87655678
 
@@ -1388,6 +1389,20 @@ static int kvm_hypercall_set_cr(struct kvm_vcpu *vcpu,
 	return 0;
 }
 
+static int kvm_hypercall_get_ktime(struct kvm_vcpu *vcpu, gva_t va)
+{
+	struct timespec now;
+	int ret;
+
+	ktime_get_ts(&now);
+
+	ret = kvm_write_guest(vcpu, va, sizeof(now), &now);
+	if (unlikely(ret))
+		return -EFAULT;
+
+	return 0;
+}
+
 static int dispatch_hypercall(struct kvm_vcpu *vcpu, unsigned long nr,
 			      unsigned long p1, unsigned long p2,
 			      unsigned long p3, unsigned long p4)
@@ -1397,6 +1412,8 @@ static int dispatch_hypercall(struct kvm_vcpu *vcpu, unsigned long nr,
 		return kvm_hypercall_mmu_write(vcpu, p1, p2, p3, p4);
 	case KVM_HYPERCALL_SET_CR:
 		return kvm_hypercall_set_cr(vcpu, p1, p2);
+	case KVM_HYPERCALL_GET_KTIME:
+		return kvm_hypercall_get_ktime(vcpu, p1);
 	}
 	return -ENOSYS;
 }
diff --git a/include/linux/kvm_para.h b/include/linux/kvm_para.h
index 7dd0cef..9aed003 100644
--- a/include/linux/kvm_para.h
+++ b/include/linux/kvm_para.h
@@ -16,6 +16,7 @@
 #define KVM_FEATURE_CR_READ_CACHE	(1UL << 2)
 #define KVM_FEATURE_MMU_WRITE		(1UL << 3)
 #define KVM_FEATURE_HYPERCALL_BATCHING	(1UL << 4)
+#define KVM_FEATURE_PARAVIRT_CLOCK	(1UL << 5)
 
 struct kvm_vmca
 {
@@ -48,5 +49,6 @@ struct kvm_hypercall_entry
 #define KVM_HYPERCALL_MMU_WRITE		0
 #define KVM_HYPERCALL_SET_CR		1
 #define KVM_HYPERCALL_FLUSH		2
+#define KVM_HYPERCALL_GET_KTIME		3
 
 #endif

--------------030007010008020504090905
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--------------030007010008020504090905
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kvm-devel mailing list
kvm-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
https://lists.sourceforge.net/lists/listinfo/kvm-devel

--------------030007010008020504090905--
