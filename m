Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94CDA3B7B71
	for <virtualization@lists.linux.dev>; Mon,  8 Jun 2026 08:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780907925; cv=none; b=kD1ZbsB9jSl5EyIRKb5zjk+EJ1yORG5yS0dAmWJV0RKDek0vqrlweQdHgj+57xN6dX6kV32vgm5DRLokwigfTyBair2Yr6Q0j+3PP33sWMXjCccvx7L8ZWD9T9RnLSJdINC+HkDU0JzufXz8DS4I94ugWb+c/ntm2Loc+KC0loc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780907925; c=relaxed/simple;
	bh=QZ3JwNzQr1I2N8bB1taSY/6E446pSRQWfElbnCUeVaI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=earNMUfrNXypINY8PQyqQBsmztZZ5eJG+rbJE968P93tCq4lpRhRYUsb8bCbLocVyPRAyxuGOKkwTBvjPjL+GNmQfPGm+VXiG6Sbj19O4GdPqZcIR/hwGsdUvINMC2bciVWdir8cZfzdcevqUS2Er+/w2seAYcxkxKAbXfyCx9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FgVBcoeO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FgVBcoeO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780907920;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vosxR5Z06o9BwR/z8OHSdoefhvjInnjhiEJ23p/a38w=;
	b=FgVBcoeOakn0yVdM0k9ezq+vOwH6hwaYVJfu0myL9+mrn3VDHcv1cEvZbIS6HJxesOj/pU
	CZF6Afz2GWexOWT+hduGA8DwpJX241XrZagxUKtGlLVSB4pY5cftOUqSqv/cfH+gfYLTnM
	1DpIKouKqHjFGyi6l/VbY1fvs4dPdKo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-374-5CuEji30Oqeflss9AvkoYw-1; Mon, 08 Jun 2026 04:38:38 -0400
X-MC-Unique: 5CuEji30Oqeflss9AvkoYw-1
X-Mimecast-MFC-AGG-ID: 5CuEji30Oqeflss9AvkoYw_1780907918
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-490ae016853so26879725e9.2
        for <virtualization@lists.linux.dev>; Mon, 08 Jun 2026 01:38:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780907917; x=1781512717;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vosxR5Z06o9BwR/z8OHSdoefhvjInnjhiEJ23p/a38w=;
        b=qxWdK3Pz0N5yMQg3ySQAuSYxjeUbJwHECsDCKsR2Nq2grVYvDs6mE+Xy7njJS8DFKx
         jSAAIBNNPcoxFnhvr7DvOAxveka5RgbYxMjshHTYuCgC8Sspuy2HBolOnUzNxvBebFR9
         uQsXtobkk/7Ly1DUozldyWu2oUUKYT2dk60JUBxWuVDCfypN8XZIVHLvres35b6liqfy
         XJKIZXIHak3ZAbuJHkk1kF1/z3nWlL/MBH4gheQbVbiv26U2ex39ZaWNXDv3k+meLXDe
         eeEeLURGmwH5lUPKxRZ0+oDQuWdzUU3UcS1J189TvaEgvddnyUbMr2NCi6AZRX/DpyBP
         0ARg==
X-Forwarded-Encrypted: i=1; AFNElJ+/pKSW3pBNQVp9ERBP1QODZyWD1BQr6NSqUC5WhgqfGUe0JY7zbC1C5rq410FCWaPkFtP10NTaJD/TutIzDg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzG3Q/aky2BHTpZxbDrsrXZq+mDDj5angphmRkBiGgZCH10XWW7
	VEF5yfJghME4MG34FJmmoxrE8tAKMU8Z71u1huKiI6SOEqaH6iwYDxQgWCZcVMhG2mHQlKqFttf
	A0opm+U8cqQUNr++vQb3v41UABYWKe23mSltk+zf8FdeZ+0urPi46NJNfZJftAoVvRJQr
X-Gm-Gg: Acq92OEedJj1XycbjSj5oS9k5rnQDONHHqy2FtSDs4e8MDnu9I2ekT0Gl4IrfdjJDtT
	+Qk8abr4s1UnbINlm6Nf42TZ5TFcjyI7fUI5ctSMnu020T3yHNt+lsnvB9yeekDU8YwBfqLxk3l
	d9AQJE07j8L3i+zuvnkNAQtH+ulZtoHFdrZ70puaAyCCjCPsDJCs2oCSRD2lwyIo9jG9QqNF6bY
	aKhawTT8GbODtrzBA+hExH+2iRjIFdZIAEEzWCYucOajz4CjRW4oEE8vEn09AmdnlO7/sC8d/Un
	RCPBv0wh9fnwWo9EGXeJW9D/bYpDbhQskj2TWRSoPGo54Jm6pseYN+2pUdIye3y5AXz2Y3w1Unk
	cxdiPk3aWfDPYGISEi5ZwH2Y=
X-Received: by 2002:a05:600c:34c9:b0:490:688b:f10d with SMTP id 5b1f17b1804b1-490c25b3549mr252415145e9.7.1780907917522;
        Mon, 08 Jun 2026 01:38:37 -0700 (PDT)
X-Received: by 2002:a05:600c:34c9:b0:490:688b:f10d with SMTP id 5b1f17b1804b1-490c25b3549mr252414265e9.7.1780907916933;
        Mon, 08 Jun 2026 01:38:36 -0700 (PDT)
Received: from redhat.com ([31.152.37.159])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2e4004sm50788900f8f.9.2026.06.08.01.38.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 01:38:36 -0700 (PDT)
Date: Mon, 8 Jun 2026 04:38:25 -0400
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
Subject: [PATCH v10 21/37] mm: page_alloc: propagate PG_zeroed in
 split_large_buddy
Message-ID: <d8fb16b7efa1c9f67847e2e92300d6e80263ca1e.1780906288.git.mst@redhat.com>
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
X-Mimecast-MFC-PROC-ID: 0DLQiIOSmrpx7AQ-NFqOhOd_zcoG7pZz-Erd4VUJCUw_1780907918
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

When splitting a large buddy page, propagate the PG_zeroed flag
to each sub-page before freeing it.  __free_pages_prepare clears
all flags (including PG_zeroed), so the flag must be re-set on
each fragment after the split.  This ensures that the buddy merge
logic can see PG_zeroed on pages that were part of a larger
zeroed block.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Gregory Price <gourry@gourry.net>
Assisted-by: Claude:claude-opus-4-6
Assisted-by: cursor-agent:GPT-5.4-xhigh
---
 mm/page_alloc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 7a6dedd716e2..21f9e92922f1 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1520,6 +1520,7 @@ static void split_large_buddy(struct zone *zone, struct page *page,
 			      bool reported)
 {
 	unsigned long end = pfn + (1 << order);
+	bool zeroed = PageZeroed(page);
 
 	VM_WARN_ON_ONCE(!IS_ALIGNED(pfn, 1 << order));
 	/* Caller removed page from freelist, buddy info cleared! */
@@ -1531,6 +1532,8 @@ static void split_large_buddy(struct zone *zone, struct page *page,
 	do {
 		int mt = get_pfnblock_migratetype(page, pfn);
 
+		if (zeroed)
+			__SetPageZeroed(page);
 		__free_one_page(page, pfn, zone, order, mt, fpi);
 		if (reported && PageBuddy(page) && buddy_order(page) == order)
 			__SetPageReported(page);
-- 
MST

