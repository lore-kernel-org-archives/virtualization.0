From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: [PATCH 00/25] xen: Xen implementation for paravirt_ops
Date: Mon, 23 Apr 2007 14:56:38 -0700
Message-ID: <20070423215638.563901986@goop.org>
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
Cc: virtualization@lists.osdl.org, Andrew Morton <akpm@linux-foundation.org>, lkml <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

Hi Andi,

This series of patches implements the Xen paravirt-ops interface.
It applies to 2.6.21-rc7 + your patches + the last batch of pv_ops
patches I posted.

This patch generally restricts itself to Xen-specific parts of the tree,
though it does make a few small changes elsewhere.

These patches include:
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
