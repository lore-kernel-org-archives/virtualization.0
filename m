Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39AD83C456D
	for <virtualization@lists.linux.dev>; Mon, 11 May 2026 09:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778490270; cv=none; b=H0Cf4IHsX5hNDooJ0udJ9KY3CtA5oQEyDauW9wzFJ2hOrjfdyw1wICvG7UVqXMqDRWZ77seK9GXRwh6puxCeFGI7h60/B/LxSKGPVcF8KbopF6ziYpq4osnTF4I9aVai3yTHmawvm95JmiITvITanRU9iDKT4Zv5b+oQL5OXxxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778490270; c=relaxed/simple;
	bh=FzG8+92oH2mwvb1TgGky3Bd7ojioTSewgWR4luIpYTY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=qMM9bojjrbcaKj/0BqZLHaoa/8J3i07orKhuX5712FE3z21QiiFvZzDWdcYMkx1WMgw+gPfsClvkGCyTLR0TWWULteFjvnZKzG1Fwb82WTrEKxBk/fDSW3rUZWBsWKNxaJt8udL2tWHVauZIqzIobgJdaHgIeOdppOShQdODP/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CFWVFP3t; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CFWVFP3t"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778490268;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gBKqj2O9gjX/tz0GTabH1SzaDOD5jZb/zvIFduhmeuI=;
	b=CFWVFP3tyW9yOLtjMOVVGqHAJ4QWm1faDpPalLjrhSuj5bNE3NHvX21c1BgnyRhrBBaSIQ
	Mnydn8aq8PR0njph8MKb0a4sl/l/U7rSCKnGvAJ6s5hNfqNd0ELk46E4tJq9PPQthytXPb
	Sc4f9q3+A5rdjz4ebtwQarIEB0gEGkQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-86-ZTGj2impOdKtyW7fKBY7-A-1; Mon, 11 May 2026 05:04:27 -0400
X-MC-Unique: ZTGj2impOdKtyW7fKBY7-A-1
X-Mimecast-MFC-AGG-ID: ZTGj2impOdKtyW7fKBY7-A_1778490266
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-48e5df296aeso25008695e9.1
        for <virtualization@lists.linux.dev>; Mon, 11 May 2026 02:04:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778490266; x=1779095066;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gBKqj2O9gjX/tz0GTabH1SzaDOD5jZb/zvIFduhmeuI=;
        b=mOtORS8QYkX/uXWfAJFYLg3J19ZMCKJyKBe6jG6GaZsf1Zjk+7UG4CBIrsMC+8L+4L
         5T0x7z2CfDzff08HNbBN0P89e3JiX7+nSMx5VB01Z7AlN5s1uX8Q9JhPmzqNCtT5fSSP
         ixV9vyTmVk37ryrG8QlKhmwdgITUNhICG7tlacEece/m53uDoliOE/jK6+gY3eGEgXtm
         viHIS7u0TjzBqQfJY1Hjl0gvmuK11U1DzLTeH/hdzgPIMZxdNvFDAI/b1Y2rIJC0kvRO
         m3KS3zbSkq3Wbjxdl9mF5V/SwOVsh2ycxogKp5XuOn2npXLiubo4Rjdxyuod6pwDCZ5E
         n8tQ==
X-Forwarded-Encrypted: i=1; AFNElJ+PW/ocAm18tiS2vhJUaCFzYDeU/1jfs29sISQRRO78au/qpWE/QrVnJsepT04bGeJaBXkPJ9PD2Xx9RLkRAw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwJtzVh49wEhw7qCY3flQUYU+i+GkLqvET4TEs03o/BT1/BEk5s
	vMlxFDlKXvVwjlDdMaO6CvyrM+qeXWjBtcbS/TzU+N/BDZAjNEJlg7POUVZDExV/ZO9CtFqB7bv
	rkJf2cJOJ95f2Ex0dP5vI7+XweOb94cjBB6pq4OznjGGzjynlSFoMwnmfmtPoyBfOSX6z
X-Gm-Gg: Acq92OFcvQxQ/pjB5sWxElQbH9mOe7ogMABov9XQrCiheJOE0c6XDAwzEdkCitdOwfg
	EikvPojwgqbscSlaW/kPAs0W3Xq34dmIvo9o+VxaegpUOiWjFJjgTRRDHLBK8TjXzQKmJO2QH5t
	59w4EDHfkz+Xhqp7nlTF8kw+XCWurJS9G9HPVV79G140TaayZqxsdq5heuYTCbvx3f63ctldKr7
	LjuYIG6hv5a/L/LeDtXsfEYfXcVFZ4LjS5y7MtujmO/dWbQDIl3ZUHuxKfb1a8XR0HMyZioeeV7
	kCq1U3+fEjlkPMht06xLWfdw8uKk6ijNvZq8bks6lwizHQCJD452GwvXX6PS+K7aTbgjD6m/Qbm
	/o03XXxLUwgfgTWboR94vDY/e0hrtzFwWOMBntRqI
X-Received: by 2002:a05:600c:3b8f:b0:48a:79d8:a8d6 with SMTP id 5b1f17b1804b1-48e642deefamr226935065e9.7.1778490265515;
        Mon, 11 May 2026 02:04:25 -0700 (PDT)
X-Received: by 2002:a05:600c:3b8f:b0:48a:79d8:a8d6 with SMTP id 5b1f17b1804b1-48e642deefamr226934275e9.7.1778490264756;
        Mon, 11 May 2026 02:04:24 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-48-7.inter.net.il. [80.230.48.7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e80ca2666sm91672175e9.10.2026.05.11.02.04.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 02:04:24 -0700 (PDT)
Date: Mon, 11 May 2026 05:04:19 -0400
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
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
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
	"Liam R. Howlett" <liam@infradead.org>,
	Youngjun Park <youngjun.park@lge.com>,
	Qi Zheng <qi.zheng@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>
Subject: [PATCH resend v6 28/30] mm: add put_page_zeroed and folio_put_zeroed
Message-ID: <450465e4a03e63381a4bb8a1799a25859d7fdd83.1778489843.git.mst@redhat.com>
References: <cover.1778489843.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <cover.1778489843.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Q0aQtK08kZGOoXKQx8PNMS-Ynv3FZDovznLtc6VwfnY_1778490266
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Add put_page_zeroed() / folio_put_zeroed() for callers that hold
a reference to a page known to be zeroed.

If this drops the last reference, the page goes through
__folio_put_zeroed() which calls free_frozen_pages_zeroed() so
the zeroed hint is preserved.  If someone else still holds a
reference, the hint is simply lost - this is best-effort.

This is useful for balloon drivers during deflation: the host
has already zeroed the pages, and the balloon is typically the
sole owner.  But if the page happens to be shared, silently
dropping the hint is safe and avoids the need for callers to
check the refcount.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Assisted-by: Claude:claude-opus-4-6
---
 include/linux/mm.h | 12 ++++++++++++
 mm/swap.c          | 18 ++++++++++++++++--
 2 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 3b1ca90fd435..4c51b7bd7576 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1913,6 +1913,7 @@ static inline struct folio *virt_to_folio(const void *x)
 }
 
 void __folio_put(struct folio *folio);
+void __folio_put_zeroed(struct folio *folio);
 
 void split_page(struct page *page, unsigned int order);
 void folio_copy(struct folio *dst, struct folio *src);
@@ -2090,6 +2091,17 @@ static inline void folio_put(struct folio *folio)
 		__folio_put(folio);
 }
 
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
index 5cc44f0de987..8d57223dfe34 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -94,7 +94,7 @@ static void page_cache_release(struct folio *folio)
 		lruvec_unlock_irqrestore(lruvec, flags);
 }
 
-void __folio_put(struct folio *folio)
+static void ___folio_put(struct folio *folio, bool zeroed)
 {
 	if (unlikely(folio_is_zone_device(folio))) {
 		free_zone_device_folio(folio);
@@ -109,10 +109,24 @@ void __folio_put(struct folio *folio)
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

