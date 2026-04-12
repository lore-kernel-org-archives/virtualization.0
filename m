Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A303290D8
	for <virtualization@lists.linux.dev>; Sun, 12 Apr 2026 22:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776034251; cv=none; b=lJP6WFGHhH1YlexWM88YU4Hxinakwvd309Ox4owmazbZE3fsX1mTR7Aq+Rcr9fJMKCAOhQo6KlzOEz/DFSeEgtIXBygnL3sv2irVek1Aqt3trKc+y9kmH4x0urzbjOTAZu5RRq0kwdbyeN8Qbb1OLVon6yHL+t7uGrxGyPqMfAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776034251; c=relaxed/simple;
	bh=0Er6JhcuZvfFJX5Imlw5RSI3Tz9qsyeujsPz9dFWRvU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=RSYyj0Y7JZOHxkTqyZMZlUDyte6cyApcwOeIkV8VUjZFLiMQ6hUaAfWUbjDSV3+u/l4XDxy4E/O2dXPzmL2vH56jl+3ruMTnTxJKFjDrID7kJSkHEgXhWz6JKnzsOLyFV8Uv0ic/C8Fv2qC7strHuSQSRKZ0E1kdmFbWUIowPqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g3Di8L2k; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g3Di8L2k"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776034243;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=0Dnj9NKff0KtA3p2PFW0ElNUpFQLHa2s5fam2oT6x2U=;
	b=g3Di8L2kDu6i8uTnS4FfJOSUqxYWTiBvQVGVkv9zoczv7540mVNEEfhwljavrZjyzn+F93
	KEJjZ0NTw0dtMHUHaQwZL17wYYYKtrQadbivcLN/HC6W0vzDLZJsreyYvFeLrRtK+UcwhH
	nl5fkxBHuPCszAjwIEPX3cDHnsjPyj0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-593-lhmNFteoPnGz4qRzATD8iw-1; Sun, 12 Apr 2026 18:50:41 -0400
X-MC-Unique: lhmNFteoPnGz4qRzATD8iw-1
X-Mimecast-MFC-AGG-ID: lhmNFteoPnGz4qRzATD8iw_1776034240
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-483786a09b1so39538935e9.3
        for <virtualization@lists.linux.dev>; Sun, 12 Apr 2026 15:50:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776034240; x=1776639040;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0Dnj9NKff0KtA3p2PFW0ElNUpFQLHa2s5fam2oT6x2U=;
        b=UUQeaq7DtqMpKt54bHjBE1BNkIVyJoBRTo3A2ml8sic90trjsKIHIFJnK+7CYuyFsI
         dHfq2OSJIvux5bY/Eyyp8E7a8qoUO6C8nXF0p3TNkQvxAc/sqMijpBN+tquitlLqwzSY
         Ftt12UazFVo9QIIBephQBOfkpE4WmG1mz+fn6epw1qMdFUloGugc7x+LYjWwXjk/2qIJ
         SQUVpGlzsENMT25WDjNibWClKW2MPsuceCxlzLo+wxG0VbF+5E7EGOBXSJ3sAt9JLOBd
         t0artBj2S2VlujEcxcWEaAD5XUDvGxcxEAwsGELoKTkE8ziAtjbfCLLQ81U6qD1v5nqJ
         98sQ==
X-Forwarded-Encrypted: i=1; AJvYcCWqFZltnDGF/3Mwoh4xlBjtg+ZbDRqgML8etuuBgTBrJyVBkhfrZMSl7fRnycUtAi4wkJt5fa9PkNB0iFrNFw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzY8REJnnDYwd8SfjX9ml4KGfs22d6JPlvUSriH3p96TZ1PNqIt
	jdyavwVzU6cHMaZiVW2gAjhKJ0h1mmE3ilpNIa47ZflJqQfXuSyib4NPIcsZUy0x0p8mop9Zqxs
	TG+SAJ3XsU8Yv6zoX3q1xTfVYEvtBUDfPEUqMaQjBeSJBFu5lonI41hPbcUUHhS3Qbw6q
X-Gm-Gg: AeBDievV1Qht9l3CTy5h/TNAUDrJgiaalEsJNpWr0N6MJau+zz2n2tzfhiGiwJ7qdMr
	7YvTyeta8YzxcxFCrj1cbVFq3VzB/HZIZqR7nNtF57+8pqN0iD8vf0kxt/97+QG6Wqsfk663UoE
	FvhFh2hNkxBuS7D2OZygckCru4f5bzEq/CEqM6KhB0s81IqgSjezS2HQcO7/GqttuGVuhYI4Q/m
	vfphI+D/sxozSgPHmK3A+ZSeuO5AjnVrXVBloU1ClkEJ5AbVU5WCI7HrivRzD03AQakLeSgoXn/
	P6RpUfs/heS+SDB7BFbq//trKTuM4vN9aZ1NSpaIVv2Wrq+h80kkwBWs18kj38T76momLR1RT6D
	vappl5Wf3pz3U9Yyd917ti99FfKESomyx4wQax3TrUfM=
X-Received: by 2002:a05:600c:a408:b0:488:8b99:54a1 with SMTP id 5b1f17b1804b1-488d68865f6mr117254755e9.28.1776034240471;
        Sun, 12 Apr 2026 15:50:40 -0700 (PDT)
X-Received: by 2002:a05:600c:a408:b0:488:8b99:54a1 with SMTP id 5b1f17b1804b1-488d68865f6mr117254615e9.28.1776034239992;
        Sun, 12 Apr 2026 15:50:39 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-25-21.inter.net.il. [80.230.25.21])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d67ced32sm109922655e9.7.2026.04.12.15.50.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Apr 2026 15:50:38 -0700 (PDT)
Date: Sun, 12 Apr 2026 18:50:36 -0400
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
Subject: [PATCH RFC 0/9] mm/virtio: skip redundant zeroing of host-zeroed
 reported pages
Message-ID: <cover.1776033471.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: U5keAtT1OEhMM-cKFF2DJ3CZoCe9gVLf6fmC50aopr4_1776034240
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

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

  metric         baseline    optimized   delta
  task-clock     179ms       99ms        -45%
  cache-misses   1.22M       287K        -76%
  instructions   15.1M       13.9M       -8%

With hugetlb surplus pages:

  metric         baseline    optimized   delta
  task-clock     322ms       9.9ms       -97%
  cache-misses   659K        88K         -87%
  instructions   18.3M       10.6M       -42%

Notes:
- The virtio_balloon patch (9/9) is a testing hack with a module
  parameter.  A proper virtio feature flag is needed before merging.
- Patch 8/9 adds a sysfs flush trigger for deterministic testing
  (avoids waiting for the 2-second reporting delay).
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
  PERF_DATA=/tmp/perf-$MODE.data
  rmmod virtio_balloon 2>/dev/null
  insmod virtio_balloon.ko host_zeroes_pages=$MODE
  echo 1 > $FLUSH
  [ "$HUGE" = "huge" ] && echo $((SZ/2)) > /proc/sys/vm/nr_overcommit_hugepages
  rm -f $PERF_DATA
  echo "=== sz=${SZ}MB mode=$MODE iter=$ITER $HUGE ==="
  for i in $(seq 1 $ITER); do
      echo 3 > /proc/sys/vm/drop_caches
      echo 1 > $FLUSH
      perf stat record -e task-clock,instructions,cache-misses \
          -o $PERF_DATA --append -- ./alloc_once $SZ $HUGE
  done
  [ "$HUGE" = "huge" ] && echo 0 > /proc/sys/vm/nr_overcommit_hugepages
  rmmod virtio_balloon
  perf stat report -i $PERF_DATA

Compile and run:
  gcc -static -O2 -o alloc_once alloc_once.c
  bash bench.sh 256 0 10          # baseline (regular pages)
  bash bench.sh 256 1 10          # optimized (regular pages)
  bash bench.sh 256 0 10 huge     # baseline (hugetlb surplus)
  bash bench.sh 256 1 10 huge     # optimized (hugetlb surplus)

Written with assistance from claude. Everything manually read, patchset
split and commit logs edited manually.

Michael S. Tsirkin (9):
  mm: page_alloc: propagate PageReported flag across buddy splits
  mm: page_reporting: skip redundant zeroing of host-zeroed reported
    pages
  mm: add __GFP_PREZEROED flag and folio_test_clear_prezeroed()
  mm: skip zeroing in vma_alloc_zeroed_movable_folio for pre-zeroed
    pages
  mm: skip zeroing in alloc_anon_folio for pre-zeroed pages
  mm: skip zeroing in vma_alloc_anon_folio_pmd for pre-zeroed pages
  mm: hugetlb: skip zeroing of pre-zeroed hugetlb pages
  mm: page_reporting: add flush parameter to trigger immediate reporting
  virtio_balloon: a hack to enable host-zeroed page optimization

 drivers/virtio/virtio_balloon.c |  7 +++++
 fs/hugetlbfs/inode.c            |  3 ++-
 include/linux/gfp_types.h       |  5 ++++
 include/linux/highmem.h         |  6 +++--
 include/linux/hugetlb.h         |  2 +-
 include/linux/mm.h              | 22 ++++++++++++++++
 include/linux/page_reporting.h  |  3 +++
 mm/huge_memory.c                |  4 +--
 mm/hugetlb.c                    |  3 ++-
 mm/memory.c                     |  5 ++--
 mm/page_alloc.c                 | 46 ++++++++++++++++++++++++++++++---
 mm/page_reporting.c             | 34 ++++++++++++++++++++++++
 mm/page_reporting.h             |  2 ++
 13 files changed, 129 insertions(+), 13 deletions(-)

-- 
MST

