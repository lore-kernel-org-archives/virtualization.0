From: Anthony Liguori <anthony-rdkfGonbjUSkNkDKm+mE6A@public.gmane.org>
Subject: [PATCH 3/5] KVM: Implement CR read caching for KVM
	paravirt_ops
Date: Wed, 20 Jun 2007 22:07:40 -0500
Message-ID: <4679EB7C.6080304@codemonkey.ws>
References: <4679EAAF.2060103@codemonkey.ws>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------050002060103070504060100"
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
--------------050002060103070504060100
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Regards,

Anthony Liguori

--------------050002060103070504060100
Content-Type: text/x-patch;
 name="kvm-cr-caching.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="kvm-cr-caching.diff"

Subject: [PATCH] KVM: Implement CR read caching for KVM paravirt_ops
Author: Anthony Liguori <aliguori-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>

With hardware virtualization, CR reads often times require a VMEXIT which is
rather expensive.  Instead of reading CR and taking the VMEXIT, maintain a
copy of each CR and return that on CR reads.

Signed-off-by: Anthony Liguori <aliguori-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>

diff --git a/arch/i386/kernel/kvm.c b/arch/i386/kernel/kvm.c
index 62c3b5b..dcc45cd 100644
--- a/arch/i386/kernel/kvm.c
+++ b/arch/i386/kernel/kvm.c
@@ -38,8 +38,13 @@
 
 #define KVM_SCALE 22
 
+#define CR0_TS_MASK (1ULL << 3)
+
 struct kvm_paravirt_state
 {
+	unsigned long cached_cr[5];
+	int cr_valid[5];
+
 	struct kvm_vmca *vmca;
 	struct kvm_hypercall_entry *queue;
 	void (*hypercall)(void);
@@ -49,6 +54,7 @@ struct kvm_paravirt_state
 
 static DEFINE_PER_CPU(struct kvm_paravirt_state *, paravirt_state);
 
+static int do_cr_read_caching;
 static int do_nop_io_delay;
 static int do_paravirt_clock;
 static u64 msr_set_vmca;
@@ -104,6 +110,93 @@ static void kvm_io_delay(void)
 {
 }
 
+/*
+ * Control register reads can be trapped.  Since trapping is relatively
+ * expensive, we can avoid paying the cost by caching logically.
+ */
+static __always_inline unsigned long kvm_read_cr(int reg)
+{
+	struct kvm_paravirt_state *state = x86_read_percpu(paravirt_state);
+
+	if (unlikely(!state->cr_valid[reg])) {
+		switch (reg) {
+		case 0:
+			state->cached_cr[reg] = native_read_cr0();
+			break;
+		case 3:
+			state->cached_cr[reg] = native_read_cr3();
+			break;
+		case 4:
+			state->cached_cr[reg] = native_read_cr4();
+			break;
+		default:
+			BUG();
+		}
+		state->cr_valid[reg] = 1;
+	}
+	return state->cached_cr[reg];
+}
+
+static __always_inline void kvm_write_cr(int reg, unsigned long value)
+{
+	struct kvm_paravirt_state *state = x86_read_percpu(paravirt_state);
+
+	state->cr_valid[reg] = 1;
+	state->cached_cr[reg] = value;
+
+	switch (reg) {
+	case 0:
+		native_write_cr0(value);
+		break;
+	case 3:
+		native_write_cr3(value);
+		break;
+	case 4:
+		native_write_cr4(value);
+		break;
+	default:
+		BUG();
+	}
+}
+
+static unsigned long kvm_read_cr0(void)
+{
+	return kvm_read_cr(0);
+}
+
+static void kvm_write_cr0(unsigned long value)
+{
+	kvm_write_cr(0, value);
+}
+
+/*
+ * We trap clts to ensure that our cached cr0 remains consistent.
+ */
+static void kvm_clts(void)
+{
+	write_cr0(read_cr0() & ~CR0_TS_MASK);
+}
+
+static unsigned long kvm_read_cr3(void)
+{
+	return kvm_read_cr(3);
+}
+
+static void kvm_write_cr3(unsigned long value)
+{
+	kvm_write_cr(3, value);
+}
+
+static unsigned long kvm_read_cr4(void)
+{
+	return kvm_read_cr(4);
+}
+
+static void kvm_write_cr4(unsigned long value)
+{
+	kvm_write_cr(4, value);
+}
+
 static void paravirt_ops_setup(void)
 {
 	paravirt_ops.name = "KVM";
@@ -119,6 +212,19 @@ static void paravirt_ops_setup(void)
 		printk(KERN_INFO "KVM: using paravirt clock source\n");
 	}
 
+	if (do_cr_read_caching) {
+		paravirt_ops.clts = kvm_clts;
+		paravirt_ops.read_cr0 = kvm_read_cr0;
+		paravirt_ops.write_cr0 = kvm_write_cr0;
+		paravirt_ops.read_cr3 = kvm_read_cr3;
+		paravirt_ops.write_cr3 = kvm_write_cr3;
+		paravirt_ops.read_cr4 = kvm_read_cr4;
+		paravirt_ops.write_cr4 = kvm_write_cr4;
+
+		/* CR4 always exists in a KVM guest */
+		paravirt_ops.read_cr4_safe = kvm_read_cr4;
+	}
+
 	paravirt_ops.paravirt_enabled = 1;
 
 	apply_paravirt(__parainstructions, __parainstructions_end);
@@ -160,6 +266,9 @@ static int paravirt_initialize(void)
 	if ((edx & KVM_FEATURE_PARAVIRT_CLOCK))
 		do_paravirt_clock = 1;
 
+	if ((edx & KVM_FEATURE_CR_READ_CACHE))
+		do_cr_read_caching = 1;
+
 	on_each_cpu(paravirt_activate, NULL, 0, 1);
 
 	return 0;
diff --git a/drivers/kvm/kvm_main.c b/drivers/kvm/kvm_main.c
index e455fca..35d73b8 100644
--- a/drivers/kvm/kvm_main.c
+++ b/drivers/kvm/kvm_main.c
@@ -95,7 +95,7 @@ struct vfsmount *kvmfs_mnt;
 
 #define KVM_PARAVIRT_FEATURES \
 	(KVM_FEATURE_VMCA | KVM_FEATURE_NOP_IO_DELAY | \
-	 KVM_FEATURE_PARAVIRT_CLOCK)
+	 KVM_FEATURE_PARAVIRT_CLOCK | KVM_FEATURE_CR_READ_CACHE)
 
 #define KVM_MSR_SET_VMCA	0x87655678
 
diff --git a/include/linux/kvm_para.h b/include/linux/kvm_para.h
index 4f27fb1..be185da 100644
--- a/include/linux/kvm_para.h
+++ b/include/linux/kvm_para.h
@@ -16,6 +16,7 @@
 #define KVM_FEATURE_VMCA		(1UL << 0)
 #define KVM_FEATURE_NOP_IO_DELAY	(1UL << 1)
 #define KVM_FEATURE_PARAVIRT_CLOCK	(1UL << 2)
+#define KVM_FEATURE_CR_READ_CACHE	(1UL << 3)
 
 struct kvm_vmca
 {

--------------050002060103070504060100
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--------------050002060103070504060100
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kvm-devel mailing list
kvm-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
https://lists.sourceforge.net/lists/listinfo/kvm-devel

--------------050002060103070504060100--
