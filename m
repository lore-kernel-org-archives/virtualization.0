From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: [PATCH 12/28] i386: now its ok to use identify_boot_cpu
Date: Sat, 14 Apr 2007 13:42:06 -0700
Message-ID: <20070414204924.272309498@goop.org>
References: <20070414204154.871250608@goop.org>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753846AbXDNVXI@vger.kernel.org>
Content-Disposition: inline; filename=cleanup-identify_cpu-fix.patch
Sender: linux-kernel-owner@vger.kernel.org
To: Andi Kleen <ak@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, virtualization@lists.osdl.org, lkml <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

Signed-off-by: Jeremy Fitzhardinge <jeremy@xensource.com>

---
 arch/i386/kernel/cpu/bugs.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

===================================================================
--- a/arch/i386/kernel/cpu/bugs.c
+++ b/arch/i386/kernel/cpu/bugs.c
@@ -177,7 +177,7 @@ static void __init check_config(void)
 
 void __init check_bugs(void)
 {
-	identify_cpu(&boot_cpu_data);
+	identify_boot_cpu();
 #ifndef CONFIG_SMP
 	printk("CPU: ");
 	print_cpu_info(&boot_cpu_data);

-- 
