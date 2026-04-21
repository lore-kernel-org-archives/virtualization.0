Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92288346AE3
	for <virtualization@lists.linux.dev>; Tue, 21 Apr 2026 22:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776808880; cv=none; b=IS+GnzJ59Lm+q2vtIkELt7FGBaIVI8Z1/x+uohU2BBtqv5moRK1w+slq7rw/DfX5bjYGnD/cgKlYAeYzZfNSArHiFqtA96Ah4vRewI9vsQcE9A2/deS7Cdg6LefRfSd0h9/eoJXF6ATVmt6gKXwHFmtS0qtRXPM2K5sJdyW/fNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776808880; c=relaxed/simple;
	bh=MNIyXe8+RiM+C8hsAVfKLm+SSR0QjWYhsjHbltPLCGQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=dnoZdIXw73owI2G6IfFfRwLnfjkrc+W8GIkBNoMO6WneNc5PX6XQB8ybbjPUHE2Z8PsFwC7yuEfFHg5Y70AlOs0CasyJUGJ7/Q0pEKP3Y6XEEqH8b/3TKBLzlLGuhMqaUNNngJj1Tjo7dom/kxDfGQiWRSftWJ0pH667Gr5GPyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iRURE8Ct; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iRURE8Ct"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776808877;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=LTem+Ne5wb4+AyKa+wXcnOG+8NLe32di58x5iUp/NiY=;
	b=iRURE8CtnuDR5ltBuHd8Ere3OEReG6TsO433K0vU9IRPfY2WbRm3RjqitFCBRwDRN90ROp
	cJRXpBh+fMfvrjc4BdtqGYOp9/M4kVksCUezvBKpEOECUFhIk1w4xwOtygVgX3ORB2r88l
	qCnmmWGecTGG/NHitIl9RftTW1F1iXo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-463-ZV_e_qO4Niun0Mt37dpBKw-1; Tue, 21 Apr 2026 18:01:13 -0400
X-MC-Unique: ZV_e_qO4Niun0Mt37dpBKw-1
X-Mimecast-MFC-AGG-ID: ZV_e_qO4Niun0Mt37dpBKw_1776808872
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-43e52dc8a04so4159585f8f.3
        for <virtualization@lists.linux.dev>; Tue, 21 Apr 2026 15:01:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776808872; x=1777413672;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LTem+Ne5wb4+AyKa+wXcnOG+8NLe32di58x5iUp/NiY=;
        b=GzllsPFnBm5KXcrOlFtNb0/bT13eK/+/SHp0PAc03ySxL9FcjNKfc3VYXU3cyWbmTg
         eL8z0RhB7PS0LxBKSDs00fPqOMipKWacWoyZDOmJpJ+i3jlagbJJEQwldsesszgUIgBW
         qDGSstmxwfo+Xu3DLoKVE7wXNbY2+JMPah6TdSIUWKytNiqXEEyIlNwMHisnz1ls2UOj
         go0wsICR/AZQSzXJIPbvTI9jsqoRN8FLOHfH12QOBLND86+xb2uFSYllBhJRIqJw6qzg
         suuAeBBsGyrRGtr4uL3s/l8CAFwbc1fR9othLsjSwy0mYAblUlcbfVSAFirlE/GpN5D2
         C47A==
X-Forwarded-Encrypted: i=1; AFNElJ9GFT6hmkAcVg/T3LHbwbfFroNUuswM1oAvY9e9nPinv7pgZlbyquB9nFiUacv7Oja5WMGRVI25IEhtFq03Tw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxbq4yj80fHAXcNHyC53SwM3XYZ1gNDE4XizX8pX8PGUkWx7D7s
	DG5DpkALWD3Ox7biY9kkFXRQgAYA8C9D6Pr9QoXhCWlR2G9eCuARJlBG2LlEniTm8YDH8uWBsr9
	IWJA0oWe+ZR63CISOV31MfmDf/fcAt/9jcNahM0AReZToK4jDNLJCODAMj3+V7Oe+kuca
X-Gm-Gg: AeBDiesADq/j1T9St23oG/Q33vOsgc+pvfPCTrleUBw47D8+KC//bf2GVS311sd09Vl
	rrG9GRnCW1YgfV35wDBTUAXDuphXIzEYXajfUpmiGmUf3tQlu42dIkFRIE9djgob934tOt24eMs
	WkaXC3gI8Im+McLHGGBV4RjvkZSjSeig4tdKAe36THZyAxGlTrKMVs1cIPWprDJZsFsNd4dpd1b
	/JNXlVyqdx4l+D4ch317Ect3280umy2wIgVe4lydTpnkmzoUfAkzGwPv7Yk6DJc8UgBpobebtkz
	iyUmyv6HE5drP71Lmd62SlsPL809GT2eC0e9NRWm2D51yL828t6SXiCLxmljQLCy+vZVMlaQlEW
	+fC1FxkHFemWUDn8BokGz4cfp0eltB0sfYgbCkUdijVN5YMyl24BV8g==
X-Received: by 2002:a05:6000:18a6:b0:43d:1c59:2dc with SMTP id ffacd0b85a97d-43fe3e0dafemr32065203f8f.28.1776808871419;
        Tue, 21 Apr 2026 15:01:11 -0700 (PDT)
X-Received: by 2002:a05:6000:18a6:b0:43d:1c59:2dc with SMTP id ffacd0b85a97d-43fe3e0dafemr32065123f8f.28.1776808870786;
        Tue, 21 Apr 2026 15:01:10 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-25-21.inter.net.il. [80.230.25.21])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4e46471sm39725991f8f.28.2026.04.21.15.01.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 15:01:10 -0700 (PDT)
Date: Tue, 21 Apr 2026 18:01:07 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Brendan Jackman <jackmanb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Jason Wang <jasowang@redhat.com>,
	Andrea Arcangeli <aarcange@redhat.com>,
	Gregory Price <gourry@gourry.net>, linux-mm@kvack.org,
	virtualization@lists.linux.dev
Subject: [PATCH RFC v3 00/19] mm/virtio: skip redundant zeroing of
 host-zeroed reported pages
Message-ID: <cover.1776808209.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: hfzSXL_yXetpFOjti_0SnwAq9-ZQ7usYRK0SlO9Bjdo_1776808872
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

For the reporting part, I am working on virtio spec now, so sending this
out for early feedback. In particular:
- is the mm zeroing rework acceptable?
- is sysfs testing hook for flushing acceptable?
- first 10 patches, including the fix for init_on_alloc double zeroing
  are independently mergeable mm rework -
  are they deemed a desirable rework, and should I post them
  separately for inclusion?

Thanks in advance.

Still an RFC as virtio bits need work, but I would very much like
to get a general agreement on mm bits first, so we don't add
a spec for something we can't then use.

-------

Performance with THP enabled on a 2GB VM, 1 vCPU, allocating
256MB of anonymous pages:

  metric         baseline            optimized           delta
  task-clock     175 +- 10 ms        40 +- 9 ms          -77%
  cache-misses   924K +- 323K        287K +- 93K         -69%
  instructions   15.3M +- 634K       13.5M +- 337K       -12%

With hugetlb surplus pages:

  metric         baseline            optimized           delta
  task-clock     169 +- 9 ms         49 +- 19 ms         -71%
  cache-misses   1.24M +- 222K       316K +- 114K        -75%
  instructions   17.3M +- 1.23M      15.0M +- 604K       -13%

Notes:
- The virtio_balloon module parameter (13/19) is a testing hack.
  A proper virtio feature flag is needed before merging.
- Patch 14/19 adds a sysfs flush trigger for deterministic testing
  (avoids waiting for the 2-second reporting delay).
- When host_zeroes_pages is set, callers skip folio_zero_user() for
  pages known to be zeroed by the host. This is safe on all
  architectures because the hypervisor invalidates guest cache lines
  when reclaiming page backing (MADV_DONTNEED).

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

- PG_zeroed is aliased to PG_private. It is excluded from
  PAGE_FLAGS_CHECK_AT_PREP because it must survive on free-list pages
  until post_alloc_hook() consumes and clears it. Is this acceptable,
  or should a different bit be used?

- On architectures with aliasing caches, upstream with init_on_alloc
  double-zeros user pages: once via kernel_init_pages() in
  post_alloc_hook, and again via clear_user_highpage() at the
  callsite (because user_alloc_needs_zeroing() returns true).
  Our patches eliminate this by zeroing once via folio_zero_user()
  in post_alloc_hook.  Not yet performance-tested on aliasing
  hardware.

PG_zeroed lifecycle:

  Sets PG_zeroed:
  - page_reporting_drain: on reported pages when host zeroes them
  - __free_pages_ok / __free_frozen_pages: when FPI_ZEROED is set
    (balloon deflate path)
  - buddy merge: on merged page if both buddies were zeroed
  - expand(): propagate to split-off buddy sub-pages

  Clears PG_zeroed:
  - buddy merge: clear both pages before merge, then conditionally
    re-set on merged head if both were zeroed
  - post_alloc_hook: clear on head page after consuming the hint

HPG_zeroed lifecycle (hugetlb pool pages, stored in folio->private):

  Sets HPG_zeroed:
  - alloc_surplus_hugetlb_folio: after buddy allocation with
    __GFP_ZERO, mark pool page as known-zero

  Clears HPG_zeroed:
  - free_huge_folio: page was mapped to userspace, no longer
    known-zero when it returns to the pool
  - alloc_hugetlb_folio / alloc_hugetlb_folio_reserve: clear
    after reporting to caller via bool *zeroed output (consumed)

- The optimization is most effective with THP, where entire 2MB
  pages are allocated directly from reported order-9+ buddy pages.
  Without THP, only ~21% of order-0 allocations come from reported
  pages due to low-order fragmentation.
- Persistent hugetlb pool pages are not covered: when freed by
  userspace they return to the hugetlb free pool, not the buddy
  allocator, so they are never reported to the host.  Surplus
  hugetlb pages are allocated from buddy and do benefit.

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
  # Usage: bench.sh <size_mb> <mode> <iterations> [huge]
  # mode 0 = baseline, mode 1 = skip zeroing
  SZ=${1:-256}; MODE=${2:-0}; ITER=${3:-10}; HUGE=${4:-}
  FLUSH=/sys/module/page_reporting/parameters/flush
  PERF_DATA=/tmp/perf-$MODE.csv
  rmmod virtio_balloon 2>/dev/null
  insmod virtio_balloon.ko host_zeroes_pages=$MODE
  echo 512 > $FLUSH
  [ "$HUGE" = "huge" ] && echo $((SZ/2)) > /proc/sys/vm/nr_overcommit_hugepages
  rm -f $PERF_DATA
  echo "=== sz=${SZ}MB mode=$MODE iter=$ITER $HUGE ==="
  for i in $(seq 1 $ITER); do
      echo 3 > /proc/sys/vm/drop_caches
      echo 512 > $FLUSH
      perf stat -e task-clock,instructions,cache-misses \
          -x, -o $PERF_DATA --append -- ./alloc_once $SZ $HUGE
  done
  [ "$HUGE" = "huge" ] && echo 0 > /proc/sys/vm/nr_overcommit_hugepages
  rmmod virtio_balloon
  awk -F, '/^#/||/^$/{next}{v=$1+0;e=$3;gsub(/ /,"",e);s[e]+=v;ss[e]+=v*v;n[e]++}
  END{for(e in s){a=s[e]/n[e];d=sqrt(ss[e]/n[e]-a*a);printf "  %-16s %10.0f +- %8.0f (n=%d)\n",e,a,d,n[e]}}' $PERF_DATA

Compile and run:
  gcc -static -O2 -o alloc_once alloc_once.c
  bash bench.sh 256 0 10          # baseline (regular pages)
  bash bench.sh 256 1 10          # optimized (regular pages)
  bash bench.sh 256 0 10 huge     # baseline (hugetlb surplus)
  bash bench.sh 256 1 10 huge     # optimized (hugetlb surplus)

Changes since v2 (address review by Gregory Price and David Hildenbrand):
- v2 used pghint_t / vma_alloc_folio_hints API.  v3 switches to
  threading user_addr through the page allocator and using __GFP_ZERO,
  so post_alloc_hook() can use folio_zero_user() for cache-friendly
  zeroing when the user fault address is known.
- Exclude __PG_ZEROED from PAGE_FLAGS_CHECK_AT_PREP macro definition
  instead of runtime masking in __free_one_page.
- Drop redundant page_poisoning_enabled() check from mm core free
  path -- already guarded at feature negotiation time in
  virtio_balloon_validate.  The balloon driver keeps its own
  page_poisoning_enabled_static() check as defense in depth.
- Split free_frozen_pages_zeroed and put_page_zeroed into separate
  patches.  David Hildenbrand indicated he intends to rework balloon
  pages to be frozen (no refcount), at which point put_page_zeroed
  (16/19) can be dropped and the balloon can call
  free_frozen_pages_zeroed directly.
- Use HPG_zeroed flag (in hugetlb folio->private) for hugetlb pool
  pages instead of PG_zeroed, since pool pages are zeroed long after
  buddy allocation and PG_zeroed is consumed at allocation time.
- syzbot CI found a PF_NO_COMPOUND BUG in the v2 pghint_t approach
  where __ClearPageZeroed was called on compound hugetlb pages in
  free_huge_folio.  The v3 HPG_zeroed approach avoids this.
- Remove redundant arch vma_alloc_zeroed_movable_folio overrides
  on x86, s390, m68k, and alpha (10/19). Suggested by David
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

Michael S. Tsirkin (19):
  mm: thread user_addr through page allocator for cache-friendly zeroing
  mm: add folio_zero_user stub for configs without THP/HUGETLBFS
  mm: page_alloc: move prep_compound_page before post_alloc_hook
  mm: use folio_zero_user for user pages in post_alloc_hook
  mm: use __GFP_ZERO in vma_alloc_zeroed_movable_folio
  mm: use __GFP_ZERO in alloc_anon_folio
  mm: use __GFP_ZERO in vma_alloc_anon_folio_pmd
  mm: hugetlb: use __GFP_ZERO and skip zeroing for zeroed pages
  mm: memfd: skip zeroing for zeroed hugetlb pool pages
  mm: remove arch vma_alloc_zeroed_movable_folio overrides
  mm: page_alloc: propagate PageReported flag across buddy splits
  mm: page_reporting: skip redundant zeroing of host-zeroed reported
    pages
  virtio_balloon: a hack to enable host-zeroed page optimization
  mm: page_reporting: add flush parameter with page budget
  mm: add free_frozen_pages_zeroed
  mm: add put_page_zeroed and folio_put_zeroed
  mm: page_alloc: clear PG_zeroed on buddy merge if not both zero
  mm: page_alloc: preserve PG_zeroed in page_del_and_expand
  virtio_balloon: mark deflated pages as zeroed

 arch/alpha/include/asm/page.h   |   3 -
 arch/m68k/include/asm/page_no.h |   3 -
 arch/s390/include/asm/page.h    |   3 -
 arch/x86/include/asm/page.h     |   3 -
 drivers/virtio/virtio_balloon.c |  12 ++-
 fs/hugetlbfs/inode.c            |  10 ++-
 include/linux/gfp.h             |  26 ++++--
 include/linux/highmem.h         |   9 +-
 include/linux/hugetlb.h         |  14 ++-
 include/linux/mm.h              |  43 +++++++++
 include/linux/page-flags.h      |  12 ++-
 include/linux/page_reporting.h  |   3 +
 mm/compaction.c                 |   5 +-
 mm/filemap.c                    |   3 +-
 mm/huge_memory.c                |  12 +--
 mm/hugetlb.c                    | 101 +++++++++++++++-------
 mm/internal.h                   |   8 +-
 mm/khugepaged.c                 |   2 +-
 mm/memfd.c                      |  17 ++--
 mm/memory.c                     |  15 +---
 mm/mempolicy.c                  |  39 ++++++---
 mm/migrate.c                    |   2 +-
 mm/page_alloc.c                 | 149 ++++++++++++++++++++++++--------
 mm/page_frag_cache.c            |   4 +-
 mm/page_reporting.c             |  56 +++++++++++-
 mm/page_reporting.h             |  12 +++
 mm/shmem.c                      |   2 +-
 mm/slub.c                       |   4 +-
 mm/swap.c                       |  18 +++-
 mm/swap_state.c                 |   2 +-
 30 files changed, 433 insertions(+), 159 deletions(-)

-- 
MST

