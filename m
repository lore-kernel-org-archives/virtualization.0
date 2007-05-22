From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: [patch 05/33] xen: paravirt: unstatic smp_store_cpu_info
Date: Tue, 22 May 2007 15:09:46 +0100
Message-ID: <20070522141251.267503488@goop.org>
References: <20070522140941.802382212@goop.org>
Return-path: <xen-devel-bounces@lists.xensource.com>
Content-Disposition: inline;
	filename=paravirt-unstatic-smp_store_cpu_info.patch
List-Unsubscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: Andrew Morton <akpm@linux-foundation.org>, Andi Kleen <ak@suse.de>
Cc: Chris Wright <chrisw@sous-sol.org>, virtualization@lists.osdl.org, Xen-devel <xen-devel@lists.xensource.com>, Linus Torvalds <torvalds@linux-foundation.org>, lkml <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

Paravirt implementations need to store cpu info when bringing up cpus.

Signed-off-by: Jeremy Fitzhardinge <jeremy@xensource.com>

---
 arch/i386/kernel/smpboot.c |    2 +-
 include/asm-i386/smp.h     |    2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

===================================================================
--- a/include/asm-i386/smp.h
+++ b/include/asm-i386/smp.h
@@ -129,6 +132,8 @@ extern void __cpu_die(unsigned int cpu);
 extern void __cpu_die(unsigned int cpu);
 extern unsigned int num_processors;
 
+void __cpuinit smp_store_cpu_info(int id);
+
 #endif /* !__ASSEMBLY__ */
 
 #else /* CONFIG_SMP */
===================================================================
--- a/arch/i386/kernel/smpboot.c
+++ b/arch/i386/kernel/smpboot.c
@@ -148,7 +148,7 @@ void __init smp_alloc_memory(void)
  * a given CPU
  */
 
-static void __cpuinit smp_store_cpu_info(int id)
+void __cpuinit smp_store_cpu_info(int id)
 {
 	struct cpuinfo_x86 *c = cpu_data + id;
 

-- 
