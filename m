Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D728E3CC7D5
	for <virtualization@lists.linux.dev>; Tue, 12 May 2026 21:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778620051; cv=none; b=Jf3wJU4jToTiTjKbvifBe73n4+hoFBn77v+Qx0RVAaBrlm4LiOMvWPI1g+tnVGmrEpSG2Q4lW2nGmI67XfnUlraDVdftXhtt7vEr83rH0c5W/THhgT9YVg0ER0EAfPywDdeMC4KvcAref10AZTX1jkZ/TMV5t+g65tOSVJfPPAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778620051; c=relaxed/simple;
	bh=UthrZxmdWcO06HJ9ALdgvYEd0atl77MZdyNsS+qUmSA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=AwiT30qgbgFXIgbZICNx9s4bz5KzocYNm8G5oeUUvQIDWdBZgALXOsV19xrzRfPLwIauPx1Ei2/mMxEhBlLjRVWKgLUMsL1YRE3YmpplnDmN+HElQbcJNW1KYfRaKfHu8rSnECovziJR11IWpHHbZE/SoUh8ftspSX7w872zajU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IvX0VXP+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IvX0VXP+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778620049;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=91FyDo4lvxPgkiSt2vN5y4yAYQZnqJbtxElmqdOrkw4=;
	b=IvX0VXP+BgNaKpT1cN3ux/t1FsyFS7GIjHhWLk7ARX9noZaRiTmrXqElRvfQGKpIhrzA3u
	sUDfQ4jAoYxS5XIqKbQ95nxk2E7jGjNNU74xMNyaqxfFPsip2/NjlWrn8d38ftI2FjIrlq
	Gpk/spLru3qh4XGsRRSogh/eYWSjeJM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-319-nedbeZPoODaSVha_iOT23A-1; Tue, 12 May 2026 17:07:27 -0400
X-MC-Unique: nedbeZPoODaSVha_iOT23A-1
X-Mimecast-MFC-AGG-ID: nedbeZPoODaSVha_iOT23A_1778620046
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-48fc9084562so3485515e9.0
        for <virtualization@lists.linux.dev>; Tue, 12 May 2026 14:07:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778620046; x=1779224846;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=91FyDo4lvxPgkiSt2vN5y4yAYQZnqJbtxElmqdOrkw4=;
        b=c/6awZw4zyAfAX4qAnnLH96t1ko/I6kQ4/Yutg7Re0nr2ls79qM4gcM0taD4tyQ1xC
         kJ4UF023WtDVjxTbMwivWhsLhJvDYnpVvQ7myzc6RcXElD/Rokruw9dRAYza9mi9EjIB
         u6J77pc6z++kRZNXTBbZ9kpGbFCmaJ/F9ILGYbuW/m+WnpjbgMbcM3ylJ9LtjtlZN0yu
         n4djrrV9jMePNnnFto2loQMxjJ1LNW+I+kbCF8EkWqpJZUvIeSol942pXAQvjMq3gIUw
         1fKKMvt1AJo8RLO4gorYkMWlpBZPzAmXmx1Yj/RJ2hNcJQW0E5vOUksCxCWQre3yIttL
         6WCw==
X-Forwarded-Encrypted: i=1; AFNElJ+5rd97Rv044919PTUxLRHmZ7vosxqLEm16Xsb6FXTQUgAUqYSSNryekNZRz4mCCaHT5NTFuBZ8UYZMdmzNcw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyzV2TUGYXa2pFwHJs1uLhVZXHOjY97riCH2cp+eWUHleLSGVXp
	WBbLBu1oYbouPFJGn32Xdbl5GKVX0Pj+/rjKdqxKOO90l8ZBB0X7Vk1gP0ybcMd+QjrPDWU6Xlf
	DpP9Qfv8w/eR7+ay51Oqre6kuXQeT6/EEx4/oca+TJYr3sOnKjz12aLBPFWbaOC7R1DrW
X-Gm-Gg: Acq92OFsFMLkf+JlDzvVMDrvSkzfXdYzn0vU0x8A687/Ptk/0u4Xq1t3yGW6kqvnrWo
	kTBJZI0Etns1eilo2luTtiktPJVDY/v/9TWkrDrSDKT7rv4X+05GiBu9m4PBMkrhV0E1Uz94SD0
	Dl9eP46oO23q2PnFhPsh8rOROTlApo6B9XS1zJ7UHGPbtHa4/HkP2jxL8E2QKrlLVGGzi4gUtJv
	Egp9QJ8d0T0yzX/uZtYz90caLjvj43heWDHCrv+ZnJCRs4u4m6Td1NIqoV/mxgXeeUQxLQFIPx/
	kEHa+VugxfWPvAwro5EXMa7WLe/oOw1VCbd+c8G2yQlyOWOb8qVrjbzVKQh44Mxp4ku8eCySh9O
	bqdexmQN4q3JfYuTBGSBZhwi6VlpZiZiSw5KPkZW4
X-Received: by 2002:a05:600c:3b19:b0:48e:8dec:19ad with SMTP id 5b1f17b1804b1-48fc9a11b29mr6570055e9.12.1778620046127;
        Tue, 12 May 2026 14:07:26 -0700 (PDT)
X-Received: by 2002:a05:600c:3b19:b0:48e:8dec:19ad with SMTP id 5b1f17b1804b1-48fc9a11b29mr6569415e9.12.1778620045558;
        Tue, 12 May 2026 14:07:25 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-48-7.inter.net.il. [80.230.48.7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4549120eb95sm34339020f8f.20.2026.05.12.14.07.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 14:07:25 -0700 (PDT)
Date: Tue, 12 May 2026 17:07:20 -0400
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
Subject: [PATCH v7 25/31] mm: page_alloc: propagate PG_zeroed in
 split_large_buddy
Message-ID: <2db0d124c647e711c0bf95b1c7f1316a0d1408ae.1778616612.git.mst@redhat.com>
References: <cover.1778616612.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <cover.1778616612.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: k61N60tBji7HsqSW8CChPZie_Ln3ReqWXRRVqe5clqE_1778620046
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
Assisted-by: Claude:claude-opus-4-6
Assisted-by: cursor-agent:GPT-5.4-xhigh
---
 mm/page_alloc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 468e8bde7d34..ce43f5a3dbaa 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1523,6 +1523,7 @@ static void split_large_buddy(struct zone *zone, struct page *page,
 			      unsigned long pfn, int order, fpi_t fpi)
 {
 	unsigned long end = pfn + (1 << order);
+	bool zeroed = PageZeroed(page);
 
 	VM_WARN_ON_ONCE(!IS_ALIGNED(pfn, 1 << order));
 	/* Caller removed page from freelist, buddy info cleared! */
@@ -1534,6 +1535,8 @@ static void split_large_buddy(struct zone *zone, struct page *page,
 	do {
 		int mt = get_pfnblock_migratetype(page, pfn);
 
+		if (zeroed)
+			__SetPageZeroed(page);
 		__free_one_page(page, pfn, zone, order, mt, fpi);
 		pfn += 1 << order;
 		if (pfn == end)
-- 
MST

