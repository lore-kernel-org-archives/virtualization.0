Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F61C3B14DE
	for <virtualization@lists.linux.dev>; Mon,  8 Jun 2026 08:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780907794; cv=none; b=mfxWpCuxYYcNwFxKme9g24pHTGDtW0gw9+tJ9dM0gGZ8amZFqrIzOKGHyrKTqG+pir5Gu9I0wub0pqYDpPEJ0TQLCY5pHHvKKuTSPsqbisrgbx+3xJU3R56Hscca6EvYQy0o8aSyZJnV5AWkEXj7idDazUU6AgTRWKW32R7Sbro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780907794; c=relaxed/simple;
	bh=92V//TJ1Mkotj2ZpeYBESUtzgMLjmko9VnfBRr6iZOA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=ZGzhMYIllGaCKPoII7cv1FGJ4HIR4/Q5Hgi7AdeXvwd79/c4M1REfQ+FgHE7eEjhaQwJgQ1SNYKZt2y9DiZ8VArIs5rVe5vW4j1tGzSa/CZ8ThxODW/CH4TQo5B/MhllT0+ns9Q4ZzeICBKvRtjPwb/Qhw3VIuxgcHT1GWy8DKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KbIRLitg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KbIRLitg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780907787;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FnyUq+qDaMsFj8Ekur/kDRnbeSK9pjyeC2qTYvUeJTc=;
	b=KbIRLitg8ieqN8pXzhH8BxEnscqUg6ZnIrC59SO5+xeX+2U4VLyiJU+GE0wqOY7NZeOM8b
	t2PhsMUjDKFyn4nSwVbYUKhZkcAFZMUdil7qcnlu8hEhvrXyzWi5nJvo4QWQYgL0KAnnJt
	zxmVl7ohTTKMv+baZHeOtcYkCxyJ6wY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-107-5VxvB4toNNa07zFGMaz_uA-1; Mon, 08 Jun 2026 04:36:23 -0400
X-MC-Unique: 5VxvB4toNNa07zFGMaz_uA-1
X-Mimecast-MFC-AGG-ID: 5VxvB4toNNa07zFGMaz_uA_1780907781
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-490b37e1ebfso19577545e9.0
        for <virtualization@lists.linux.dev>; Mon, 08 Jun 2026 01:36:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780907781; x=1781512581;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FnyUq+qDaMsFj8Ekur/kDRnbeSK9pjyeC2qTYvUeJTc=;
        b=D3RKCJGRtGV3JyucZPJ67Aw61A+slX8SJPqWnsMMO096NKd/lKbV29OeeJSmIIYaZY
         aeilIxWpChzpvFEkBaVkejWfv8Om9s4r2l5mP6s94AB4Nnube0Bvir6MZej6cnG5oxQP
         c34ZA9DAt6SrkNRIB9N48qTtkh1BgSeaiqIcfivkzJDjjau8fTGLTfbcuqAW+y91qhoh
         JLs0x//sdXfAnHYWg5HwUS2v0Oth7tGtMovLn8o+idz/QXxJgxXizd1AhX0hGqx7yvuX
         evyV0FUhK1td1Auv1/DGTgSIdj5RBVU6iRPioZr5FUzUt58Gu3vbUm18fK9+fiwWB4iY
         Na0g==
X-Forwarded-Encrypted: i=1; AFNElJ8Nfoyz09NAVDIoO59nqh+itSobt961vcTMLRrH1zCcG79sh0cXgmKO4CMc47x3XyNx5WLkvjlYgeIsKxeS/g==@lists.linux.dev
X-Gm-Message-State: AOJu0YxqFY5VTAG5IHv6qkfyfcxgLyiAipTklBmQBqbabTMoPcJEbsTY
	VrmYBk0QT8ziNrJwQ6eOtKhngByiQL4OrWRXDR5ASUIlE52hQ7HspiGEksbJ9bdrEuhCVYiJbDa
	wyjUPhv/bz82l6a+B9WeH6R2y0uxrCdOaFjZzTp535m/Ogz4buLNHPB1kWHNUWORpb6Y5
X-Gm-Gg: Acq92OFMiDuzNV23HbMX92NkkAaOq+og6u9UJnxUDeUXSa9ehr/kAUUcqGv7nrpwAov
	x0Zb9roTbY1JlmO6I54RmCyyJQpwlQGhYcmqVWXIFwdtTdTw56k9LfiQSCK2YvM/pYBbT3N67+7
	ASmHs+CkAaa7MLyQ9UUph9Fxh/+NrG1hwTljkKSSkAW4BroPahrjEQZ00O5hMsBVY3/B1aeLAhn
	OWBoedrGKW2Ma6Qt7vRq9xs2nCGU4RQr2YHOGfHKwlYZyOM8tiXgqNdSgKsRHf36iEdeoO4AdPI
	40idBBBdfgrxmE74X58LA9eIdftfR9WbaOwGzz46lfNmgotcfTE5sDn9X8WXK3wLScul5XS6f8T
	vRxL3MhG/G070E87rWispxts=
X-Received: by 2002:a05:600c:4e4b:b0:490:bfda:7d7e with SMTP id 5b1f17b1804b1-490c258999amr250329265e9.3.1780907780970;
        Mon, 08 Jun 2026 01:36:20 -0700 (PDT)
X-Received: by 2002:a05:600c:4e4b:b0:490:bfda:7d7e with SMTP id 5b1f17b1804b1-490c258999amr250328155e9.3.1780907780459;
        Mon, 08 Jun 2026 01:36:20 -0700 (PDT)
Received: from redhat.com ([31.152.37.159])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc3918fcsm427602815e9.3.2026.06.08.01.36.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 01:36:19 -0700 (PDT)
Date: Mon, 8 Jun 2026 04:36:02 -0400
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
Subject: [PATCH v10 10/37] mm: add folio_zero_user stub for configs without
 THP/HUGETLBFS
Message-ID: <60d48e3c6f03238f385cdb8e48f6d8ffd4cff387.1780906288.git.mst@redhat.com>
References: <cover.1780906288.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <cover.1780906288.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: oe5ZFRbQz2ow8Hrv7CTaGMKnUFmMYhXnRbvkD-hYMBQ_1780907781
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

folio_zero_user() is defined in mm/memory.c under
CONFIG_TRANSPARENT_HUGEPAGE || CONFIG_HUGETLBFS.  A subsequent patch
will call it from post_alloc_hook() for all user page zeroing, so
configs without THP or HUGETLBFS will need a stub.

Add a stub that uses clear_user_highpages() with aligned
addr_hint.

Without THP/HUGETLBFS, only order-0 user pages are allocated, so
the locality optimization in the real folio_zero_user() (zero near
the faulting address last) is not needed.
This also matches what vma_alloc_zeroed_movable_folio currently does.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Assisted-by: Claude:claude-opus-4-6
Assisted-by: cursor-agent:GPT-5.4-xhigh
---
 mm/folio_zero.h | 18 ++++++++++++++++++
 mm/page_alloc.c |  1 +
 2 files changed, 19 insertions(+)
 create mode 100644 mm/folio_zero.h

diff --git a/mm/folio_zero.h b/mm/folio_zero.h
new file mode 100644
index 000000000000..c135b3a34da8
--- /dev/null
+++ b/mm/folio_zero.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef MM_FOLIO_ZERO_H
+#define MM_FOLIO_ZERO_H
+
+#include <linux/highmem.h>
+
+#if defined(CONFIG_TRANSPARENT_HUGEPAGE) || defined(CONFIG_HUGETLBFS)
+void folio_zero_user(struct folio *folio, unsigned long addr_hint);
+#else
+static inline void folio_zero_user(struct folio *folio, unsigned long addr_hint)
+{
+	unsigned long base = ALIGN_DOWN(addr_hint, folio_size(folio));
+
+	clear_user_highpages(&folio->page, base, folio_nr_pages(folio));
+}
+#endif
+
+#endif /* MM_FOLIO_ZERO_H */
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 6d3f284c607d..0943ab724032 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -17,6 +17,7 @@
 #include <linux/stddef.h>
 #include <linux/mm.h>
 #include <linux/highmem.h>
+#include "folio_zero.h"
 #include <linux/interrupt.h>
 #include <linux/jiffies.h>
 #include <linux/compiler.h>
-- 
MST

