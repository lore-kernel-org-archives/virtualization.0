From: Juergen Gross <jgross@suse.com>
Subject: [PATCH 2/4] paravirt: switch vcpu_is_preempted to use
	_paravirt_false() on bare metal
Date: Tue,  5 Sep 2017 15:24:42 +0200
Message-ID: <20170905132444.7163-3-jgross__21014.7848389626$1504617952$gmane$org@suse.com>
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

Instead of special casing pv_lock_ops.vcpu_is_preempted when patching
use _paravirt_false() on bare metal.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
 arch/x86/kernel/paravirt-spinlocks.c | 14 +-------------
 arch/x86/kernel/paravirt_patch_32.c  | 10 ----------
 arch/x86/kernel/paravirt_patch_64.c  | 10 ----------
 3 files changed, 1 insertion(+), 33 deletions(-)

diff --git a/arch/x86/kernel/paravirt-spinlocks.c b/arch/x86/kernel/paravirt-spinlocks.c
index 8f2d1c9d43a8..26e4bd92f309 100644
--- a/arch/x86/kernel/paravirt-spinlocks.c
+++ b/arch/x86/kernel/paravirt-spinlocks.c
@@ -20,25 +20,13 @@ bool pv_is_native_spin_unlock(void)
 		__raw_callee_save___native_queued_spin_unlock;
 }
 
-__visible bool __native_vcpu_is_preempted(long cpu)
-{
-	return false;
-}
-PV_CALLEE_SAVE_REGS_THUNK(__native_vcpu_is_preempted);
-
-bool pv_is_native_vcpu_is_preempted(void)
-{
-	return pv_lock_ops.vcpu_is_preempted.func ==
-		__raw_callee_save___native_vcpu_is_preempted;
-}
-
 struct pv_lock_ops pv_lock_ops = {
 #ifdef CONFIG_SMP
 	.queued_spin_lock_slowpath = native_queued_spin_lock_slowpath,
 	.queued_spin_unlock = PV_CALLEE_SAVE(__native_queued_spin_unlock),
 	.wait = paravirt_nop,
 	.kick = paravirt_nop,
-	.vcpu_is_preempted = PV_CALLEE_SAVE(__native_vcpu_is_preempted),
+	.vcpu_is_preempted = __PV_IS_CALLEE_SAVE(_paravirt_false),
 #endif /* SMP */
 };
 EXPORT_SYMBOL(pv_lock_ops);
diff --git a/arch/x86/kernel/paravirt_patch_32.c b/arch/x86/kernel/paravirt_patch_32.c
index 287c7b9735de..ea311a3563e3 100644
--- a/arch/x86/kernel/paravirt_patch_32.c
+++ b/arch/x86/kernel/paravirt_patch_32.c
@@ -13,7 +13,6 @@ DEF_NATIVE(, xor, "xor %eax, %eax");
 
 #if defined(CONFIG_PARAVIRT_SPINLOCKS)
 DEF_NATIVE(pv_lock_ops, queued_spin_unlock, "movb $0, (%eax)");
-DEF_NATIVE(pv_lock_ops, vcpu_is_preempted, "xor %eax, %eax");
 #endif
 
 unsigned paravirt_patch_ident_32(void *insnbuf, unsigned len)
@@ -35,7 +34,6 @@ unsigned paravirt_patch_false(void *insnbuf, unsigned len)
 }
 
 extern bool pv_is_native_spin_unlock(void);
-extern bool pv_is_native_vcpu_is_preempted(void);
 
 unsigned native_patch(u8 type, u16 clobbers, void *ibuf,
 		      unsigned long addr, unsigned len)
@@ -65,14 +63,6 @@ unsigned native_patch(u8 type, u16 clobbers, void *ibuf,
 				goto patch_site;
 			}
 			goto patch_default;
-
-		case PARAVIRT_PATCH(pv_lock_ops.vcpu_is_preempted):
-			if (pv_is_native_vcpu_is_preempted()) {
-				start = start_pv_lock_ops_vcpu_is_preempted;
-				end   = end_pv_lock_ops_vcpu_is_preempted;
-				goto patch_site;
-			}
-			goto patch_default;
 #endif
 
 	default:
diff --git a/arch/x86/kernel/paravirt_patch_64.c b/arch/x86/kernel/paravirt_patch_64.c
index 8ab4379ceea9..64dffe4499b4 100644
--- a/arch/x86/kernel/paravirt_patch_64.c
+++ b/arch/x86/kernel/paravirt_patch_64.c
@@ -21,7 +21,6 @@ DEF_NATIVE(, xor, "xor %rax, %rax");
 
 #if defined(CONFIG_PARAVIRT_SPINLOCKS)
 DEF_NATIVE(pv_lock_ops, queued_spin_unlock, "movb $0, (%rdi)");
-DEF_NATIVE(pv_lock_ops, vcpu_is_preempted, "xor %rax, %rax");
 #endif
 
 unsigned paravirt_patch_ident_32(void *insnbuf, unsigned len)
@@ -43,7 +42,6 @@ unsigned paravirt_patch_false(void *insnbuf, unsigned len)
 }
 
 extern bool pv_is_native_spin_unlock(void);
-extern bool pv_is_native_vcpu_is_preempted(void);
 
 unsigned native_patch(u8 type, u16 clobbers, void *ibuf,
 		      unsigned long addr, unsigned len)
@@ -76,14 +74,6 @@ unsigned native_patch(u8 type, u16 clobbers, void *ibuf,
 				goto patch_site;
 			}
 			goto patch_default;
-
-		case PARAVIRT_PATCH(pv_lock_ops.vcpu_is_preempted):
-			if (pv_is_native_vcpu_is_preempted()) {
-				start = start_pv_lock_ops_vcpu_is_preempted;
-				end   = end_pv_lock_ops_vcpu_is_preempted;
-				goto patch_site;
-			}
-			goto patch_default;
 #endif
 
 	default:
-- 
2.12.3
