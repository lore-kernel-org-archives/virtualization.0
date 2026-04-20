Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE313A544B
	for <virtualization@lists.linux.dev>; Mon, 20 Apr 2026 12:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776689482; cv=none; b=kSXmpFMfV+fDGHkfNjgZAmTL3axTsVdbV/9TFpNNC9zLBuMh/uzevuxZIuMLpftDYKrqfcxHp8oMbuq2JnvIbaSn3IAZvduwwDuoeAi06x/vQWizoCdxQ8ajsqjpi0n4umNSlfaNuUQ3w9vpiQhjewmqAPsD+2R7hBmQeg/dpWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776689482; c=relaxed/simple;
	bh=tyJl3hoOZ1CVkMj2m4ibDWqOPWJjcOlTbD1BB7LjTNU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=pwCjYPzXU++RqYeq/CPbvm+2EMqgGVuIuEzo0J+TAmOonqJLZkXELGRCL0NE0wpMuAtjtM3JjoVGJwFGQ/6r0HD8+hKEyqe5uzBo29R84itfauIaG1rWjwkGVGqHujaE90TUt7uKX3A1stbPGzqBU7/8JzsPMHewy56yk5yuNF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UttfPWMh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UttfPWMh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776689479;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=X7lPKT3ZlJbuSaN0JH9oInPdyaWIPp6laf7u7SE1AJ4=;
	b=UttfPWMhAV/rKmLczJjClxo+qb1PmYwfIjPwqpkGnt7nXTTSpou7bZZpSgWvxJ4XwHU4Z9
	06jPwmhXiLwN7HFYRZ3K6KSDwVyOw2oDiVSEu0eIhdjUmo/xv9Nr7X5R1I9680ZlkUQpVp
	6RNDu8Sw+2Dm8W4WtRhYC2I2otLhYQk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-nOAaANrXMtSb3xJCOHVhWA-1; Mon, 20 Apr 2026 08:51:18 -0400
X-MC-Unique: nOAaANrXMtSb3xJCOHVhWA-1
X-Mimecast-MFC-AGG-ID: nOAaANrXMtSb3xJCOHVhWA_1776689476
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-4411a69f565so698877f8f.2
        for <virtualization@lists.linux.dev>; Mon, 20 Apr 2026 05:51:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776689476; x=1777294276;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X7lPKT3ZlJbuSaN0JH9oInPdyaWIPp6laf7u7SE1AJ4=;
        b=OzuGaGmWRFaFqw2weFsm3bNJkpIS+Hp8x1kfbsdTRxkYOcFQv0xGB+BTqsQSD/7kCT
         GNIFgYvV8Nm9i6ZhVHJmmhyiIKcaM8OGT4JBeZtYRKS81NTWwIxXCLTNRtRhMB1Feyyp
         W4/OlvQO3WWiskxTjonHlSfvIf1USGMquEOP1uGEvxyHeye9dejsyWgUUD9vzWk1ieuc
         Tw16TVhVeBqoi1Z/jojO1qcYtWy0cXxWHB/PQtYxQJsk7oQBjmS/jhoD1QxoHYT690+x
         VD23U+nh0IvKJcibbgYXxoFudy9TO0HirzdMZnV41Qg0xc4Qrb5fM/VtSssq4xfnQcU2
         whbg==
X-Forwarded-Encrypted: i=1; AFNElJ9Tx7BYxWkccuq0JgS0kffNm5zYlOX86EUXhCCIV4fIsARhaERWBJOOtBeOhu0/bgoXUeTvj3M1gmSu7evZyQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwMyzwLd8qHctyVJ8pbq2GW95jQ9np7ZeU/jMc4MLAl0o/R+GEQ
	W1qx7g4GLeuJsD3A0Hs1CEULLZ7CPGXXd8h1wpAJl0rQX3CIJr8tjl6iwzMgQ3D4NCLRhdrKjNx
	giIB2qENZOyfB+sjrXnOost/ugQzfZQje0wM9UNuHugza/nkejE/SH25C5bNTLYWjCd6O
X-Gm-Gg: AeBDiev8i/vf5mKt265w0Nd9wSodK+aG94wFr9Ds3oKcP5SC0QILzie3tyx/ZGt6izR
	jsM/glsvfTHkC6jTUHl5mHsedNPz6DqM11DSiLZgnzxEKBB5wrb5Su8F+V4M2HQdNOu+WDzvqhV
	vrKxL4M7VpAOIs8BDuHAc15V6LuMu0lzYRgBJU1V5mG+IkZe0vcGKue+7pB0qFNiMsrCKRqDaX+
	vlfh8qlkcJxIfOn3xkrgT5WIrDg2hlgK35RC2TNA9T6pEloAPow65Ek+u2Vc5xxe2cW95dZN/Mf
	0jFIzUrVhUbmniFvtx5nCF3H3fZjQC7LXr7wCwIbzDV6j38Ww6NMqMJ/1lU/zP1uGWl82BcYnHS
	CtRt1wJN/fwwkw9cC5joTO9ghMiy7inPjNV/cuwsz6tLpRf495XN8Qw==
X-Received: by 2002:a05:6000:2f83:b0:43d:7d6f:f529 with SMTP id ffacd0b85a97d-43fe3e0dc49mr20902424f8f.31.1776689475954;
        Mon, 20 Apr 2026 05:51:15 -0700 (PDT)
X-Received: by 2002:a05:6000:2f83:b0:43d:7d6f:f529 with SMTP id ffacd0b85a97d-43fe3e0dc49mr20902359f8f.31.1776689475350;
        Mon, 20 Apr 2026 05:51:15 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-25-21.inter.net.il. [80.230.25.21])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4e4d5b1sm32131117f8f.30.2026.04.20.05.51.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 05:51:14 -0700 (PDT)
Date: Mon, 20 Apr 2026 08:51:13 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Brendan Jackman <jackmanb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Jason Wang <jasowang@redhat.com>,
	Andrea Arcangeli <aarcange@redhat.com>, linux-mm@kvack.org,
	virtualization@lists.linux.dev
Subject: [PATCH RFC v2 00/18] mm/virtio: skip redundant zeroing of
 host-zeroed reported pages
Message-ID: <cover.1776689093.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: QCSF5ROIZBcmVvsUZ80jWy9PxdYIrAK1B6_www3jRr4_1776689476
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline



v2 - this is an attempt to address David Hildenbrand's comments:
overloading GFP and using page->private, support for
balloon deflate.

I hope this one is acceptable, API wise.

I also went ahead and implemented an alternative approach
that David suggested:
using GFP_ZERO to zero userspace pages.
The issue is simple: on some architectures, one has to know the
userspace fault address in order to flush the cache.

So, I had to propagate the fault address everywhere.
A lot of churn, and my concern is, if we miss even one
place, silent, subtle data corruption will result and only
on some arches (x86 will be fine).

Still, you can view that approach here:
https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git gfp_zero

David, if you still feel I should switch to that approach,
let me know. Personally, I'd rather keep that as a separate
project from this optimization.


Still an RFC as virtio bits need work, but I would very much like
to get a general agreement on mm bits first. Thanks!

Patch 1 is a minor
optimization that I am carrying here to avoid conflicts. It
might make sense to merge it straight away.

-------



When a guest reports free pages to the hypervisor via virtio-balloon's
free page reporting, the host typically zeros those pages when reclaiming
their backing memory (e.g., via MADV_DONTNEED on anonymous mappings).
When the guest later reallocates those pages, the kernel zeros them
again -- redundantly.

This series eliminates that double-zeroing by propagating the "host
already zeroed this page" information through the buddy allocator and
into the page fault path.

Performance with THP enabled on a 2GB VM, 1 vCPU, allocating
256MB of anonymous pages:

  metric         baseline        optimized       delta
  task-clock     191 +- 31 ms    60 +- 35 ms     -68%
  cache-misses   1.10M +- 460K   269K +- 31K     -76%
  instructions   4.54M +- 275K   4.10M +- 130K   -10%

With hugetlb surplus pages:

  metric         baseline        optimized       delta
  task-clock     183 +- 24 ms    45 +- 23 ms     -76%
  cache-misses   1.27M +- 544K   270K +- 16K     -79%
  instructions   5.37M +- 254K   4.94M +- 155K   -8%

Notes:
- The virtio_balloon module parameter (15/18) is a testing hack.
  A proper virtio feature flag is needed before merging.
- Patch 16/18 adds a sysfs flush trigger for deterministic testing
  (avoids waiting for the 2-second reporting delay).
- When host_zeroes_pages is set, callers skip folio_zero_user() for
  pages known to be zeroed by the host. This is safe on all
  architectures because the hypervisor invalidates guest cache lines
  when reclaiming page backing (MADV_DONTNEED).
- PG_zeroed is aliased to PG_private. It is excluded from
  PAGE_FLAGS_CHECK_AT_PREP because it must survive on free-list pages
  until post_alloc_hook() consumes and clears it. Is this acceptable,
  or should a different bit be used?
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
  awk -F, '/^#/||/^$/{next}{v=$1+0;e=$3;gsub(/ /,"",e);s[e]+=v;n[e]++}
  END{for(e in s)printf "  %-16s %10.2f (n=%d)\n",e,s[e]/n[e],n[e]}' $PERF_DATA

Compile and run:
  gcc -static -O2 -o alloc_once alloc_once.c
  bash bench.sh 256 0 10          # baseline (regular pages)
  bash bench.sh 256 1 10          # optimized (regular pages)
  bash bench.sh 256 0 10 huge     # baseline (hugetlb surplus)
  bash bench.sh 256 1 10 huge     # optimized (hugetlb surplus)

Changes since v1:
- Replaced __GFP_PREZEROED with PG_zeroed page flag (aliased PG_private)
- Added pghint_t type and vma_alloc_folio_hints() API
- Track PG_zeroed across buddy merges and splits
- Added post_alloc_hook integration (single consume/clear point)
- Added hugetlb support (pool pages + memfd)
- Added page_reporting flush parameter for deterministic testing
- Added free_frozen_pages_hint/put_page_hint for balloon deflate path
- Added try_to_claim_block PG_zeroed preservation
- Updated perf numbers with per-iteration flush methodology

Michael S. Tsirkin (18):
  mm: page_alloc: propagate PageReported flag across buddy splits
  mm: add pghint_t type and vma_alloc_folio_hints API
  mm: add PG_zeroed page flag for known-zero pages
  mm: page_alloc: track PG_zeroed across buddy merges
  mm: page_alloc: preserve PG_zeroed in try_to_claim_block
  mm: page_alloc: thread pghint_t through get_page_from_freelist
  mm: post_alloc_hook: use PG_zeroed to skip zeroing, return pghint_t
  mm: hugetlb: thread pghint_t through buddy allocation chain
  mm: hugetlb: use PG_zeroed for pool pages, skip redundant zeroing
  mm: page_reporting: support host-zeroed reported pages
  mm: skip zeroing in vma_alloc_zeroed_movable_folio for pre-zeroed
    pages


Michael S. Tsirkin (18):
  mm: page_alloc: propagate PageReported flag across buddy splits
  mm: add pghint_t type and vma_alloc_folio_hints API
  mm: add PG_zeroed page flag for known-zero pages
  mm: page_alloc: track PG_zeroed across buddy merges
  mm: page_alloc: preserve PG_zeroed in try_to_claim_block
  mm: page_alloc: thread pghint_t through get_page_from_freelist
  mm: post_alloc_hook: use PG_zeroed to skip zeroing, return pghint_t
  mm: hugetlb: thread pghint_t through buddy allocation chain
  mm: hugetlb: use PG_zeroed for pool pages, skip redundant zeroing
  mm: page_reporting: support host-zeroed reported pages
  mm: skip zeroing in vma_alloc_zeroed_movable_folio for pre-zeroed
    pages
  mm: skip zeroing in alloc_anon_folio for pre-zeroed pages
  mm: skip zeroing in vma_alloc_anon_folio_pmd for pre-zeroed pages
  mm: memfd: skip zeroing for pre-zeroed hugetlb pages
  virtio_balloon: add host_zeroes_pages module parameter
  mm: page_reporting: add flush parameter with page budget
  mm: add free_frozen_pages_hint and put_page_hint APIs
  virtio_balloon: mark deflated pages as pre-zeroed

 drivers/virtio/virtio_balloon.c |  11 ++-
 fs/hugetlbfs/inode.c            |   5 +-
 include/linux/gfp.h             |  17 +++++
 include/linux/highmem.h         |   6 +-
 include/linux/hugetlb.h         |   6 +-
 include/linux/mm.h              |  12 +++
 include/linux/page-flags.h      |  13 +++-
 include/linux/page_reporting.h  |   3 +
 mm/compaction.c                 |   4 +-
 mm/huge_memory.c                |  12 +--
 mm/hugetlb.c                    |  52 +++++++++----
 mm/internal.h                   |   7 +-
 mm/memfd.c                      |  12 +--
 mm/memory.c                     |  14 ++--
 mm/mempolicy.c                  |  85 +++++++++++++++++++++
 mm/page_alloc.c                 | 131 ++++++++++++++++++++++++--------
 mm/page_reporting.c             |  55 +++++++++++++-
 mm/page_reporting.h             |  11 +++
 mm/swap.c                       |  19 +++++
 19 files changed, 392 insertions(+), 83 deletions(-)

-- 
MST

