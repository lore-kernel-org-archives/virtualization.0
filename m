From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: [PATCH 04/12] Clean up duplicate includes in
	arch/i386/xen/
Date: Mon, 15 Oct 2007 13:48:44 -0700
Message-ID: <20071015210114.891237072@goop.org>
References: <20071015204840.074767068@goop.org>
Return-path: <xen-devel-bounces@lists.xensource.com>
Content-Disposition: inline; filename=xen-clean-up-duplicate-includes.patch
List-Unsubscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: xen-devel@lists.xensource.com, Jesper Juhl <jesper.juhl@gmail.com>, LKML <linux-kernel@vger.kernel.org>, Andi Kleen <ak@suse.de>, Chris Wright <chrisw@sous-sol.org>, virtualization@lists.osdl.org, Andrew Morton <akpm@linux-foundation.org>, Keir Fraser <keir@xensource.com>, Stable Kernel <stable@kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

This patch cleans up duplicate includes in
	arch/i386/xen/

Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
Signed-off-by: Jeremy Fitzhardinge <jeremy@xensource.com>
---
 arch/x86/xen/enlighten.c |    1 -
 arch/x86/xen/mmu.c       |    2 --
 2 files changed, 3 deletions(-)

===================================================================
--- a/arch/x86/xen/enlighten.c
+++ b/arch/x86/xen/enlighten.c
@@ -25,7 +25,6 @@
 #include <linux/mm.h>
 #include <linux/page-flags.h>
 #include <linux/highmem.h>
-#include <linux/smp.h>
 
 #include <xen/interface/xen.h>
 #include <xen/interface/physdev.h>
diff --git a/arch/x86/xen/mmu.c b/arch/x86/xen/mmu.c
index 4ae038a..35691a2 100644
===================================================================
--- a/arch/x86/xen/mmu.c
+++ b/arch/x86/xen/mmu.c
@@ -41,7 +41,6 @@
 #include <linux/sched.h>
 #include <linux/highmem.h>
 #include <linux/bug.h>
-#include <linux/sched.h>
 
 #include <asm/pgtable.h>
 #include <asm/tlbflush.h>
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

-- 
