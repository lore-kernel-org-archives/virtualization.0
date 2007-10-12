From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: [PATCH 02/10] Clean up duplicate includes in
	arch/i386/xen/
Date: Fri, 12 Oct 2007 14:11:34 -0700
Message-ID: <20071012211147.800072000@goop.org>
References: <20071012211132.198718000@goop.org>
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
To: LKML <linux-kernel@vger.kernel.org>
Cc: xen-devel@lists.xensource.com, virtualization@lists.osdl.org, Jesper Juhl <jesper.juhl@gmail.com>, Chris Wright <chrisw@sous-sol.org>, Andi Kleen <ak@muc.de>, Andrew Morton <akpm@linux-foundation.org>, Keir Fraser <keir@xensource.com>
List-Id: virtualization@lists.linuxfoundation.org

This patch cleans up duplicate includes in
	arch/i386/xen/

Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
Signed-off-by: Jeremy Fitzhardinge <jeremy@xensource.com>
---
 arch/i386/xen/enlighten.c |    1 -
 arch/i386/xen/mmu.c       |    2 --
 2 files changed, 3 deletions(-)

===================================================================
--- a/arch/i386/xen/enlighten.c
+++ b/arch/i386/xen/enlighten.c
@@ -25,7 +25,6 @@
 #include <linux/mm.h>
 #include <linux/page-flags.h>
 #include <linux/highmem.h>
-#include <linux/smp.h>
 
 #include <xen/interface/xen.h>
 #include <xen/interface/physdev.h>
diff --git a/arch/i386/xen/mmu.c b/arch/i386/xen/mmu.c
index 4ae038a..35691a2 100644
===================================================================
--- a/arch/i386/xen/mmu.c
+++ b/arch/i386/xen/mmu.c
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
