From: Chris Wright <chrisw@sous-sol.org>
Subject: Re: Oops
Date: Thu, 11 Jan 2007 20:23:43 -0800
Message-ID: <20070112042343.GZ10475@sequoia.sous-sol.org>
References: <45A399D7.3090205@suse.de> <45A41B60.3070500@goop.org>
	<45A4A0C7.5050405@suse.de> <45A4C014.9030909@suse.de>
	<45A4E4A0.5060800@suse.de>
	<20070110235232.GE19575@sequoia.sous-sol.org>
	<45A65B7C.6050503@suse.de>
	<1168570436.31891.16.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <1168570436.31891.16.camel@localhost.localdomain>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Chris Wright <chrisw@sous-sol.org>, Virtualization Mailing List <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

* Rusty Russell (rusty@rustcorp.com.au) wrote:
> So I'd prefer a generic way of disabling the VGA stuff...

Heh, me too, like the patch at the bottom. I toyed with putting it into
vgacon directly since we'll need in on x86_64 too, like so:

static int vgacon_disabled;
void vgacon_disable(void)
{
	vgacon_disabled =3D 1;
}
EXPORT_SYMBOL_GPL(vgacon_disable);

vgacon_startup()
...
-	if (ORIG_VIDEO_ISVGA =3D=3D VIDEO_TYPE_VLFB)
+	if (vgacon_disabled || ORIG_VIDEO_ISVGA =3D=3D VIDEO_TYPE_VLFB)
...

but opted for the more arch specific way:

diff -r e1974f36aa13 arch/i386/kernel/setup.c
--- a/arch/i386/kernel/setup.c	Wed Jan 10 18:19:52 2007 -0800
+++ b/arch/i386/kernel/setup.c	Thu Jan 11 18:32:22 2007 -0800
@@ -69,6 +69,9 @@ unsigned long init_pg_tables_end __initd
 unsigned long init_pg_tables_end __initdata =3D ~0UL;
 =

 int disable_pse __devinitdata =3D 0;
+
+/* use to runtime disable vga_con */
+int vgacon_enabled =3D 1;
 =

 /*
  * Machine setup..
@@ -643,7 +646,7 @@ void __init setup_arch(char **cmdline_p)
 =

 #ifdef CONFIG_VT
 #if defined(CONFIG_VGA_CONSOLE)
-	if (!efi_enabled || (efi_mem_type(0xa0000) !=3D EFI_CONVENTIONAL_MEMORY))
+	if (vgacon_enabled && (!efi_enabled || (efi_mem_type(0xa0000) !=3D EFI_CO=
NVENTIONAL_MEMORY)))
 		conswitchp =3D &vga_con;
 #elif defined(CONFIG_DUMMY_CONSOLE)
 	conswitchp =3D &dummy_con;
diff -r e1974f36aa13 arch/i386/paravirt-xen/enlighten.c
--- a/arch/i386/paravirt-xen/enlighten.c	Wed Jan 10 18:19:52 2007 -0800
+++ b/arch/i386/paravirt-xen/enlighten.c	Thu Jan 11 18:37:40 2007 -0800
@@ -7,6 +7,7 @@
 #include <linux/start_kernel.h>
 #include <linux/sched.h>
 #include <linux/bootmem.h>
+#include <linux/console.h>
 =

 #include <xen/interface/xen.h>
 #include <xen/features.h>
@@ -779,6 +780,9 @@ static asmlinkage void __init xen_start_
 	new_cpu_data.hard_math =3D 1;
 	identify_cpu(&new_cpu_data);
 =

+	/* prepare for xen console */
+	vgacon_enabled =3D 0;
+
 	/* Poke various useful things into boot_params */
 	LOADER_TYPE =3D (9 << 4) | 0;
 	INITRD_START =3D xen_start_info->mod_start ? __pa(xen_start_info->mod_sta=
rt) : 0;
diff -r e1974f36aa13 include/asm-i386/setup.h
--- a/include/asm-i386/setup.h	Wed Jan 10 18:19:52 2007 -0800
+++ b/include/asm-i386/setup.h	Thu Jan 11 18:36:42 2007 -0800
@@ -77,6 +77,8 @@ void __init add_memory_region(unsigned l
 void __init add_memory_region(unsigned long long start,
 			      unsigned long long size, int type);
 =

+extern int vgacon_enabled;
+
 #endif /* __ASSEMBLY__ */
 =

 #endif  /*  __KERNEL__  */
