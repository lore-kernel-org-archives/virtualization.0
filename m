Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B85035898
	for <virtualization@lists.linux.dev>; Sun, 26 Apr 2026 21:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777240051; cv=none; b=fBV70pS0xu/EKYMjcFcxaDS04YYqgHRdFQXW+J4bQ7SgwzCawAYCJv4He3WbrDrdSPfCtV9rl2WlJsrK1/Ed+hO93jfC5KKVztgxYxzIk2kLJzzO4mM1M9CEAqapIyfYv1pqLE9s0lW91ARF6wByIppfsjwCsSvX7Xp6eYIst2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777240051; c=relaxed/simple;
	bh=+PGQMQ4i3J/KXwyoVkun6S5fSdi/tK7aWudnnRiWvvY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=chIV/DvbSyj2ZGP98+vMs+PGhS5ivoYxJRnb2lA+eQGCqhwkPeej6/9Q8AhoC4kmZzcMt0ur4YFJXeYdeHCJLvt7QRPQ3sCUoTQfaVxweQ57wcjRaaup9v3iIw6hjLVvVvkTxoa9ezIH7qnKyYyScINSLDnfUMT+kzLNl/iOyWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ErzqhSq5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ErzqhSq5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777240047;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=wUTZ8d2+nmZUz2JmwBmw760Ox8zWMl/D7BdSudbMLqQ=;
	b=ErzqhSq5bchszgKRldwuKUMznNoyX0d25BPdISXUUdAH0fLh8f15GUX3o4pqBHnQGzQSU7
	DDEF3g2Iuo75uqhahxHT5EsQuxBArrKrLq0aWSyNIWsvMJtyrKCC+1X4c5cXT4KYPa64IJ
	Z2ZknlFu3h7rVjp4wx01ukXWO21NA0w=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-422-18W3OI9ePiiw8E8t8ptlfg-1; Sun, 26 Apr 2026 17:47:26 -0400
X-MC-Unique: 18W3OI9ePiiw8E8t8ptlfg-1
X-Mimecast-MFC-AGG-ID: 18W3OI9ePiiw8E8t8ptlfg_1777240045
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-43d1dea12aaso15563f8f.1
        for <virtualization@lists.linux.dev>; Sun, 26 Apr 2026 14:47:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777240045; x=1777844845;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wUTZ8d2+nmZUz2JmwBmw760Ox8zWMl/D7BdSudbMLqQ=;
        b=RHGGkBCGStVAaXH0hk3z1blJcmIDtyu2ogyNACzGMxd2jfcICTNZRHSlY585mvtr6U
         Ry3TutBS5TtGG43Yqf4FcmT1pUiNMPAYj26mC0YvA/lj31Ue43qqRO4aOld4pXgk1Tep
         QSQQs77Y7iQHRo5zfdLBVFv7j3pXtO4agofEF1sqIAF/AX+Ycv+7fckGX5wVqh0luUNB
         ENXmOHiOMfYxRaAXQ3RmOj9k/vjKMeu1WHcrzhXbpQO+jN5MIVtOYfDwnuy6cL9WKy/5
         ccILhmX2N3l0+Gai4lZzXGAmSrqEy+qjkLRD0331J48VyZzWyBNjuH14nzPC+CmERnvn
         8WPg==
X-Forwarded-Encrypted: i=1; AFNElJ9ZxT2TczSB19Z5pTYxZRPs22mFDETm5yx1R5rPWdIpuJC6JNo1hCwVTQ07JmC0GDNyMi6vBp+ePDFZBOsWEw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwZbKhM5yL5+RJIN93uu/4WBhASYflig7dWKs/ChdfWG7Ur1faD
	A/L9ynS5igHc5tcdaQJ6mBuvJw0WjNSLMZILlWwUU+1tzeHr9PZqy0sOrvKz6eVUfknP/PfmFeK
	5s8cKGpWvVuEuXWqaIwwwbYAeI4LLd2D3nZjMWKXzRHo6GoGiVgTyDH2xcXzWlXVo+ZKj
X-Gm-Gg: AeBDietp8ua9NgeSI14zbrP2pCEqWj25Mwan+wPbx5slNE12EfpW3xtbUKxXVdpPS2E
	CCuUTPcPmHJUnCkewvclOA/U7hS85FfGOyNqPQPXI3obLt0uc4o3RTGXLsdarKJKs+UJxLBm1oy
	bB9GF8TkV8DwOd/W6aJcqQYrZrpzdIyDuXKgD3uLjvrHLjK4b+qx60p3oIUTI7WaAgiuY+3Tzbb
	6uy82pgCYEA1+D+5S/No7UhTSvrFeD5KG2Z6/+EzPpJWqH00YkKSYv0uYXB9RdUn1RkKz1zPK2H
	wEQBXkQ4bWq5dWCjUSrZUb6I7LOz/OVml60vV7uk821OUHcphE63QEdIoA8fmYwKkVRHCjnrX8Q
	yPzy4a8JReHj+xfe29rgdiBo7Z7pTwQLJSZSqrOUYFBGcB5gFW7R/nS3E
X-Received: by 2002:a05:600c:4714:b0:48a:5574:3a5b with SMTP id 5b1f17b1804b1-48a55743d05mr350679425e9.27.1777240044770;
        Sun, 26 Apr 2026 14:47:24 -0700 (PDT)
X-Received: by 2002:a05:600c:4714:b0:48a:5574:3a5b with SMTP id 5b1f17b1804b1-48a55743d05mr350678985e9.27.1777240044114;
        Sun, 26 Apr 2026 14:47:24 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-47-179.inter.net.il. [80.230.47.179])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fc0f8193sm678381545e9.1.2026.04.26.14.47.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2026 14:47:23 -0700 (PDT)
Date: Sun, 26 Apr 2026 17:47:21 -0400
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
Subject: [PATCH RFC v4 00/22] mm/virtio: skip redundant zeroing of
 host-zeroed reported pages
Message-ID: <cover.1777223007.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Lz8-vtZ1cco8dTS_FSmmL9exYiYoZgZHUvk2BZ1HYno_1777240045
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
- first 12 patches, including the fix for init_on_alloc double zeroing
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
- The virtio_balloon module parameter (18/22) is a testing hack.
  A proper virtio feature flag is needed before merging.
- Patch 19/22 adds a sysfs flush trigger for deterministic testing
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

Michael S. Tsirkin (22):
  mm: move vma_alloc_folio to page_alloc.c
  mm: add vma_alloc_folio_user_addr
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
  mm: page_alloc: clear PG_zeroed on buddy merge if not both zero
  mm: page_alloc: preserve PG_zeroed in page_del_and_expand
  mm: page_reporting: add per-page zeroed bitmap for host feedback
  virtio_balloon: a hack to enable host-zeroed page optimization
  mm: page_reporting: add flush parameter with page budget
  mm: add free_frozen_pages_zeroed
  mm: add put_page_zeroed and folio_put_zeroed
  virtio_balloon: mark deflated pages as zeroed

 arch/alpha/include/asm/page.h   |   3 -
 arch/m68k/include/asm/page_no.h |   3 -
 arch/s390/include/asm/page.h    |   3 -
 arch/x86/include/asm/page.h     |   3 -
 drivers/virtio/virtio_balloon.c |  17 ++-
 fs/hugetlbfs/inode.c            |  10 +-
 include/linux/gfp.h             |  22 ++--
 include/linux/highmem.h         |   9 +-
 include/linux/hugetlb.h         |  14 ++-
 include/linux/mm.h              |  15 +++
 include/linux/page-flags.h      |   9 ++
 include/linux/page_reporting.h  |  10 ++
 mm/compaction.c                 |   7 +-
 mm/huge_memory.c                |  18 +--
 mm/hugetlb.c                    | 101 +++++++++++-----
 mm/internal.h                   |  11 +-
 mm/memfd.c                      |  17 ++-
 mm/memory.c                     |  17 +--
 mm/mempolicy.c                  |  59 ++++-----
 mm/page_alloc.c                 | 204 ++++++++++++++++++++++++++------
 mm/page_reporting.c             |  62 +++++++++-
 mm/page_reporting.h             |  12 ++
 mm/slub.c                       |   4 +-
 mm/swap.c                       |  18 ++-
 24 files changed, 479 insertions(+), 169 deletions(-)

-- 
MST

