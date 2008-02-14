From: Ian Campbell <ijc@hellion.org.uk>
Subject: Re: [PATCHv3 1/3] x86: use ELF format in compressed images.
Date: Thu, 14 Feb 2008 17:57:14 +0000
Message-ID: <1203011834.30565.8.camel__36957.0070332431$1203011979$gmane$org@cthulhu.hellion.org.uk>
References: <1202936100-30859-1-git-send-email-ijc@hellion.org.uk>
	<9d3a007a2bfe774201b6deed5115a0cc8182bbb4.1202935389.git.ijc@hellion.org.uk>
	<1202988844.26435.4.camel@muff>
	<1203008490.30818.69.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1203008490.30818.69.camel@localhost.localdomain>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Mark McLoughlin <markmc@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org


On Thu, 2008-02-14 at 17:01 +0000, Ian Campbell wrote:
> 
> I have a xen domain builder patch as well. I was waiting for the Linux
> side to gain some traction before putting it forward (I'd attach it
> now but it's at home on a laptop which is sleeping).

Here it is:

# HG changeset patch
# User ijc@hellion.org.uk
# Date 1203011758 0
# Node ID 3079b4b3835e3aba52bb6548bbbced70471a9f32
# Parent  42369d21641d6297dc369441c3bfd355880d28c0
Support loading Linux bzImage v2.08 and up.

Signed-off-by : Ian Campbell <ijc@hellion.org.uk>

diff -r 42369d21641d -r 3079b4b3835e tools/libxc/Makefile
--- a/tools/libxc/Makefile	Thu Jan 31 16:23:35 2008 +0000
+++ b/tools/libxc/Makefile	Thu Feb 14 17:55:58 2008 +0000
@@ -40,6 +40,7 @@ GUEST_SRCS-y += libelf-dominfo.c libelf-
 # new domain builder
 GUEST_SRCS-y += xc_dom_core.c xc_dom_boot.c
 GUEST_SRCS-y += xc_dom_elfloader.c
+GUEST_SRCS-y += xc_dom_bzimageloader.c
 GUEST_SRCS-y += xc_dom_binloader.c
 GUEST_SRCS-y += xc_dom_compat_linux.c
 
diff -r 42369d21641d -r 3079b4b3835e tools/libxc/xc_dom_bzimageloader.c
--- /dev/null	Thu Jan 01 00:00:00 1970 +0000
+++ b/tools/libxc/xc_dom_bzimageloader.c	Thu Feb 14 17:55:58 2008 +0000
@@ -0,0 +1,159 @@
+/*
+ * Xen domain builder -- bzImage bits
+ *
+ * Parse and load bzImage kernel images.
+ *
+ * This relies on version 2.08 of the boot protocol, which contains an
+ * ELF file embedded in the bzImage.  The loader extracts this ELF
+ * image and passes it off to the standard ELF loader.
+ *
+ * This code is licenced under the GPL.
+ * written 2006 by Gerd Hoffmann <kraxel@suse.de>.
+ * written 2007 by Jeremy Fitzhardinge <jeremy@xensource.com>
+ * written 2008 by Ian Campbell <ijc@hellion.org.uk>
+ *
+ */
+#include <stdio.h>
+#include <stdlib.h>
+#include <inttypes.h>
+
+#include "xg_private.h"
+#include "xc_dom.h"
+
+struct setup_header {
+	uint8_t		_pad0[0x1f1];		/* skip uninteresting stuff */
+	uint8_t		setup_sects;
+	uint16_t	root_flags;
+	uint32_t	syssize;
+	uint16_t	ram_size;
+	uint16_t	vid_mode;
+	uint16_t	root_dev;
+	uint16_t	boot_flag;
+	uint16_t	jump;
+	uint32_t	header;
+#define HDR_MAGIC		"HdrS"
+#define HDR_MAGIC_SZ	4
+	uint16_t	version;
+#define VERSION(h,l)	(((h)<<8) | (l))
+	uint32_t	realmode_swtch;
+	uint16_t	start_sys;
+	uint16_t	kernel_version;
+	uint8_t		type_of_loader;
+	uint8_t		loadflags;
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
+	uint32_t	compressed_payload_offset;
+	uint32_t	compressed_payload_length;
+} __attribute__((packed));
+
+extern struct xc_dom_loader elf_loader;
+
+static unsigned int compressed_offset(struct setup_header *hdr)
+{
+    unsigned int off;
+
+    off = (hdr->setup_sects + 1) * 512;
+    off += hdr->compressed_payload_offset;
+    return off;
+}
+
+static int check_bzimage_kernel(struct xc_dom_image *dom, int verbose)
+{
+    struct setup_header *hdr;
+
+    if ( dom->kernel_blob == NULL )
+    {
+        if ( verbose )
+            xc_dom_panic(XC_INTERNAL_ERROR, "%s: no kernel image loaded\n",
+                         __FUNCTION__);
+        return -EINVAL;
+    }
+    if ( dom->kernel_size < sizeof(struct setup_header) )
+    {
+        if ( verbose )
+            xc_dom_panic(XC_INTERNAL_ERROR, "%s: kernel image too small\n",
+                         __FUNCTION__);
+        return -EINVAL;
+    }
+
+    hdr = dom->kernel_blob;
+
+    if ( memcmp(&hdr->header, HDR_MAGIC, HDR_MAGIC_SZ) != 0 )
+    {
+        if ( verbose )
+            xc_dom_panic(XC_INVALID_KERNEL, "%s: kernel is not a bzImage\n",
+                         __FUNCTION__);
+        return -EINVAL;
+    }
+
+    if ( hdr->version < VERSION(2,8) )
+    {
+        if ( verbose )
+            xc_dom_panic(XC_INVALID_KERNEL, "%s: boot protocol too old (%04x)\n",
+                         __FUNCTION__, hdr->version);
+        return -EINVAL;
+    }
+
+    dom->kernel_blob = dom->kernel_blob + compressed_offset(hdr);
+    dom->kernel_size = hdr->compressed_payload_length;
+
+    if ( xc_dom_try_gunzip(dom, &dom->kernel_blob, &dom->kernel_size) == -1 )
+    {
+        if ( verbose )
+            xc_dom_panic(XC_INVALID_KERNEL, "%s: unable to decompress kernel\n",
+                         __FUNCTION__);
+        return -EINVAL;
+    }
+
+    return elf_loader.probe(dom);
+}
+
+static int xc_dom_probe_bzimage_kernel(struct xc_dom_image *dom)
+{
+    return check_bzimage_kernel(dom, 0);
+}
+
+static int xc_dom_parse_bzimage_kernel(struct xc_dom_image *dom)
+{
+    return elf_loader.parser(dom);
+}
+
+static int xc_dom_load_bzimage_kernel(struct xc_dom_image *dom)
+{
+    return elf_loader.loader(dom);
+}
+
+static struct xc_dom_loader bzimage_loader = {
+    .name = "Linux bzImage",
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
diff -r 42369d21641d -r 3079b4b3835e tools/libxc/xc_dom_elfloader.c
--- a/tools/libxc/xc_dom_elfloader.c	Thu Jan 31 16:23:35 2008 +0000
+++ b/tools/libxc/xc_dom_elfloader.c	Thu Feb 14 17:55:58 2008 +0000
@@ -281,7 +281,7 @@ static int xc_dom_load_elf_kernel(struct
 
 /* ------------------------------------------------------------------------ */
 
-static struct xc_dom_loader elf_loader = {
+struct xc_dom_loader elf_loader = {
     .name = "ELF-generic",
     .probe = xc_dom_probe_elf_kernel,
     .parser = xc_dom_parse_elf_kernel,

-- 
Ian Campbell

The English have no respect for their language, and will not teach
their children to speak it.
		-- G. B. Shaw
