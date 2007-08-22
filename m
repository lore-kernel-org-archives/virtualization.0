From: Zachary Amsden <zach@vmware.com>
Subject: [PATCH] Fix lazy mode vmalloc synchronization for paravirt
Date: Tue, 21 Aug 2007 18:30:36 -0700
Message-ID: <46CB91BC.2010808@vmware.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------060406000404010004030508"
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755095AbXHVBfx@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Virtualization Mailing List <virtualization@lists.osdl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>, Chris Wright <chrisw@sous-so>
Cc: Ben Collins <ben.collins@ubuntu.com>
List-Id: virtualization@lists.linuxfoundation.org

This is a multi-part message in MIME format.
--------------060406000404010004030508
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Found this looping Ubuntu installs with VMI.

If unlucky enough to hit a vmalloc sync fault during a lazy mode 
operation (from an IRQ handler for a module which was not yet populated 
in current page directory, or from inside copy_one_pte, which touches 
swap_map, and hit in an unused 4M region), the required PDE update would 
never get flushed, causing an infinite page fault loop.

This bug affects any paravirt-ops backend which uses lazy updates, I 
believe that makes it a bug in Xen, VMI and lguest.  It only happens on 
LOWMEM kernels.

Currently for 2.6.23, but we'll want to backport to -stable as well.

Zach

--------------060406000404010004030508
Content-Type: text/x-patch;
 name="i386-linus-vmalloc-paravirt-fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="i386-linus-vmalloc-paravirt-fix.patch"

    Touching vmalloc memory in the middle of a lazy mode update can generate
    a kernel PDE update, which must be flushed immediately.  The fix is to
    leave lazy mode when doing a vmalloc sync.
    
    Signed-off-by: Zachary Amsden <zach@vmware.com>

diff --git a/arch/i386/mm/fault.c b/arch/i386/mm/fault.c
diff --git a/arch/i386/mm/fault.c b/arch/i386/mm/fault.c
index 01ffdd4..fcb38e7 100644
--- a/arch/i386/mm/fault.c
+++ b/arch/i386/mm/fault.c
@@ -249,9 +249,10 @@ static inline pmd_t *vmalloc_sync_one(pgd_t *pgd, unsigned long address)
 	pmd_k = pmd_offset(pud_k, address);
 	if (!pmd_present(*pmd_k))
 		return NULL;
-	if (!pmd_present(*pmd))
+	if (!pmd_present(*pmd)) {
 		set_pmd(pmd, *pmd_k);
-	else
+		arch_flush_lazy_mmu_mode();
+	} else
 		BUG_ON(pmd_page(*pmd) != pmd_page(*pmd_k));
 	return pmd_k;
 }

--------------060406000404010004030508--
