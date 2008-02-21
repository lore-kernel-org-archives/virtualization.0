From: yamahata@valinux.co.jp
Subject: [PATCH 00/28] ia64/xen domU paravirtualization
Date: Thu, 21 Feb 2008 18:17:31 +0900
Message-ID: <20080221091731.641745000__21921.9617582441$1203633829$gmane$org@ls.local.valinux.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Resent-Message-ID: <20080221223141.GA17530%yamahata@valinux.co.jp>
Resent-To: linux-ia64@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        kvm-ia64-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-ia64@vger.kernel.org
Cc: xen-ia64-devel@lists.xensource.com, kvm-ia64-devel@lists.sourceforge.net, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Hi linux/ia64 developers. 
Few days before Eddie posted the mail for Linux/IA64 paravirtualization.
But only a few responded partially because there was no reviewable patches.
Here is the patches for xen/ia64 Linux paravirtualization.

The goal is to merge IA64 xen Linux paravirtualization for both domU and dom0
eventually. However the first step is to merge domU portion.
As you can see from the current patchset, abstraction and many clean up
must be done before merge.
Before starting cleaning up, we want to discuss with linux ia64 developers.
Please comment. Especially the first blocker is the paravirtualization of
the hand written assembly code as Eddie already tried to discuss.
The corresponding patch is
"ia64/xen: xen hand written assembly code paravirtualization."

NOTE:
This patchset depends on another patchset which I sent out as
"Xen arch portability patches."

thansk,

Diffstat:
 arch/ia64/Kconfig                        |   76 +
 arch/ia64/Makefile                       |   12 +-
 arch/ia64/configs/xen_domu_wip_defconfig |  854 ++++++++++++
 arch/ia64/kernel/Makefile                |   63 +
 arch/ia64/kernel/acpi.c                  |    6 +
 arch/ia64/kernel/asm-offsets.c           |   25 +
 arch/ia64/kernel/entry.S                 |   41 +-
 arch/ia64/kernel/fsys.S                  |   41 +
 arch/ia64/kernel/gate.S                  |   55 +
 arch/ia64/kernel/gate.lds.S              |   18 +
 arch/ia64/kernel/head.S                  |    6 +
 arch/ia64/kernel/iosapic.c               |   89 ++-
 arch/ia64/kernel/irq_ia64.c              |  363 +++++-
 arch/ia64/kernel/mca.c                   |   22 +
 arch/ia64/kernel/module.c                |   32 +
 arch/ia64/kernel/pal.S                   |    5 +-
 arch/ia64/kernel/paravirt_alt.c          |  118 ++
 arch/ia64/kernel/paravirt_core.c         |  201 +++
 arch/ia64/kernel/paravirt_entry.c        |   99 ++
 arch/ia64/kernel/paravirt_nop.c          |   49 +
 arch/ia64/kernel/paravirtentry.S         |   37 +
 arch/ia64/kernel/patch.c                 |   28 +
 arch/ia64/kernel/salinfo.c               |   44 +
 arch/ia64/kernel/setup.c                 |  121 ++
 arch/ia64/kernel/smpboot.c               |    4 +
 arch/ia64/kernel/time.c                  |  204 +++
 arch/ia64/kernel/vmlinux.lds.S           |   41 +
 arch/ia64/kernel/xengate-data.S          |    3 +
 arch/ia64/mm/init.c                      |   22 +-
 arch/ia64/xen/Kconfig                    |   29 +
 arch/ia64/xen/Makefile                   |   11 +
 arch/ia64/xen/hypercall.S                |  141 ++
 arch/ia64/xen/hypervisor.c               |  228 +++
 arch/ia64/xen/machvec.c                  |    4 +
 arch/ia64/xen/paravirt_xen.c             |  242 ++++
 arch/ia64/xen/privops_asm.S              |  221 +++
 arch/ia64/xen/privops_c.c                |  279 ++++
 arch/ia64/xen/util.c                     |  101 ++
 arch/ia64/xen/xcom_asm.S                 |   27 +
 arch/ia64/xen/xcom_hcall.c               |  458 +++++++
 arch/ia64/xen/xencomm.c                  |  108 ++
 arch/ia64/xen/xenentry.S                 |  798 +++++++++++
 arch/ia64/xen/xenivt.S                   | 2204 ++++++++++++++++++++++++++++++
 arch/ia64/xen/xenminstate.h              |  320 +++++
 arch/ia64/xen/xenpal.S                   |   76 +
 arch/ia64/xen/xensetup.S                 |   50 +
 include/asm-ia64/gcc_intrin.h            |   58 +-
 include/asm-ia64/hw_irq.h                |   10 +
 include/asm-ia64/intel_intrin.h          |   64 +-
 include/asm-ia64/intrinsics.h            |   12 +
 include/asm-ia64/iosapic.h               |    2 +
 include/asm-ia64/irq.h                   |   33 +
 include/asm-ia64/machvec.h               |    2 +
 include/asm-ia64/machvec_xen.h           |   22 +
 include/asm-ia64/meminit.h               |    7 +
 include/asm-ia64/mmu_context.h           |    6 +-
 include/asm-ia64/module.h                |    6 +
 include/asm-ia64/page.h                  |   11 +
 include/asm-ia64/paravirt_alt.h          |   82 ++
 include/asm-ia64/paravirt_core.h         |   54 +
 include/asm-ia64/paravirt_entry.h        |   62 +
 include/asm-ia64/paravirt_nop.h          |   46 +
 include/asm-ia64/privop.h                |   67 +
 include/asm-ia64/privop_paravirt.h       |  587 ++++++++
 include/asm-ia64/sal.h                   |   36 +
 include/asm-ia64/sync_bitops.h           |   61 +
 include/asm-ia64/system.h                |    4 +-
 include/asm-ia64/xen/hypercall.h         |  426 ++++++
 include/asm-ia64/xen/hypervisor.h        |  249 ++++
 include/asm-ia64/xen/interface.h         |  686 ++++++++++
 include/asm-ia64/xen/page.h              |   19 +
 include/asm-ia64/xen/privop.h            |  609 +++++++++
 include/asm-ia64/xen/xcom_hcall.h        |   55 +
 include/asm-ia64/xen/xencomm.h           |   33 +
 74 files changed, 11190 insertions(+), 95 deletions(-)

-- 
yamahata
