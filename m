From: Jesper Juhl <jesper.juhl@gmail.com>
Subject: [PATCH][03/37] Clean up duplicate includes in arch/i386/xen/
Date: Sat, 21 Jul 2007 17:01:47 +0200
Message-ID: <200707211701.47855.jesper.juhl@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S938650AbXGUPEB@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Jesper Juhl <jesper.juhl@gmail.com>, Jeremy Fitzhardinge <jeremy@xensource.com>, Chris Wright <chrisw@sous-sol.org>, virtualization@lists.osdl.org, xen-devel@lists.xensource.com
List-Id: virtualization@lists.linuxfoundation.org

Hi,

This patch cleans up duplicate includes in
	arch/i386/xen/


Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

diff --git a/arch/i386/xen/enlighten.c b/arch/i386/xen/enlighten.c
index 9a8c118..f65ef89 100644
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
--- a/arch/i386/xen/mmu.c
+++ b/arch/i386/xen/mmu.c
@@ -41,7 +41,6 @@
 #include <linux/sched.h>
 #include <linux/highmem.h>
 #include <linux/bug.h>
-#include <linux/sched.h>
 
 #include <asm/pgtable.h>
 #include <asm/tlbflush.h>
