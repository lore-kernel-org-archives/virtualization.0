From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: [PATCH RFC] add domain builder support for bzImage
	kernels
Date: Fri, 15 Jun 2007 09:57:52 -0700
Message-ID: <4672C510.3070208@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <xen-devel-bounces@lists.xensource.com>
List-Unsubscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: Keir Fraser <Keir.Fraser@cl.cam.ac.uk>, Gerd Hoffmann <kraxel@redhat.com>
Cc: Virtualization Mailing List <virtualization@lists.osdl.org>, Xen-devel <xen-devel@lists.xensource.com>, "Eric W. Biederman" <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>
List-Id: virtualization@lists.linuxfoundation.org

This implements a loader for version 2.07 boot protocol bzImage format
files.  This allows a single bzImage kernel file to boot either native
from a normal bootloader (grub, etc), or paravirtualized under Xen.

These bzImages have two changes to make this possible:

   1. There's a new field for the bootloader to tell the booted kernel
      what kind of environment its coming up under.  We can use this to
      tell the kernel to unambigiously tell that its booting under Xen. 
      There's also an extra field for storing some environment-specific
      data; we use this to store the Xen start_info pointer.
   2. The 32-part of the bzImage code, which includes a decompressor and
      the compressed data for the actual kernel, is wrapped in an ELF
      file.  This allows us to decorate it with the Xen-spceific ELF
      notes, and also use the PHDRs to specify how much memory Xen needs
      to map initially.  The ELF file is constructed so that the PHDRs
      map enough memory for the kernel to decompress itself, and run
      enough until it can build its own initial pagetables.


The Linux boot protocol requires that %esi point to the boot_params
block on entry.  Unfortunately this conflicts with the normal Xen boot
protocol, which starts with %esi pointing to a struct start_info.

In order to implement this, I've had to muck up Gerd's nice clean
layering a little bit.  struct xc_dom_image now has a bootparams_pfn,
which is set by the bzImage loader.  Then, when xc_dom_x86 sees that its
non-NULL when setting up the initial vcpu state, it points %esi that
rather than start_info (and the boot_params contains a pointer to
start_info).  Fortunately, the embedded ELF file makes it easy to reuse
a lot of the existing ELF machinery, so there's not a lot of new code.

Signed-off-by: Jeremy Fitzhardinge <jeremy@xensource.com>

diff -r 3af164753238 tools/libxc/Makefile
--- a/tools/libxc/Makefile	Thu Jun 14 08:15:19 2007 -0700
+++ b/tools/libxc/Makefile	Thu Jun 14 08:43:44 2007 -0700
@@ -47,6 +47,7 @@ GUEST_SRCS-y += $(LIBELF_SRCS)
 # new domain builder
 GUEST_SRCS-y += xc_dom_core.c xc_dom_boot.c
 GUEST_SRCS-y += xc_dom_elfloader.c
+GUEST_SRCS-y += xc_dom_bzimageloader.c
 GUEST_SRCS-y += xc_dom_binloader.c
 GUEST_SRCS-y += xc_dom_compat_linux.c
 
diff -r 3af164753238 tools/libxc/bootparam.h
--- /dev/null	Thu Jan 01 00:00:00 1970 +0000
+++ b/tools/libxc/bootparam.h	Thu Jun 14 08:43:44 2007 -0700
@@ -0,0 +1,53 @@
+#ifndef _ASM_BOOTPARAM_H
+#define _ASM_BOOTPARAM_H
+
+#include <stdint.h>
+
+#define HDR_MAGIC "HdrS"
+#define HDR_MAGIC_SZ 4
+
+struct setup_header {
+	uint8_t		setup_sects;
+	uint16_t	root_flags;
+	uint32_t	syssize;
+	uint16_t	ram_size;
+	uint16_t	vid_mode;
+	uint16_t	root_dev;
+	uint16_t	boot_flag;
+	uint16_t	jump;
+	uint32_t	header;
+	uint16_t	version;
+#define VERSION(h,l)	(((h)<<8) | (l))
+	uint32_t	realmode_swtch;
+	uint16_t	start_sys;
+	uint16_t	kernel_version;
+	uint8_t		type_of_loader;
+	uint8_t		loadflags;
+#define LOADED_HIGH	(1<<0)
+#define KEEP_SEGMENTS	(1<<6)
+#define CAN_USE_HEAP	(1<<7)
+	uint16_t	setup_move_size;
+	uint32_t	code32_start;
+	uint32_t	ramdisk_image;
+	uint32_t	ramdisk_size;
+	uint32_t	bootsect_kludge;
+	uint16_t	heap_end_ptr;
+	uint16_t	_pad1;
+	uint32_t	cmd_line_ptr;
+	uint32_t	initrd_addr_max;
+	uint32_t	kernel_alignment;
+	uint8_t		relocatable_kernel;
+	uint8_t		_pad2[3];
+	uint32_t	cmdline_size;
+	uint32_t	hardware_subarch;
+	uint64_t	hardware_subarch_data;
+} __attribute__((packed));
+
+/* The so-called "zeropage" */
+struct boot_params {
+	uint8_t	_pad0[0x1f1];		/* skip uninteresting stuff */
+	struct setup_header hdr;/* setup header */	/* 0x1f1 */
+	uint8_t  _pad7[0x1000-0x1f1-sizeof(struct setup_header)];
+} __attribute__((packed));
+
+#endif /* _ASM_BOOTPARAM_H */
diff -r 3af164753238 tools/libxc/xc_dom.h
--- a/tools/libxc/xc_dom.h	Thu Jun 14 08:15:19 2007 -0700
+++ b/tools/libxc/xc_dom.h	Thu Jun 14 08:43:44 2007 -0700
@@ -55,6 +55,7 @@ struct xc_dom_image {
     xen_pfn_t xenstore_pfn;
     xen_pfn_t shared_info_pfn;
     xen_pfn_t bootstack_pfn;
+    xen_pfn_t bootparams_pfn;
     xen_vaddr_t virt_alloc_end;
     xen_vaddr_t bsd_symtab_start;
 
@@ -254,6 +255,11 @@ static inline xen_pfn_t xc_dom_p2m_guest
     return dom->p2m_host[pfn];
 }
 
+char *xc_dom_guest_type(struct xc_dom_image *dom,
+                        struct elf_binary *elf);
+int xc_dom_load_elf_symtab(struct xc_dom_image *dom,
+                           struct elf_binary *elf, int load);
+
 /* --- arch bits --------------------------------------------------- */
 
 int arch_setup_meminit(struct xc_dom_image *dom);
diff -r 3af164753238 tools/libxc/xc_dom_bzimageloader.c
--- /dev/null	Thu Jan 01 00:00:00 1970 +0000
+++ b/tools/libxc/xc_dom_bzimageloader.c	Thu Jun 14 08:43:44 2007 -0700
@@ -0,0 +1,169 @@
+/*
+ * Xen domain builder -- bzImage bits
+ *
+ * Parse and load bzImage kernel images.
+ *
+ * This relies on version 2.07 of the boot protocol, which an ELF file
+ * embedded in the bzImage.  The loader extracts the boot_params from
+ * the bzImage and updates it appropriately, then loads and runs the
+ * self-extracting kernel ELF file.
+ *
+ * This code is licenced under the GPL.
+ * written 2006 by Gerd Hoffmann <kraxel@suse.de>.
+ * written 2007 by Jeremy Fitzhardinge <jeremy@xensource.com>
+ *
+ */
+#include <stdio.h>
+#include <stdlib.h>
+#include <inttypes.h>
+
+#include "xg_private.h"
+#include "xc_dom.h"
+#include "bootparam.h"
+
+#define XEN_VER "xen-3.0"
+
+static unsigned elf_offset(struct boot_params *params)
+{
+    return (params->hdr.setup_sects + 1) * 512;
+}
+
+static int check_bzimage_kernel(struct xc_dom_image *dom, int verbose)
+{
+    struct boot_params *params;
+    const char *elf;
+
+    if ( dom->kernel_blob == NULL || dom->kernel_size < 512*8)
+    {
+        if ( verbose )
+            xc_dom_panic(XC_INTERNAL_ERROR, "%s: no kernel image loaded\n",
+                         __FUNCTION__);
+        return -EINVAL;
+    }
+
+    params = dom->kernel_blob;
+
+    if ( memcmp(&params->hdr.header, HDR_MAGIC, HDR_MAGIC_SZ) != 0 )
+    {
+        if ( verbose )
+            xc_dom_panic(XC_INVALID_KERNEL, "%s: kernel is not a bzImage\n",
+                         __FUNCTION__);
+        return -EINVAL;
+    }
+
+    if ( params->hdr.version < VERSION(2,07) )
+    {
+        if ( verbose )
+            xc_dom_panic(XC_INVALID_KERNEL, "%s: boot protocol too old (%04x)\n",
+                         __FUNCTION__, params->hdr.version);
+        return -EINVAL;
+    }
+
+    elf = dom->kernel_blob + elf_offset(params);
+    if ( !elf_is_elfbinary(elf) )
+    {
+        if ( verbose )
+            xc_dom_panic(XC_INVALID_KERNEL, "%s: bzImage does not contain ELF image\n",
+                         __FUNCTION__);
+        return -EINVAL;
+    }
+
+    return 0;
+}
+
+static int xc_dom_probe_bzimage_kernel(struct xc_dom_image *dom)
+{
+    return check_bzimage_kernel(dom, 0);
+}
+
+static int xc_dom_parse_bzimage_kernel(struct xc_dom_image *dom)
+{
+    int rc;
+    struct boot_params *params;
+    struct elf_binary *elf;
+    unsigned offset;
+
+    rc = check_bzimage_kernel(dom, 1);
+    if ( rc != 0 )
+        return rc;
+
+    params = dom->kernel_blob;
+    offset = elf_offset(params);
+
+    elf = xc_dom_malloc(dom, sizeof(*elf));
+    dom->private_loader = elf;
+
+    rc = elf_init(elf, dom->kernel_blob + offset, dom->kernel_size - offset);
+    if ( xc_dom_logfile )
+        elf_set_logfile(elf, xc_dom_logfile, 1);
+    if ( rc != 0 )
+    {
+        xc_dom_panic(XC_INVALID_KERNEL, "%s: corrupted ELF image\n",
+                     __FUNCTION__);
+        return rc;
+    }
+
+    /* parse binary and get xen meta info */
+    elf_parse_binary(elf);
+    if ( (rc = elf_xen_parse(elf, &dom->parms)) != 0 )
+        return rc;
+
+    /* find kernel segment */
+    dom->kernel_seg.vstart = dom->parms.virt_kstart;
+    dom->kernel_seg.vend   = dom->parms.virt_kend;
+
+    if ( dom->parms.bsd_symtab )
+        xc_dom_load_elf_symtab(dom, elf, 0);
+
+    dom->guest_type = xc_dom_guest_type(dom, elf);
+    xc_dom_printf("%s: %s: 0x%" PRIx64 " -> 0x%" PRIx64 "\n",
+                  __FUNCTION__, dom->guest_type,
+                  dom->kernel_seg.vstart, dom->kernel_seg.vend);
+    return 0;
+}
+
+static int xc_dom_load_bzimage_kernel(struct xc_dom_image *dom)
+{
+    struct elf_binary *elf = dom->private_loader;
+    xen_pfn_t bootparams_pfn;
+    struct boot_params *bzparams, *bootparams;
+
+    bzparams = dom->kernel_blob;
+
+    elf->dest = xc_dom_seg_to_ptr(dom, &dom->kernel_seg);
+    elf_load_binary(elf);
+    if ( dom->parms.bsd_symtab )
+        xc_dom_load_elf_symtab(dom, elf, 1);
+
+    bootparams_pfn = xc_dom_alloc_page(dom, "bootparams");
+    bootparams = xc_dom_pfn_to_ptr(dom, bootparams_pfn, 1);
+    memset(bootparams, 0, sizeof(*bootparams));
+
+    memcpy(&bootparams->hdr, &bzparams->hdr, sizeof(bootparams->hdr));
+
+    dom->bootparams_pfn = bootparams_pfn;
+
+    return 0;
+}
+
+static struct xc_dom_loader bzimage_loader = {
+    .name = "bzImage",
+    .probe = xc_dom_probe_bzimage_kernel,
+    .parser = xc_dom_parse_bzimage_kernel,
+    .loader = xc_dom_load_bzimage_kernel,
+};
+
+static void __init register_loader(void)
+{
+    xc_dom_register_loader(&bzimage_loader);
+}
+
+/*
+ * Local variables:
+ * mode: C
+ * c-set-style: "BSD"
+ * c-basic-offset: 4
+ * tab-width: 4
+ * indent-tabs-mode: nil
+ * End:
+ */
diff -r 3af164753238 tools/libxc/xc_dom_elfloader.c
--- a/tools/libxc/xc_dom_elfloader.c	Thu Jun 14 08:15:19 2007 -0700
+++ b/tools/libxc/xc_dom_elfloader.c	Thu Jun 14 08:43:44 2007 -0700
@@ -18,8 +18,8 @@
 
 /* ------------------------------------------------------------------------ */
 
-static char *xc_dom_guest_type(struct xc_dom_image *dom,
-                               struct elf_binary *elf)
+char *xc_dom_guest_type(struct xc_dom_image *dom,
+                        struct elf_binary *elf)
 {
     uint64_t machine = elf_uval(elf, elf->ehdr, e_machine);
 
@@ -78,8 +78,8 @@ static int xc_dom_probe_elf_kernel(struc
     return check_elf_kernel(dom, 0);
 }
 
-static int xc_dom_load_elf_symtab(struct xc_dom_image *dom,
-                                  struct elf_binary *elf, int load)
+int xc_dom_load_elf_symtab(struct xc_dom_image *dom,
+                           struct elf_binary *elf, int load)
 {
     struct elf_binary syms;
     const elf_shdr *shdr, *shdr2;
diff -r 3af164753238 tools/libxc/xc_dom_x86.c
--- a/tools/libxc/xc_dom_x86.c	Thu Jun 14 08:15:19 2007 -0700
+++ b/tools/libxc/xc_dom_x86.c	Thu Jun 14 08:43:44 2007 -0700
@@ -23,6 +23,7 @@
 #include "xg_private.h"
 #include "xc_dom.h"
 #include "xenctrl.h"
+#include "bootparam.h"
 
 /* ------------------------------------------------------------------------ */
 
@@ -407,6 +408,36 @@ static int alloc_magic_pages(struct xc_d
 
 /* ------------------------------------------------------------------------ */
 
+static unsigned long guest_pfn_addr(struct xc_dom_image *dom, xen_pfn_t pfn,
+                                    size_t offset)
+{
+    return dom->parms.virt_base + pfn * PAGE_SIZE_X86 + offset;
+}
+
+static void setup_boot_params(struct xc_dom_image *dom)
+{
+    struct boot_params *params =
+        xc_dom_pfn_to_ptr(dom, dom->bootparams_pfn, 1);
+
+    params->hdr.type_of_loader = (9 << 4) | 0;  /* xen v0 */
+    params->hdr.loadflags |= LOADED_HIGH | KEEP_SEGMENTS;
+
+    params->hdr.hardware_subarch = 2;  /* xen */
+    params->hdr.hardware_subarch_data =
+        (uint64_t)guest_pfn_addr(dom, dom->start_info_pfn, 0);
+
+    if ( dom->ramdisk_blob )
+    {
+        params->hdr.ramdisk_image = (uint32_t)dom->ramdisk_seg.vstart;
+        params->hdr.ramdisk_size = dom->ramdisk_seg.vend - dom->ramdisk_seg.vstart;
+    }
+
+    params->hdr.cmd_line_ptr =
+        guest_pfn_addr(dom, dom->start_info_pfn,
+                       offsetof(start_info_x86_32_t, cmd_line));
+    params->hdr.cmdline_size = MAX_GUEST_CMDLINE;
+}
+
 static int start_info_x86_32(struct xc_dom_image *dom)
 {
     start_info_x86_32_t *start_info =
@@ -440,6 +471,12 @@ static int start_info_x86_32(struct xc_d
     {
         strncpy((char *)start_info->cmd_line, dom->cmdline, MAX_GUEST_CMDLINE);
         start_info->cmd_line[MAX_GUEST_CMDLINE - 1] = '\0';
+    }
+
+    if ( dom->bootparams_pfn != 0 )
+    {
+        setup_boot_params(dom);
+        dom->start_info_pfn = dom->bootparams_pfn;
     }
 
     return 0;
@@ -528,10 +565,8 @@ static int vcpu_x86_32(struct xc_dom_ima
     ctxt->user_regs.ss = FLAT_KERNEL_SS_X86_32;
     ctxt->user_regs.cs = FLAT_KERNEL_CS_X86_32;
     ctxt->user_regs.eip = dom->parms.virt_entry;
-    ctxt->user_regs.esp =
-        dom->parms.virt_base + (dom->bootstack_pfn + 1) * PAGE_SIZE_X86;
-    ctxt->user_regs.esi =
-        dom->parms.virt_base + (dom->start_info_pfn) * PAGE_SIZE_X86;
+    ctxt->user_regs.esp = guest_pfn_addr(dom, dom->bootstack_pfn, PAGE_SIZE_X86);
+    ctxt->user_regs.esi = guest_pfn_addr(dom, dom->start_info_pfn, 0);
     ctxt->user_regs.eflags = 1 << 9; /* Interrupt Enable */
 
     ctxt->kernel_ss = ctxt->user_regs.ss;
