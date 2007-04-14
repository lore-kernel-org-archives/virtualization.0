From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: [PATCH 01/28] revert account-for-module-percpu-space-separately-from-kernel-percpu
Date: Sat, 14 Apr 2007 13:41:55 -0700
Message-ID: <20070414204923.447804915@goop.org>
References: <20070414204154.871250608@goop.org>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753841AbXDNVUP@vger.kernel.org>
Content-Disposition: inline; filename=revert-mm-x86_64-mm-account-for-module-percpu-space-separately-from-kernel-percpu.patch
Sender: linux-kernel-owner@vger.kernel.org
To: Andi Kleen <ak@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, virtualization@lists.osdl.org, lkml <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

Signed-off-by: Jeremy Fitzhardinge <jeremy@xensource.com>

---
 include/asm-i386/percpu.h |   10 ----------
 1 file changed, 10 deletions(-)

===================================================================
--- a/include/asm-i386/percpu.h
+++ b/include/asm-i386/percpu.h
@@ -4,16 +4,6 @@
 #ifndef __ASSEMBLY__
 #include <asm-generic/percpu.h>
 #else
-
-#ifdef CONFIG_MODULES
-# define PERCPU_MODULE_RESERVE 8192
-#else
-# define PERCPU_MODULE_RESERVE 0
-#endif
-
-#define PERCPU_ENOUGH_ROOM \
-	(ALIGN(__per_cpu_end - __per_cpu_start, SMP_CACHE_BYTES) + \
-	 PERCPU_MODULE_RESERVE)
 
 /*
  * PER_CPU finds an address of a per-cpu variable.

-- 
