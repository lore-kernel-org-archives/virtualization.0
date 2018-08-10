From: Juergen Gross <jgross@suse.com>
Subject: [PATCH 00/10] x86/paravirt: several cleanups
Date: Fri, 10 Aug 2018 13:52:42 +0200
Message-ID: <20180810115252.18213-1-jgross__31542.6509282135$1533901884$gmane$org@suse.com>
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
Cc: Juergen Gross <jgross@suse.com>, boris.ostrovsky@oracle.com, rusty@rustcorp.com.au, mingo@redhat.com, hpa@zytor.com, akataria@vmware.com, tglx@linutronix.de
List-Id: virtualization@lists.linuxfoundation.org

This series removes some no longer needed stuff from paravirt
infrastructure and puts large quantities of paravirt ops under a new
config option PARAVIRT_XXL which is selected by XEN_PV only.

A pvops kernel without XEN_PV being configured is about 2.5% smaller
with this series applied.

tip commit 5800dc5c19f34e6e03b5adab1282535cb102fafd ("x86/paravirt:
Fix spectre-v2 mitigations for paravirt guests") is a prerequisite
for this series.

The last 4 patches of this series require my Xen cleanup series
https://lore.kernel.org/lkml/20180717120113.12756-1-jgross@suse.com/
which hides more Xen PV-only code behind CONFIG_XEN_PV.

Juergen Gross (10):
  x86/paravirt: make paravirt_patch_call() and paravirt_patch_jmp()
    static
  x86/paravirt: remove clobbers parameter from paravirt patch functions
  x86/paravirt: remove clobbers from struct paravirt_patch_site
  x86/paravirt: use a single ops structure
  x86/paravirt: remove unused paravirt bits
  x86/paravirt: introduce new config option PARAVIRT_XXL
  x86/paravirt: move items in pv_info under PARAVIRT_XXL umbrella
  x86/paravirt: move the Xen-only pv_cpu_ops under the PARAVIRT_XXL
    umbrella
  x86/paravirt: move the Xen-only pv_irq_ops under the PARAVIRT_XXL
    umbrella
  x86/paravirt: move the Xen-only pv_mmu_ops under the PARAVIRT_XXL
    umbrella

 arch/x86/Kconfig                            |   3 +
 arch/x86/hyperv/mmu.c                       |   4 +-
 arch/x86/include/asm/debugreg.h             |   2 +-
 arch/x86/include/asm/desc.h                 |   4 +-
 arch/x86/include/asm/fixmap.h               |   2 +-
 arch/x86/include/asm/irqflags.h             |  56 +++---
 arch/x86/include/asm/mmu_context.h          |   4 +-
 arch/x86/include/asm/msr.h                  |   4 +-
 arch/x86/include/asm/paravirt.h             | 183 +++++++++---------
 arch/x86/include/asm/paravirt_types.h       |  65 +++----
 arch/x86/include/asm/pgalloc.h              |   2 +-
 arch/x86/include/asm/pgtable-3level_types.h |   2 +-
 arch/x86/include/asm/pgtable.h              |   7 +-
 arch/x86/include/asm/processor.h            |   4 +-
 arch/x86/include/asm/ptrace.h               |   3 +-
 arch/x86/include/asm/segment.h              |   2 +-
 arch/x86/include/asm/special_insns.h        |   4 +-
 arch/x86/kernel/alternative.c               |   2 +-
 arch/x86/kernel/asm-offsets.c               |  15 +-
 arch/x86/kernel/asm-offsets_64.c            |   9 +-
 arch/x86/kernel/cpu/common.c                |   4 +-
 arch/x86/kernel/cpu/vmware.c                |   4 +-
 arch/x86/kernel/head_64.S                   |   2 +-
 arch/x86/kernel/kvm.c                       |  18 +-
 arch/x86/kernel/kvmclock.c                  |   4 +-
 arch/x86/kernel/paravirt-spinlocks.c        |  15 +-
 arch/x86/kernel/paravirt.c                  | 290 ++++++++++++++--------------
 arch/x86/kernel/paravirt_patch_32.c         |   9 +-
 arch/x86/kernel/paravirt_patch_64.c         |  11 +-
 arch/x86/kernel/tsc.c                       |   2 +-
 arch/x86/kernel/vsmp_64.c                   |  17 +-
 arch/x86/xen/Kconfig                        |   1 +
 arch/x86/xen/enlighten_pv.c                 |  32 +--
 arch/x86/xen/irq.c                          |   2 +-
 arch/x86/xen/mmu_hvm.c                      |   2 +-
 arch/x86/xen/mmu_pv.c                       |  28 +--
 arch/x86/xen/spinlock.c                     |  12 +-
 arch/x86/xen/time.c                         |   4 +-
 drivers/xen/time.c                          |   2 +-
 39 files changed, 430 insertions(+), 406 deletions(-)

-- 
2.13.7
