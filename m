Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB063BC667
	for <virtualization@lists.linux.dev>; Mon,  8 Jun 2026 08:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780907968; cv=none; b=D3RuXXlpa6Q00DijarNWtmCK1I9b5LTooQQplcG9BBNIcD8jRVJDCAn58OVHFnlBAB9Mbmku6J7qed/O8GrNBvVNtRS0ZKWauN4cLOqkToob0oH9iJ4AynLFfmoCI5G7L2kheNOddqVPUuJxM4wXNf8AheKSW8+ashbIbKxrcBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780907968; c=relaxed/simple;
	bh=8lKGno9llqXVAoyhq8ZkwVVgxVUaSsktCgeYhaFtI3o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=FOdj3iG14IL9Pos/NYp8rOPcdQSLehaI/r704nlv5/FkBZ8VH5RVjYfWA8Q8mNhksClHku4gIFfnzmr3Ae/EP7+hjSoODMnskmrKRQPhWjm6G7WDQa1oSN81hJqAB2Ep7cbfPjsCqaSqEgv5sbs5imfJZOy360XMRJswg9lKXII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K+UJCjrl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K+UJCjrl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780907963;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sR3mqTwhRYGGG0tioR5exPzZ/dZTwNqp64a/18KVd0I=;
	b=K+UJCjrlY03LT6krA9sIquUbiMnPkdzVYXTLhTL1qnX/ayNW+tWounfsJWOKleEWMc90gR
	sG04Uqq+e8QreHIK6EjEb9jrIgSZey3f+KjDzJ4nzbKXn/rHZwiyzvSAIOTqKCxXtRipF8
	GCDf5xrMFgGHo2lAHrR23j1I+gfKCCM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-225-muzfbn0kPDuK8Cm3jG4z2w-1; Mon, 08 Jun 2026 04:39:20 -0400
X-MC-Unique: muzfbn0kPDuK8Cm3jG4z2w-1
X-Mimecast-MFC-AGG-ID: muzfbn0kPDuK8Cm3jG4z2w_1780907959
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-460129ef947so2392618f8f.1
        for <virtualization@lists.linux.dev>; Mon, 08 Jun 2026 01:39:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780907959; x=1781512759;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sR3mqTwhRYGGG0tioR5exPzZ/dZTwNqp64a/18KVd0I=;
        b=bqc8Bibnj/xim5G3VurYsVIt5Z9yJ14z8uridmTuNydBnsKRsfDn2j2ojZ8OZc2R+f
         vsLgROmb1mjfc03XZo77MdjlWo0NINe2HyJyWFDJzy4RvPwP5DLh8YMd4lbGAv6Wv5cr
         qfMliq3je4sWuzi3Gle27UiS9jX7BtrlqcOMhpuoUaDDemm8ABem08K93tVyhwYXenLW
         8rXAPTS8IRRE8aZ8tuprXzTxygYRdZpS70+3kYGdiE18WYrJqzysxZXUoy1feTQ8oc4J
         roayo32kqJDbj/in5YXaHSCbUnNkiLkB6/8J9InOPG+eHpewhytzAG2jw9botGXAkZzU
         PieA==
X-Forwarded-Encrypted: i=1; AFNElJ95S/9tHDezjn+5v8xkvmvwwBKLyHRoAKZkApn8kNfQZV7/ZJHFgdhvBLG1HOjE3dhNHUQ79pL53yi2E1jPDw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yye3LGmAN6zlFZhsnkBE0dUCNtM09g5OskDgY4GEKH3VzfWkzDa
	6flRvR689ByKCgWi4xqkMfczwG+vEs7QTKQRJWCWOc2GKDrMP/9KGHHxw0d0+628eFF+fGQNz7J
	1HA0ZM0rcFAT6DicvBpNCqYWRUY1yywJRs4CNfKMhQUxryzsRjrmKqMB/rhiz+WI4Q8A0
X-Gm-Gg: Acq92OGELC4wjw7YSGKspqXqa6diNWXO1+5tMkWqQo4YsCUhvZNokpRzsdUigDvq1qD
	UwzVCM+PU8ErCoI53WYnjZemFVq4/mTHgb/RERiVHcZsQZ1xc7kX1cwbxvDqCC+jYzmQJK1d+6g
	6eKlI9lCM9qhBpriCgLgLYnWB71T3U9QRMacfgEPBy4GA4tOY+p1OU1Qg52dVrgyaOIwXslR6HF
	wCFqlZswIRPGbMyCRe02fbeUhFNuo6D8xeIK2j+aKlFLR6i8RL2li5Rh/3fU5soj6ZhfxSB+QF2
	XNW+x1MKv14cdh7Co2uiOKwoz3iFP0VSHg0739xpf5IlVyk8097k5/Ft+N/U+cQk2s65imedTKf
	Fa9zKSVIF9283fKUeYtqUnuk=
X-Received: by 2002:a05:600c:4e94:b0:490:9588:bdae with SMTP id 5b1f17b1804b1-490c25e30e0mr244497355e9.18.1780907958532;
        Mon, 08 Jun 2026 01:39:18 -0700 (PDT)
X-Received: by 2002:a05:600c:4e94:b0:490:9588:bdae with SMTP id 5b1f17b1804b1-490c25e30e0mr244496725e9.18.1780907958066;
        Mon, 08 Jun 2026 01:39:18 -0700 (PDT)
Received: from redhat.com ([31.152.37.159])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc3e59f5sm399310235e9.14.2026.06.08.01.39.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 01:39:17 -0700 (PDT)
Date: Mon, 8 Jun 2026 04:39:10 -0400
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
Subject: [PATCH v10 26/37] mm: vma_alloc_anon_folio_pmd: pass raw fault
 address to vma_alloc_folio
Message-ID: <94f64aeca62d8419d76f2cf82b36f1da6017a312.1780906288.git.mst@redhat.com>
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
X-Mimecast-MFC-PROC-ID: xZ_MUm2iXxaFMaz8HVOk_poG7T0VW1YPWVKeBSIkI0g_1780907959
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Drop the redundant HPAGE_PMD_MASK alignment at the callsite.
NUMA interleave is not affected by the raw address; the ilx
calculation shifts addr >> PAGE_SHIFT >> order, dropping
sub-page bits regardless of alignment. post_alloc_hook will
use the raw address for cache-friendly zeroing.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Assisted-by: Claude:claude-opus-4-6
Reviewed-by: Gregory Price <gourry@gourry.net>
---
 mm/huge_memory.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 970e077019b7..d689e6491ddb 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1337,7 +1337,7 @@ static struct folio *vma_alloc_anon_folio_pmd(struct vm_area_struct *vma,
 	const int order = HPAGE_PMD_ORDER;
 	struct folio *folio;
 
-	folio = vma_alloc_folio(gfp, order, vma, addr & HPAGE_PMD_MASK);
+	folio = vma_alloc_folio(gfp, order, vma, addr);
 
 	if (unlikely(!folio)) {
 		count_vm_event(THP_FAULT_FALLBACK);
-- 
MST

