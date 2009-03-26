From: Rusty Russell <rusty-8n+1lVoiYb80n/F98K4Iww@public.gmane.org>
Subject: [PATCH 2/5] lguest: wire up pte_update/pte_update_defer
Date: Fri, 27 Mar 2009 10:22:02 +1030
Message-ID: <200903271022.03020.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lguest-bounces+glkvl-lguest=m.gmane.org-mnsaURCQ41sdnm+yROfE0A@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <https://ozlabs.org/mailman/options/lguest>,
	<mailto:lguest-request-mnsaURCQ41sdnm+yROfE0A@public.gmane.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/lguest>
List-Post: <mailto:lguest-mnsaURCQ41sdnm+yROfE0A@public.gmane.org>
List-Help: <mailto:lguest-request-mnsaURCQ41sdnm+yROfE0A@public.gmane.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/lguest>,
	<mailto:lguest-request-mnsaURCQ41sdnm+yROfE0A@public.gmane.org?subject=subscribe>
Sender: lguest-bounces+glkvl-lguest=m.gmane.org-mnsaURCQ41sdnm+yROfE0A@public.gmane.org
Errors-To: lguest-bounces+glkvl-lguest=m.gmane.org-mnsaURCQ41sdnm+yROfE0A@public.gmane.org
To: lguest-mnsaURCQ41sdnm+yROfE0A@public.gmane.org
Cc: virtualization-qjLDD68F18O7TbgM5vRIOg@public.gmane.org, stable-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Ingo Molnar <mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jeremy-8XJ3FbD+ij9l57MIdRCFDg@public.gmane.org
List-Id: virtualization@lists.linuxfoundation.org


Impact: intermittent guest segv/crash fix

I've been seeing random guest bad address crashes and segmentation faults:
bisect led to 4f98a2fee8 (vmscan: split LRU lists into anon & file sets),
but that's a red herring.

It turns out that lguest never hooked up the pte_update/pte_update_defer
calls, so our ptes were not always in sync.  After the vmscan commit, the
bug became reproducible; now a fsck in a 64MB guest causes reproducible
pagetable corruption.

Signed-off-by: Rusty Russell <rusty-8n+1lVoiYb80n/F98K4Iww@public.gmane.org>
Cc: jeremy-8XJ3FbD+ij9l57MIdRCFDg@public.gmane.org
Cc: virtualization-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
Cc: stable-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
---
 arch/x86/lguest/boot.c |   10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/x86/lguest/boot.c b/arch/x86/lguest/boot.c
index 65f0b8a..c3bdf0b 100644
--- a/arch/x86/lguest/boot.c
+++ b/arch/x86/lguest/boot.c
@@ -475,11 +480,17 @@ static void lguest_write_cr4(unsigned long val)
  * into a process' address space.  We set the entry then tell the Host the
  * toplevel and address this corresponds to.  The Guest uses one pagetable per
  * process, so we need to tell the Host which one we're changing (mm->pgd). */
+static void lguest_pte_update(struct mm_struct *mm, unsigned long addr,
+			       pte_t *ptep)
+{
+	lazy_hcall(LHCALL_SET_PTE, __pa(mm->pgd), addr, ptep->pte_low);
+}
+
 static void lguest_set_pte_at(struct mm_struct *mm, unsigned long addr,
 			      pte_t *ptep, pte_t pteval)
 {
 	*ptep = pteval;
-	lazy_hcall(LHCALL_SET_PTE, __pa(mm->pgd), addr, pteval.pte_low);
+	lguest_pte_update(mm, addr, ptep);
 }
 
 /* The Guest calls this to set a top-level entry.  Again, we set the entry then
@@ -1018,6 +1046,8 @@ __init void lguest_init(void)
 	pv_mmu_ops.read_cr3 = lguest_read_cr3;
 	pv_mmu_ops.lazy_mode.enter = paravirt_enter_lazy_mmu;
 	pv_mmu_ops.lazy_mode.leave = lguest_leave_lazy_mode;
+	pv_mmu_ops.pte_update = lguest_pte_update;
+	pv_mmu_ops.pte_update_defer = lguest_pte_update;
 
 #ifdef CONFIG_X86_LOCAL_APIC
 	/* apic read/write intercepts */
