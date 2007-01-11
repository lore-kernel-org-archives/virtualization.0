From: Gerd Hoffmann <kraxel@suse.de>
Subject: Re: Oops
Date: Thu, 11 Jan 2007 16:45:00 +0100
Message-ID: <45A65B7C.6050503@suse.de>
References: <45A399D7.3090205@suse.de> <45A41B60.3070500@goop.org>
	<45A4A0C7.5050405@suse.de> <45A4C014.9030909@suse.de>
	<45A4E4A0.5060800@suse.de>
	<20070110235232.GE19575@sequoia.sous-sol.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------010903090604010102000308"
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <20070110235232.GE19575@sequoia.sous-sol.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Chris Wright <chrisw@sous-sol.org>
Cc: Virtualization Mailing List <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

This is a multi-part message in MIME format.
--------------010903090604010102000308
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Chris Wright wrote:
> 
> This should not be needed, the console should be xcv0, completely decoupled
> from serial.

You've made the whole thing even more complicated with the last commit.
Enabling VT is possible now.  Good.  No way around that.  The kernel
hangs now though.  Fix is attached:  better don't try to setup the vga
console for xen guests which don't have the hardware.

Next problem:  The default for xencons (tty) conflicts with the virtual
consoles.  I'm tempted to drop the complete xencons=foobar stuff into
the waste basket and leave in xencons=xvc only.  And maybe xencons=off.
 xencons=tty conflicts with the VT subsystem.  xencons=ttyS conflicts
with the serial driver.  Disabling the offending drivers is completely
out of question for a kernel which is supposed to work both native and
paravirtualized.

One more issue:  What should be the default console?  Right now it is
the vt console (using the dummy device).  Not very good.  vgacon doesn't
work.  fbcon doesn't work either (yet).  So you'll end up with a
non-functional console by default.  Bummer.

cheers,
  Gerd

-- 
Gerd Hoffmann <kraxel@suse.de>

--------------010903090604010102000308
Content-Type: text/plain;
 name="vga"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="vga"

Index: paravirt-2.6.20-rc4-hg699/arch/i386/kernel/setup.c
===================================================================
--- paravirt-2.6.20-rc4-hg699.orig/arch/i386/kernel/setup.c
+++ paravirt-2.6.20-rc4-hg699/arch/i386/kernel/setup.c
@@ -61,6 +61,7 @@
 #include <asm/ist.h>
 #include <asm/io.h>
 #include <asm/vmi.h>
+#include <asm/hypervisor.h>
 #include <setup_arch.h>
 #include <bios_ebda.h>
 
@@ -651,12 +652,17 @@ void __init setup_arch(char **cmdline_p)
 	e820_register_memory();
 
 #ifdef CONFIG_VT
-#if defined(CONFIG_VGA_CONSOLE)
-	if (!efi_enabled || (efi_mem_type(0xa0000) != EFI_CONVENTIONAL_MEMORY))
-		conswitchp = &vga_con;
-#elif defined(CONFIG_DUMMY_CONSOLE)
+#if defined(CONFIG_DUMMY_CONSOLE)
 	conswitchp = &dummy_con;
 #endif
+#if defined(CONFIG_VGA_CONSOLE)
+	if (efi_enabled && (efi_mem_type(0xa0000) == EFI_CONVENTIONAL_MEMORY))
+		goto novga;
+	if (is_running_on_xen() && !is_initial_xendomain())
+		goto novga;
+	conswitchp = &vga_con;
+novga:
+#endif
 #endif
 	tsc_init();
 }

--------------010903090604010102000308
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.osdl.org
https://lists.osdl.org/mailman/listinfo/virtualization

--------------010903090604010102000308--
