From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: [PATCH 00/14] PV ticket locks without expanding spinlock
Date: Tue, 16 Nov 2010 13:08:31 -0800
Message-ID: <cover.1289940821.git.jeremy.fitzhardinge__15456.5245764845$1289942305$gmane$org@citrix.com>
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
Cc: Xen-devel <xen-devel@lists.xensource.com>, Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>, Nick Piggin <npiggin@kernel.dk>, Srivatsa Vaddagiri <vatsa@linux.vnet.ibm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Jan Beulich <JBeulich@novell.com>, Eric Dumazet <dada1@cosmosbay.com>, Jeremy Fitzhardinge <jeremy.fitzhardinge@citrix.com>, Avi Kivity <avi@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, =?UTF-8?q?Am=C3=A9rico=20Wang?= <xiyou.wangcong@gmail.com>, Linux Virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

From: Jeremy Fitzhardinge <jeremy.fitzhardinge@citrix.com>

Hi all,

This is a revised version of the pvticket lock series.

The early part of the series is mostly unchanged: it converts the bulk
of the ticket lock code into C and makes the "small" and "large"
ticket code common.  The only changes are the incorporation of various
review comments.

The latter part of the series converts from pv spinlocks to pv ticket
locks (ie, using the ticket lock fastpath as-is, but adding pv ops for
the ticketlock slowpaths).

The significant difference here is that rather than adding a new
ticket_t-sized element to arch_spinlock_t - effectively doubling the
size - I steal the LSB of the tickets themselves to store a bit.  This
allows the structure to remain the same size, but at the cost of
halving the max number of CPUs (127 for a 8-bit ticket, and a hard max
of 32767 overall).

The extra bit (well, two, but one is unused) in indicates whether the
lock has gone into "slowpath state", which means one of its lockers
has entered its slowpath and has blocked in the hypervisor.  This
means the current lock-holder needs to make sure it gets kicked out of
the hypervisor on unlock.

The spinlock remains in slowpath state until the last unlock happens
(ie there are no more queued lockers).

This code survives for a while with moderate testing, (make -j 100 on
8 VCPUs on a 4 PCPU system), but locks up after about 20 iterations,
so there's still some race/deadlock in there (probably something
misordered), but I think the basic approach is sound.

Thanks,
	J

Jeremy Fitzhardinge (14):
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
  x86/pvticketlock: use callee-save for lock_spinning
  x86/ticketlock: don't inline _spin_unlock when using paravirt
    spinlocks
  x86/ticketlocks: when paravirtualizing ticket locks, increment by 2
  x86/ticketlock: add slowpath logic
  x86/ticketlocks: tidy up __ticket_unlock_kick()

 arch/x86/Kconfig                      |    3 +
 arch/x86/include/asm/paravirt.h       |   30 +---
 arch/x86/include/asm/paravirt_types.h |    8 +-
 arch/x86/include/asm/spinlock.h       |  236 +++++++++++++---------------
 arch/x86/include/asm/spinlock_types.h |   32 ++++-
 arch/x86/kernel/paravirt-spinlocks.c  |   52 +++++--
 arch/x86/xen/spinlock.c               |  281 +++++----------------------------
 kernel/Kconfig.locks                  |    2 +-
 8 files changed, 231 insertions(+), 413 deletions(-)

-- 
1.7.2.3
