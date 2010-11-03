From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: [PATCH 00/20] x86: ticket lock rewrite and paravirtualization
Date: Wed,  3 Nov 2010 10:59:41 -0400
Message-ID: <cover.1288794124.git.jeremy.fitzhardinge__43768.5026824058$1288797067$gmane$org@citrix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
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
To: Peter Zijlstra <peterz@infradead.org>
Cc: Nick Piggin <npiggin@suse.de>, Xen-devel <xen-devel@lists.xensource.com>, Srivatsa Vaddagiri <vatsa@linux.vnet.ibm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Jan Beulich <JBeulich@novell.com>, Linux Virtualization <virtualization@lists.linux-foundation.org>, Jeremy Fitzhardinge <jeremy.fitzhardinge@citrix.com>, Avi Kivity <avi@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>
List-Id: virtualization@lists.linuxfoundation.org

From: Jeremy Fitzhardinge <jeremy.fitzhardinge@citrix.com>

Hi all,

This series does two major things:

1. It converts the bulk of the implementation to C, and makes the
   "small ticket" and "large ticket" code common.  Only the actual
   size-dependent asm instructions are specific to the ticket size.
   The resulting generated asm is very similar to the current
   hand-written code.

   This results in a very large reduction in lines of code.

2. Get rid of pv spinlocks, and replace them with pv ticket locks.
   Currently we have the notion of "pv spinlocks" where a pv-ops
   backend can completely replace the spinlock implementation with a
   new one.  This has two disadvantages:
    - its a completely separate spinlock implementation, and
    - there's an extra layer of indirection in front of every
      spinlock operation.

   To replace this, this series introduces the notion of pv ticket
   locks.  In this design, the ticket lock fastpath is the standard
   ticketlock algorithm.  However, after an iteration threshold it
   falls into a slow path which invokes a pv-op to block the spinning
   CPU.  Conversely, on unlock it does the normal unlock, and then
   checks to see if it needs to do a special "kick" to wake the next
   CPU.

   The net result is that the pv-op calls are restricted to the slow
   paths, and the normal fast-paths are largely unaffected.

   There are still some overheads, however:
   - When locking, there's some extra tests to count the spin iterations.
     There are no extra instructions in the uncontended case though.

   - When unlocking, there are two ways to detect when it is necessary
     to kick a blocked CPU:

      - with an unmodified struct spinlock, it can check to see if
        head == tail after unlock; if not, then there's someone else
        trying to lock, and we can do a kick.  Unfortunately this
        generates very high level of redundant kicks, because the
        waiting CPU might not have blocked yet (which is the common
        case)

      - With a struct spinlock modified to include a "waiters" field,
        to keep count of blocked CPUs, which is a much tighter test.
        But it does increase the size of each spinlock by 50%
	(doubled with padding).

The series is very fine-grained, and I've left a lightly cleaned up
history of the various options I evaluated, since they're not all
obvious.

Jeremy Fitzhardinge (20):
  x86/ticketlock: clean up types and accessors
  x86/ticketlock: convert spin loop to C
  x86/ticketlock: Use C for __ticket_spin_unlock
  x86/ticketlock: make large and small ticket versions of spin_lock the
    same
  x86/ticketlock: make __ticket_spin_lock common
  x86/ticketlock: make __ticket_spin_trylock common
  x86/spinlocks: replace pv spinlocks with pv ticketlocks
  x86/ticketlock: collapse a layer of functions
  xen/pvticketlock: Xen implementation for PV ticket locks
  x86/pvticketlock: keep count of blocked cpus
  x86/pvticketlock: use callee-save for lock_spinning
  x86/pvticketlock: use callee-save for unlock_kick as well
  x86/pvticketlock: make sure unlock is seen by everyone before
    checking waiters
  x86/ticketlock: loosen ordering restraints on unlock
  x86/ticketlock: prevent compiler reordering into locked region
  x86/ticketlock: don't inline _spin_unlock when using paravirt
    spinlocks
  x86/ticketlock: clarify barrier in arch_spin_lock
  x86/ticketlock: remove .slock
  x86/ticketlocks: use overlapping read to eliminate mb()
  x86/ticketlock: rename ticketpair to head_tail

 arch/x86/Kconfig                      |    3 +
 arch/x86/include/asm/paravirt.h       |   30 +---
 arch/x86/include/asm/paravirt_types.h |    8 +-
 arch/x86/include/asm/spinlock.h       |  250 +++++++++++++++--------------
 arch/x86/include/asm/spinlock_types.h |   41 +++++-
 arch/x86/kernel/paravirt-spinlocks.c  |   15 +--
 arch/x86/xen/spinlock.c               |  282 +++++----------------------------
 kernel/Kconfig.locks                  |    2 +-
 8 files changed, 221 insertions(+), 410 deletions(-)

-- 
1.7.2.3
