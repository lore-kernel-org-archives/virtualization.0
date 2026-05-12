Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51576385D76
	for <virtualization@lists.linux.dev>; Tue, 12 May 2026 21:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778619903; cv=none; b=CBoItIJ0IE+qcKen9DnnUqcgHhIgxuye4+cndVDcPA2/gc238LaOisLWjiqw1wjv1BBPAmLpovMVWbTknUNe0N3Cqzd/XgyGbdVmK7Q1szanPK/FYA/BOwtNej+1leDO0gFaA029QWL3O/3PNL31Y6hbJz2sTWWEvh00XxTlE7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778619903; c=relaxed/simple;
	bh=Bq9qkOreR0mv9dhRyX55+xstvVblY7PFIrRI0/52p64=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=bA0NeS0GdZRIinay1qkYM5IZ1MLOsxUwRd1slLMS0qrsU7Pt6PGJSlAluMJbjo9hOLz6WHu0lzSTNERKs/Cb/sckyP/Js8A03Tr+0suWMHRNAiQ2UKtRssgUHj2NdOzXnDwDk8nzK5eUYCMHn9tfe+LLoBFrssX3IUVmeqmzrkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IANmKZ29; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IANmKZ29"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778619900;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=9lLv6p/j4Irzd0qfT6E+pYhovjt9ZWQYdkDBYtl1rbw=;
	b=IANmKZ29/+fMhlhCebnjPKuJuDuzkCR+YkcMgYvmtIvTig3p/9kczbUFxbJxnkeifA+Lpx
	O4A2OVsiyavFGytkiBiehMT8B5+/6jeN1zyuR5ucBQvxKDtiugRO/7VUWlb9uGmckRO23J
	jzf6zvgzo2CtMPTxFpF9yKyXX+rb9hI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-UeD8Vwu_P_entJwJI06jCQ-1; Tue, 12 May 2026 17:04:58 -0400
X-MC-Unique: UeD8Vwu_P_entJwJI06jCQ-1
X-Mimecast-MFC-AGG-ID: UeD8Vwu_P_entJwJI06jCQ_1778619897
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-48d1b294dfeso53429505e9.0
        for <virtualization@lists.linux.dev>; Tue, 12 May 2026 14:04:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778619897; x=1779224697;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9lLv6p/j4Irzd0qfT6E+pYhovjt9ZWQYdkDBYtl1rbw=;
        b=e6KDDAMNehuk96Bz1QpXXX4fG+qTKrqwB8uJ69BM63lW+m7ZGBn5tZ/JpVkdjoRiwN
         EWs6p3uwDkbCS7N2hBHNovy8FBtMhIDiRvKtsWKXERr0lAEOQHpYqPFUbBZaO+YPz5be
         xSYkbwNXShvusq9V+ARth6m4P0c4sCmcqhfq0uCIe7b4DcdriPuu0ILNu093Giz5lD9F
         ig47OIRiAum8s17uYcKsVLD5S5sKiOgkwpafYMI8ixgev1DSBr7dJ4rPQuqHCW04ZB8x
         79i33zf4opLEY5ikmZJwHgRKIx7DFcwuv0v0ONGWuuGX5TMZati6ZfImpFODgTl8hEbN
         Jdzg==
X-Forwarded-Encrypted: i=1; AFNElJ+FnoKmsvP1o/zOHhDEf5oIxmMlpXL1okXgV0rnHBdgJMcnd7MkZgwVAr3zqHnTt+UarFbF+baMC37Qj+/TAw==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywpw6eCrR+OxYbbDFQnyWBvvIO+J5oNETAc3ccrbDMUbq7QGKMU
	w/3hOUTb5IKFUzFR1lZq0XbQg7zNXaIbhmkLgdI3x7cp3zWI1j2rvkQaMi3+KssiNEspUMoCw6z
	KZK1N4q8LGZ1oyh8kVMesP+C4JjvGVbgw0rYyF+uLixfkbKIjx9BRDWSLH+tNjbXUu3A0
X-Gm-Gg: Acq92OG07zVj7+R5VpzpgX4WH086IVD3Ctikq7seeXNdCY2AklVcprgNbrnzdbHpJBD
	ktURgocT+aH+tRLbWLeNO11JivBzv+B8NXL2XT2fUazf0Ybc6G4GLsiCdC1R/X4lVZU0jHCsxWZ
	VdFLRcYqf98/mHizYHsD7c9idnNkQAZoAnnO5BE34Ux1ceqCx9mFlAjaKj24mXLUkrFnvBCdjPU
	gEnV3AtQy8zmR9Q4BIGb1zWVwZQ9KqUNByRyXOVUypM53qydxAUN01tBK73HuY26RKXeTqIHCjT
	F6sRkJ3qWk3uLjlkbbpbfjOyZTBAINH752PQq+Ci+9wgjIPQVhxP4Py9+a3wV6Dgv4JIG78zhcT
	+kKAZeo53aySjvvg0VFR/9T9c9OLch0tNXblnOtAG
X-Received: by 2002:a05:600c:c08e:b0:48a:5574:3a5b with SMTP id 5b1f17b1804b1-48fc9a5350bmr4552365e9.27.1778619896866;
        Tue, 12 May 2026 14:04:56 -0700 (PDT)
X-Received: by 2002:a05:600c:c08e:b0:48a:5574:3a5b with SMTP id 5b1f17b1804b1-48fc9a5350bmr4551885e9.27.1778619896189;
        Tue, 12 May 2026 14:04:56 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-48-7.inter.net.il. [80.230.48.7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fc8d2855fsm23266145e9.10.2026.05.12.14.04.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 14:04:55 -0700 (PDT)
Date: Tue, 12 May 2026 17:04:51 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: "David Hildenbrand (Arm)" <david@kernel.org>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <jackmanb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
	Lance Yang <lance.yang@linux.dev>, Hugh Dickins <hughd@google.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
	Byungchul Park <byungchul@sk.com>,
	Gregory Price <gourry@gourry.net>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Alistair Popple <apopple@nvidia.com>,
	Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Harry Yoo <harry.yoo@oracle.com>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,
	Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>,
	virtualization@lists.linux.dev, linux-mm@kvack.org,
	Andrea Arcangeli <aarcange@redhat.com>
Subject: [PATCH v7 00/31] mm/virtio: skip redundant zeroing of host-zeroed
 pages
Message-ID: <cover.1778616612.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: uw3lzmvhFoZATm2s11AEdwGamIa7Q7ji8HN2FXhyyjY_1778619897
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

When a guest reports free pages to the hypervisor via virtio-balloon's
free page reporting, the host typically zeros those pages when reclaiming
their backing memory (e.g., via MADV_DONTNEED on anonymous mappings).
When the guest later reallocates those pages, the kernel zeros them
again, redundantly.

Further, on architectures with aliasing caches, upstream with init_on_alloc
double-zeros user pages: once via kernel_init_pages() in
post_alloc_hook, and again via clear_user_highpage() at the
callsite (because user_alloc_needs_zeroing() returns true).
This series eliminates that double-zeroing by moving the zeroing
into the post_alloc_hook + propagating the "host
already zeroed this page" information through the buddy allocator.

For page reporting, VIRTIO_BALLOON_F_DEVICE_INIT_REPORTED (bit 6)
is used. For the inflate/deflate path,
VIRTIO_BALLOON_F_DEVICE_INIT_ON_INFLATE (bit 7) is used.

Virtio spec: https://lore.kernel.org/all/cover.1778140241.git.mst@redhat.com

Based on v7.1-rc2.  When applying on mm-unstable, two conflicts
are expected:
- kernel_init_pages() was renamed to clear_highpages_kasan_tagged()
  in mm-unstable.  Use clear_highpages_kasan_tagged() in the
  post_alloc_hook else branch.
- FPI_PREPARED uses BIT(3) in mm-unstable.  Bump FPI_ZEROED to
  BIT(4).
Build-tested on mm-unstable at e9dd96806dbc:
https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git zero-mm-unstable

Patches 1-4: fixes/cleanups, dependencies of the zeroing patches.
Patches 5-18: mm rework + cleanups + init_on_alloc double-zeroing fix.
Patches 19-27: page reporting zeroing (DEVICE_INIT_REPORTED).
Patches 28-31: inflate/deflate zeroing (DEVICE_INIT_ON_INFLATE).

-------

Performance with THP enabled on a 2GB VM, 1 vCPU, allocating
256MB of anonymous pages:

  metric         baseline            optimized           delta
  task-clock     232 +- 20 ms        51 +- 26 ms         -78%
  cache-misses   1.20M +- 248K       288K +- 102K        -76%
  instructions   16.3M +- 1.2M       13.8M +- 1.0M       -15%

With hugetlb surplus pages:

  metric         baseline            optimized           delta
  task-clock     219 +- 23 ms        65 +- 34 ms         -70%
  cache-misses   1.17M +- 391K       263K +- 36K         -78%
  instructions   17.9M +- 1.2M       15.1M +- 724K       -16%

Two flags track known-zero pages:
  PG_zeroed (aliased to PG_private) marks buddy allocator pages that
  are known to contain all zeros -- either because the host zeroed
  them during page reporting, or because they were freed via the
  balloon deflate path.  It lives on free-list pages and is consumed
  by post_alloc_hook() on allocation.
  HPG_zeroed (stored in hugetlb folio->private bits) serves the same
  purpose for hugetlb pool pages, which are kept in a pool and may
  be zeroed long after buddy allocation, so PG_zeroed (consumed at
  allocation time) cannot track their state.

PG_zeroed lifecycle:

  Sets PG_zeroed:
  - page_reporting_drain: on reported pages when host zeroes them
  - __free_pages_ok / __free_frozen_pages: when FPI_ZEROED is set
    (balloon deflate path)
  - buddy merge: on merged page if both buddies were zeroed
  - expand(): propagate to split-off buddy sub-pages

  Clears PG_zeroed:
  - __free_pages_prepare: clears all PAGE_FLAGS_CHECK_AT_PREP flags
    (PG_zeroed included), preventing PG_private aliasing leaks
  - rmqueue_buddy / __rmqueue_pcplist: read-then-clear, passes
    zeroed hint to prep_new_page -> post_alloc_hook
  - __isolate_free_page: clear (compaction/page_reporting isolation)
  - compaction, alloc_contig, split_free_frozen: clear before use
  - buddy merge: clear both pages before merge, then conditionally
    re-set on merged head if both were zeroed

HPG_zeroed lifecycle (hugetlb pool pages, stored in folio->private):

  Sets HPG_zeroed:
  - alloc_surplus_hugetlb_folio: after buddy allocation with
    __GFP_ZERO, mark pool page as known-zero

  Clears HPG_zeroed:
  - free_huge_folio: page was mapped to userspace, no longer
    known-zero when it returns to the pool
  - alloc_hugetlb_folio: cleared unconditionally on output
  - alloc_hugetlb_folio_reserve: cleared after checking

- The optimization is most effective with THP, where entire 2MB
  pages are allocated directly from reported order-9+ buddy pages.
  Without THP, only ~21% of order-0 allocations come from reported
  pages due to low-order fragmentation.
- Persistent hugetlb pool pages are not covered: when freed by
  userspace they return to the hugetlb free pool, not the buddy
  allocator, so they are never reported to the host.  Surplus
  hugetlb pages are allocated from buddy and do benefit.

- PG_zeroed is aliased to PG_private.  __free_pages_prepare() clears it
  (preventing filesystem PG_private from leaking as false PG_zeroed).
  FPI_ZEROED re-sets it after prepare for balloon deflate pages.
  Is aliasing PG_private acceptable, or should a different bit be used?

- On architectures with aliasing caches, upstream with init_on_alloc
  double-zeros user pages: once via kernel_init_pages() in
  post_alloc_hook, and again via clear_user_highpage() at the
  callsite (because user_alloc_needs_zeroing() returns true).
  Our patches eliminate this by zeroing once via folio_zero_user()
  in post_alloc_hook.  Not a critical fix (people who set init_on_alloc
  know they are paying performance) but a nice cleanup anyway.


Test program:

  #include <stdio.h>
  #include <stdlib.h>
  #include <string.h>
  #include <sys/mman.h>

  #ifndef MADV_POPULATE_WRITE
  #define MADV_POPULATE_WRITE 23
  #endif
  #ifndef MAP_HUGETLB
  #define MAP_HUGETLB 0x40000
  #endif

  int main(int argc, char **argv)
  {
      unsigned long size;
      int flags = MAP_PRIVATE | MAP_ANONYMOUS;
      void *p;
      int r;

      if (argc < 2) {
          fprintf(stderr, "usage: %s <size_mb> [huge]\n", argv[0]);
          return 1;
      }
      size = atol(argv[1]) * 1024UL * 1024;
      if (argc >= 3 && strcmp(argv[2], "huge") == 0)
          flags |= MAP_HUGETLB;
      p = mmap(NULL, size, PROT_READ | PROT_WRITE, flags, -1, 0);
      if (p == MAP_FAILED) {
          perror("mmap");
          return 1;
      }
      r = madvise(p, size, MADV_POPULATE_WRITE);
      if (r) {
          perror("madvise");
          return 1;
      }
      munmap(p, size);
      return 0;
  }

Test script (bench.sh):

  #!/bin/bash
  # Usage: bench.sh <size_mb> <iterations> [huge]
  # Feature negotiation (DEVICE_INIT_REPORTED/ON_INFLATE) is
  # handled by QEMU command line flags, not module parameters.
  SZ=${1:-256}; ITER=${2:-10}; HUGE=${3:-}
  FLUSH=/sys/module/page_reporting/parameters/flush
  CSV=/tmp/perf.csv
  rmmod virtio_balloon 2>/dev/null
  insmod /mnt/share/virtio_balloon.ko
  echo 512 > $FLUSH
  [ "$HUGE" = "huge" ] && echo $((SZ/2)) > /proc/sys/vm/nr_overcommit_hugepages
  rm -f $CSV
  echo "=== sz=${SZ}MB iter=$ITER $HUGE ==="
  for i in $(seq 1 $ITER); do
      echo 3 > /proc/sys/vm/drop_caches
      echo 512 > $FLUSH
      perf stat -e task-clock,instructions,cache-misses \
          -x, -o $CSV --append -- /mnt/share/alloc_once $SZ $HUGE
  done
  [ "$HUGE" = "huge" ] && echo 0 > /proc/sys/vm/nr_overcommit_hugepages
  rmmod virtio_balloon
  awk -F, '/^#/||/^$/{next}{v=$1+0;e=$3;gsub(/ /,"",e);s[e]+=v;ss[e]+=v*v;n[e]++}
  END{for(e in s){a=s[e]/n[e];d=sqrt(ss[e]/n[e]-a*a);printf "  %-16s %10.0f +- %8.0f (n=%d)\n",e,a,d,n[e]}}' $CSV

Compile and run:
  gcc -static -O2 -o alloc_once alloc_once.c
  bash bench.sh 256 10            # regular pages
  bash bench.sh 256 10 huge       # hugetlb surplus

Changes since v6 (address review by Gregory Price):
- Rework hugetlb: use gfp_t parameter instead of bool zero /
  bool *zeroed.  Sink zeroing inside alloc_hugetlb_folio().
  Pass raw fault address (user_addr) for cache-friendly zeroing
  on both pool-page and fresh allocation
  paths.  (Suggested by Gregory Price)
- Reorder compaction_alloc_noprof() to call prep_compound_page
  before post_alloc_hook for consistency.
  (Suggested by Gregory Price)
- Reorder: interleave fix first, PageReported propagation and
  capacity fix moved to front as dependencies.
- Add USER_ADDR_NONE comments in mmap.c and internal.h explaining why -1 is
  never a valid userspace address.
- Fix err uninitialized warning in virtballoon_free_page_report().
- Lots of commit log tweaks.

Also in v7:
- Fix hugetlb pool page zeroing to use vmf->real_address
  (the actual faulting subpage) instead of vmf->address
  (hugepage-aligned), preserving cache-friendly zeroing
  locality that upstream had at the callsite.
- Remove dead/broken alloc_hugetlb_folio !CONFIG_HUGETLB_PAGE
  stub (returned NULL but callers check IS_ERR).

Changes since v5:
- Rebased onto v7.1-rc2.
- Split alloc_anon_folio and alloc_swap_folio raw fault address
  changes into separate patches.
- In virtio, move PAGE_POISON check for DEVICE_INIT_REPORTED
  from probe() to validate(), clearing the feature instead of
  just gating host_zeroes_pages.  Same for confidential
  computing check.
- Fix bisectability: FPI_ZEROED definition and usage now in
  the same patch.
- Lots of commit log tweaks.
- Reorder: REPORTED before ON_INFLATE.
- Kerneldoc fixes.

Changes since v4:
With virtio spec posted, update to latest spec:
- Add VIRTIO_BALLOON_F_DEVICE_INIT_REPORTED (bit 6) for reporting.
- Add VIRTIO_BALLOON_F_DEVICE_INIT_ON_INFLATE (bit 7) for inflate.
- Per-page virtqueue submission, per-page used_len feedback.
- Balloon migration preserves PageZeroed hint.
- Page_reporting capacity bugfix for small virtqueues.
- PG_zeroed propagation in split_large_buddy.
- Disable both features for confidential computing guests.
- Gate host_zeroes_pages on PAGE_POISON/poison_val: when PAGE_POISON
  is negotiated with non-zero poison_val, device fills with poison
  not zeros, so host_zeroes_pages must be false.
- Disable ON_INFLATE when PAGE_POISON with non-zero poison_val.
- Bound inflate bitmap reads by used_len from device.
- Move ON_INFLATE poison_val check to validate() for proper
  feature negotiation.
- Fix NUMA interleave index for unaligned VMA start (new patch 1).
- Drop vma_alloc_folio_user_addr: with the ilx fix, callers can
  pass raw fault address to vma_alloc_folio directly.
- Tested with DEBUG_VM, INIT_ON_ALLOC/FREE enabled.

Changes since v3 (address review by Gregory Price and David Hildenbrand):
- Keep user_addr threading internal: public APIs (__alloc_pages,
  __folio_alloc, folio_alloc_mpol) are unchanged.  Only internal
  functions (__alloc_frozen_pages_noprof, __alloc_pages_mpol) carry
  user_addr.  This eliminates all API churn for external callers.
- Add vma_alloc_folio_user_addr() (2/22) to separate NUMA policy
  address from the zeroing hint address.  Fixes NUMA interleave
  index corruption when passing unaligned fault address for
  higher-order allocations.
- Add per-page zeroed_bitmap to page_reporting_dev_info (17/22).
  The driver's report() callback manages the bitmap.  Drain
  checks it gated by the host_zeroes_pages static key.  This
  matches the proposed virtio balloon extension at
  https://lore.kernel.org/all/cover.1776874126.git.mst@redhat.com/
- Clear PG_zeroed in __isolate_free_page() to prevent the aliased
  PG_private flag from leaking to compaction/alloc_contig paths.
- Do not exclude PG_zeroed from PAGE_FLAGS_CHECK_AT_PREP macro.
  Instead, __free_pages_prepare() clears it (preventing filesystem
  PG_private leaking as false PG_zeroed), and FPI_ZEROED sets it
  after prepare.  Only buddy merge assertion is relaxed.
- Initialize alloc_context.user_addr in alloc_pages_bulk_noprof.
- Deflate and hugetlb changes are much smaller now.  Still, the
  patchset can be merged gradually, if desired.

Changes since v2 (address review by Gregory Price and David Hildenbrand):
- v2 used pghint_t / vma_alloc_folio_hints API.  v3 switches to
  threading user_addr through the page allocator and using __GFP_ZERO,
  so post_alloc_hook() can use folio_zero_user() for cache-friendly
  zeroing when the user fault address is known.
- Use FPI_ZEROED to set PG_zeroed after __free_pages_prepare() instead
  of runtime masking in __free_one_page (further refined in v4).
- Drop redundant page_poisoning_enabled() check from mm core free
  path -- already guarded at feature negotiation time in
  virtio_balloon_validate.  The balloon driver keeps its own
  page_poisoning_enabled_static() check as defense in depth.
- Split free_frozen_pages_zeroed and put_page_zeroed into separate
  patches.  David Hildenbrand indicated he intends to rework balloon
  pages to be frozen (no refcount), at which point put_page_zeroed
  (21/22) can be dropped and the balloon can call
  free_frozen_pages_zeroed directly.
- Use HPG_zeroed flag (in hugetlb folio->private) for hugetlb pool
  pages instead of PG_zeroed, since pool pages are zeroed long after
  buddy allocation and PG_zeroed is consumed at allocation time.
- syzbot CI found a PF_NO_COMPOUND BUG in the v2 pghint_t approach
  where __ClearPageZeroed was called on compound hugetlb pages in
  free_huge_folio.  The v3 HPG_zeroed approach avoids this.
- Remove redundant arch vma_alloc_zeroed_movable_folio overrides
  on x86, s390, m68k, and alpha (12/22). Suggested by David
  Hildenbrand.
- Updated benchmarking script to compute per-run avg +- stddev
  via awk on CSV output.

Changes v1->v2:
- Replaced __GFP_PREZEROED with PG_zeroed page flag (aliased PG_private)
- Added pghint_t type and vma_alloc_folio_hints() API
- Track PG_zeroed across buddy merges and splits
- Added post_alloc_hook integration (single consume/clear point)
- Added hugetlb support (pool pages + memfd)
- Added page_reporting flush parameter for deterministic testing
- Added free_frozen_pages_hint/put_page_hint for balloon deflate path
- Added try_to_claim_block PG_zeroed preservation
- Updated perf numbers with per-iteration flush methodology

Written with assistance from Claude (claude-opus-4-6).
Reviewed by cursor-agent (GPT-5.4-xhigh).
Everything manually read, patchset split and commit logs edited manually.

Michael S. Tsirkin (31):
  mm: mempolicy: fix interleave index for unaligned VMA start
  mm: page_alloc: propagate PageReported flag across buddy splits
  mm: page_reporting: allow driver to set batch capacity
  mm: hugetlb: remove dead alloc_hugetlb_folio stub
  mm: move vma_alloc_folio_noprof to page_alloc.c
  mm: thread user_addr through page allocator for cache-friendly zeroing
  mm: add folio_zero_user stub for configs without THP/HUGETLBFS
  mm: page_alloc: move prep_compound_page before post_alloc_hook
  mm: use folio_zero_user for user pages in post_alloc_hook
  mm: use __GFP_ZERO in vma_alloc_zeroed_movable_folio
  mm: remove arch vma_alloc_zeroed_movable_folio overrides
  mm: alloc_anon_folio: pass raw fault address to vma_alloc_folio
  mm: alloc_swap_folio: pass raw fault address to vma_alloc_folio
  mm: use __GFP_ZERO in alloc_anon_folio
  mm: vma_alloc_anon_folio_pmd: pass raw fault address to
    vma_alloc_folio
  mm: use __GFP_ZERO in vma_alloc_anon_folio_pmd
  mm: hugetlb: add gfp parameter and skip zeroing for zeroed pages
  mm: memfd: skip zeroing for zeroed hugetlb pool pages
  mm: page_reporting: skip redundant zeroing of host-zeroed reported
    pages
  mm: page_reporting: add per-page zeroed bitmap for host feedback
  mm: page_alloc: clear PG_zeroed on buddy merge if not both zero
  mm: page_alloc: preserve PG_zeroed in page_del_and_expand
  virtio_balloon: submit reported pages as individual buffers
  mm: page_reporting: add flush parameter with page budget
  mm: page_alloc: propagate PG_zeroed in split_large_buddy
  virtio_balloon: skip zeroing for host-zeroed reported pages
  virtio_balloon: disable reporting zeroed optimization for confidential
    guests
  mm: add free_frozen_pages_zeroed
  mm: add put_page_zeroed and folio_put_zeroed
  virtio_balloon: implement VIRTIO_BALLOON_F_DEVICE_INIT_ON_INFLATE
  mm: balloon: use put_page_zeroed for zeroed balloon pages

 arch/alpha/include/asm/page.h       |   3 -
 arch/m68k/include/asm/page_no.h     |   3 -
 arch/s390/include/asm/page.h        |   3 -
 arch/x86/include/asm/page.h         |   3 -
 drivers/virtio/virtio_balloon.c     | 160 +++++++++++++++++----
 fs/hugetlbfs/inode.c                |   3 +-
 include/linux/gfp.h                 |  12 +-
 include/linux/highmem.h             |   9 +-
 include/linux/hugetlb.h             |  18 ++-
 include/linux/mm.h                  |  15 ++
 include/linux/page-flags.h          |   9 ++
 include/linux/page_reporting.h      |  13 ++
 include/uapi/linux/virtio_balloon.h |   2 +
 mm/balloon.c                        |   7 +-
 mm/compaction.c                     |   9 +-
 mm/huge_memory.c                    |  12 +-
 mm/hugetlb.c                        |  94 ++++++++----
 mm/internal.h                       |  21 ++-
 mm/memfd.c                          |  14 +-
 mm/memory.c                         |  17 +--
 mm/mempolicy.c                      |  73 ++++------
 mm/mmap.c                           |   6 +
 mm/page_alloc.c                     | 213 +++++++++++++++++++++++-----
 mm/page_reporting.c                 |  88 ++++++++++--
 mm/page_reporting.h                 |  12 ++
 mm/slub.c                           |   4 +-
 mm/swap.c                           |  18 ++-
 27 files changed, 613 insertions(+), 228 deletions(-)

-- 
MST

