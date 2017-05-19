From: Juergen Gross <jgross@suse.com>
Subject: [PATCH 00/10] paravirt: make amount of paravirtualization configurable
Date: Fri, 19 May 2017 17:47:36 +0200
Message-ID: <20170519154746.29389-1-jgross@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org, x86@kernel.org, virtualization@lists.linux-foundation.org
Cc: Juergen Gross <jgross@suse.com>, jeremy@goop.org, chrisw@sous-sol.org, mingo@redhat.com, tglx@linutronix.de, hpa@zytor.com, akataria@vmware.com, boris.ostrovsky@oracle.com
List-Id: virtualization@lists.linuxfoundation.org

Today paravirtualization is a all-or-nothing game: either a kernel is
compiled with no paravirtualization support at all, or it is supporting
paravirtualized environments like Xen pv-guests or lguest additionally
to some paravirtualized tuning for KVM, Hyperv, VMWare or Xen
HVM-guests.

As support of pv-guests requires quite intrusive pv-hooks (e.g. all
access functions to page table entries, privileged instructions) it is
desirable to enable those hooks only in cases where support of
pv-guests is really desired.

With splitting up of Xen guest support into pv-guest support and
support for HVM-guests it is now possible to do the same for support
of paravirtualization: only if XEN_PV or LGUEST_GUEST are configured
full paravirtualization is required.

This patch series carves out pv-guest support form PARAVIRT by
introducing PARAVIRT_FULL config option selected by XEN_PV and
LGUEST_GUEST config options.

The series has been tested for 32 and 64 bit kernels without
PARAVIRT, with PARAVIRT, and with PARAVIRT + PARAVIRT_FULL configured.


Juergen Gross (10):
  x86: remove stale prototype from arch/x86/include/asm/pgalloc.h
  paravirt: remove unused function paravirt_disable_iospace()
  xen: move interrupt handling for pv guests under CONFIG_XEN_PV
    umbrella
  xen: remove non-pv test from arch/x86/xen/irq.c
  paravirt: add new PARAVIRT_FULL config item
  paravirt: split pv_cpu_ops for support of PARAVIRT_FULL
  paravirt: split pv_irq_ops for support of PARAVIRT_FULL
  paravirt: split pv_mmu_ops for support of PARAVIRT_FULL
  paravirt: split pv_info for support of PARAVIRT_FULL
  paravirt: merge pv_ops_* structures into one

 MAINTAINERS                                 |   2 +-
 arch/x86/Kconfig                            |   4 +
 arch/x86/boot/compressed/misc.h             |   1 +
 arch/x86/entry/entry_32.S                   |   4 +-
 arch/x86/entry/entry_64.S                   |  10 +-
 arch/x86/include/asm/debugreg.h             |   2 +-
 arch/x86/include/asm/desc.h                 |   4 +-
 arch/x86/include/asm/fixmap.h               |   2 +-
 arch/x86/include/asm/irqflags.h             |  40 +-
 arch/x86/include/asm/mmu_context.h          |   4 +-
 arch/x86/include/asm/msr.h                  |   4 +-
 arch/x86/include/asm/paravirt.h             | 738 ++--------------------------
 arch/x86/include/asm/paravirt_full.h        | 714 +++++++++++++++++++++++++++
 arch/x86/include/asm/paravirt_types.h       | 243 +--------
 arch/x86/include/asm/paravirt_types_full.h  | 218 ++++++++
 arch/x86/include/asm/pgalloc.h              |   4 +-
 arch/x86/include/asm/pgtable-3level_types.h |   4 +-
 arch/x86/include/asm/pgtable.h              |   8 +-
 arch/x86/include/asm/processor.h            |   4 +-
 arch/x86/include/asm/ptrace.h               |   5 +-
 arch/x86/include/asm/segment.h              |   2 +-
 arch/x86/include/asm/special_insns.h        |  25 +-
 arch/x86/include/asm/tlbflush.h             |   2 +-
 arch/x86/kernel/Makefile                    |   1 +
 arch/x86/kernel/alternative.c               |   4 +-
 arch/x86/kernel/asm-offsets.c               |  21 +-
 arch/x86/kernel/asm-offsets_64.c            |   9 +-
 arch/x86/kernel/cpu/common.c                |   4 +-
 arch/x86/kernel/cpu/vmware.c                |   6 +-
 arch/x86/kernel/head_64.S                   |   2 +-
 arch/x86/kernel/kvm.c                       |   6 +-
 arch/x86/kernel/kvmclock.c                  |   6 +-
 arch/x86/kernel/paravirt.c                  | 303 +-----------
 arch/x86/kernel/paravirt_full.c             | 277 +++++++++++
 arch/x86/kernel/paravirt_patch_32.c         |  36 +-
 arch/x86/kernel/paravirt_patch_64.c         |  50 +-
 arch/x86/kernel/tsc.c                       |   2 +-
 arch/x86/kernel/vsmp_64.c                   |  18 +-
 arch/x86/lguest/Kconfig                     |   1 +
 arch/x86/lguest/boot.c                      | 100 ++--
 arch/x86/xen/Kconfig                        |   1 +
 arch/x86/xen/Makefile                       |   8 +-
 arch/x86/xen/enlighten_hvm.c                |   4 +-
 arch/x86/xen/enlighten_pv.c                 |  58 ++-
 arch/x86/xen/irq.c                          |  15 +-
 arch/x86/xen/mmu_hvm.c                      |   2 +-
 arch/x86/xen/mmu_pv.c                       |  34 +-
 arch/x86/xen/time.c                         |  11 +-
 drivers/xen/time.c                          |   2 +-
 49 files changed, 1548 insertions(+), 1477 deletions(-)
 create mode 100644 arch/x86/include/asm/paravirt_full.h
 create mode 100644 arch/x86/include/asm/paravirt_types_full.h
 create mode 100644 arch/x86/kernel/paravirt_full.c

-- 
2.12.0
