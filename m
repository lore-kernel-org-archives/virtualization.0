Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB3C3B1EC8
	for <virtualization@lists.linux.dev>; Mon,  8 Jun 2026 08:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780907913; cv=none; b=JBDJfUOzSE/2b/pYQ/dyh016l9VasrryyfLGsIllfgzfkeV5wJwJx4Gzp3nQ8Kss+NfKfc7F4lPUyNv5zx/HazE5GbeWa19003HrXKyt8Le/Ij3H1plYWkov8Fj2oMO3A7r11tiwIul/3/qyBsTyMSsEgXilfrThE9sqyb0JxDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780907913; c=relaxed/simple;
	bh=UxeyPjgwwid26PyqR+dr8ssEfWP9Pr8mV393MNefhtc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=fo4C8E5TRtgQVvfvgVdVM0YFuQqWpABitducBCKbKr5x7UmcBbn6Z2aFOy+TcCFaCkuUD+eTpg/Rm+1HZ19V2YUrezufQXP1jo0esJ56X3ne8p4dYGIvWJexZFuy3KQmm5i4ESAJoTBRw/dZjBUZIIkWVSHNX13WUq/cMDYjuRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Kws79ZkD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Kws79ZkD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780907908;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pR/GrYiW1j/TwC+RCSDEiDzn5vRq7z0PTWnhHKvSevw=;
	b=Kws79ZkDcXF5XOSVwOBOqAzQqx9/4EJXAsjqWXLjXNFJku/1D7Sa+ZECADXanoYvZvQwvU
	Ip2NHmlC1HMxX54bSfbGeSSPlB8ql5sIg3AbyCfP09SxcHCRbeXFqVJ+j0je9YVJt2Zpqm
	fXKwAYFjf+QWjmaMekKk9fewGTYym78=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-66-JwnYOvSQOpGiDd_sVcF8xw-1; Mon, 08 Jun 2026 04:38:27 -0400
X-MC-Unique: JwnYOvSQOpGiDd_sVcF8xw-1
X-Mimecast-MFC-AGG-ID: JwnYOvSQOpGiDd_sVcF8xw_1780907906
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-45efb6e60e4so3799222f8f.0
        for <virtualization@lists.linux.dev>; Mon, 08 Jun 2026 01:38:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780907906; x=1781512706;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pR/GrYiW1j/TwC+RCSDEiDzn5vRq7z0PTWnhHKvSevw=;
        b=HXsKcRYZurFyks9k3V7RF6Cajyv2sILvDA1JbVPyJ+G0hvz7WgAXIpsTIu0mnC7dVf
         GKZ8ATTa/6h4xnNsham+fgtCsid1jFI95iJOGqvBKHeFmnhgfIKv8uNzMW4s5xjgr597
         k8NuRBtG0nPG4ZUafKVopBUXi/BmG22mxtDu6q/YLZV4J1ud5fto29ZrkvnA9tx0yPEk
         NmIQmQwXwPHitQ6PHOlS8/x1kmLv9uChrbFP31e7M3fugob+dMN2/9QQkiRVvJ3Kgb4x
         cmcKKF0yNZG+Z22GOeVo/2pRRQSMgtl8MWi6kHskaV4ML/RdzA07uSwKcRbxSYB3e3id
         dCKA==
X-Forwarded-Encrypted: i=1; AFNElJ/t+gZ6wm7+zfVr0I14v7nrZdDnux9vTZL2x+LM9CfFcXtLg6Wdnw9VLUrEtgUKmp+vO1lBAhizDddAHCgAmQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw4w5xGZ7+BsEQoyOKRvEoZK3BPRaijfp+Clsju5c6C7JmpvOXu
	+0COVfjCJ9HbPkeNoFdtGIyeo2PFZSc4V2tWH2ZaAS8HYVmv7seVYjwCTzSBX/CExYWPT4UBvK9
	PDdSIGsjdVXQC0AKiK+o4BZjyuZigbaZttfvxD1a0KwYGZC4ZrbHL2KoR0oCn0Tse+z7r
X-Gm-Gg: Acq92OHdr9V1jqF/JZj8/angM/h0Cen2DXcncQ6kYpjtw6FqOPPqRCBaSOA5n0gu+6N
	+HbEJwDHWgNzrNjRKzDtWXPUqQEM6/7/CgzwxfQ2zaMW/OwSnnKh6dO9976jj6u2Cl6N1ZR3iOa
	m4/UVDJMWs0R55/4rI2zoPXu80T0S67wjtasXa+dW0QZZTqJcRCdw22HAaXT0v22bH+VsyKeh/t
	lDBtBUkWZv59u6IdjQLrmGj8vCmXstPe+YOQUTVzbBbvE+IC1U8rs189UBLryj7ZWRn3744mYdz
	IWCe0/bbQEytmoHuEC6r8eKVzpMdZ65yfivX++wmfIzV3qgBiop04eCdvwSeXl/7O0jmYYcRyR2
	HRwqQQsezzADmr1wm/iQtIIQ=
X-Received: by 2002:a05:6000:2d10:b0:43f:dfb6:78e1 with SMTP id ffacd0b85a97d-460302e0a26mr15095017f8f.8.1780907905904;
        Mon, 08 Jun 2026 01:38:25 -0700 (PDT)
X-Received: by 2002:a05:6000:2d10:b0:43f:dfb6:78e1 with SMTP id ffacd0b85a97d-460302e0a26mr15094967f8f.8.1780907905416;
        Mon, 08 Jun 2026 01:38:25 -0700 (PDT)
Received: from redhat.com ([31.152.37.159])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f3444fesm51241760f8f.20.2026.06.08.01.38.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 01:38:24 -0700 (PDT)
Date: Mon, 8 Jun 2026 04:38:16 -0400
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
Subject: [PATCH v10 20/37] mm: page_alloc: preserve PG_zeroed in
 page_del_and_expand
Message-ID: <a8fe7eb8ee42128e7e74279662316c1d089e138e.1780906288.git.mst@redhat.com>
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
X-Mimecast-MFC-PROC-ID: BX-w6pcz5msWnCwSia3gKy1N_k5-sVtccBI8SF3R1xU_1780907906
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Propagate PG_zeroed through buddy splits in page_del_and_expand()
and try_to_claim_block().  When a zeroed high-order page is split
to satisfy a smaller allocation, the sub-pages placed back on the
free lists keep PG_zeroed.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Gregory Price <gourry@gourry.net>
Assisted-by: Claude:claude-opus-4-6
Assisted-by: cursor-agent:GPT-5.4-xhigh
---
 mm/page_alloc.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index a90bca5317c1..7a6dedd716e2 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1712,7 +1712,8 @@ struct page *__pageblock_pfn_to_page(unsigned long start_pfn,
  * -- nyc
  */
 static inline unsigned int expand(struct zone *zone, struct page *page, int low,
-				  int high, int migratetype, bool reported)
+				  int high, int migratetype, bool reported,
+				  bool zeroed)
 {
 	unsigned int size = 1 << high;
 	unsigned int nr_added = 0;
@@ -1743,6 +1744,8 @@ static inline unsigned int expand(struct zone *zone, struct page *page, int low,
 		 */
 		if (reported)
 			__SetPageReported(&page[size]);
+		if (zeroed)
+			__SetPageZeroed(&page[size]);
 	}
 
 	return nr_added;
@@ -1754,10 +1757,12 @@ static __always_inline void page_del_and_expand(struct zone *zone,
 {
 	int nr_pages = 1 << high;
 	bool was_reported = page_reported(page);
+	bool was_zeroed = PageZeroed(page);
 
 	__del_page_from_free_list(page, zone, high, migratetype);
 
-	nr_pages -= expand(zone, page, low, high, migratetype, was_reported);
+	nr_pages -= expand(zone, page, low, high, migratetype, was_reported,
+			   was_zeroed);
 	account_freepages(zone, -nr_pages, migratetype);
 }
 
@@ -2355,11 +2360,12 @@ try_to_claim_block(struct zone *zone, struct page *page,
 	if (current_order >= pageblock_order) {
 		unsigned int nr_added;
 		bool was_reported = page_reported(page);
+		bool was_zeroed = PageZeroed(page);
 
 		del_page_from_free_list(page, zone, current_order, block_type);
 		change_pageblock_range(page, current_order, start_type);
 		nr_added = expand(zone, page, order, current_order, start_type,
-				  was_reported);
+				  was_reported, was_zeroed);
 		account_freepages(zone, nr_added, start_type);
 		return page;
 	}
-- 
MST

