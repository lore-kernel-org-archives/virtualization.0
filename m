From: Josh Poimboeuf <jpoimboe@redhat.com>
Subject: [PATCH 01/13] x86/paravirt: remove wbinvd() paravirt interface
Date: Wed,  4 Oct 2017 10:58:22 -0500
Message-ID: <3f9bf17f6372ee92d984f6c7fd13e0cb14bc0e0a.1507128293.git.jpoimboe__14516.5254515179$1509079575$gmane$org@redhat.com>
References: <cover.1507128293.git.jpoimboe@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <cover.1507128293.git.jpoimboe@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: x86@kernel.org
Cc: Juergen Gross <jgross@suse.com>, Rusty Russell <rusty@rustcorp.com.au>, xen-devel@lists.xenproject.org, Peter Zijlstra <peterz@infradead.org>, Jiri Slaby <jslaby@suse.cz>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Mike Galbraith <efault@gmx.de>, linux-kernel@vger.kernel.org, Sasha Levin <alexander.levin@verizon.com>, Chris Wright <chrisw@sous-sol.org>, Thomas Gleixner <tglx@linutronix.de>, Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>, live-patching@vger.kernel.org, Alok Kataria <akataria@vmware.com>, virtualization@lists.linux-foundation.org, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

Since lguest was removed, only the native version of wbinvd() is used.
The paravirt interface is no longer needed.

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 arch/x86/include/asm/paravirt.h       | 5 -----
 arch/x86/include/asm/paravirt_types.h | 1 -
 arch/x86/include/asm/special_insns.h  | 7 +------
 arch/x86/kernel/paravirt.c            | 1 -
 arch/x86/kernel/paravirt_patch_64.c   | 2 --
 arch/x86/xen/enlighten_pv.c           | 2 --
 6 files changed, 1 insertion(+), 17 deletions(-)

diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index 12deec722cf0..2f51fbf175da 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -98,11 +98,6 @@ static inline void halt(void)
 	PVOP_VCALL0(pv_irq_ops.halt);
 }
 
-static inline void wbinvd(void)
-{
-	PVOP_VCALL0(pv_cpu_ops.wbinvd);
-}
-
 #define get_kernel_rpl()  (pv_info.kernel_rpl)
 
 static inline u64 paravirt_read_msr(unsigned msr)
diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/paravirt_types.h
index 280d94c36dad..0e112f279514 100644
--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@ -137,7 +137,6 @@ struct pv_cpu_ops {
 
 	void (*set_iopl_mask)(unsigned mask);
 
-	void (*wbinvd)(void);
 	void (*io_delay)(void);
 
 	/* cpuid emulation, mostly so that caps bits can be disabled */
diff --git a/arch/x86/include/asm/special_insns.h b/arch/x86/include/asm/special_insns.h
index a24dfcf79f4a..ac402c6fc24b 100644
--- a/arch/x86/include/asm/special_insns.h
+++ b/arch/x86/include/asm/special_insns.h
@@ -128,7 +128,7 @@ static inline void __write_pkru(u32 pkru)
 }
 #endif
 
-static inline void native_wbinvd(void)
+static inline void wbinvd(void)
 {
 	asm volatile("wbinvd": : :"memory");
 }
@@ -183,11 +183,6 @@ static inline void __write_cr4(unsigned long x)
 	native_write_cr4(x);
 }
 
-static inline void wbinvd(void)
-{
-	native_wbinvd();
-}
-
 #ifdef CONFIG_X86_64
 
 static inline unsigned long read_cr8(void)
diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
index 19a3e8f961c7..3fead3a50723 100644
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -332,7 +332,6 @@ __visible struct pv_cpu_ops pv_cpu_ops = {
 	.read_cr8 = native_read_cr8,
 	.write_cr8 = native_write_cr8,
 #endif
-	.wbinvd = native_wbinvd,
 	.read_msr = native_read_msr,
 	.write_msr = native_write_msr,
 	.read_msr_safe = native_read_msr_safe,
diff --git a/arch/x86/kernel/paravirt_patch_64.c b/arch/x86/kernel/paravirt_patch_64.c
index 11aaf1eaa0e4..0a1ba3f80cbf 100644
--- a/arch/x86/kernel/paravirt_patch_64.c
+++ b/arch/x86/kernel/paravirt_patch_64.c
@@ -10,7 +10,6 @@ DEF_NATIVE(pv_mmu_ops, read_cr2, "movq %cr2, %rax");
 DEF_NATIVE(pv_mmu_ops, read_cr3, "movq %cr3, %rax");
 DEF_NATIVE(pv_mmu_ops, write_cr3, "movq %rdi, %cr3");
 DEF_NATIVE(pv_mmu_ops, flush_tlb_single, "invlpg (%rdi)");
-DEF_NATIVE(pv_cpu_ops, wbinvd, "wbinvd");
 
 DEF_NATIVE(pv_cpu_ops, usergs_sysret64, "swapgs; sysretq");
 DEF_NATIVE(pv_cpu_ops, swapgs, "swapgs");
@@ -60,7 +59,6 @@ unsigned native_patch(u8 type, u16 clobbers, void *ibuf,
 		PATCH_SITE(pv_mmu_ops, read_cr3);
 		PATCH_SITE(pv_mmu_ops, write_cr3);
 		PATCH_SITE(pv_mmu_ops, flush_tlb_single);
-		PATCH_SITE(pv_cpu_ops, wbinvd);
 #if defined(CONFIG_PARAVIRT_SPINLOCKS)
 		case PARAVIRT_PATCH(pv_lock_ops.queued_spin_unlock):
 			if (pv_is_native_spin_unlock()) {
diff --git a/arch/x86/xen/enlighten_pv.c b/arch/x86/xen/enlighten_pv.c
index 73f809a6ca87..c0cb5c2bfd92 100644
--- a/arch/x86/xen/enlighten_pv.c
+++ b/arch/x86/xen/enlighten_pv.c
@@ -1045,8 +1045,6 @@ static const struct pv_cpu_ops xen_cpu_ops __initconst = {
 	.write_cr8 = xen_write_cr8,
 #endif
 
-	.wbinvd = native_wbinvd,
-
 	.read_msr = xen_read_msr,
 	.write_msr = xen_write_msr,
 
-- 
2.13.6
