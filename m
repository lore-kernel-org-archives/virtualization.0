From: Chris Wright <chrisw@sous-sol.org>
Subject: [patch 42/45] lguest: wire up pte_update/pte_update_defer
Date: Tue, 31 Mar 2009 16:11:27 -0700
Message-ID: <20090331231802.875046298@sous-sol.org>
References: <20090331231045.719396245@sous-sol.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline;
	filename=lguest-wire-up-pte_update-pte_update_defer.patch
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Theodore Ts'o <tytso@mit.edu>, Zwane Mwaikambo <zwane@arm.linux.org.uk>, Eugene Teo <eteo@redhat.com>, Justin Forbes <jmforbes@linuxtx.org>, Domenico Andreoli <cavokz@gmail.com>, Chris Wedgwood <reviews@ml.cw.f00f.org>, Jake Edge <jake@lwn.net>, virtualization@lists.osdl.org, Michael Krufky <mkrufky@linuxtv.org>, alan@lxorguk.ukuu.org.uk, Chuck Ebbert <cebbert@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>, akpm@linux-foundation.org, torvalds@linux-foundation.org, Willy Tarreau <w@1wt.eu>, Rodrigo Rubira Branco <rbranco@la.checkpoint.com>
List-Id: virtualization@lists.linuxfoundation.org

-stable review patch.  If anyone has any objections, please let us know.
---------------------

From: Rusty Russell <rusty@rustcorp.com.au>

upstream commit: b7ff99ea53cd16de8f6166c0e98f19a7c6ca67ee

Impact: intermittent guest segv/crash fix

I've been seeing random guest bad address crashes and segmentation faults:
bisect led to 4f98a2fee8 (vmscan: split LRU lists into anon & file sets),
but that's a red herring.

It turns out that lguest never hooked up the pte_update/pte_update_defer
calls, so our ptes were not always in sync.  After the vmscan commit, the
bug became reproducible; now a fsck in a 64MB guest causes reproducible
pagetable corruption.

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
Cc: jeremy@xensource.com
Cc: virtualization@lists.osdl.org
Cc: stable@kernel.org
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---
 arch/x86/lguest/boot.c |   10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

--- a/arch/x86/lguest/boot.c
+++ b/arch/x86/lguest/boot.c
@@ -485,11 +485,17 @@ static void lguest_write_cr4(unsigned lo
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
@@ -1034,6 +1040,8 @@ __init void lguest_init(void)
 	pv_mmu_ops.read_cr3 = lguest_read_cr3;
 	pv_mmu_ops.lazy_mode.enter = paravirt_enter_lazy_mmu;
 	pv_mmu_ops.lazy_mode.leave = lguest_leave_lazy_mode;
+	pv_mmu_ops.pte_update = lguest_pte_update;
+	pv_mmu_ops.pte_update_defer = lguest_pte_update;
 
 #ifdef CONFIG_X86_LOCAL_APIC
 	/* apic read/write intercepts */
