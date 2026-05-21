Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D1D91F2B8D
	for <virtualization@lists.linux.dev>; Thu, 21 May 2026 14:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779372566; cv=none; b=iKkV2VmlMqBwe94vPomq3C4fHDZLlzxVQulf4GZGfkg2x3WZ7ZdEBvIXIm7GhZW5hqE5ADfuax91VJ/RRlY0rUyGcNhVwM/zY6fSEnTAoXWslOqbPt3lrBNpmpBhjWbh9dKAef7uBPw/Zvga3fkEd7R01e+VteLS2kyex8a7R3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779372566; c=relaxed/simple;
	bh=zVWai+7lGIvjl6SkZBpll6gJb+jxqobnMbSWMceYjNA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=NBpwC86WqhIQupOEXou3NHLqwp7oQPiMe+ww0OG87z+evAmdFtrleiF+/wwEJTH1gSp/TJkJqDvaHyEkpmPAUpKHxv5TLDuCpfSlRmHLnPw5i9H1+2Ff5ke3lUZblqadDGzLOd8QiREcwIrnetUa0sHd53p5dQNtp7acfoyancg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Vct6ra0N; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vct6ra0N"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779372563;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=E82Z22wc78DWFtKs22Dwf10Uc2AV6EGoZcG/joqub6E=;
	b=Vct6ra0NH6nH4gBZFIjDfwKIDfUeotUzCK74H6H/a5kOjzU/YrsAAYBGF3ntHbZD1ne2c4
	5ohIe+ivTxEF32OOB7HHvVhCDDij9BE2G13DTYOa8ON6rNueN8E3xcXz9K4yY5E7hN67IQ
	HH8/bn4l0kj1cZB/7vha9bGifmrk/SQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-680-QuQ96MPCN_-D4KpzlSY5Cw-1; Thu, 21 May 2026 10:09:19 -0400
X-MC-Unique: QuQ96MPCN_-D4KpzlSY5Cw-1
X-Mimecast-MFC-AGG-ID: QuQ96MPCN_-D4KpzlSY5Cw_1779372558
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-48fd233d1e2so56956845e9.1
        for <virtualization@lists.linux.dev>; Thu, 21 May 2026 07:09:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779372558; x=1779977358;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E82Z22wc78DWFtKs22Dwf10Uc2AV6EGoZcG/joqub6E=;
        b=jPdW1znsaR+mhv3nDD3IFAOy2KUJff/eeLoWqbfPjMVxJmB8Y3f1YQQrwnxCFdUwhe
         EYp0QuRCt94ur5dmwm93Qcj5Emg/koX/ePVHjKsozEWbli4tuVJY5EXKyjwsDmtez05L
         cgf4G3ZdnYVu7oR1NiVEJRHbHmBunGAE+jFeDaF0FR5A+ANcSrnzupbO+OlB0RFVDRuc
         TcaKUFM2/z9bOCAkFtXzXAZOUnO+a9yI08lcNQ99zMwL7oSxOGsj5n3AOiyAqUyE9+y/
         cxNq4xaGaa+P3RQZ6iCc6jniSbAHde6f79wod3iT58UbzhpAYTfFB29+nvo2tSTmLPoa
         /BJA==
X-Forwarded-Encrypted: i=1; AFNElJ8DMt8fE4Ho+/YxPRT1+N8WbHTMFYH91wMlJQPcsV1sTOsNeJqyMAKF0OMmfvpw+UqP8ybRtBHuF7TBOB48+g==@lists.linux.dev
X-Gm-Message-State: AOJu0YzJdjIGQdHTyhE5dBExmIyvwN4kgnbfF/NxLL4fwhV8K4RewJVq
	YRJNcRIscmCghy30UnbfQCTDtcNBktvxUAHgg2juX1Hg8le49TEk5oElyizJtIextdM5HjOBPJT
	LwJRfyR2tSaZLphlIsvVRktaf8fN6Fop1t6qxneEUlASk2pnoNBj2K0Ndza4OPZBrIkKo
X-Gm-Gg: Acq92OFKsXtYm+MBR/N7mDGY+JD4x3rRxzlC4HpwJ5fOEw+CfTwGMM+Mekr5rjQrAw6
	M5t5f9LScksO1ppU6P9HQ7mWilQprHkY/MvrMvHvMMSMkXiAaQKf/Ukv0v6S7+eNcp0R75q2/4+
	mL+LRcQAr/Wvag/6l9SxxN3RGJp33uoJcvXkTjrc7eCBdJPTT5/UCfBGIlRZ5Vvnx0HgBbxjr6k
	XaIA0qzrEhcUuGmfQsUWSQVRrcxk3FfSOMGApRGu8JbuJaMaZa12gkQqvHzQrnaBv9A3EKU5qW9
	gHjPONnd2i4shweAMVzpKN3K2+i3ljSsl6bLhRAv97EmUnSJTielvv8jE0yDFb3GZtRrY4iWwmo
	1I6tSigAraS+mhnHV1sfHDYDQOR2HXEiG8KNRebWbA0qlelLlYlHMSw==
X-Received: by 2002:a05:600c:4e92:b0:490:3b84:c106 with SMTP id 5b1f17b1804b1-4903b84c8ffmr34030235e9.26.1779372557807;
        Thu, 21 May 2026 07:09:17 -0700 (PDT)
X-Received: by 2002:a05:600c:4e92:b0:490:3b84:c106 with SMTP id 5b1f17b1804b1-4903b84c8ffmr34029025e9.26.1779372557076;
        Thu, 21 May 2026 07:09:17 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-25-45.inter.net.il. [80.230.25.45])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4903ad2ee77sm25394465e9.0.2026.05.21.07.09.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 07:09:16 -0700 (PDT)
Date: Thu, 21 May 2026 10:09:11 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: "David Hildenbrand (Arm)" <david@kernel.org>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
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
Subject: Re: [PATCH v8 00/37] mm/virtio: skip redundant zeroing of
 host-zeroed pages
Message-ID: <20260521100313-mutt-send-email-mst@kernel.org>
References: <cover.1779315441.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <cover.1779315441.git.mst@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: PkHafRtJl4J8dBh9rAUSqnkQC0Nw6RKmFwcEDcQPBe4_1779372558
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 20, 2026 at 06:20:13PM -0400, Michael S. Tsirkin wrote:
> When a guest reports free pages to the hypervisor via virtio-balloon's
> free page reporting, the host typically zeros those pages when reclaiming
> their backing memory (e.g., via MADV_DONTNEED on anonymous mappings).
> When the guest later reallocates those pages, the kernel zeros them
> again, redundantly.

FYI Sashiko reported a couple of issues. Mostly false positives but
I tweaked commit log to make it clearer. But also a couple of
real issues. So far I have this diff on top:

--->

Changes from v8 to v9 candidate (code only):

1. mm/mempolicy.c (patch 1: mm: mempolicy: fix interleave index calculation)
   Combine vm_pgoff and VMA offset into a single expression before
   shifting, fixing carry loss for file-backed VMAs with unaligned
   vm_pgoff.

2. mm/memory-failure.c (patch 2: mm: memory-failure: serialize TestSetPageHWPoison with zone->lock)
   Wrap ClearPageHWPoison in retry path with zone->lock too.

3. mm/huge_memory.c (patch 19: mm: use __GFP_ZERO in vma_alloc_anon_folio_pmd)
   Fix stale comment: "folio_zero_user writes" -> "page zeroing".

4. mm/page_reporting.c (patch 4: mm: page_reporting: allow driver to set batch capacity)
   Drop rounddown_pow_of_two: compiler cannot optimize division
   by runtime variable anyway, and rounding halves batch size for
   non-power-of-2 capacity values.

Commit log improvements (no code change):
- Patch 1: rewritten to explain new single-expression formula (fixes patch 1)
- Patch 2: mention ClearPageHWPoison in retry path (fixes patch 2)
- Patch 4: drop "rounded down to a power of 2" (fixes patch 4)
- Patch 10: "stub" wording simplified (fixes patch 10)
- Patch 22: note PG_zeroed hint loss is harmless (fixes patch 22)
- Patch 23: add PowerPC note (fixes patch 23)
- Patch 28: explain DEVICE_INIT_ON_INFLATE is a follow-up (fixes patch 28)
- Patch 29: explain flush over-reporting is by design (fixes patch 29)
- Patch 33: note __SetPageZeroed is safe on frozen pages (fixes patch 33)
- Patch 36: note __SetPageZeroed is safe on balloon-owned pages (fixes patch 36)

---

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 9845c920c29c..4978d34532ea 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1358,7 +1358,7 @@ static struct folio *vma_alloc_anon_folio_pmd(struct vm_area_struct *vma,
 
 	/*
 	 * The memory barrier inside __folio_mark_uptodate makes sure that
-	 * folio_zero_user writes become visible before the set_pmd_at()
+	 * page zeroing becomes visible before the set_pmd_at()
 	 * write.
 	 */
 	__folio_mark_uptodate(folio);
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index a6b61172dd13..d106f2c135c7 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -2426,7 +2426,9 @@ int memory_failure(unsigned long pfn, int flags)
 			} else {
 				/* We lost the race, try again */
 				if (retry) {
+					spin_lock_irqsave(&zone->lock, mf_flags);
 					ClearPageHWPoison(p);
+					spin_unlock_irqrestore(&zone->lock, mf_flags);
 					retry = false;
 					goto try_again;
 				}
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index ea3043e0075b..f573ff32e94d 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -2048,9 +2048,9 @@ struct mempolicy *get_vma_policy(struct vm_area_struct *vma,
 		pol = get_task_policy(current);
 	if (pol->mode == MPOL_INTERLEAVE ||
 	    pol->mode == MPOL_WEIGHTED_INTERLEAVE) {
-		*ilx += vma->vm_pgoff >> order;
-		*ilx += (addr >> (PAGE_SHIFT + order)) -
-			(vma->vm_start >> (PAGE_SHIFT + order));
+		*ilx += (vma->vm_pgoff +
+			(addr >> PAGE_SHIFT) -
+			(vma->vm_start >> PAGE_SHIFT)) >> order;
 	}
 	return pol;
 }
diff --git a/mm/page_reporting.c b/mm/page_reporting.c
index 8b278a494ea5..3f584f538c68 100644
--- a/mm/page_reporting.c
+++ b/mm/page_reporting.c
@@ -443,9 +443,6 @@ int page_reporting_register(struct page_reporting_dev_info *prdev)
 	if (!prdev->capacity || prdev->capacity > PAGE_REPORTING_CAPACITY)
 		prdev->capacity = PAGE_REPORTING_CAPACITY;
 
-	/* Power of 2 so division by capacity in the budget calc is cheap */
-	prdev->capacity = rounddown_pow_of_two(prdev->capacity);
-
 	/* initialize state and work structures */
 	atomic_set(&prdev->state, PAGE_REPORTING_IDLE);
 	INIT_DELAYED_WORK(&prdev->work, &page_reporting_process);

