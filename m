From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: [PATCH] mm: fix comment formatting in
	asm-generic/pgtable.h:__ptep_modify_prot_
Date: Mon, 02 Jun 2008 14:02:34 +0100
Message-ID: <4843EF6A.20305@goop.org>
References: <patchbomb.1212192268@localhost>
	<4deead25e96efc8ca783.1212192269@localhost>
	<20080602111339.GB18586@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <xen-devel-bounces@lists.xensource.com>
In-Reply-To: <20080602111339.GB18586@elte.hu>
List-Unsubscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: Ingo Molnar <mingo@elte.hu>
Cc: Zachary Amsden <zach@vmware.com>, Rusty Russell <rusty@rustcorp.com.au>, xen-devel <xen-devel@lists.xensource.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, kvm-devel <kvm-devel@lists.sourceforge.net>, x86@kernel.org, LKML <linux-kernel@vger.kernel.org>, Virtualization Mailing List <virtualization@lists.osdl.org>, Hugh Dickins <hugh@veritas.com>, Thomas Gleixner <tglx@linutronix.de>, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Signed-off-by: Jeremy Fitzhardinge <jeremy.fitzhardinge@citrix.com>
---
 include/asm-generic/pgtable.h |   14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

===================================================================
--- a/include/asm-generic/pgtable.h
+++ b/include/asm-generic/pgtable.h
@@ -201,9 +201,11 @@
 					     unsigned long addr,
 					     pte_t *ptep)
 {
-	/* Get the current pte state, but zero it out to make it
-	   non-present, preventing the hardware from asynchronously
-	   updating it. */
+	/*
+	 * Get the current pte state, but zero it out to make it
+	 * non-present, preventing the hardware from asynchronously
+	 * updating it.
+	 */
 	return ptep_get_and_clear(mm, addr, ptep);
 }
 
@@ -211,8 +213,10 @@
 					     unsigned long addr,
 					     pte_t *ptep, pte_t pte)
 {
-	/* The pte is non-present, so there's no hardware state to
-	   preserve. */
+	/*
+	 * The pte is non-present, so there's no hardware state to
+	 * preserve.
+	 */
 	set_pte_at(mm, addr, ptep, pte);
 }
