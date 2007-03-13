From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: [patch 00/34] Xen-pv_ops: Xen guest implementation for
	paravirt_ops interface
Date: Tue, 13 Mar 2007 16:30:17 -0700
Message-ID: <20070313233017.933601256@goop.org>
Return-path: <xen-devel-bounces@lists.xensource.com>
List-Unsubscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: Andi Kleen <ak@muc.de>
Cc: Zachary Amsden <zach@vmware.com>, xen-devel@lists.xensource.com, Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org, Chris Wright <chrisw@sous-sol.org>, virtualization@lists.osdl.org, Andrew Morton <akpm@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Hi Andi,

This patch series implements the Linux Xen guest as a paravirt_ops
backend.  The features in implemented this patch series are:
 * domU only
 * UP and SMP guest support (NEW!)
 * dynamic ticks (NEW!)
 * writable pagetables, with late pinning/early unpinning
   (no shadow pagetable support)
 * supports both PAE and non-PAE modes
   (non-PAE may be broken at the moment)
 * xen hvc console (console=hvc0)
 * virtual block device (blockfront)
 * virtual network device (netfront)

The patch series is in three parts:
  1-2	Cleanup patches to various parts of the kernel
  3-19	Extensions to the core code and/or paravirt ops, needed to support
	Xen. Includes hooks into get/setting pte values and the new
	patching machinery.
 19-34	The Xen paravirt_ops implementation itself.

(Some of the earlier patches in the series have already been posted,
 but are included to make the series self-contained.)

I've tried to make each patch as self-explanatory as possible.  The
series is based on 2.6.21-rc3-git7.

Changes since the previous posting:
- SMP support
- Implemented xen_clockevent, so Xen is fully compatible with
  CONFIG_NO_HZ and HIGH_RES_TIMERS.
- Finished implementing late pinning/early unpinning of pagetables, which
  should now be equivalent to xen-unstable in performance.
- Add kmap_atomic_pte for mapping ptes, and therefore support for HIGHPTE
- Fixed crash on systems with >= 4G memory
- Cleanup netfront (Stephen Hemminger)
- Add MAINTAINERS entries
- Fold kill-HAVE_ARCH_MM_LIFETIME.patch into mm-lifetime-hooks.patch
- rebased

Thanks,
	J
-- 
