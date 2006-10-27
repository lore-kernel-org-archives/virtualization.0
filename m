From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH 1/4] Prep for paravirt: move pagetable includes.
Date: Fri, 27 Oct 2006 13:38:44 +1000
Message-ID: <1161920325.17807.29.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1946148AbWJ0Div@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>
Cc: lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

Move header includes for the nopud / nopmd types to the location of the
actual pte / pgd type definitions.  This allows generic 4-level page
type code to be written before the split 2/3 level page table headers are
included.

Signed-off-by: Zachary Amsden <zach@vmware.com>
Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>

===================================================================
--- a/include/asm-i386/page.h
+++ b/include/asm-i386/page.h
@@ -52,6 +52,7 @@ typedef struct { unsigned long long pgpr
 #define pte_val(x)	((x).pte_low | ((unsigned long long)(x).pte_high << 32))
 #define __pmd(x) ((pmd_t) { (x) } )
 #define HPAGE_SHIFT	21
+#include <asm-generic/pgtable-nopud.h>
 #else
 typedef struct { unsigned long pte_low; } pte_t;
 typedef struct { unsigned long pgd; } pgd_t;
@@ -59,6 +60,7 @@ typedef struct { unsigned long pgprot; }
 #define boot_pte_t pte_t /* or would you rather have a typedef */
 #define pte_val(x)	((x).pte_low)
 #define HPAGE_SHIFT	22
+#include <asm-generic/pgtable-nopmd.h>
 #endif
 #define PTE_MASK	PAGE_MASK
 
===================================================================
--- a/include/asm-i386/pgtable-2level.h
+++ b/include/asm-i386/pgtable-2level.h
@@ -1,7 +1,5 @@
 #ifndef _I386_PGTABLE_2LEVEL_H
 #define _I386_PGTABLE_2LEVEL_H
-
-#include <asm-generic/pgtable-nopmd.h>
 
 #define pte_ERROR(e) \
 	printk("%s:%d: bad pte %08lx.\n", __FILE__, __LINE__, (e).pte_low)
===================================================================
--- a/include/asm-i386/pgtable-3level.h
+++ b/include/asm-i386/pgtable-3level.h
@@ -1,7 +1,5 @@
 #ifndef _I386_PGTABLE_3LEVEL_H
 #define _I386_PGTABLE_3LEVEL_H
-
-#include <asm-generic/pgtable-nopud.h>
 
 /*
  * Intel Physical Address Extension (PAE) Mode - three-level page
