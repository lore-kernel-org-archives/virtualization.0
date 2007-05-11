From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: [patch 00/28]xen: Xen implementation for paravirt_ops
Date: Thu, 10 May 2007 17:06:43 -0700
Message-ID: <20070511000643.025196000@goop.org>
Return-path: <xen-devel-bounces@lists.xensource.com>
List-Unsubscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: Andi Kleen <ak@suse.de>
Cc: Chris Wright <chrisw@sous-sol.org>, virtualization@lists.osdl.org, Andrew Morton <akpm@linux-foundation.org>, Xen-devel <xen-devel@lists.xensource.com>, lkml <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

Hi Andi,

This series of patches implements the Xen paravirt-ops interface.  It
applies to 2.6.21-git13 + patches-2.6.21-git7-070507-1.tar.gz (I think
"unwinder" is the only patch which doesn't apply to git13, and the
sched-clock patches are the only ones which this series actually
needs).

Changes since the last posting:
 - More netfront review and cleanup
 - Added ability to cleanly halt/reboot guests from outside the domain.
 - Folded bugfix patches into their main patch
 - Lots of little style and other cleanups

These patches are now moderately well tested, with several successful
runs through XenSource's regression test suite, and some amount of
non-me testing.  While I wouldn't go into production with a
xen/paravirt_ops kernel right now, it does seem pretty functional.

This series generally restricts itself to Xen-specific parts of the
tree, though it does make a few small changes elsewhere.

It includes:
 - some helper routines for allocating address space and walking pagetables
 - Xen interface header files
 - Core Xen implementation (boot, mmu, events, time)
 - Efficient late-pinning/early-unpinning pagetable handling
 - Virtualized time, including stolen time
 - SMP support
 - Preemption support
 - Batched pagetable updates
 - Xen console, based on hvc console
 - Xenbus
 - Netfront, the paravirtualized network device
 - Blockfront, the paravirtualized block device

Thanks,
	J
-- 
