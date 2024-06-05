Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A06193097
	for <virtualization@lists.linux-foundation.org>; Wed,  5 Jun 2024 11:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717587683; cv=none; b=bo+d3FPUS0vZLcm6kl0w+qPuYnTDdo5JJOfAI6on0BnCAdVoXzrhNFEL+Lyuv9SAby9zNyv+zlVxNmEonnV78yz5aGWEmI2IFKEUDFHROlvoiJiNdvP8lSJoeZKgH2YA5lzxAvwx5UiiA4+zBn9NC70xCdRgDxf3QvcoeSpRIKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717587683; c=relaxed/simple;
	bh=S3u0bjQpavDADgmw6jZLWSNIcNZGzJbh3evgRUz4DTk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rPtS8aU01y3f4TdNJ413jye88E3cLudEqHhK6gQbeax6qqqflJjZI1IpxgCVaozjQ6CHdbsU0moP4viWrw+Bfr1XL6mHjesmMarCZ8SXOJXJuWsK9VAhqZfNdh//A68SAgsxtXGDmXawpcnk0gwsh25ahvBZgZYbktmbl1MotB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LaL7bLdq; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LaL7bLdq"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5BF08820B5
	for <virtualization@lists.linux-foundation.org>; Wed,  5 Jun 2024 11:41:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -4.401
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0RPp5qeBQxYl for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Jun 2024 11:41:20 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=145.40.73.55; helo=sin.source.kernel.org; envelope-from=bjorn@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 8695A820AD
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none) header.from=kernel.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8695A820AD
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=LaL7bLdq
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 8695A820AD
	for <virtualization@lists.linux-foundation.org>; Wed,  5 Jun 2024 11:41:19 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id DDD41CE1774;
	Wed,  5 Jun 2024 11:41:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8A7DC3277B;
	Wed,  5 Jun 2024 11:41:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717587674;
	bh=S3u0bjQpavDADgmw6jZLWSNIcNZGzJbh3evgRUz4DTk=;
	h=From:To:Cc:Subject:Date:From;
	b=LaL7bLdq+6cwrcQHLBpD94M8DbKhYUAqVsushnVvy0cLD86AL6hUnHO3M7GhiEeCh
	 yOli8oZSSzQglUtdfZ9lQdxULAIbKEkNV9nUt8mivwieLLYJthz4StgifM6pNibyp8
	 XyqvB20qwl3nEV7TZWuL6SUKTpv8NL8vfrL/PGaUY3Bd8sqdoNPunneetDIZKUKIOh
	 ZpRqWoiS5ox4iSnObOMf9bR4taHjlUzZR5El7C38znb4weoT7oDvB8xt+sm302YqBT
	 fHPt/fuN+mI6QageH31bWvLU/ml0sWxrVS6X1C4IDyR8yEkzb+/Z6P1Q4BE82JbCBj
	 KdcdPmXk4qenw==
From: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>
To: Alexandre Ghiti <alexghiti@rivosinc.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	David Hildenbrand <david@redhat.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	linux-riscv@lists.infradead.org,
	Oscar Salvador <osalvador@suse.de>
Cc: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
	Andrew Bresticker <abrestic@rivosinc.com>,
	Chethan Seshadri <Chethan.Seshadri@catalinasystems.io>,
	Lorenzo Stoakes <lstoakes@gmail.com>,
	Santosh Mamila <santosh.mamila@catalinasystems.io>,
	Sivakumar Munnangi <siva.munnangi@catalinasystems.io>,
	Sunil V L <sunilvl@ventanamicro.com>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	virtualization@lists.linux-foundation.org
Subject: [PATCH v4 00/11] riscv: Memory Hot(Un)Plug support
Date: Wed,  5 Jun 2024 13:40:43 +0200
Message-ID: <20240605114100.315918-1-bjorn@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Björn Töpel <bjorn@rivosinc.com>

================================================================
Memory Hot(Un)Plug support (and ZONE_DEVICE) for the RISC-V port
================================================================

(For the restless folks: change log in the bottom!)

Introduction
============

To quote "Documentation/admin-guide/mm/memory-hotplug.rst": "Memory
hot(un)plug allows for increasing and decreasing the size of physical
memory available to a machine at runtime."

This series adds memory hot(un)plugging, and ZONE_DEVICE support for
the RISC-V Linux port.

MM configuration
================

RISC-V MM has the following configuration:

 * Memory blocks are 128M, analogous to x86-64. It uses PMD
   ("hugepage") vmemmaps. From that follows that 2M (PMD) worth of
   vmemmap spans 32768 pages á 4K which gets us 128M.

 * The pageblock size is the minimum minimum virtio_mem size, and on
   RISC-V it's 2M (2^9 * 4K).

Implementation
==============

The PGD table on RISC-V is shared/copied between for all processes. To
avoid doing page table synchronization, the first patch (patch 1)
pre-allocated the PGD entries for vmemmap/direct map. By doing that
the init_mm PGD will be fixed at kernel init, and synchronization can
be avoided all together.

The following two patches (patch 2-3) does some preparations, followed
by the actual MHP implementation (patch 4-5). Then, MHP and virtio-mem
are enabled (patch 6-7), and finally ZONE_DEVICE support is added
(patch 8).

MHP and locking
===============

TL;DR: The MHP does not step on any toes, except for ptdump.
Additional locking is required for ptdump.

Long version: For v2 I spent some time digging into init_mm
synchronization/update. Here are my findings, and I'd love them to be
corrected if incorrect.

It's been a gnarly path...

The `init_mm` structure is a special mm (perhaps not a "real" one).
It's a "lazy context" that tracks kernel page table resources, e.g.,
the kernel page table (swapper_pg_dir), a kernel page_table_lock (more
about the usage below), mmap_lock, and such.

`init_mm` does not track/contain any VMAs. Having the `init_mm` is
convenient, so that the regular kernel page table walk/modify
functions can be used.

Now, `init_mm` being special means that the locking for kernel page
tables are special as well.

On RISC-V the PGD (top-level page table structure), similar to x86, is
shared (copied) with user processes. If the kernel PGD is modified, it
has to be synched to user-mode processes PGDs. This is avoided by
pre-populating the PGD, so it'll be fixed from boot.

The in-kernel pgd regions are documented in
`Documentation/arch/riscv/vm-layout.rst`.

The distinct regions are:
 * vmemmap
 * vmalloc/ioremap space
 * direct mapping of all physical memory
 * kasan
 * modules, BPF
 * kernel

Memory hotplug is the process of adding/removing memory to/from the
kernel.

Adding is done in two phases:
 1. Add the memory to the kernel
 2. Online memory, making it available to the page allocator.

Step 1 is partially architecture dependent, and updates the init_mm
page table:
 * Update the direct map page tables. The direct map is a linear map,
   representing all physical memory: `virt = phys + PAGE_OFFSET`
 * Add a `struct page` for each added page of memory. Update the
   vmemmap (virtual mapping to the `struct page`, so we can easily
   transform a kernel virtual address to a `struct page *` address.

From an MHP perspective, there are two regions of the PGD that are
updated:
 * vmemmap
 * direct mapping of all physical memory

The `struct mm_struct` has a couple of locks in play:
 * `spinlock_t page_table_lock` protects the page table, and some
    counters
 * `struct rw_semaphore mmap_lock` protect an mm's VMAs

Note again that `init_mm` does not contain any VMAs, but still uses
the mmap_lock in some places.

The `page_table_lock` was originally used to to protect all pages
tables, but more recently a split page table lock has been introduced.
The split lock has a per-table lock for the PTE and PMD tables. If
split lock is disabled, all tables are guarded by
`mm->page_table_lock` (for user processes). Split page table locks are
not used for init_mm.

MHP operations is typically synchronized using
`DEFINE_STATIC_PERCPU_RWSEM(mem_hotplug_lock)`.

Actors
------

The following non-MHP actors in the kernel traverses (read), and/or
modifies the kernel PGD.

 * `ptdump`

   Walks the entire `init_mm`, via `ptdump_walk_pgd()` with the
   `mmap_write_lock(init_mm)` taken.

   Observation: ptdump can race with MHP, and needs additional locking
   to avoid crashes/races.

 * `set_direct_*` / `arch/riscv/mm/pageattr.c`

   The `set_direct_*` functionality is used to "synchronize" the
   direct map to other kernel mappings, e.g. modules/kernel text. The
   direct map is using "as large huge table mappings as possible",
   which means that the `set_direct_*` might need to split the direct
   map.

  The `set_direct_*` functions operates with the
  `mmap_write_lock(init_mm)` taken.

  Observation: `set_direct_*` uses the direct map, but will never
  modify the same entry as MHP. If there is a mapping, that entry will
  never race with MHP. Further, MHP acts when memory is offline.

 * HVO / `mm/hugetlb_vmemmap`

   HVO optimizes the backing `struct page` for hugetlb pages, which
   means changing the "vmemmap" region. HVO can split (merge?) a
   vmemmap pmd. However, it will never race with MHP, since HVO only
   operates at online memory. HVO cannot touch memory being MHP added
   or removed.

 * `apply_to_page_range`

   Walks a range, creates pages and applies a callback (setting
   permissions) for the page.

   When creating a table, it might use `int __pte_alloc_kernel(pmd_t
   *pmd)` which takes the `init_mm.page_table_lock` to synchronize pmd
   populate.

   Used by: `mm/vmalloc.c` and `mm/kasan/shadow.c`. The KASAN callback
   takes the `init_mm.page_table_lock` to synchronize pte creation.

   Observations: `apply_to_page_range` applies to the "vmalloc/ioremap
   space" region, and "kasan" region. *Not* affected by MHP.

 * `apply_to_existing_page_range`

   Walks a range, applies a callback (setting permissions) for the
   page (no page creation).

   Used by: `kernel/bpf/arena.c` and `mm/kasan/shadow.c`. The KASAN
   callback takes the `init_mm.page_table_lock` to synchronize pte
   creation. *Not* affected by MHP regions.

 * `apply_to_existing_page_range` applies to the "vmalloc/ioremap
   space" region, and "kasan" region. *Not* affected by MHP regions.

 *  `ioremap_page_range` and `vmap_page_range`

    Uses the same internal function, and might create table entries at
    the "vmalloc/ioremap space" region. Can call
    `__pte_alloc_kernel()` which takes the `init_mm.page_table_lock`
    synchronizing pmd populate in the region. *Not* affected by MHP
    regions.

Summary:
  * MHP add will never modify the same page table entries, as any of
    the other actors.
  * MHP remove is done when memory is offlined, and will not clash
    with any of the actors.
  * Functions that walk the entire kernel page table need
    synchronization

  * It's sufficient to add the MHP lock ptdump.

Testing
=======

This series adds basic DT supported hotplugging. There is a QEMU
series enabling MHP for the RISC-V "virt" machine here: [1]

ACPI/MSI support is still in the making for RISC-V, and prior proper
(ACPI) PCI MSI support lands [2] and NUMA SRAT support [3], it hard to
try it out.

I've prepared a QEMU branch with proper ACPI GED/PC-DIMM support [4],
and a this series with the required prerequisites [5] (AIA, ACPI AIA
MADT, ACPI NUMA SRAT).


To test with virtio-mem, e.g.:
  | qemu-system-riscv64 \
  |     -machine virt,aia=aplic-imsic \
  |     -cpu rv64,v=true,vlen=256,elen=64,h=true,zbkb=on,zbkc=on,zbkx=on,zkr=on,zkt=on,svinval=on,svnapot=on,svpbmt=on \
  |     -nodefaults \
  |     -nographic -smp 8 -kernel rv64-u-boot.bin \
  |     -drive file=rootfs.img,format=raw,if=virtio \
  |     -device virtio-rng-pci \
  |     -m 16G,slots=3,maxmem=32G \
  |     -object memory-backend-ram,id=mem0,size=16G \
  |     -numa node,nodeid=0,memdev=mem0 \
  |     -serial chardev:char0 \
  |     -mon chardev=char0,mode=readline \
  |     -chardev stdio,mux=on,id=char0 \
  |     -device pci-serial,id=serial0,chardev=char0 \
  |     -object memory-backend-ram,id=vmem0,size=2G \
  |     -device virtio-mem-pci,id=vm0,memdev=vmem0,node=0

where "rv64-u-boot.bin" is U-boot with EFI/ACPI-support (use [6] if
you're lazy).

In the QEMU monitor:
  | (qemu) info memory-devices
  | (qemu) qom-set vm0 requested-size 1G

...to test DAX/KMEM, use the follow QEMU parameters:
  |  -object memory-backend-file,id=mem1,share=on,mem-path=virtio_pmem.img,size=4G \
  |  -device virtio-pmem-pci,memdev=mem1,id=nv1

and the regular ndctl/daxctl dance.

If you're brave to try the ACPI branch, add "acpi=on" to "-machine
virt", and test PC-DIMM MHP (in addition to virtio-{p},mem):

In the QEMU monitor:
  | (qemu) object_add memory-backend-ram,id=mem1,size=1G
  | (qemu) device_add pc-dimm,id=dimm1,memdev=mem1

You can also try hot-remove with some QEMU options, say:
  | -object memory-backend-file,id=mem-1,size=256M,mem-path=/pagesize-2MB
  | -device pc-dimm,id=mem1,memdev=mem-1
  | -object memory-backend-file,id=mem-2,size=1G,mem-path=/pagesize-1GB
  | -device pc-dimm,id=mem2,memdev=mem-2
  | -object memory-backend-file,id=mem-3,size=256M,mem-path=/pagesize-2MB
  | -device pc-dimm,id=mem3,memdev=mem-3

Remove "acpi=on" to run with DT.

Thanks to Alex, Andrew, David, and Oscar for all
comments/tests/fixups.

Changelog
=========

v3->v4:
  Collect tags
  0002-riscv-mm-Pre-allocate-vmemmap-direct-map-kasan-PG
    * Pre-allocate KASAN PGD entries as well (Alex)
  0005-riscv-mm-Add-pfn_to_kaddr-implementation
    * New patch, add missing function for KASAN
  0006-riscv-mm-Add-memory-hotplugging-support
    * Use pXXX_get() instead of READ_ONCE (Alex)
    * Separated vmemmap storage and pgtable allocation. Use matching
      alloc/dealloc functions (e.g. ptdesc alloc/delloc) with also
      avoids WARNs ;-)
    * Cleaned up the reserved page freeing (Alex)
  0008-riscv-Enable-memory-hotplugging-for-RISC-V
    * Simplified the dependencies (Alex)
    * Added ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE
  0011-riscv-Enable-DAX-VMEMMAP-optimization
    * New patch, added ARCH_WANT_OPTIMIZE_DAX_VMEMMAP

v2->v3:
  Collect tags
  0001-riscv-mm-Properly-forward-vmemmap_populate-altmap
    * New patch, split from attribute change (Alex, Oscar)
  0005-riscv-mm-Add-memory-hotplugging-support
    * Fix page table free to take PG_reserved into consideration (David,
      Oscar)
    * Depend on SPARSE_VMEMMAP (Alex, David, Oscar)
    * Proper TLB flushing (Alex)
  0009-riscv-mm-Add-support-for-ZONE_DEVICE
    * Fixed 32b build

v1->v2:
  Reviewed a lot of MHP locking scenarios
  Various config build issues (e.g. build !CONFIG_MEMORY_HOTPLUG) (Andrew)
  Added arch_get_mappable_range() implementation
  Acquire MHP lock for ptdump, analogous to arm64
  ACPI MHP tests
  Add ZONE_DEVICE patch

References
==========

[1] https://lore.kernel.org/qemu-devel/20240521105635.795211-1-bjorn@kernel.org/
[2] https://lore.kernel.org/linux-riscv/20240501121742.1215792-1-sunilvl@ventanamicro.com/
[3] https://lore.kernel.org/linux-riscv/cover.1713778236.git.haibo1.xu@intel.com/
[4] https://github.com/bjoto/qemu/commits/virtio-mem-pc-dimm-mhp-acpi-v2/
[5] https://github.com/bjoto/linux/commits/mhp-v4-acpi
[6] https://github.com/bjoto/riscv-rootfs-utils/tree/acpi


Thanks,
Björn


Björn Töpel (11):
  riscv: mm: Properly forward vmemmap_populate() altmap parameter
  riscv: mm: Pre-allocate vmemmap/direct map/kasan PGD entries
  riscv: mm: Change attribute from __init to __meminit for page
    functions
  riscv: mm: Refactor create_linear_mapping_range() for memory hot add
  riscv: mm: Add pfn_to_kaddr() implementation
  riscv: mm: Add memory hotplugging support
  riscv: mm: Take memory hotplug read-lock during kernel page table dump
  riscv: Enable memory hotplugging for RISC-V
  virtio-mem: Enable virtio-mem for RISC-V
  riscv: mm: Add support for ZONE_DEVICE
  riscv: Enable DAX VMEMMAP optimization

 arch/riscv/Kconfig                    |   5 +
 arch/riscv/include/asm/kasan.h        |   4 +-
 arch/riscv/include/asm/mmu.h          |   4 +-
 arch/riscv/include/asm/page.h         |   5 +
 arch/riscv/include/asm/pgtable-64.h   |  20 ++
 arch/riscv/include/asm/pgtable-bits.h |   1 +
 arch/riscv/include/asm/pgtable.h      |  19 +-
 arch/riscv/mm/init.c                  | 347 +++++++++++++++++++++++---
 arch/riscv/mm/ptdump.c                |   3 +
 drivers/virtio/Kconfig                |   2 +-
 10 files changed, 364 insertions(+), 46 deletions(-)


base-commit: e2c79b4c5c4d83520abb570ca633ded09621c0a6
-- 
2.43.0

