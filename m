From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: [patch 06/33] xen: paravirt: make siblingmap functions
	visible
Date: Tue, 22 May 2007 15:09:47 +0100
Message-ID: <20070522141251.350437872@goop.org>
References: <20070522140941.802382212@goop.org>
Return-path: <xen-devel-bounces@lists.xensource.com>
Content-Disposition: inline; filename=paravirt-unstatic-siblingmaps.patch
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

Paravirt implementations need to set the sibling map on new cpus.

Signed-off-by: Jeremy Fitzhardinge <jeremy@xensource.com>
---
 arch/i386/kernel/smpboot.c |    6 ++----
 include/asm-i386/smp.h     |    3 +++
 2 files changed, 5 insertions(+), 4 deletions(-)

===================================================================
--- a/include/asm-i386/smp.h
+++ b/include/asm-i386/smp.h
@@ -43,9 +43,12 @@ extern u8 x86_cpu_to_apicid[];
 
 #define cpu_physical_id(cpu)	x86_cpu_to_apicid[cpu]
 
+extern void set_cpu_sibling_map(int cpu);
+
 #ifdef CONFIG_HOTPLUG_CPU
 extern void cpu_exit_clear(void);
 extern void cpu_uninit(void);
+extern void remove_siblinginfo(int cpu);
 #endif
 
 struct smp_ops
===================================================================
--- a/arch/i386/kernel/smpboot.c
+++ b/arch/i386/kernel/smpboot.c
@@ -308,8 +308,7 @@ cpumask_t cpu_coregroup_map(int cpu)
 /* representing cpus for which sibling maps can be computed */
 static cpumask_t cpu_sibling_setup_map;
 
-static inline void
-set_cpu_sibling_map(int cpu)
+void set_cpu_sibling_map(int cpu)
 {
 	int i;
 	struct cpuinfo_x86 *c = cpu_data;
@@ -1157,8 +1156,7 @@ void __init native_smp_prepare_boot_cpu(
 }
 
 #ifdef CONFIG_HOTPLUG_CPU
-static void
-remove_siblinginfo(int cpu)
+void remove_siblinginfo(int cpu)
 {
 	int sibling;
 	struct cpuinfo_x86 *c = cpu_data;

-- 
