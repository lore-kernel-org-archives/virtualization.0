From: Glauber de Oliveira Costa <gcosta@redhat.com>
Subject: [PATCH 22/24] prepare x86_64 architecture initialization for
	paravirt
Date: Fri,  9 Nov 2007 16:43:03 -0200
Message-ID: <11946339033567-git-send-email-gcosta__16190.3893728324$1194645997$gmane$org@redhat.com>
References: <11946337851964-git-send-email-gcosta@redhat.com>
	<11946337933104-git-send-email-gcosta@redhat.com>
	<11946337991750-git-send-email-gcosta@redhat.com>
	<11946338053158-git-send-email-gcosta@redhat.com>
	<11946338103068-git-send-email-gcosta@redhat.com>
	<1194633815833-git-send-email-gcosta@redhat.com>
	<11946338212915-git-send-email-gcosta@redhat.com>
	<11946338263902-git-send-email-gcosta@redhat.com>
	<1194633831882-git-send-email-gcosta@redhat.com>
	<11946338361369-git-send-email-gcosta@redhat.com>
	<11946338413283-git-send-email-gcosta@redhat.com>
	<11946338473652-git-send-email-gcosta@redhat.com>
	<1194633852469-git-send-email-gcosta@redhat.com>
	<1194633857930-git-send-email-gcosta@redhat.com>
	<11946338621966-git-send-email-gcosta@redhat.com>
	<11946338683305-git-send-email-gcosta@redhat.com>
	<1194633873306-git-send-email-gcosta@redhat.com>
	<1194633878886-git-send-email-gcosta@redhat.com>
	<11946338832681-git-send-email-gcosta@redhat.com>
	<1194633888761-git-send-email-gco!
	sta@redhat.com> <11946338932611-git-send-email-gcosta@redhat.com>
	<1194633898545-git-send-email-gcosta@redhat.com>
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1194633898545-git-send-email-gcosta@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org
Cc: lguest@ozlabs.org, kvm-devel@lists.sourceforge.net, ak@suse.de, virtualization@lists.linux-foundation.org, chrisw@sous-sol.org, tglx@linutronix.de, anthony@codemonkey.ws, akpm@linux-foundation.org, Glauber de Oliveira Costa <gcosta@redhat.com>, mingo@elte.hu
List-Id: virtualization@lists.linuxfoundation.org

This patch prepares the x86_64 architecture initialization for
paravirt. It requires a memory initialization step, which is done
by implementing 64-bit version for machine_specific_memory_setup,
and putting an ARCH_SETUP hook, for guest-dependent initialization.
This last step is done akin to i386

Signed-off-by: Glauber de Oliveira Costa <gcosta@redhat.com>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
Acked-by: Jeremy Fitzhardinge <jeremy@xensource.com>
---
 arch/x86/kernel/e820_64.c  |    9 +++++++--
 arch/x86/kernel/setup_64.c |   28 +++++++++++++++++++++++++++-
 include/asm-x86/setup.h    |   11 ++++++++---
 3 files changed, 42 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/e820_64.c b/arch/x86/kernel/e820_64.c
index 0128b0b..eed900b 100644
--- a/arch/x86/kernel/e820_64.c
+++ b/arch/x86/kernel/e820_64.c
@@ -639,8 +639,10 @@ void early_panic(char *msg)
 	panic(msg);
 }
 
-void __init setup_memory_region(void)
+/* We're not void only for x86 32-bit compat */
+char * __init machine_specific_memory_setup(void)
 {
+	char *who = "BIOS-e820";
 	/*
 	 * Try to copy the BIOS-supplied E820-map.
 	 *
@@ -651,7 +653,10 @@ void __init setup_memory_region(void)
 	if (copy_e820_map(boot_params.e820_map, boot_params.e820_entries) < 0)
 		early_panic("Cannot find a valid memory map");
 	printk(KERN_INFO "BIOS-provided physical RAM map:\n");
-	e820_print_map("BIOS-e820");
+	e820_print_map(who);
+
+	/* In case someone cares... */
+	return who;
 }
 
 static int __init parse_memopt(char *p)
diff --git a/arch/x86/kernel/setup_64.c b/arch/x86/kernel/setup_64.c
index 2451a63..1c9f237 100644
--- a/arch/x86/kernel/setup_64.c
+++ b/arch/x86/kernel/setup_64.c
@@ -39,6 +39,7 @@
 #include <linux/dmi.h>
 #include <linux/dma-mapping.h>
 #include <linux/ctype.h>
+#include <linux/uaccess.h>
 
 #include <asm/mtrr.h>
 #include <asm/uaccess.h>
@@ -61,6 +62,12 @@
 #include <asm/cacheflush.h>
 #include <asm/mce.h>
 
+#ifdef CONFIG_PARAVIRT
+#include <asm/paravirt.h>
+#else
+#define ARCH_SETUP
+#endif
+
 /*
  * Machine setup..
  */
@@ -244,6 +251,16 @@ static void discover_ebda(void)
 	 * 4K EBDA area at 0x40E
 	 */
 	ebda_addr = *(unsigned short *)__va(EBDA_ADDR_POINTER);
+	/*
+	 * There can be some situations, like paravirtualized guests,
+	 * in which there is no available ebda information. In such
+	 * case, just skip it
+	 */
+	if (!ebda_addr) {
+		ebda_size = 0;
+		return;
+	}
+
 	ebda_addr <<= 4;
 
 	ebda_size = *(unsigned short *)__va(ebda_addr);
@@ -257,6 +274,12 @@ static void discover_ebda(void)
 		ebda_size = 64*1024;
 }
 
+/* Overridden in paravirt.c if CONFIG_PARAVIRT */
+void __attribute__((weak)) memory_setup(void)
+{
+       machine_specific_memory_setup();
+}
+
 void __init setup_arch(char **cmdline_p)
 {
 	printk(KERN_INFO "Command line: %s\n", boot_command_line);
@@ -272,7 +295,10 @@ void __init setup_arch(char **cmdline_p)
 	rd_prompt = ((boot_params.hdr.ram_size & RAMDISK_PROMPT_FLAG) != 0);
 	rd_doload = ((boot_params.hdr.ram_size & RAMDISK_LOAD_FLAG) != 0);
 #endif
-	setup_memory_region();
+
+	ARCH_SETUP
+
+	memory_setup();
 	copy_edd();
 
 	if (!boot_params.hdr.root_flags)
diff --git a/include/asm-x86/setup.h b/include/asm-x86/setup.h
index 24d786e..071e054 100644
--- a/include/asm-x86/setup.h
+++ b/include/asm-x86/setup.h
@@ -3,6 +3,13 @@
 
 #define COMMAND_LINE_SIZE 2048
 
+#ifndef __ASSEMBLY__
+char *machine_specific_memory_setup(void);
+#ifndef CONFIG_PARAVIRT
+#define paravirt_post_allocator_init()	do {} while (0)
+#endif
+#endif /* __ASSEMBLY__ */
+
 #ifdef __KERNEL__
 
 #ifdef __i386__
@@ -51,9 +58,7 @@ void __init add_memory_region(unsigned long long start,
 
 extern unsigned long init_pg_tables_end;
 
-#ifndef CONFIG_PARAVIRT
-#define paravirt_post_allocator_init()	do {} while (0)
-#endif
+
 
 #endif /* __i386__ */
 #endif /* _SETUP */
-- 
1.4.4.2
