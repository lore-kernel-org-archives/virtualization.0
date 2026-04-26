Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B4C2306B31
	for <virtualization@lists.linux.dev>; Sun, 26 Apr 2026 21:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777240125; cv=none; b=qhSMRPnTwsfGPaSpnuDgxQc/4k1hdXxvH3wMuAguMMW56Afw6ip9rLDdSkX70uVCq4Z8Gil0AWtGyrss69zsNb3fSpDXLeVC8Rd6NJtCZidobLjrcv3+YCuLW3Ur2tk1OlGWgxgfS9josBlpHvopgFRtd+s5y91UlyeDe7UsJYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777240125; c=relaxed/simple;
	bh=UOL/ZsOQuxZxCdyyXjZBk1f9WnmSmNTDh0iqg53ebK0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=M/oLTWB5N9/Do+dm0WCIrFhOXvsx3yZwqS0MgfymXDgzFC8N/SeEiKw9/CB+G4IPAK3DOW/3k1552d2k5QXOTzqDCOGzEQ/0owdUfTO075OoPlvXiw1ItL7ceqFOWzM4pOPZaRIkp7DhX3THJ4F7qakcevCare4KsKBHYSX/vws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iBiW016E; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iBiW016E"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777240122;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yr2uOCi7TxHPhFnCx38/iKRYLu7TO1I9ea6WeFSAtGo=;
	b=iBiW016EH7V5y92SngQo45ML3zj2VTBX6UW988jfbLxBB0F/j6Sn+wWtqkkVcx0chqzAD8
	6uJM45s9fQrheluQZnIt0JMtRtbjO1KewSHHQ/iC/wbeLgBjp2zvodIFsD0xfcEjeidJ35
	gyKSIuvdpNVbX3isb7YpD01/rtKbvnw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-351-bgoPsVQsPeu-TQ_ChqTxXA-1; Sun, 26 Apr 2026 17:48:41 -0400
X-MC-Unique: bgoPsVQsPeu-TQ_ChqTxXA-1
X-Mimecast-MFC-AGG-ID: bgoPsVQsPeu-TQ_ChqTxXA_1777240121
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-48a588ff84eso42424115e9.1
        for <virtualization@lists.linux.dev>; Sun, 26 Apr 2026 14:48:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777240120; x=1777844920;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yr2uOCi7TxHPhFnCx38/iKRYLu7TO1I9ea6WeFSAtGo=;
        b=ckbRzmKWqTE2yOwmwJ7ZWy1onXBxgCqnMT7jxG8ViRnRgMXUyrntMdojRGyxdbOZ/t
         VTYscstbSgp0lwEYvTn25/S66AWFhvCWSKx7fRZus9s1m7oPBiqKSdzQlC94aJiTyFB5
         JnDdXAMbD9ynZRJsnd0+N9aVYb/vJZiUeTDiogjo3GD24lf8SvOeRJJlz4WzkFMrlmBG
         T7fbMyhtmkvWBcRnIsvm+Rj/IKTWVtLyV/li3xRtmZNINmN8fh6gB8Itf19vGiMqYOhd
         As+19KK2lXxeY2qUf4zYrqXxzeJ9Oe5bVa0RVT03EE6eYRIWQx/MqNSrIVW41GBFmtVb
         cRqA==
X-Forwarded-Encrypted: i=1; AFNElJ8Oxz8UBuKTdajZ5JcIpB2N69WDVxAKrA0fS73HhCjYaFegWjxdFGHI0TZSYIR7hewtdwAacgvQrYR3K3Q9YA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyubPR80XqRoKF+6e1QWsnpKfbrvIEAD4Cj9YeBwNXCzodxVYxQ
	B0rjx3nPZY9RGvika3iFlIIr0H6wc7JwFw03CFzuAHwJU1+ZadzVdQ/HTyHsDHQoL4h9tR2ai3t
	kyJohGec+ys/dHzpFZCfpuzLqLSZU2pR43TLD+Wog2gnE3CGQSJF8W6VvssCzzkQj4m25iKAeHz
	xQ
X-Gm-Gg: AeBDievXsHxE+bglB146weR+5UHB6W5r2lrCJDk2/kMduWkwcpez2UERzsfOGLDMkfj
	dgOzizCU7EJVGWTc7hQ1GCiQ1YrObS9GL/BVNPf6tUqcqnDSkoukhgi82KIZzoIZXtctiigqdkX
	QECuB8PkZGkdlm9rmkjN6iRwU90qhSwIjO4sbnOxkIX792SSllYhFUmJay8g8/669I90JSPOVup
	PJT9Ncax0YhyMvyBZESR2LT5jQzn8DIkBfhSo45yzzjfvoSqszekf3l/zaLA1aviC1C6aQfup8I
	cb6rIBMN0AVzmklhq8TNuKDy3K2LX7VjiB7qlKTDCuB2C6NbvgMiFz0M1ZDGSJEUhbT0d+F5zaN
	vY4/N1UgrylbbN0Tsn4IR/wQpIy1hTxiCb1Jws2+Uc9aQI+OX0yeq9pdu
X-Received: by 2002:a05:600c:4746:b0:488:9439:881a with SMTP id 5b1f17b1804b1-488fb738412mr555456305e9.2.1777240120253;
        Sun, 26 Apr 2026 14:48:40 -0700 (PDT)
X-Received: by 2002:a05:600c:4746:b0:488:9439:881a with SMTP id 5b1f17b1804b1-488fb738412mr555455875e9.2.1777240119660;
        Sun, 26 Apr 2026 14:48:39 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-47-179.inter.net.il. [80.230.47.179])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fb7bf7besm270287995e9.34.2026.04.26.14.48.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2026 14:48:39 -0700 (PDT)
Date: Sun, 26 Apr 2026 17:48:36 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Brendan Jackman <jackmanb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Jason Wang <jasowang@redhat.com>,
	Andrea Arcangeli <aarcange@redhat.com>,
	Gregory Price <gourry@gourry.net>, linux-mm@kvack.org,
	virtualization@lists.linux.dev,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Mike Rapoport <rppt@kernel.org>, Chris Li <chrisl@kernel.org>,
	Kairui Song <kasong@tencent.com>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>,
	Barry Song <baohua@kernel.org>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>
Subject: [PATCH RFC v4 21/22] mm: add put_page_zeroed and folio_put_zeroed
Message-ID: <111219af35c4bb357e30cf1a77265fb63eecb21c.1777223007.git.mst@redhat.com>
References: <cover.1777223007.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <cover.1777223007.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: VCXPqv6wZA_cb5JcnITUTia0KnP9Dm4g5jSUqpi06aE_1777240121
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Add put_page_zeroed() / folio_put_zeroed() for callers that hold
a reference to a page known to be zeroed.

If this drops the last reference, the page goes through
__folio_put_zeroed() which calls free_frozen_pages_zeroed() so
the zeroed hint is preserved.  If someone else still holds a
reference, the hint is simply lost -- this is best-effort.

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
index 541d36e5e420..1c6bf82a967a 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1640,6 +1640,7 @@ static inline struct folio *virt_to_folio(const void *x)
 }
 
 void __folio_put(struct folio *folio);
+void __folio_put_zeroed(struct folio *folio);
 
 void split_page(struct page *page, unsigned int order);
 void folio_copy(struct folio *dst, struct folio *src);
@@ -1817,6 +1818,17 @@ static inline void folio_put(struct folio *folio)
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
index bb19ccbece46..5d05a463b46a 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -94,7 +94,7 @@ static void page_cache_release(struct folio *folio)
 		unlock_page_lruvec_irqrestore(lruvec, flags);
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

