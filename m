From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH 0/8] lguest
Date: Tue, 10 Apr 2007 21:04:28 +1000
Message-ID: <1176203068.26372.21.camel__6534.74035575545$1176204269$gmane$org@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
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
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Andi Kleen <ak@muc.de>, lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

As promised to Andrew, and with much thanks to Andi Kleen for feedback,
this is the new series of lguest patches.

Main change is the move to drivers/lguest (for future non-i386
expansion), but lots of cleanups driven by Andi's feedback and the
documentation effort (which made me examine every line of code).

It's not perfect, but it's definitely useful.

Cheers,
Rusty.

List of changes from the previous version in -mm:
- Updated to 2.6.21-rc6-mm1
- Moved to drivers/lguest
- Don't bother fflush()ing in verbose(): we always use a \n now anyway.
- Remove part of lguest.txt which documents the code: moving them to the
  code, is in progress.
- Move assembler parts of lguest.c out to lguest_asm.S.
- Use ktimer_get_real_ts() rather than do_gettimeofday.  It's the new
  black!
- Use explicit types (w/ typechecking) for shadow pagetable code.
- Use unsigned long for addresses rather than u32.
- Comment on wmb().
- Use mask-in, not mask-out on CPUID for more future proofiness.
- Implement noop wbinvd (used when cpuid says there's no clflush,
  ie. pre Pentium 4). (Discovered while playing with CPUID).
- Rename many internal shadow pagetable functions & vars for clarity.
- Remove cr3 member from "struct lguest": easy to calculate when needed.
- Add comment on lack of interface stability.
- Move lguest_devices array declaration from lguest.h to lguest_bus.h
  (it's only useful for devices).
- Use read_cr0() and write_cr0() rather than open-coding them.
- Use KERN_INFO on printk() for lguest initialization
- Remove unneeded __attribute_used__ in core.c
- Print out message when failing to run lguest under lguest/Xen etc.
- Use a wmb() for dma transfer code, not mb().
- Change hash table size from 64 to 61.
- Reorder can cleanup of example launcher code to make it suck less.
- s/hypervisor/switcher/ for more clarity.
- lguest_address_ok() now takes length to check.
- Rename GUEST_DPL to GUEST_PL: it's not just for descriptors.
- Wake other guest when it's out of buffers, don't just yield.
- Rename "addr" to "key" as I/O argument.
- Rename "interrupts" in "struct lguest_data" to "blocked_interrupts".
- Don't set regs fields to 0: allocated with get_zeroed_page() anyway.
- Various minor cleanups.
