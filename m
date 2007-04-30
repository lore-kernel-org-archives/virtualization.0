From: ebiederm@xmission.com (Eric W. Biederman)
Subject: [PATCH 04/12] i386 voyager: Use modern techniques to setup and
	teardown low identiy mappings.
Date: Mon, 30 Apr 2007 09:57:40 -0600
Message-ID: <m1vefd4zyj.fsf_-_@ebiederm.dsl.xmission.com>
References: <m1d51l6f1y.fsf@ebiederm.dsl.xmission.com>
	<m18xc96eyq.fsf@ebiederm.dsl.xmission.com>
	<m14pmx6ewk.fsf_-_@ebiederm.dsl.xmission.com>
	<m1zm4p509a.fsf_-_@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <m1zm4p509a.fsf_-_@ebiederm.dsl.xmission.com> (Eric
	W. Biederman's message of "Mon, 30 Apr 2007 09:51:13 -0600")
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org, virtualization <virtualization@lists.linux-foundation.org>, James Bottomley <James.Bottomley@HansenPartnership.com>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org


This is a trivial and hopefully obviously correct patch to setup
and teardown the identity mappings the way the rest of arch/i386
does.

My new page table setup code will break some assumptions below so
this is my attempt to keep voyager working. 

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 arch/i386/mach-voyager/voyager_smp.c |   38 +++++----------------------------
 1 files changed, 6 insertions(+), 32 deletions(-)

diff --git a/arch/i386/mach-voyager/voyager_smp.c b/arch/i386/mach-voyager/voyager_smp.c
index b9ce33c..5e98ae7 100644
--- a/arch/i386/mach-voyager/voyager_smp.c
+++ b/arch/i386/mach-voyager/voyager_smp.c
@@ -536,15 +536,6 @@ do_boot_cpu(__u8 cpu)
 		& ~( voyager_extended_vic_processors
 		     & voyager_allowed_boot_processors);
 
-	/* For the 486, we can't use the 4Mb page table trick, so
-	 * must map a region of memory */
-#ifdef CONFIG_M486
-	int i;
-	unsigned long *page_table_copies = (unsigned long *)
-		__get_free_page(GFP_KERNEL);
-#endif
-	pgd_t orig_swapper_pg_dir0;
-
 	/* This is an area in head.S which was used to set up the
 	 * initial kernel stack.  We need to alter this to give the
 	 * booting CPU a new stack (taken from its idle process) */
@@ -587,24 +578,11 @@ do_boot_cpu(__u8 cpu)
 	VDEBUG(("VOYAGER SMP: Booting CPU%d at 0x%lx[%x:%x], stack %p\n", cpu, 
 		(unsigned long)hijack_source.val, hijack_source.idt.Segment,
 		hijack_source.idt.Offset, stack_start.esp));
-	/* set the original swapper_pg_dir[0] to map 0 to 4Mb transparently
-	 * (so that the booting CPU can find start_32 */
-	orig_swapper_pg_dir0 = swapper_pg_dir[0];
-#ifdef CONFIG_M486
-	if(page_table_copies == NULL)
-		panic("No free memory for 486 page tables\n");
-	for(i = 0; i < PAGE_SIZE/sizeof(unsigned long); i++)
-		page_table_copies[i] = (i * PAGE_SIZE) 
-			| _PAGE_RW | _PAGE_USER | _PAGE_PRESENT;
-
-	((unsigned long *)swapper_pg_dir)[0] = 
-		((virt_to_phys(page_table_copies)) & PAGE_MASK)
-		| _PAGE_RW | _PAGE_USER | _PAGE_PRESENT;
-#else
-	((unsigned long *)swapper_pg_dir)[0] = 
-		(virt_to_phys(pg0) & PAGE_MASK)
-		| _PAGE_RW | _PAGE_USER | _PAGE_PRESENT;
-#endif
+
+	/* init lowmem identity mapping */
+	clone_pgd_range(swapper_pg_dir, swapper_pg_dir + USER_PGD_PTRS,
+			min_t(unsigned long, KERNEL_PGD_PTRS, USER_PGD_PTRS));
+	flush_tlb_all();
 
 	if(quad_boot) {
 		printk("CPU %d: non extended Quad boot\n", cpu);
@@ -647,11 +625,7 @@ do_boot_cpu(__u8 cpu)
 		udelay(100);
 	}
 	/* reset the page table */
-	swapper_pg_dir[0] = orig_swapper_pg_dir0;
-	local_flush_tlb();
-#ifdef CONFIG_M486
-	free_page((unsigned long)page_table_copies);
-#endif
+	zap_low_mappings();
 	  
 	if (cpu_booted_map) {
 		VDEBUG(("CPU%d: Booted successfully, back in CPU %d\n",
-- 
1.5.1.1.181.g2de0
