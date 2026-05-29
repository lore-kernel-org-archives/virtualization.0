Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E07BB33BBA7
	for <virtualization@lists.linux.dev>; Fri, 29 May 2026 15:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780068135; cv=none; b=hFq2269f9ULk+xJseLwhC30Cv7P1kpZaQZG0jOQ5lkU7Hzk7onXl2Ht9whnmowgxRM4CGQV40Ke1tw0LQRyMuvsC6qcG2buuLXKmNHKLQ9M5N3avERN4UXHqaloy9uZKVraf2BxXmBydxCu8Gnm142lHvYvtc2wPJwcUjnoY0q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780068135; c=relaxed/simple;
	bh=dLwvi//baacn3n8rIevovGgw9quo9fxLCluZHbxyZLo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=lzMc1dSOq6mrMMq7J2j5x8I2Eue+eSs1XCukIYxrN+DxOXoz9HHa5IAA8DDTMxEPTplv4Aq8aMR4sWYmATV3Yj2+R9YdyuLq6TkHsEUnctERuNE67VC/grTP4WcDkVUUHaz3nwllNGYYNnNYSyMXrWUkKK0STge98/odb1tCcW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S5G2/2l+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S5G2/2l+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780068131;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2AidVnhggA8VE7Rp7AzizljfRXloglHAGJNzEsjmR7U=;
	b=S5G2/2l+FRbAdGHXJhJBeFVCRSmaI+zIc4Ka+slYR4/AXhfwOjM5Px+1o9fu4UD+NUUy5T
	PZVtG2OUia/q/4uVmhs3LUI2Y1+OCOnOIfGHE6xMfVciN/vM9ljA/KUoD8V937LaLBlLW/
	ESkAft9MwyB/9VcnDFaTlYM+P8lFRMc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-83-kvOB3dO5OX2UBZ6KRCQreQ-1; Fri, 29 May 2026 11:22:08 -0400
X-MC-Unique: kvOB3dO5OX2UBZ6KRCQreQ-1
X-Mimecast-MFC-AGG-ID: kvOB3dO5OX2UBZ6KRCQreQ_1780068127
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-43fe791a398so10394208f8f.0
        for <virtualization@lists.linux.dev>; Fri, 29 May 2026 08:22:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780068127; x=1780672927;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2AidVnhggA8VE7Rp7AzizljfRXloglHAGJNzEsjmR7U=;
        b=E0Udm+LS0ZasjNrJD/YH0jtP42RaViG1q6A3GXOqwpPL8Y1Go/5EmzL6pbjzVa7r/9
         zglPGMa7/MciMjS1yqPuPwJSEtyNE77zfAZ/JDxbwrez+bN8Mq41C7qkrV859FjWr4KQ
         1mdz+N9oL4Mpi5HshQ9tf0S+6T1bsCBq9XMabEB9LEGPGRMMqaNTRsuPLVRdj2pvggMk
         dJVhNMUJGPdLtn7CTE1LrNl9XuZaSnvznimQ9CQg98/T3zi4kYWg9MeX5mmI6wYjZw8i
         kksQ/NfGG6fm3PI9HJUVTdE9H8FiZRLbzcWnan6iCxCg5iFX+8F/KvaK4Ideg1veSTmM
         sSNQ==
X-Forwarded-Encrypted: i=1; AFNElJ8v1zHe1ZNkNdiIWlp3Vqlu6xT2wUNHtWMxWCzkusioC675WIuEhB85tXYpSVVzhNFo1QV9sVY75dVPjWSIMw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzrEsH7XhBh5ehbH58bHJSIEPqaWZrGcoipMQFP1XKOOpSyl02Q
	zWcNjVO8EE/WDvrfsxJ6UdsejmR/tjMScwYnpiuwccIvm0zBKds9Kqb+1U0EQL5K/JLY0dotj2p
	x/9Wp6SdPfUpJBjfcXUUqw7StolyZTmWv1IQZtJufT0K8u2CFrEBRyvDi65pwyaItYCjF
X-Gm-Gg: Acq92OHLDKOX5uhQ6R270sy9rNjzOTnr7xO4mzkaI5crEgz5NbBS3Wpmybz5zr1TIIE
	GediBsmGLoCDrF/YvXv90en73q5w0KkgIf9xH4zjEgbnbb1I7DEwnrHS3d1yEiftVLlIJVr3hgc
	tcYUf3ufnzBwKjNAhcWIojL7+RBvu6el05danfrF3YryNLxZCIsYL+5y85QOW87WCeI8SVsnIYP
	g7jtli/YgbfWgexSa4gnZV4Y74WvpUZy8YaEc3Lh0bcaiL9VJ7VyqqJmVHEn1F7rvS2H/CwD6Ze
	xdYMHLj9IrwABcSGohwkSmb1wa1XqKtezrUvqBSdt2cEogj6RWxas6khFfYz80tgqpJDZoSALuh
	32PmEYqsttx0w0q32aKiCglkBfNdsxV34EhEJBpsUeFvjG+lLBkvlbw==
X-Received: by 2002:adf:f14b:0:b0:441:1e41:194 with SMTP id ffacd0b85a97d-45ef6b235c4mr404066f8f.17.1780068126559;
        Fri, 29 May 2026 08:22:06 -0700 (PDT)
X-Received: by 2002:adf:f14b:0:b0:441:1e41:194 with SMTP id ffacd0b85a97d-45ef6b235c4mr403962f8f.17.1780068125748;
        Fri, 29 May 2026 08:22:05 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-25-45.inter.net.il. [80.230.25.45])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef34bd896sm4067972f8f.14.2026.05.29.08.22.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 08:22:04 -0700 (PDT)
Date: Fri, 29 May 2026 11:22:00 -0400
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
Subject: [PATCH v9 00/37] mm/virtio: skip redundant zeroing of host-zeroed
 pages
Message-ID: <cover.1780067977.git.mst@redhat.com>
References: <cover.1779315441.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <cover.1779315441.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Tu7dBAN3QnrYdEEeXB4v6iuwkneGA9Jh4JNXLw86Ajs_1780068127
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

Patches 1-5: fixes/cleanups, dependencies of the zeroing patches.
Patches 6-9: thread user_addr through page allocator, contig API,
  and gigantic hugetlb allocation.
Patches 10-23: mm rework + cleanups + init_on_alloc double-zeroing
  fix + aliasing guard.
Patches 24-32: page reporting zeroing (DEVICE_INIT_REPORTED),
  disable indirect descriptors.
Patches 33-37: inflate/deflate zeroing (DEVICE_INIT_ON_INFLATE),
  FPI_ZEROED optimization.

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
  are known to contain all zeros, either because the host zeroed
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

- With __GFP_ZERO, the folio is zeroed before mem_cgroup_charge().
  If the charge fails (cgroup at limit), the zeroing work is wasted
  and the folio is freed and retried at a smaller order.  Previously,
  zeroing was done after a successful charge.  This is inherent to
  the __GFP_ZERO approach.  Is this acceptable?

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

Changes since v8 (address Sashiko v8 review findings):
- Fix mempolicy interleave: combine vm_pgoff and VMA offset into
  a single expression before shifting, fixing carry loss for
  file-backed VMAs with unaligned vm_pgoff.
- Fix memory-failure: wrap ClearPageHWPoison in retry path with
  zone->lock (same race as TestSetPageHWPoison).
- Fix stale comment: "folio_zero_user writes" -> "page zeroing"
  in huge_memory.c __folio_mark_uptodate comment.
- Drop rounddown_pow_of_two for page reporting capacity (no-op
  for compiler optimization, halves batch size for non-power-of-2).
- Reorder: move "mm: balloon: use put_page_zeroed" before
  "virtio_balloon: implement DEVICE_INIT_ON_INFLATE" so the
  ClearPageZeroed handling is in place before any page gets
  the flag set.
- Various commit log improvements (PowerPC note in aliasing
  patch, memory-failure note about other HWPoison calls,
  wording fixes).

Changes since v7 (address Sashiko AI review findings):
- Fix dcache flush on VIPT aliasing architectures: add
  user_alloc_needs_zeroing() guard in post_alloc_hook to force
  folio_zero_user for user pages when cache aliasing requires it.
  Host-zeroed pages excluded (!zeroed).  Optimization preserved.
- Fix folio_zero_user stub: replace macro with non-inline function
  in mm/memory.c to avoid double-evaluation and missing include.
- Fix C89 declaration-after-statement in free_huge_folio.
- Fix CMA __GFP_ZERO: pass through to cma_alloc_frozen_compound
  so HPG_zeroed accurately reflects whether page was zeroed.
- Fix big-endian bitmap: use test_bit_le() for inflate_bitmap.
- Fix migratepage: clear PageZeroed on old page before deflation.
- Fix page_reporting flush: overflow-safe loop, add -EINTR on
  signal, add code comment explaining double flush_delayed_work.
- Add atomic ClearPageZeroed (CLEARPAGEFLAG) for balloon migration
  path where zone->lock is not held.
- Add VM_WARN_ON_ONCE for order>0 without __GFP_COMP in
  post_alloc_hook (folio_zero_user requires compound metadata).
- Add _noprof pattern for vma_alloc_zeroed_movable_folio to
  preserve memory allocation profiling attribution.
- Add PageReported propagation in split_large_buddy (was missing
  from patch 2).
- Add FPI_ZEROED guard: skip PageZeroed when page_poisoning
  enabled and init_on_free disabled (poison overwrites zeroes).
- Add DMA alignment comment for inflate_bitmap (ACCESS_PLATFORM
  cleared, so not needed now).
- Restore tell_host comment explaining vq buffer assumption.
- Various code comments documenting design decisions.
- Drop __GFP_ZERO from gather_surplus_pages: avoid shifting
  zeroing from fault time to reservation time (mmap/fallocate).
  Pool pages are zeroed at fault time via alloc_hugetlb_folio.
  Fresh surplus allocations at fault time still benefit from
  __GFP_ZERO + HPG_zeroed.
- New patch: add alloc_contig_frozen_pages_user API with user_addr
  for cache-friendly zeroing in the contiguous allocation path.
- New patch: thread user_addr through gigantic hugetlb allocation
  via alloc_contig_frozen_pages_user.
- New patch: replace user_alloc_needs_zeroing() with aliasing-only
  checks (cpu_dcache_is_aliasing || cpu_icache_is_aliasing) in the
  post_alloc_hook guard.  Avoids redundant re-zero on non-aliasing.
- New patch: serialize TestSetPageHWPoison with zone->lock in
  memory_failure to fix pre-existing race with non-atomic buddy
  flag operations (e.g. page->flags.f &= ~PAGE_FLAGS_CHECK_AT_PREP).
- New patch: disable VIRTIO_RING_F_INDIRECT_DESC in balloon to
  prevent GFP_KERNEL allocation under balloon_lock (OOM deadlock).
- New patch: skip kernel_init_pages for FPI_ZEROED when page
  poisoning is not enabled (page already zero, skip redundant work).

Also since v7 (address review by Gregory Price):
- Drop from_pool bool in alloc_hugetlb_folio: use
  folio_test_hugetlb_zeroed directly.  HPG_zeroed is set by
  alloc_surplus_hugetlb_folio for fresh allocations, so the
  check handles both pool and fresh pages.
- Drop bool *zeroed output parameter from alloc_hugetlb_folio:
  sink zeroing inside the function.  When __GFP_ZERO is set and
  !folio_test_hugetlb_zeroed, call folio_zero_user internally.
- Rename addr to user_addr in alloc_hugetlb_folio, align
  internally with huge_page_mask.
- Add Reviewed-by: Gregory Price tags on reviewed patches.

New patches since v7:
- mm: memory-failure: serialize TestSetPageHWPoison with zone->lock
- mm: add alloc_contig_frozen_pages_user for cache-friendly zeroing
- mm: hugetlb: thread user_addr through gigantic page allocation
- mm: page_alloc: use aliasing checks instead of
  user_alloc_needs_zeroing
- virtio_balloon: disable indirect descriptors
- mm: page_alloc: skip kernel_init_pages for FPI_ZEROED when safe

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
  path, already guarded at feature negotiation time in
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

Michael S. Tsirkin (37):
  mm: mempolicy: fix interleave index calculation
  mm: memory-failure: serialize TestSetPageHWPoison with zone->lock
  mm: page_alloc: propagate PageReported flag across buddy splits
  mm: page_reporting: allow driver to set batch capacity
  mm: hugetlb: remove dead alloc_hugetlb_folio stub
  mm: move vma_alloc_folio_noprof to page_alloc.c
  mm: thread user_addr through page allocator for cache-friendly zeroing
  mm: add alloc_contig_frozen_pages_user for cache-friendly zeroing
  mm: hugetlb: thread user_addr through gigantic page allocation
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
  mm: page_alloc: use aliasing checks instead of
    user_alloc_needs_zeroing
  mm: page_reporting: add per-page zeroed bitmap for host feedback
  mm: page_alloc: clear PG_zeroed on buddy merge if not both zero
  mm: page_alloc: preserve PG_zeroed in page_del_and_expand
  virtio_balloon: submit reported pages as individual buffers
  virtio_balloon: disable indirect descriptors
  mm: page_reporting: add flush parameter with page budget
  mm: page_alloc: propagate PG_zeroed in split_large_buddy
  virtio_balloon: skip zeroing for host-zeroed reported pages
  virtio_balloon: disable reporting zeroed optimization for confidential
    guests
  mm: add free_frozen_pages_zeroed
  mm: page_alloc: skip kernel_init_pages for FPI_ZEROED when safe
  mm: add put_page_zeroed and folio_put_zeroed
  mm: balloon: use put_page_zeroed for zeroed balloon pages
  virtio_balloon: implement VIRTIO_BALLOON_F_DEVICE_INIT_ON_INFLATE

 arch/alpha/include/asm/page.h       |   3 -
 arch/m68k/include/asm/page_no.h     |   3 -
 arch/s390/include/asm/page.h        |   3 -
 arch/x86/include/asm/page.h         |   3 -
 drivers/virtio/virtio_balloon.c     | 177 +++++++++++++++---
 fs/hugetlbfs/inode.c                |   3 +-
 include/linux/cma.h                 |   3 +-
 include/linux/gfp.h                 |  18 +-
 include/linux/highmem.h             |  15 +-
 include/linux/hugetlb.h             |  18 +-
 include/linux/mm.h                  |  15 ++
 include/linux/page-flags.h          |  10 +
 include/linux/page_reporting.h      |  13 ++
 include/uapi/linux/virtio_balloon.h |   2 +
 mm/balloon.c                        |  10 +-
 mm/cma.c                            |   6 +-
 mm/compaction.c                     |   9 +-
 mm/huge_memory.c                    |  14 +-
 mm/hugetlb.c                        | 102 ++++++----
 mm/hugetlb_cma.c                    |   4 +-
 mm/internal.h                       |  21 ++-
 mm/memfd.c                          |  14 +-
 mm/memory-failure.c                 |   8 +
 mm/memory.c                         |  26 ++-
 mm/mempolicy.c                      |  75 ++++----
 mm/mmap.c                           |   6 +
 mm/page_alloc.c                     | 281 ++++++++++++++++++++++++----
 mm/page_reporting.c                 |  99 ++++++++--
 mm/page_reporting.h                 |  12 ++
 mm/slub.c                           |   4 +-
 mm/swap.c                           |  20 +-
 31 files changed, 748 insertions(+), 249 deletions(-)

-- 
MST

