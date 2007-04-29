From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: [patch 00/32] xen: Xen implementation for paravirt_ops
Date: Sun, 29 Apr 2007 10:28:35 -0700
Message-ID: <20070429172835.284784000@goop.org>
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Andi Kleen <ak@suse.de>
Cc: Chris Wright <chrisw@sous-sol.org>, virtualization@lists.osdl.org, Andrew Morton <akpm@linux-foundation.org>, lkml <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

Hi Andi,

This series of patches implements the Xen paravirt-ops interface.
It applies to 2.6.21 + 2.6.21-070428-1 + the patches I've posted over
the last couple of days.

Changes since the last posting:
 - update per review comments
   - comment each file
   - comment barrier use
   - use common cpu sibling setup
 - fixed a few minor bugs, specifically a traceirq mismatch warning
 - some xenbus cleanups as a result of my review; more coming
 - split xen-core into more pieces

These patches are now moderately well tested, with several successful
runs through XenSource's regression test suite, and some amount of
non-me testing.  While I wouldn't go into production with a
xen/paravirt_ops kernel right now, it does seem pretty functional.

This series generally restricts itself to Xen-specific parts of the
tree, though it does make a few small changes elsewhere.

It includes:
 - some helper routines for allocating address space and walking pagetables
 - Xen interface header files
 - Core Xen implementation
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
