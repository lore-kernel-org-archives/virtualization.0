From: Anthony Liguori <aliguori-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 3/3] Eliminate read_cr3 on TLB flush
Date: Wed, 30 May 2007 09:53:41 -0500
Message-ID: <465D8FF5.6040804@us.ibm.com>
References: <465D8F03.7000201@us.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------060801070303050208030607"
Return-path: <kvm-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <465D8F03.7000201-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>
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
--------------060801070303050208030607
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Regards,

Anthony Liguori

--------------060801070303050208030607
Content-Type: text/x-patch;
 name="paravirt-no-read-cr3-flush.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="paravirt-no-read-cr3-flush.diff"

Subject: [PATCH][PARAVIRT] Eliminate unnecessary CR3 read in TLB flush

This patch eliminates the CR3 read (which would cause a VM exit) in the TLB
flush path.  The patch is based on Ingo Molnar's paravirt series.

Signed-off-by: Anthony Liguori <aliguori-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>

Index: kvm/arch/i386/kernel/kvm.c
===================================================================
--- kvm.orig/arch/i386/kernel/kvm.c	2007-05-30 09:13:48.000000000 -0500
+++ kvm/arch/i386/kernel/kvm.c	2007-05-30 09:14:24.000000000 -0500
@@ -24,11 +24,35 @@
 #include <linux/kernel.h>
 #include <linux/kvm_para.h>
 #include <linux/cpu.h>
+#include <linux/mm.h>
+#include <asm/processor.h>
+#include <asm/tlbflush.h>
 
 static DEFINE_PER_CPU(struct kvm_vcpu_para_state, para_state);
 extern unsigned char hypercall_addr[4];
 
 /*
+ * Avoid the VM exit upon cr3 load by using the cached
+ * ->active_mm->pgd value:
+ */
+static void kvm_flush_tlb_user(void)
+{
+	write_cr3(__pa(current->active_mm->pgd));
+}
+
+/*
+ * Avoid VM exit for cr3 read by calling into kvm_flush_tlb_user
+ */
+static fastcall void kvm_flush_tlb_kernel(void)
+{
+	unsigned long orig_cr4 = read_cr4();
+
+	write_cr4(orig_cr4 & ~X86_CR4_PGE);
+	kvm_flush_tlb_user();
+	write_cr4(orig_cr4);
+}
+
+/*
  * No need for any "IO delay" on KVM
  */
 static void kvm_io_delay(void)
@@ -38,6 +62,8 @@
 static void kvm_guest_setup(void)
 {
 	paravirt_ops.name = "KVM";
+	paravirt_ops.flush_tlb_user = kvm_flush_tlb_user;
+	paravirt_ops.flush_tlb_kernel = kvm_flush_tlb_kernel;
 	paravirt_ops.io_delay = kvm_io_delay;
 	paravirt_ops.paravirt_enabled = 1;
 }

--------------060801070303050208030607
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--------------060801070303050208030607
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kvm-devel mailing list
kvm-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
https://lists.sourceforge.net/lists/listinfo/kvm-devel

--------------060801070303050208030607--
