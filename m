From: "Luck, Tony" <tony.luck@intel.com>
Subject: RE: [PATCH 09/27] ia64/xen: implement the arch specific part of
	xencomm.
Date: Wed, 18 Jun 2008 13:39:02 -0700
Message-ID: <57C9024A16AD2D4C97DC78E552063EA30621364B__43148.2367370792$1213821756$gmane$org@orsmsx505.amr.corp.intel.com>
References: <12130840433561-git-send-email-yamahata@valinux.co.jp>
	<12130840434082-git-send-email-yamahata@valinux.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <12130840434082-git-send-email-yamahata@valinux.co.jp>
Content-Language: en-US
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Isaku Yamahata <yamahata@valinux.co.jp>, "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>
Cc: "xen-ia64-devel@lists.xensource.com" <xen-ia64-devel@lists.xensource.com>, "Dong, Eddie" <eddie.dong@intel.com>, Alex Williamson <alex.williamson@hp.com>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

> On ia64/xen, pointer argument for the hypercall is passed
> by pseudo physical address (guest phsysical address.)
s/phsysical/physical/

> So it is necessary to convert virtual address into pseudo physical
> address rigth before issuing hypercall. The frame work is called
s/rigth/right/



+#ifdef HAVE_XEN_PLATFORM_COMPAT_H
+#include <xen/platform-compat.h>
+#endif

What is this for?  This patch series doesn't make this file.


+static unsigned long kernel_start_pa;
+
+void
+xencomm_initialize(void)
+{
+       kernel_start_pa = KERNEL_START - ia64_tpa(KERNEL_START);
+}

"kernel_start_pa" is an unhelpful name ... this variable doesn't
contain the starting physical address (which is what the name
sounds like).  Perhaps "kernel_virtual_offset" is better?


+       if (vaddr > TASK_SIZE) {
+               /* kernel address */
+               return __pa(vaddr);
+       }

Can this routine ever be given the address of a percpu variable?
This will return the wrong value if someone does.

+#define is_kernel_addr(x)                                      \
+       ((PAGE_OFFSET <= (x) &&                                 \
+         (x) < (PAGE_OFFSET + (1UL << IA64_MAX_PHYS_BITS))) || \
+        (KERNEL_START <= (x) &&                                \
+         (x) < KERNEL_START + KERNEL_TR_PAGE_SIZE))

Misleading name.  What does it consider a "kernel_addr"? Just
region 7 (up to physical address limit) and the piece of region
5 that is mapped by itr[0]/dtr[0].  Preferebly pick a better name
or add a comment here saying what this is testing for.

-Tony
