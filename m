From: "H. Peter Anvin" <hpa@linux.intel.com>
Subject: [GIT PULL] x86/mm changes for v3.9-rc1
Date: Thu, 21 Feb 2013 16:34:06 -0800
Message-ID: <201302220034.r1M0Y6O8008311__20431.2942376875$1361493643$gmane$org@terminus.zytor.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6620059395951459387=="
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
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-mips@linux-mips.org, Jeremy Fitzhardinge <jeremy@goop.org>, "H. J. Lu" <hjl.tools@gmail.com>, Frederic Weisbecker <fweisbec@gmail.com>, Joe Millenbach <jmillenbach@gmail.com>, virtualization@lists.linux-foundation.org, Gokul Caushik <caushik1@gmail.com>, Ralf Baechle <ralf@linux-mips.org>, Pavel Machek <pavel@ucw.cz>, "H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org, Christoph Lameter <cl@linux.com>, Ingo Molnar <mingo@kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>, Andrea Arcangeli <aarcange@redhat.com>, Lee Schermerhorn <Lee.Schermerhorn@hp.com>, xen-devel@lists.xensource.com, Russell King <linux@arm.linux.org.uk>, Len Brown <len.brown@intel.com>, Joerg Roedel <joro@8bytes.org>, Stefano Stabellini <stefano.s tabellini@eu.citrix.com>, Hugh Dickins <hughd@google.com>, Yasuaki Ishimatsu <isimatu.yasuaki@jp.f>
List-Id: virtualization@lists.linuxfoundation.org

--===============6620059395951459387==
Content-Type: text/plain

Hi Linus,

This is a huge set of several partly interrelated (and concurrently
developed) changes, which is why the branch history is messier than
one would like.

The *really* big items are two humonguous patchsets mostly developed
by Yinghai Lu at my request, which completely revamps the way we
create initial page tables.  In particular, rather than estimating how
much memory we will need for page tables and then build them into that
memory -- a calculation that has shown to be incredibly fragile -- we
now build them (on 64 bits) with the aid of a "pseudo-linear mode" --
a #PF handler which creates temporary page tables on demand.

This has several advantages:

1. It makes it much easier to support things that need access to
   data very early (a followon patchset uses this to load microcode
   way early in the kernel startup).

2. It allows the kernel and all the kernel data objects to be invoked
   from above the 4 GB limit.  This allows kdump to work on very large
   systems.

3. It greatly reduces the difference between Xen and native (Xen's
   equivalent of the #PF handler are the temporary page tables created
   by the domain builder), eliminating a bunch of fragile hooks.

The patch series also gets us a bit closer to W^X.

Additional work in this pull is the 64-bit get_user() work which you
were also involved with, and a bunch of cleanups/speedups to
__phys_addr()/__pa().

----------------------------------------------------------------

The following changes since commit 5dcd14ecd41ea2b3ae3295a9b30d98769d52165f:

  x86, boot: Sanitize boot_params if not zeroed on creation (2013-01-29 01:22:17 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-mm-for-linus

for you to fetch changes up to 0da3e7f526fde7a6522a3038b7ce609fc50f6707:

  Merge branch 'x86/mm2' into x86/mm (2013-02-15 09:25:08 -0800)

----------------------------------------------------------------

Alexander Duyck (9):
      x86: Move some contents of page_64_types.h into pgtable_64.h and page_64.h
      x86: Improve __phys_addr performance by making use of carry flags and inlining
      x86: Make it so that __pa_symbol can only process kernel symbols on x86_64
      x86: Drop 4 unnecessary calls to __pa_symbol
      x86: Use __pa_symbol instead of __pa on C visible symbols
      x86/ftrace: Use __pa_symbol instead of __pa on C visible symbols
      x86/acpi: Use __pa_symbol instead of __pa on C visible symbols
      x86/lguest: Use __pa_symbol instead of __pa on C visible symbols
      x86: Fix warning about cast from pointer to integer of different size

Borislav Petkov (1):
      x86/numa: Use __pa_nodebug() instead

Dave Hansen (6):
      x86, mm: Make DEBUG_VIRTUAL work earlier in boot
      x86, mm: Pagetable level size/shift/mask helpers
      x86, mm: Use new pagetable helpers in try_preserve_large_page()
      x86, mm: Create slow_virt_to_phys()
      x86, kvm: Fix kvm's use of __pa() on percpu areas
      x86-32, mm: Rip out x86_32 NUMA remapping code

H. Peter Anvin (13):
      Merge branch 'x86/mm' of ssh://ra.kernel.org/.../tip/tip into x86/mm
      Merge tag 'v3.8-rc5' into x86/mm
      Merge remote-tracking branch 'origin/x86/boot' into x86/mm2
      x86, 64bit: Use a #PF handler to materialize early mappings on demand
      x86-32, mm: Remove reference to resume_map_numa_kva()
      x86-32, mm: Remove reference to alloc_remap()
      Merge remote-tracking branch 'origin/x86/mm' into x86/mm2
      x86, mm: Use a bitfield to mask nuisance get_user() warnings
      x86: Be consistent with data size in getuser.S
      x86, mm: Redesign get_user with a __builtin_choose_expr hack
      x86, doc: Clarify the use of asm("%edx") in uaccess.h
      x86, mm: Move reserving low memory later in initialization
      Merge branch 'x86/mm2' into x86/mm

Ingo Molnar (1):
      x86/mm: Don't flush the TLB on #WP pmd fixups

Jacob Shin (3):
      x86, mm: if kernel .text .data .bss are not marked as E820_RAM, complain and fix
      x86, mm: Fixup code testing if a pfn is direct mapped
      x86, mm: Only direct map addresses that are marked as E820_RAM

Shuah Khan (1):
      x86/kvm: Fix compile warning in kvm_register_steal_time()

Stefano Stabellini (1):
      x86, mm: Add pointer about Xen mmu requirement for alloc_low_pages

Ville Syrjälä (1):
      x86-32: Add support for 64bit get_user()

Yinghai Lu (74):
      x86, mm: Add global page_size_mask and probe one time only
      x86, mm: Split out split_mem_range from init_memory_mapping
      x86, mm: Move down find_early_table_space()
      x86, mm: Move init_memory_mapping calling out of setup.c
      x86, mm: Revert back good_end setting for 64bit
      x86, mm: Change find_early_table_space() paramters
      x86, mm: Find early page table buffer together
      x86, mm: Separate out calculate_table_space_size()
      x86, mm: Set memblock initial limit to 1M
      x86, mm: use pfn_range_is_mapped() with CPA
      x86, mm: use pfn_range_is_mapped() with gart
      x86, mm: use pfn_range_is_mapped() with reserve_initrd
      x86, mm: relocate initrd under all mem for 64bit
      x86, mm: Align start address to correct big page size
      x86, mm: Use big page size for small memory range
      x86, mm: Don't clear page table if range is ram
      x86, mm: Break down init_all_memory_mapping
      x86, mm: setup page table in top-down
      x86, mm: Remove early_memremap workaround for page table accessing on 64bit
      x86, mm: Remove parameter in alloc_low_page for 64bit
      x86, mm: Merge alloc_low_page between 64bit and 32bit
      x86, mm: Move min_pfn_mapped back to mm/init.c
      x86, mm, Xen: Remove mapping_pagetable_reserve()
      x86, mm: Add alloc_low_pages(num)
      x86, mm: only call early_ioremap_page_table_range_init() once
      x86, mm: Move back pgt_buf_* to mm/init.c
      x86, mm: Move init_gbpages() out of setup.c
      x86, mm: change low/hignmem_pfn_init to static on 32bit
      x86, mm: Move function declaration into mm_internal.h
      x86, mm: Add check before clear pte above max_low_pfn on 32bit
      x86, mm: use round_up/down in split_mem_range()
      x86, mm: use PFN_DOWN in split_mem_range()
      x86, mm: use pfn instead of pos in split_mem_range
      x86, mm: use limit_pfn for end pfn
      x86, mm: Unifying after_bootmem for 32bit and 64bit
      x86, mm: Move after_bootmem to mm_internel.h
      x86, mm: Use clamp_t() in init_range_memory_mapping
      x86, mm: kill numa_free_all_bootmem()
      x86, mm: kill numa_64.h
      sparc, mm: Remove calling of free_all_bootmem_node()
      mm: Kill NO_BOOTMEM version free_all_bootmem_node()
      x86, mm: Let "memmap=" take more entries one time
      x86, mm: Fix page table early allocation offset checking
      x86: Factor out e820_add_kernel_range()
      x86, 64bit, mm: Make pgd next calculation consistent with pud/pmd
      x86, realmode: Set real_mode permissions early
      x86, 64bit, mm: Add generic kernel/ident mapping helper
      x86, 64bit: Copy struct boot_params early
      x86, 64bit, realmode: Use init_level4_pgt to set trampoline_pgd directly
      x86, realmode: Separate real_mode reserve and setup
      x86, 64bit: #PF handler set page to cover only 2M per #PF
      x86, 64bit: Don't set max_pfn_mapped wrong value early on native path
      x86: Merge early_reserve_initrd for 32bit and 64bit
      x86: Add get_ramdisk_image/size()
      x86, boot: Add get_cmd_line_ptr()
      x86, boot: Move checking of cmd_line_ptr out of common path
      x86, boot: Pass cmd_line_ptr with unsigned long instead
      x86, boot: Move verify_cpu.S and no_longmode down
      x86, boot: Move lldt/ltr out of 64bit code section
      x86, kexec: Remove 1024G limitation for kexec buffer on 64bit
      x86, kexec: Set ident mapping for kernel that is above max_pfn
      x86, kexec: Replace ident_mapping_init and init_level4_page
      x86, kexec, 64bit: Only set ident mapping for ram.
      x86, boot: Support loading bzImage, boot_params and ramdisk above 4G
      x86, boot: Update comments about entries for 64bit image
      x86, boot: Not need to check setup_header version for setup_data
      memblock: Add memblock_mem_size()
      x86, kdump: Remove crashkernel range find limit for 64bit
      x86: Add Crash kernel low reservation
      x86: Merge early kernel reserve for 32bit and 64bit
      x86, 64bit, mm: Mark data/bss/brk to nx
      x86, 64bit, mm: hibernate use generic mapping_init
      mm: Add alloc_bootmem_low_pages_nopanic()
      x86: Don't panic if can not alloc buffer for swiotlb

 Documentation/kernel-parameters.txt     |   3 +
 Documentation/x86/boot.txt              |  38 +++
 arch/mips/cavium-octeon/dma-octeon.c    |   3 +-
 arch/sparc/mm/init_64.c                 |  24 +-
 arch/x86/Kconfig                        |   4 -
 arch/x86/boot/boot.h                    |  18 +-
 arch/x86/boot/cmdline.c                 |  12 +-
 arch/x86/boot/compressed/cmdline.c      |  12 +-
 arch/x86/boot/compressed/head_64.S      |  48 ++--
 arch/x86/boot/header.S                  |  10 +-
 arch/x86/include/asm/init.h             |  28 +-
 arch/x86/include/asm/kexec.h            |   6 +-
 arch/x86/include/asm/mmzone_32.h        |   6 -
 arch/x86/include/asm/numa.h             |   2 -
 arch/x86/include/asm/numa_64.h          |   6 -
 arch/x86/include/asm/page.h             |   7 +-
 arch/x86/include/asm/page_32.h          |   1 +
 arch/x86/include/asm/page_64.h          |  36 +++
 arch/x86/include/asm/page_64_types.h    |  22 --
 arch/x86/include/asm/page_types.h       |   2 +
 arch/x86/include/asm/pgtable.h          |  16 ++
 arch/x86/include/asm/pgtable_64.h       |   5 +
 arch/x86/include/asm/pgtable_64_types.h |   4 +
 arch/x86/include/asm/pgtable_types.h    |   4 +-
 arch/x86/include/asm/processor.h        |   1 +
 arch/x86/include/asm/realmode.h         |   3 +-
 arch/x86/include/asm/uaccess.h          |  55 ++--
 arch/x86/include/asm/x86_init.h         |  12 -
 arch/x86/kernel/acpi/boot.c             |   1 -
 arch/x86/kernel/acpi/sleep.c            |   2 +-
 arch/x86/kernel/amd_gart_64.c           |   5 +-
 arch/x86/kernel/apic/apic_numachip.c    |   1 +
 arch/x86/kernel/cpu/amd.c               |   9 +-
 arch/x86/kernel/cpu/intel.c             |   3 +-
 arch/x86/kernel/e820.c                  |  16 +-
 arch/x86/kernel/ftrace.c                |   4 +-
 arch/x86/kernel/head32.c                |  20 --
 arch/x86/kernel/head64.c                | 131 ++++++---
 arch/x86/kernel/head_64.S               | 210 +++++++++------
 arch/x86/kernel/i386_ksyms_32.c         |   1 +
 arch/x86/kernel/kvm.c                   |  11 +-
 arch/x86/kernel/kvmclock.c              |   4 +-
 arch/x86/kernel/machine_kexec_64.c      | 171 ++++--------
 arch/x86/kernel/setup.c                 | 260 +++++++++++-------
 arch/x86/kernel/traps.c                 |   9 +
 arch/x86/kernel/x8664_ksyms_64.c        |   3 +
 arch/x86/kernel/x86_init.c              |   4 -
 arch/x86/lguest/boot.c                  |   3 +-
 arch/x86/lib/getuser.S                  |  43 ++-
 arch/x86/mm/init.c                      | 459 +++++++++++++++++++++-----------
 arch/x86/mm/init_32.c                   | 106 +++++---
 arch/x86/mm/init_64.c                   | 255 ++++++++++--------
 arch/x86/mm/mm_internal.h               |  19 ++
 arch/x86/mm/numa.c                      |  32 +--
 arch/x86/mm/numa_32.c                   | 161 -----------
 arch/x86/mm/numa_64.c                   |  13 -
 arch/x86/mm/numa_internal.h             |   6 -
 arch/x86/mm/pageattr.c                  |  66 +++--
 arch/x86/mm/pat.c                       |   4 +-
 arch/x86/mm/pgtable.c                   |   7 +-
 arch/x86/mm/physaddr.c                  |  60 +++--
 arch/x86/platform/efi/efi.c             |  11 +-
 arch/x86/power/hibernate_32.c           |   2 -
 arch/x86/power/hibernate_64.c           |  66 ++---
 arch/x86/realmode/init.c                |  49 ++--
 arch/x86/xen/mmu.c                      |  28 --
 drivers/xen/swiotlb-xen.c               |   4 +-
 include/linux/bootmem.h                 |   5 +
 include/linux/kexec.h                   |   3 +
 include/linux/memblock.h                |   1 +
 include/linux/mm.h                      |   1 -
 include/linux/swiotlb.h                 |   2 +-
 kernel/kexec.c                          |  34 ++-
 lib/swiotlb.c                           |  47 ++--
 mm/bootmem.c                            |   8 +
 mm/memblock.c                           |  17 ++
 mm/nobootmem.c                          |  23 +-
 77 files changed, 1541 insertions(+), 1247 deletions(-)

[Skipping the full diff due to size]

--===============6620059395951459387==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============6620059395951459387==--
