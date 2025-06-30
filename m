Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 957E92BFC60
	for <virtualization@lists.linux.dev>; Mon, 30 Jun 2025 13:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751288509; cv=none; b=sgGTJJNxw3ViBI3OpdTPRSahR6vpM3mNfwzvmosuuLvljMPzrv35r9EaNkrvqV0HJwmnB8Y/0zgna9VHm5aHzvKX7Hjd5cy51SuniISuUUAkgZDJoHMxipSNpVwUhihXGMCckc6NWk9bKhJXbBkkYlyNJU8/usXkaTHdMN8IXcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751288509; c=relaxed/simple;
	bh=VLtr/75+OgLg5UKJqAhr4SPpTHq3QNsAl+8ocPk3Nhw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=iL0r9tanUFnJ/g1+kAwCJGf8u+Jx7KuuNAkn0XHF7/DdfXTfqcXLs1V/w6i5fqGqrOXtxt+SKWIk8s9m9funIk8Uag2qit6FVKtd9Jk+AoM+H+a+pM/9Nv46++zLAK1Pcwp9uiuW/WCWQt5bFQPHOvQFNxLGnUHW0g4J+P8eqcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BI/V/2BH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BI/V/2BH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751288506;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cBlqU3v31THD5gXpB9nn15wD9nofG3PBMtxlPOPDIeI=;
	b=BI/V/2BHr4wuS7mT8BgRkrh/x4dCYVkiTG8ShP6vilIV4gJjse9aKV64LXNkJvApGeF13Y
	Y+QKgp0WBKN8SPVGet21y9KVboqcHba52deNgp0r4v4D+6QBVzKD+BqlHQANYDzeBMoOMe
	j+7ef//OISWYpQjsUQdhbLOwQEE30OA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-320--EBpXks9MQK_oFhMCLYcRQ-1; Mon, 30 Jun 2025 09:01:43 -0400
X-MC-Unique: -EBpXks9MQK_oFhMCLYcRQ-1
X-Mimecast-MFC-AGG-ID: -EBpXks9MQK_oFhMCLYcRQ_1751288502
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-450db029f2aso19629455e9.3
        for <virtualization@lists.linux.dev>; Mon, 30 Jun 2025 06:01:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751288502; x=1751893302;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cBlqU3v31THD5gXpB9nn15wD9nofG3PBMtxlPOPDIeI=;
        b=DfYiIpxT+JOMDWrk1aE84frulvkSoh7gtGjkMc0aAqLY3WKu/lo0UHVo0uHQRLTWaa
         glNE2TlcayPVG/fKdi+OFVDlG6kDxfhZ8/GJpkydiVeyhoK5yjsGeaLrmhXO6sGLgv5N
         ojHr33tm9975RGswvW34wjvdNQXNkgYRmoBPjjI5ysh86HiMCKeHA6NVbXWspYTuje46
         4MKWxs6VrTNvftbkUfIVqgMzouG5+kK73Gm8StcpPjhl/pftAdp0H2ZLGCLlIaFABlNS
         Ak9dadOzwjldW4HqOOtIZFYAlnAWGLnJO/xrBs1KdnfyqS/5PWNQe34T6pruwaTIbblX
         02UQ==
X-Forwarded-Encrypted: i=1; AJvYcCXOjcfOco2UGMuFmbJGB5Sk5nIg8N8HzUOu5xTp7MV+HCiTReO/uxvIdqfY4hAqG1IFrxgWCoSC8JU8+yPdmw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxmwgWIEQ6Gr/0chbYnbs65HWsqawsNhaXdASOhwiNBHaIJ4nZz
	Os7Og3sd9r9KkJIumk/NTU2vaRRcBh4bYdf8lDN2plCrlFaq4lagfeki/3XU6xCPz+CxOSY7fYF
	RdLWPY9pO685NOxnkMZmlPpmeM8lCBCdVmcE2yoc9VhGtNnDmNV0ENk8sjvAEDGQwayu/
X-Gm-Gg: ASbGncvE5pt+cT62ZUVNk8/KYMCvi4O7xyy/SL+oI5mvSbEPA/7XrByvv+SpgDA4XIr
	g7kbSt7oybbjjDVsJXn68QdyfXU/oZaJGAA++jC4ntRUN5z/KRZ6iSSoNjQHsH81r78jEl+7RpZ
	PsMVS7Pf1IsHFXohG8f8iE52Pxb2P/52xMp0KhJbllvvoV3jQA9rT2PalJrg3dOvgww2k4QMlyB
	x+GzfH0sIZWXf3lLD1ujpezNjWYISSYuOw82KomjwB4MZl4WTv3sV+Tsu20ARWd7gQXCSvGo1CY
	ofCGjUFmL/bYQZFQYNscukSnmawuknWUJ+vjjtx2979D3ZU5zmsKtqVogpvEqqzFex9xVtxX4c3
	1TRQBkBI=
X-Received: by 2002:adf:9c85:0:b0:3a4:f90c:31e3 with SMTP id ffacd0b85a97d-3a8ffcca245mr9545897f8f.31.1751288501862;
        Mon, 30 Jun 2025 06:01:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEmBHmttdmK2eq+WBU1B9I2DDaPMLfI/76nbXYnXDHgExr/7iQPmKv6fPJxJBiz140zN+RyvQ==
X-Received: by 2002:adf:9c85:0:b0:3a4:f90c:31e3 with SMTP id ffacd0b85a97d-3a8ffcca245mr9545827f8f.31.1751288501169;
        Mon, 30 Jun 2025 06:01:41 -0700 (PDT)
Received: from localhost (p200300d82f40b30053f7d260aff47256.dip0.t-ipconnect.de. [2003:d8:2f40:b300:53f7:d260:aff4:7256])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3a892e5f943sm10337130f8f.101.2025.06.30.06.01.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jun 2025 06:01:40 -0700 (PDT)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	virtualization@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Jerrin Shaji George <jerrin.shaji-george@broadcom.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Zi Yan <ziy@nvidia.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>,
	Rakie Kim <rakie.kim@sk.com>,
	Byungchul Park <byungchul@sk.com>,
	Gregory Price <gourry@gourry.net>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Alistair Popple <apopple@nvidia.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Minchan Kim <minchan@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Brendan Jackman <jackmanb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	John Hubbard <jhubbard@nvidia.com>,
	Peter Xu <peterx@redhat.com>,
	Xu Xin <xu.xin16@zte.com.cn>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>,
	Oscar Salvador <osalvador@suse.de>,
	Rik van Riel <riel@surriel.com>,
	Harry Yoo <harry.yoo@oracle.com>,
	Qi Zheng <zhengqi.arch@bytedance.com>,
	Shakeel Butt <shakeel.butt@linux.dev>
Subject: [PATCH v1 29/29] mm/balloon_compaction: provide single balloon_page_insert() and balloon_mapping_gfp_mask()
Date: Mon, 30 Jun 2025 15:00:10 +0200
Message-ID: <20250630130011.330477-30-david@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250630130011.330477-1-david@redhat.com>
References: <20250630130011.330477-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: MhJxZY8ZTPOCv01pA7MfROuqIXx8GqEmnpO3TXcc4fA_1751288502
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Let's just special-case based on IS_ENABLED(CONFIG_BALLOON_COMPACTION
like we did for balloon_page_finalize().

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/balloon_compaction.h | 42 +++++++++++-------------------
 1 file changed, 15 insertions(+), 27 deletions(-)

diff --git a/include/linux/balloon_compaction.h b/include/linux/balloon_compaction.h
index 2fecfead91d26..7cfe48769239e 100644
--- a/include/linux/balloon_compaction.h
+++ b/include/linux/balloon_compaction.h
@@ -77,6 +77,15 @@ static inline void balloon_devinfo_init(struct balloon_dev_info *balloon)
 
 #ifdef CONFIG_BALLOON_COMPACTION
 extern const struct movable_operations balloon_mops;
+/*
+ * balloon_page_device - get the b_dev_info descriptor for the balloon device
+ *			 that enqueues the given page.
+ */
+static inline struct balloon_dev_info *balloon_page_device(struct page *page)
+{
+	return (struct balloon_dev_info *)page_private(page);
+}
+#endif /* CONFIG_BALLOON_COMPACTION */
 
 /*
  * balloon_page_insert - insert a page into the balloon's page list and make
@@ -91,41 +100,20 @@ static inline void balloon_page_insert(struct balloon_dev_info *balloon,
 				       struct page *page)
 {
 	__SetPageOffline(page);
-	SetPageMovableOps(page);
-	set_page_private(page, (unsigned long)balloon);
-	list_add(&page->lru, &balloon->pages);
-}
-
-/*
- * balloon_page_device - get the b_dev_info descriptor for the balloon device
- *			 that enqueues the given page.
- */
-static inline struct balloon_dev_info *balloon_page_device(struct page *page)
-{
-	return (struct balloon_dev_info *)page_private(page);
-}
-
-static inline gfp_t balloon_mapping_gfp_mask(void)
-{
-	return GFP_HIGHUSER_MOVABLE;
-}
-
-#else /* !CONFIG_BALLOON_COMPACTION */
-
-static inline void balloon_page_insert(struct balloon_dev_info *balloon,
-				       struct page *page)
-{
-	__SetPageOffline(page);
+	if (IS_ENABLED(CONFIG_BALLOON_COMPACTION)) {
+		SetPageMovableOps(page);
+		set_page_private(page, (unsigned long)balloon);
+	}
 	list_add(&page->lru, &balloon->pages);
 }
 
 static inline gfp_t balloon_mapping_gfp_mask(void)
 {
+	if (IS_ENABLED(CONFIG_BALLOON_COMPACTION))
+		return GFP_HIGHUSER_MOVABLE;
 	return GFP_HIGHUSER;
 }
 
-#endif /* CONFIG_BALLOON_COMPACTION */
-
 /*
  * balloon_page_finalize - prepare a balloon page that was removed from the
  *			   balloon list for release to the page allocator
-- 
2.49.0

