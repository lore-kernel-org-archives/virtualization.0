From: Glauber Costa <gcosta@redhat.com>
Subject: [PATCH 3/5] [PATCH] call vsmp_init explicitly
Date: Mon, 11 Feb 2008 17:16:03 -0200
Message-ID: <1202757365-18634-3-git-send-email-gcosta__16538.5508248166$1202770573$gmane$org@redhat.com>
References: <1202757365-18634-1-git-send-email-gcosta@redhat.com>
	<1202757365-18634-2-git-send-email-gcosta@redhat.com>
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1202757365-18634-2-git-send-email-gcosta@redhat.com>
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
Cc: ehabkost@redhat.com, shai@scalemp.com, ak@suse.de, virtualization@lists.linux-foundation.org, chrisw@sous-sol.org, tglx@linutronix.de, kiran@scalemp.com, anthony@codemonkey.ws, akpm@linux-foundation.org, Glauber Costa <gcosta@redhat.com>, mingo@elte.hu
List-Id: virtualization@lists.linuxfoundation.org

It becomes to early for ioremap, so we use early_ioremap

Signed-off-by: Glauber Costa <gcosta@redhat.com>
Signed-off-by: Ravikiran Thirumalai <kiran@scalemp.com>
Acked-by: Shai Fultheim <shai@scalemp.com>
---
 arch/x86/kernel/setup_64.c |    4 ++++
 arch/x86/kernel/vsmp_64.c  |   11 +++++------
 include/asm-x86/setup.h    |    4 ++++
 3 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/setup_64.c b/arch/x86/kernel/setup_64.c
index a49f5f7..6f5571c 100644
--- a/arch/x86/kernel/setup_64.c
+++ b/arch/x86/kernel/setup_64.c
@@ -346,6 +346,10 @@ #endif
 	if (efi_enabled)
 		efi_init();
 
+#ifdef	CONFIG_PARAVIRT
+	vsmp_init();
+#endif
+
 	dmi_scan_machine();
 
 	io_delay_init();
diff --git a/arch/x86/kernel/vsmp_64.c b/arch/x86/kernel/vsmp_64.c
index 9766917..fdf9fba 100644
--- a/arch/x86/kernel/vsmp_64.c
+++ b/arch/x86/kernel/vsmp_64.c
@@ -16,10 +16,10 @@ #include <linux/pci_regs.h>
 #include <asm/pci-direct.h>
 #include <asm/io.h>
 
-static void __init vsmp_init(void)
+void __init vsmp_init(void)
 {
 	void *address;
-	unsigned int cap, ctl;
+	unsigned int cap, ctl, cfg;
 
 	if (!early_pci_allowed())
 		return;
@@ -32,7 +32,8 @@ static void __init vsmp_init(void)
 		return;
 
 	/* set vSMP magic bits to indicate vSMP capable kernel */
-	address = ioremap(read_pci_config(0, 0x1f, 0, PCI_BASE_ADDRESS_0), 8);
+	cfg = read_pci_config(0, 0x1f, 0, PCI_BASE_ADDRESS_0);
+	address = early_ioremap(cfg, 8);
 	cap = readl(address);
 	ctl = readl(address + 4);
 	printk(KERN_INFO "vSMP CTL: capabilities:0x%08x  control:0x%08x\n",
@@ -45,8 +46,6 @@ static void __init vsmp_init(void)
 		printk(KERN_INFO "vSMP CTL: control set to:0x%08x\n", ctl);
 	}
 
-	iounmap(address);
+	early_iounmap(address, 8);
 	return;
 }
-
-core_initcall(vsmp_init);
diff --git a/include/asm-x86/setup.h b/include/asm-x86/setup.h
index 071e054..f745de2 100644
--- a/include/asm-x86/setup.h
+++ b/include/asm-x86/setup.h
@@ -4,6 +4,10 @@ #define _ASM_X86_SETUP_H
 #define COMMAND_LINE_SIZE 2048
 
 #ifndef __ASSEMBLY__
+
+/* Interrupt control for vSMPowered x86_64 systems */
+void vsmp_init(void);
+
 char *machine_specific_memory_setup(void);
 #ifndef CONFIG_PARAVIRT
 #define paravirt_post_allocator_init()	do {} while (0)
-- 
1.4.2
