From: Juergen Gross <jgross@suse.com>
Subject: [PATCH 1/4] paravirt: add generic _paravirt_false() function
Date: Tue,  5 Sep 2017 15:24:41 +0200
Message-ID: <20170905132444.7163-2-jgross__28193.426380358$1504617971$gmane$org@suse.com>
References: <20170905132444.7163-1-jgross@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20170905132444.7163-1-jgross@suse.com>
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
Cc: Juergen Gross <jgross@suse.com>, jeremy@goop.org, peterz@infradead.org, chrisw@sous-sol.org, mingo@redhat.com, tglx@linutronix.de, hpa@zytor.com, longman@redhat.com, akataria@vmware.com, boris.ostrovsky@oracle.com
List-Id: virtualization@lists.linuxfoundation.org

Add a _paravirt_false() default function returning always false which
can be used for cases where a boolean pvops replacement should just
say "no".

Signed-off-by: Juergen Gross <jgross@suse.com>
---
 arch/x86/include/asm/paravirt_types.h | 2 ++
 arch/x86/kernel/paravirt.c            | 7 +++++++
 arch/x86/kernel/paravirt_patch_32.c   | 8 ++++++++
 arch/x86/kernel/paravirt_patch_64.c   | 7 +++++++
 4 files changed, 24 insertions(+)

diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/paravirt_types.h
index 6b64fc6367f2..19efefc0e27e 100644
--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@ -377,6 +377,7 @@ extern struct pv_lock_ops pv_lock_ops;
 
 unsigned paravirt_patch_ident_32(void *insnbuf, unsigned len);
 unsigned paravirt_patch_ident_64(void *insnbuf, unsigned len);
+unsigned paravirt_patch_false(void *insnbuf, unsigned len);
 unsigned paravirt_patch_call(void *insnbuf,
 			     const void *target, u16 tgt_clobbers,
 			     unsigned long addr, u16 site_clobbers,
@@ -682,6 +683,7 @@ void paravirt_flush_lazy_mmu(void);
 void _paravirt_nop(void);
 u32 _paravirt_ident_32(u32);
 u64 _paravirt_ident_64(u64);
+bool _paravirt_false(void);
 
 #define paravirt_nop	((void *)_paravirt_nop)
 
diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
index a14df9eecfed..94105773c00c 100644
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -66,6 +66,11 @@ u64 notrace _paravirt_ident_64(u64 x)
 	return x;
 }
 
+bool notrace _paravirt_false(void)
+{
+	return false;
+}
+
 void __init default_banner(void)
 {
 	printk(KERN_INFO "Booting paravirtualized kernel on %s\n",
@@ -149,6 +154,8 @@ unsigned paravirt_patch_default(u8 type, u16 clobbers, void *insnbuf,
 		ret = paravirt_patch_ident_32(insnbuf, len);
 	else if (opfunc == _paravirt_ident_64)
 		ret = paravirt_patch_ident_64(insnbuf, len);
+	else if (opfunc == _paravirt_false)
+		ret = paravirt_patch_false(insnbuf, len);
 
 	else if (type == PARAVIRT_PATCH(pv_cpu_ops.iret) ||
 		 type == PARAVIRT_PATCH(pv_cpu_ops.usergs_sysret64))
diff --git a/arch/x86/kernel/paravirt_patch_32.c b/arch/x86/kernel/paravirt_patch_32.c
index 553acbbb4d32..287c7b9735de 100644
--- a/arch/x86/kernel/paravirt_patch_32.c
+++ b/arch/x86/kernel/paravirt_patch_32.c
@@ -9,6 +9,8 @@ DEF_NATIVE(pv_mmu_ops, read_cr2, "mov %cr2, %eax");
 DEF_NATIVE(pv_mmu_ops, write_cr3, "mov %eax, %cr3");
 DEF_NATIVE(pv_mmu_ops, read_cr3, "mov %cr3, %eax");
 
+DEF_NATIVE(, xor, "xor %eax, %eax");
+
 #if defined(CONFIG_PARAVIRT_SPINLOCKS)
 DEF_NATIVE(pv_lock_ops, queued_spin_unlock, "movb $0, (%eax)");
 DEF_NATIVE(pv_lock_ops, vcpu_is_preempted, "xor %eax, %eax");
@@ -26,6 +28,12 @@ unsigned paravirt_patch_ident_64(void *insnbuf, unsigned len)
 	return 0;
 }
 
+unsigned paravirt_patch_false(void *insnbuf, unsigned len)
+{
+	return paravirt_patch_insns(insnbuf, len,
+				    start__xor, end__xor);
+}
+
 extern bool pv_is_native_spin_unlock(void);
 extern bool pv_is_native_vcpu_is_preempted(void);
 
diff --git a/arch/x86/kernel/paravirt_patch_64.c b/arch/x86/kernel/paravirt_patch_64.c
index 11aaf1eaa0e4..8ab4379ceea9 100644
--- a/arch/x86/kernel/paravirt_patch_64.c
+++ b/arch/x86/kernel/paravirt_patch_64.c
@@ -17,6 +17,7 @@ DEF_NATIVE(pv_cpu_ops, swapgs, "swapgs");
 
 DEF_NATIVE(, mov32, "mov %edi, %eax");
 DEF_NATIVE(, mov64, "mov %rdi, %rax");
+DEF_NATIVE(, xor, "xor %rax, %rax");
 
 #if defined(CONFIG_PARAVIRT_SPINLOCKS)
 DEF_NATIVE(pv_lock_ops, queued_spin_unlock, "movb $0, (%rdi)");
@@ -35,6 +36,12 @@ unsigned paravirt_patch_ident_64(void *insnbuf, unsigned len)
 				    start__mov64, end__mov64);
 }
 
+unsigned paravirt_patch_false(void *insnbuf, unsigned len)
+{
+	return paravirt_patch_insns(insnbuf, len,
+				    start__xor, end__xor);
+}
+
 extern bool pv_is_native_spin_unlock(void);
 extern bool pv_is_native_vcpu_is_preempted(void);
 
-- 
2.12.3
