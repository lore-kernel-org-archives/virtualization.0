Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D91313F7A83
	for <virtualization@lists.linux.dev>; Fri, 29 May 2026 15:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780068330; cv=none; b=bJtgmjtEC4C4pCaH/iYGgWUch65j8j8qOiCU98wIEWJo0HivcDD0rgJkynP5VMnx1Ss0RHwj+oTG5JUJRTn+0Oag+vbirRuSgnzdlnYrSNhHVZ6iTnAvrLGUoXIJx5WC30ik3pbM8CmdHbW12Mq1nbCukDk1/DzY/tmspP6KXNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780068330; c=relaxed/simple;
	bh=4jLzODooKNrRdgluzPWerRBde7vslo8ZvEbzyAfj6vs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=o/MFpk/pMhoYN0D/C5iFexlH662SS7SVf+2mx7qBvetn+3T4VINLjtRqLFJd3uvMiRLdOJfbi2eoqQ9lgb3DpUOTbmPSbsulsK+ocKtwxFIdaZ0YHYqjkF8oTusqGeOEKzWmxdytPoDWjw7voOelO91lNgWgwDAxTqR2hvRx+mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W5505X6z; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W5505X6z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780068327;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RfirkbM5TmZ61fE0cxqW40X8dDTC2oX5xU5kp1FvlUs=;
	b=W5505X6zwgfGQLPtKjvIjnYz0RXTf0Tth1m1ZU66pTROn41CzCqtkmZHFPdpNkyP/GpreA
	dIeEXIC+Pe0njiM5P8iLW/q3cTjPNdXdFr37CEiuzO66V0mznnJ7mzWONQdBXwS5Gbw7zq
	51wfFqEMZ4/pX3JNz/JUF1o2QB0nMWE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-690-oHtrzrjGNRePprOeYLNpiQ-1; Fri, 29 May 2026 11:25:26 -0400
X-MC-Unique: oHtrzrjGNRePprOeYLNpiQ-1
X-Mimecast-MFC-AGG-ID: oHtrzrjGNRePprOeYLNpiQ_1780068325
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-45ef6417092so186643f8f.2
        for <virtualization@lists.linux.dev>; Fri, 29 May 2026 08:25:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780068325; x=1780673125;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RfirkbM5TmZ61fE0cxqW40X8dDTC2oX5xU5kp1FvlUs=;
        b=T+mbmFV+M/IwNzTwEV7oJ51gRcs+xZESNhl+v2NNx9Vx7TGaiQxjGcyO91CH5BLkzl
         efnCGYpFrCKp5jLc2FxMceqxunvIQ4QwgeCekTZjV1H2xexgDGL1r4OeNg3ydbRx4pTi
         370hu7m83wZEXavuON2cGNk1YCMinVVbzCIYBj39jtLwwck89dP5CcgdSslA8x246NXm
         kB/8F2sNT3Ewdj/Hr070NkjfojfiHWlAzSupLJTdqY7B3erVNvPQi+ocHtY3umDo1ovp
         rPzoQOM+B3Sv6HDKnthP7XzrUYtJw9cYytR5a9JlSZuXy+82KvuWLmAWflKVS29i+Bf1
         KhlQ==
X-Forwarded-Encrypted: i=1; AFNElJ+bGTkMhr6qyg/WTrSNN+udZgR1p31RpeIDJJAxBDCFv44gEwNc7qKJ/PSKMQL/tvhPZyS5gaVSE2DwyOiFaw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyhXN4x31hUZYeKcHG0Krx6Kn9Es8cYGiGt8zZR3bYoFUCLmXba
	DZQCti7sSbb4rQ6VAf288vdmCkgP8W4R9eXPzibHv9w002MvhoAuHBgM7shn8jawQ5hRRBci3mf
	wyGgXZxDI7qgC19y9Dxr2GkFW26HmaaHmSqGSNJljP1/+g7E23pt1P6DDOSkOT71akdg2
X-Gm-Gg: Acq92OF3fYgN+CW1GKbvBPISuJTNUk1hRz9ffdQ6ih2cqYoeGX96dGxMoq2fmMRAY4H
	U9nmMzD4cYWBK6n8TqrL+pnv3yA0umAzpGSqH2nZlAKXlLa1d9EIEPxorrKRj9tPMYhvizxoMhm
	Bz+w2Lrem1wokeo/qSJmLZD+MzjEbd5DJX6kPiGWaP52GMDYWX4fIGrYa6GXHZzPF9t+XCErcA8
	DL9Zs5kHIsQJ56MFYpCOY8/9UOf7PdWjDHiAsjdXSghb5RaOEfhoQPXSfOGrpVTdnmLpJfxctt7
	FNt8bfM0Tyl1BavPire6kB1iDeMhiEr1fF87618vLpHghP4lw0pbh7duHj7YhpA/gv0sDCSgIe3
	hfmPSs5dxfR8x1/3oFV8b6GVVSLj2OELbcw9WMsEKj2OqZY0sjAfrsA==
X-Received: by 2002:a05:600c:450d:b0:490:778:4fe4 with SMTP id 5b1f17b1804b1-490a2952091mr1218365e9.26.1780068325300;
        Fri, 29 May 2026 08:25:25 -0700 (PDT)
X-Received: by 2002:a05:600c:450d:b0:490:778:4fe4 with SMTP id 5b1f17b1804b1-490a2952091mr1217355e9.26.1780068324663;
        Fri, 29 May 2026 08:25:24 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-25-45.inter.net.il. [80.230.25.45])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef34b7d6bsm4731601f8f.10.2026.05.29.08.25.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 08:25:24 -0700 (PDT)
Date: Fri, 29 May 2026 11:25:19 -0400
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
Subject: [PATCH v9 35/37] mm: add put_page_zeroed and folio_put_zeroed
Message-ID: <343a0d61f4b597791e3ebd16dffc5b91a0d733e0.1780067978.git.mst@redhat.com>
References: <cover.1780067977.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <cover.1780067977.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: AlBj-XN88JK94a4Umq8My8doOrpsuroPjUpXgw4fxyo_1780068325
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

