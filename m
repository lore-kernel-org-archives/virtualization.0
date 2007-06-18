From: Anthony Liguori <anthony-rdkfGonbjUSkNkDKm+mE6A@public.gmane.org>
Subject: [PATCH 2/5] KVM: Implement CR read caching for KVM
	paravirt_ops
Date: Sun, 17 Jun 2007 21:58:57 -0500
Message-ID: <4675F4F1.5090207@codemonkey.ws>
References: <4675F462.1010708@codemonkey.ws>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------090807060809090906000008"
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
--------------090807060809090906000008
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Regards,

Anthony Liguori

--------------090807060809090906000008
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
index 22ea647..89e83a4 100644
--- a/arch/i386/kernel/kvm.c
+++ b/arch/i386/kernel/kvm.c
@@ -26,8 +26,13 @@
 #include <linux/cpu.h>
 #include <linux/mm.h>
 
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
@@ -37,6 +42,7 @@ struct kvm_paravirt_state
 
 static DEFINE_PER_CPU(struct kvm_paravirt_state *, paravirt_state);
 
+static int do_cr_read_caching;
 static int do_nop_io_delay;
 static u64 msr_set_vmca;
 
@@ -69,6 +75,85 @@ static void kvm_io_delay(void)
 {
 }
 
+/*
+ * Control register reads can be trapped.  Since trapping is relatively
+ * expensive, we can avoid paying the cost by caching logically.
+ */
+static unsigned long kvm_read_cr(int reg)
+{
+	struct kvm_paravirt_state *state
+		= per_cpu(paravirt_state, smp_processor_id());
+
+	if (unlikely(!state->cr_valid[reg])) {
+		if (reg == 0)
+			state->cached_cr[reg] = native_read_cr0();
+		else if (reg == 3)
+			state->cached_cr[reg] = native_read_cr3();
+		else if (reg == 4)
+			state->cached_cr[reg] = native_read_cr4();
+		else
+			BUG();
+		state->cr_valid[reg] = 1;
+	}
+	return state->cached_cr[reg];
+}
+
+static void kvm_write_cr(int reg, unsigned long value)
+{
+	struct kvm_paravirt_state *state
+		= per_cpu(paravirt_state, smp_processor_id());
+
+	state->cr_valid[reg] = 1;
+	state->cached_cr[reg] = value;
+
+	if (reg == 0)
+		native_write_cr0(value);
+	else if (reg == 3)
+		native_write_cr3(value);
+	else if (reg == 4)
+		native_write_cr4(value);
+	else
+		BUG();
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
@@ -76,6 +161,19 @@ static void paravirt_ops_setup(void)
 	if (do_nop_io_delay)
 		paravirt_ops.io_delay = kvm_io_delay;
 
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
@@ -114,6 +212,9 @@ static int paravirt_initialize(void)
 	if ((edx & KVM_FEATURE_NOP_IO_DELAY))
 		do_nop_io_delay = 1;
 
+	if ((edx & KVM_FEATURE_CR_READ_CACHE))
+		do_cr_read_caching = 1;
+
 	on_each_cpu(paravirt_activate, NULL, 0, 1);
 
 	return 0;
diff --git a/drivers/kvm/kvm_main.c b/drivers/kvm/kvm_main.c
index f7a0e6e..7b57431 100644
--- a/drivers/kvm/kvm_main.c
+++ b/drivers/kvm/kvm_main.c
@@ -93,7 +93,8 @@ struct vfsmount *kvmfs_mnt;
 #define EFER_RESERVED_BITS 0xfffffffffffff2fe
 
 #define KVM_PARAVIRT_FEATURES \
-	(KVM_FEATURE_VMCA | KVM_FEATURE_NOP_IO_DELAY)
+	(KVM_FEATURE_VMCA | KVM_FEATURE_NOP_IO_DELAY | \
+	 KVM_FEATURE_CR_READ_CACHE)
 
 #define KVM_MSR_SET_VMCA	0x87655678
 
diff --git a/include/linux/kvm_para.h b/include/linux/kvm_para.h
index cf51d4a..121a09c 100644
--- a/include/linux/kvm_para.h
+++ b/include/linux/kvm_para.h
@@ -13,6 +13,7 @@
 
 #define KVM_FEATURE_VMCA		(1UL << 0)
 #define KVM_FEATURE_NOP_IO_DELAY	(1UL << 1)
+#define KVM_FEATURE_CR_READ_CACHE	(1UL << 2)
 
 struct kvm_vmca
 {

--------------090807060809090906000008
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--------------090807060809090906000008
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kvm-devel mailing list
kvm-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
https://lists.sourceforge.net/lists/listinfo/kvm-devel

--------------090807060809090906000008--
