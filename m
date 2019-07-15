From: Juergen Gross <jgross@suse.com>
Subject: [PATCH 0/2] Remove 32-bit Xen PV guest support
Date: Mon, 15 Jul 2019 13:37:37 +0200
Message-ID: <20190715113739.17694-1-jgross__19259.7239905567$1563190679$gmane$org@suse.com>
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
To: xen-devel@lists.xenproject.org, x86@kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
Cc: Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, Alok Kataria <akataria@vmware.com>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Boris Ostrovsky <boris.ostrovsky@oracle.com>
List-Id: virtualization@lists.linuxfoundation.org

The long term plan has been to replace Xen PV guests by PVH. The first
victim of that plan are now 32-bit PV guests, as those are used only
rather seldom these days. Xen on x86 requires 64-bit support and with
Grub2 now supporting PVH officially since version 2.04 there is no
need to keep 32-bit PV guest support alive in the Linux kernel.
Additionally Meltdown mitigation is not available in the kernel running
as 32-bit PV guest, so dropping this mode makes sense from security
point of view, too.

Juergen Gross (2):
  x86/xen: remove 32-bit Xen PV guest support
  x86/paravirt: remove 32-bit support from PARAVIRT_XXL

 arch/x86/entry/entry_32.S                   |  93 --------
 arch/x86/entry/vdso/vdso32/vclock_gettime.c |   1 +
 arch/x86/include/asm/paravirt.h             | 105 +--------
 arch/x86/include/asm/paravirt_types.h       |  20 --
 arch/x86/include/asm/pgtable-3level_types.h |   5 -
 arch/x86/include/asm/proto.h                |   2 +-
 arch/x86/include/asm/segment.h              |   2 +-
 arch/x86/include/asm/traps.h                |   2 +-
 arch/x86/kernel/cpu/common.c                |   8 -
 arch/x86/kernel/paravirt.c                  |  17 --
 arch/x86/kernel/paravirt_patch_32.c         |  36 +--
 arch/x86/xen/Kconfig                        |   3 +-
 arch/x86/xen/Makefile                       |   4 +-
 arch/x86/xen/apic.c                         |  17 --
 arch/x86/xen/enlighten_pv.c                 |  45 +---
 arch/x86/xen/mmu_pv.c                       | 326 +++-------------------------
 arch/x86/xen/p2m.c                          |   4 -
 arch/x86/xen/setup.c                        |  44 +---
 arch/x86/xen/smp_pv.c                       |  19 +-
 arch/x86/xen/xen-asm.S                      |  14 --
 arch/x86/xen/xen-asm_32.S                   | 207 ------------------
 arch/x86/xen/xen-head.S                     |   6 -
 arch/x86/xen/xen-ops.h                      |   5 -
 drivers/xen/Kconfig                         |   4 +-
 24 files changed, 57 insertions(+), 932 deletions(-)
 delete mode 100644 arch/x86/xen/xen-asm_32.S

-- 
2.16.4
