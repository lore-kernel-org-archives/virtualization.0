From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 4 of 7]  lguest: Config and headers
Date: Sat, 10 Feb 2007 20:33:37 +1100
Message-ID: <1171100017.15356.21.camel@localhost.localdomain>
References: <1171033146.2718.157.camel@localhost.localdomain>
	 <1171033383.2718.163.camel@localhost.localdomain>
	 <1171033436.2718.165.camel@localhost.localdomain>
	 <1171033484.2718.167.camel@localhost.localdomain>
	 <1171033741.2718.172.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0702091304090.9927@d.namei>
	 <1171064515.15356.10.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0702092243170.13855@d.namei>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752188AbXBJJeY@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0702092243170.13855@d.namei>
Sender: linux-kernel-owner@vger.kernel.org
To: James Morris <jmorris@namei.org>
Cc: lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>, Andi Kleen <ak@muc.de>, Andrew Morton <akpm@linux-foundation.org>, virtualization <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, 2007-02-09 at 22:45 -0500, James Morris wrote:
> On Sat, 10 Feb 2007, Rusty Russell wrote:
> 
> > Well it was the use of get_order() which triggered Andi's alarm bells,
> > so I went back to deriving it.  This code is correct, however.
> 
> +       hype_pages = alloc_pages(GFP_KERNEL|__GFP_ZERO, HYPERVISOR_MAP_ORDER);
> +       if (!hype_pages)
> +               return -ENOMEM;
> 
> This will try and allocate 2^16 pages.  I guess we need a 
> HYPERVISOR_PAGE_ORDER ?

Fuck a brick, you're right.  Worked here tho 8)  There's a moral here
somewhere about futzing with perfectly working code after midnight, I'm
sure.

Name: Don't allocate 2^16 pages in lg.ko

Code cleanup which avoided use of get_order() resulted in a thinko: we
allocated 65536 pages instead of 65536 bytes.  Thanks to James Morris
for pointing this out (twice!).

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>

diff -r 3bcbcc7c7659 arch/i386/lguest/core.c
--- a/arch/i386/lguest/core.c	Sat Feb 10 10:44:25 2007 +1100
+++ b/arch/i386/lguest/core.c	Sat Feb 10 20:26:03 2007 +1100
@@ -24,8 +24,8 @@ static char __initdata hypervisor_blob[]
 #include "hypervisor-blob.c"
 };
 
-#define MAX_LGUEST_GUESTS						\
-	(((1 << HYPERVISOR_MAP_ORDER) - sizeof(hypervisor_blob))	\
+#define MAX_LGUEST_GUESTS						  \
+	(((PAGE_SIZE << HYPERVISOR_PAGE_ORDER) - sizeof(hypervisor_blob)) \
 	 / sizeof(struct lguest_state))
 
 static struct vm_struct *hypervisor_vma;
@@ -62,12 +62,12 @@ static __init int map_hypervisor(void)
 	int err;
 	struct page *pages[HYPERVISOR_PAGES], **pagep = pages;
 
-	hype_pages = alloc_pages(GFP_KERNEL|__GFP_ZERO, HYPERVISOR_MAP_ORDER);
+	hype_pages = alloc_pages(GFP_KERNEL|__GFP_ZERO, HYPERVISOR_PAGE_ORDER);
 	if (!hype_pages)
 		return -ENOMEM;
 
-	hypervisor_vma = __get_vm_area(1 << HYPERVISOR_MAP_ORDER, VM_ALLOC,
-				       HYPE_ADDR, VMALLOC_END);
+	hypervisor_vma = __get_vm_area(PAGE_SIZE << HYPERVISOR_PAGE_ORDER,
+				       VM_ALLOC, HYPE_ADDR, VMALLOC_END);
 	if (!hypervisor_vma) {
 		err = -ENOMEM;
 		printk("lguest: could not map hypervisor pages high\n");
@@ -100,14 +100,14 @@ free_vma:
 free_vma:
 	vunmap(hypervisor_vma->addr);
 free_pages:
-	__free_pages(hype_pages, HYPERVISOR_MAP_ORDER);
+	__free_pages(hype_pages, HYPERVISOR_PAGE_ORDER);
 	return err;
 }
 
 static __exit void unmap_hypervisor(void)
 {
 	vunmap(hypervisor_vma->addr);
-	__free_pages(hype_pages, HYPERVISOR_MAP_ORDER);
+	__free_pages(hype_pages, HYPERVISOR_PAGE_ORDER);
 }
 
 /* IN/OUT insns: enough to get us past boot-time probing. */
diff -r 3bcbcc7c7659 arch/i386/lguest/lg.h
--- a/arch/i386/lguest/lg.h	Sat Feb 10 10:44:25 2007 +1100
+++ b/arch/i386/lguest/lg.h	Sat Feb 10 20:27:54 2007 +1100
@@ -3,8 +3,8 @@
 
 #include <asm/desc.h>
 /* 64k ought to be enough for anybody! */
-#define HYPERVISOR_MAP_ORDER 16
-#define HYPERVISOR_PAGES ((1 << HYPERVISOR_MAP_ORDER)/PAGE_SIZE)
+#define HYPERVISOR_PAGE_ORDER (16 - PAGE_SHIFT)
+#define HYPERVISOR_PAGES (1 << HYPERVISOR_PAGE_ORDER)
 
 #define GDT_ENTRY_LGUEST_CS	10
 #define GDT_ENTRY_LGUEST_DS	11
