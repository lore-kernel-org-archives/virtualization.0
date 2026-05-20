Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8E563BFE33
	for <virtualization@lists.linux.dev>; Wed, 20 May 2026 22:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779315818; cv=none; b=qZ87/5eIYBn59GgB9eMW5dp2JUyzdVrvaxCYmt0cwc498vonOKGcE159DBjrUwjZhrjDCFpFIucDtQjV9icGXfimShhQJpk58+Ffdbah4Czx9XgLzQbmt61VjtMr1D4A/H0AGbHambInALV8tKtdAloK5JZb8V+HRnpK48ioNCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779315818; c=relaxed/simple;
	bh=4jLzODooKNrRdgluzPWerRBde7vslo8ZvEbzyAfj6vs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=TPhIiVulCRNb24mnjR9NP/osrBq1/oGtzGkJsvFIREYmiyOFxuvtPnXaoHcb7bLKkxdMKwXTeYH62Ewp4WQX/XGlo2WHCZUgahbs+KP6szzQVgdLIVtd/YOVjcSNTXHV3EwjwncDQBAuGcduKq1uDaxyrjDqR7T6jLKmmRcM59M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UDVJCnMe; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UDVJCnMe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779315816;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RfirkbM5TmZ61fE0cxqW40X8dDTC2oX5xU5kp1FvlUs=;
	b=UDVJCnMeqL9Y804VfU1aS1nPg5k86wTtG5afXRosp90JyOiM6lAMhXNUJSrTRZkUr3AXmn
	fpZTF+fSvHggmZ9x2N4/77gHpm4tCl4Ye9tjvoGmcD6OCLMHFWSSg2uy0Zrv7NMzTqheW1
	Qh8jgka2cC0UZsbzqs7e3lgtr2L8CcE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-490-DowNIknfO1Ok1YKTPNetMA-1; Wed, 20 May 2026 18:23:34 -0400
X-MC-Unique: DowNIknfO1Ok1YKTPNetMA-1
X-Mimecast-MFC-AGG-ID: DowNIknfO1Ok1YKTPNetMA_1779315813
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-45e81291d62so3753638f8f.1
        for <virtualization@lists.linux.dev>; Wed, 20 May 2026 15:23:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779315813; x=1779920613;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RfirkbM5TmZ61fE0cxqW40X8dDTC2oX5xU5kp1FvlUs=;
        b=pGlMOpkeCT4VrBAqnAg6MKIpxHjp2G3Q/8t3NB4RC2G62YKVmY7AHK4dGF7UC1hPu8
         uRsjETUwXMbj9nZAXaOmdWXHKz55syG8QW3f9uUf72RDCJLUiU1b+fGZXlXob6kav+7S
         j88H/qf9BmTnoOXSx6gCHB6DWzUbYroFJiVUvdXGwjytMpgQX4T5NhmgdNV9NNLKUqPU
         qhmk05w/l7ESqi8D7SyJ4tHpioQ1ngEY0mNFJIO/YmSSkI2cZAGoACbwAQcaXrLRPW+2
         X+7c+0vQY+Wvuy5R2sCUWdNCy70yQffXSo1fk/JlobaawNywHdZYvspWFhtQTlKlSNip
         6euA==
X-Forwarded-Encrypted: i=1; AFNElJ+AU/bh5XAxO+TJMWtjV6r90/ufGuucNec36NCjsASNhE4iqf28UnYswILXlvP+YIjFJamiuyty6iVeqS4tIA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzmgvAhMRiPZzylMLK+lT3s7oKY8UW1thSY0A94EKecN88LocP3
	0TZ5Rr8j8uQ/oWA6hosMOC0haiVqTj8vAVRgd6uKyfOrqcghjisVPCr5s91XKgCPWdwv2ch4WCJ
	/iGGTxdq4eNA6nshFSC0tXjlqYBylNZgWM2Bu6dkuRbEgS6NC/hzi/FFYsSHn1pcxq540
X-Gm-Gg: Acq92OHsaXnbqIUnEK3gMK0YUJlctvJtOWKPD8C2f1rW9dwB6ZM00UlNk/PRoG3gTx+
	11qBgGLHg1f2ZEqkXc5zM8MerWLZLTQJ7FXrx0lrbw60xMbUgkW1cEo2Fd3GMbN27tDwV8eq15W
	Vnknm6nIVe8AYmzicABKBPVw6gO1dgsmpnQlRPP18dpQv0XffVHAWR1xUzxhLGxEIpkedvIBnpp
	NK2+RB6VfRE3oxvYSJmBVUzMuAkAndsxeOE3Q2nlKYjscs7OO6RL6FfrX6TYtQ6WgDEZLkzmHFc
	r+q8PMKKk/65G1WeOhmhwsiHNjsSWLLBpeLJ8xTh28n1qy+K9VfVunJKOsDZArmSVz8wgBAzkhx
	90S1WLlYdMztYZlfmaXDqXYbgs0SNP2t/QKgNfxXMCrc=
X-Received: by 2002:a05:600c:848d:b0:48e:635a:18d7 with SMTP id 5b1f17b1804b1-49035fbaad0mr3144645e9.0.1779315813437;
        Wed, 20 May 2026 15:23:33 -0700 (PDT)
X-Received: by 2002:a05:600c:848d:b0:48e:635a:18d7 with SMTP id 5b1f17b1804b1-49035fbaad0mr3144455e9.0.1779315812865;
        Wed, 20 May 2026 15:23:32 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-25-45.inter.net.il. [80.230.25.45])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49033d8e24bsm20927915e9.10.2026.05.20.15.23.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 15:23:32 -0700 (PDT)
Date: Wed, 20 May 2026 18:23:27 -0400
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
	Andrea Arcangeli <aarcange@redhat.com>,
	Qi Zheng <qi.zheng@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Youngjun Park <youngjun.park@lge.com>
Subject: [PATCH v8 35/37] mm: add put_page_zeroed and folio_put_zeroed
Message-ID: <db4fe54453847ef5cd8ab45668edf5039c72881e.1779315441.git.mst@redhat.com>
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
X-Mimecast-MFC-PROC-ID: PrjCbJTSLrkwioyvuXm8I5COcvoSSWzrnjziCMZ9dR8_1779315813
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Add put_page_zeroed() / folio_put_zeroed() for callers that hold
a reference to a page known to be zeroed.

If this drops the last reference, the zeroed hint is
propagated to the buddy allocator.  If someone else still holds a
reference, the hint is simply lost - this is best-effort.

This is useful for balloon drivers during deflation: the host
has already zeroed the pages, and the balloon is typically the
sole owner.  But if the page happens to be shared, silently
dropping the hint is safe and avoids the need for callers to
check the refcount.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Assisted-by: Claude:claude-opus-4-6
---
 include/linux/mm.h | 13 +++++++++++++
 mm/swap.c          | 20 ++++++++++++++++++--
 2 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index d1e768dcda13..86638ffaad01 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1913,6 +1913,7 @@ static inline struct folio *virt_to_folio(const void *x)
 }
 
 void __folio_put(struct folio *folio);
+void __folio_put_zeroed(struct folio *folio);
 
 void split_page(struct page *page, unsigned int order);
 void folio_copy(struct folio *dst, struct folio *src);
@@ -2090,6 +2091,18 @@ static inline void folio_put(struct folio *folio)
 		__folio_put(folio);
 }
 
+/* Caller must be sole owner to guarantee page is still zero */
+static inline void folio_put_zeroed(struct folio *folio)
+{
+	if (folio_put_testzero(folio))
+		__folio_put_zeroed(folio);
+}
+
+static inline void put_page_zeroed(struct page *page)
+{
+	folio_put_zeroed(page_folio(page));
+}
+
 /**
  * folio_put_refs - Reduce the reference count on a folio.
  * @folio: The folio.
diff --git a/mm/swap.c b/mm/swap.c
index 5cc44f0de987..ecec780172ad 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -94,13 +94,15 @@ static void page_cache_release(struct folio *folio)
 		lruvec_unlock_irqrestore(lruvec, flags);
 }
 
-void __folio_put(struct folio *folio)
+static void ___folio_put(struct folio *folio, bool zeroed)
 {
+	/* zeroed hint ignored for now, no current user */
 	if (unlikely(folio_is_zone_device(folio))) {
 		free_zone_device_folio(folio);
 		return;
 	}
 
+	/* zeroed hint ignored for now, no current user */
 	if (folio_test_hugetlb(folio)) {
 		free_huge_folio(folio);
 		return;
@@ -109,10 +111,24 @@ void __folio_put(struct folio *folio)
 	page_cache_release(folio);
 	folio_unqueue_deferred_split(folio);
 	mem_cgroup_uncharge(folio);
-	free_frozen_pages(&folio->page, folio_order(folio));
+	if (zeroed)
+		free_frozen_pages_zeroed(&folio->page, folio_order(folio));
+	else
+		free_frozen_pages(&folio->page, folio_order(folio));
+}
+
+void __folio_put(struct folio *folio)
+{
+	___folio_put(folio, false);
 }
 EXPORT_SYMBOL(__folio_put);
 
+void __folio_put_zeroed(struct folio *folio)
+{
+	___folio_put(folio, true);
+}
+EXPORT_SYMBOL(__folio_put_zeroed);
+
 typedef void (*move_fn_t)(struct lruvec *lruvec, struct folio *folio);
 
 static void lru_add(struct lruvec *lruvec, struct folio *folio)
-- 
MST

