From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: [patch 02/20] XEN-paravirt: Add a flag to allow the VGA
	console to be disabled
Date: Fri, 12 Jan 2007 17:45:41 -0800
Message-ID: <20070113014647.240188180@goop.org>
References: <20070113014539.408244126@goop.org>
Return-path: <xen-devel-bounces@lists.xensource.com>
Content-Disposition: inline; filename=vgacon-enable-flag.patch
List-Unsubscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: Andrew Morton <akpm@osdl.org>
Cc: virtualization@lists.osdl.org, Gerd Hoffmann <kraxel@suse.de>, xen-devel@lists.xensource.com, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

Add a flag to allow the VGA console to be disabled.  The VGA code will
spin forever if there isn't any real VGA hardware, which will happen
under Xen.

Signed-off-by: Jeremy Fitzhardinge <jeremy@xensource.com>
Signed-off-by: Gerd Hoffmann <kraxel@suse.de>
Cc: Andrew Morton <akpm@osdl.org>

===================================================================
--- a/arch/i386/kernel/setup.c
+++ b/arch/i386/kernel/setup.c
@@ -71,6 +71,9 @@ unsigned long init_pg_tables_end __initd
 
 int disable_pse __devinitdata = 0;
 
+/* use to runtime disable vga_con */
+int vgacon_enabled = 1;
+ 
 /*
  * Machine setup..
  */
@@ -652,7 +655,7 @@ void __init setup_arch(char **cmdline_p)
 
 #ifdef CONFIG_VT
 #if defined(CONFIG_VGA_CONSOLE)
-	if (!efi_enabled || (efi_mem_type(0xa0000) != EFI_CONVENTIONAL_MEMORY))
+	if (vgacon_enabled && (!efi_enabled || (efi_mem_type(0xa0000) != EFI_CONVENTIONAL_MEMORY)))
 		conswitchp = &vga_con;
 #elif defined(CONFIG_DUMMY_CONSOLE)
 	conswitchp = &dummy_con;
===================================================================
--- a/include/asm-i386/setup.h
+++ b/include/asm-i386/setup.h
@@ -77,6 +77,8 @@ void __init add_memory_region(unsigned l
 void __init add_memory_region(unsigned long long start,
 			      unsigned long long size, int type);
 
+extern int vgacon_enabled;
+
 #endif /* __ASSEMBLY__ */
 
 #endif  /*  __KERNEL__  */

-- 
