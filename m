Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70C2F306107
	for <virtualization@lists.linux.dev>; Wed, 18 Jun 2025 17:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750268503; cv=none; b=WmK/6DoIDMMzoQW/DqMJMKWSoxN2JWzc8SVahcQZqHcblgVo/lG0E8y3r8yVczHX5Lix85y68SnFHx0ypAS49tIGZbjNEi4Ot12Pa26sZ0juhuy3jLpKkzLL6d8BL8nwwnXpcxJ707jKdPpxGm96WOcZduzuPOsn67PnhXL6qjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750268503; c=relaxed/simple;
	bh=VLtr/75+OgLg5UKJqAhr4SPpTHq3QNsAl+8ocPk3Nhw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=JaQ/BvnUK/BDQAoOrFktnjihRBwyeZiuSqt1MCb3VtUjcs8rn761QJr+8TgPfd9/zb27WcAUcxrsPmHwcGIHIx6YCNMaYtfyF9qQiYUxwcWKmowYhmjr+NVNGl4XblK1Hno90nuvxgPnW13pvupxLSPT1dWtD/Fsa5SUtpdKgcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ORQqGOTJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ORQqGOTJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750268500;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cBlqU3v31THD5gXpB9nn15wD9nofG3PBMtxlPOPDIeI=;
	b=ORQqGOTJcHS3YtHnoIs6b20qDNjnzwdED7T30fJoZqqyrzwAFvz4DmKzUH26CTL04yxHcA
	HSuNgJB6FFYdhRy02hOK2QzpJh7ILANb8KbdZ2bBH3xc8liq8xpsu7K6fIysZrwX7kjtrn
	zJ/8poY7UsESlEDwEYkb9mxT4wsbSIw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-vyCo9jAfP1auLd1BQiritA-1; Wed, 18 Jun 2025 13:41:37 -0400
X-MC-Unique: vyCo9jAfP1auLd1BQiritA-1
X-Mimecast-MFC-AGG-ID: vyCo9jAfP1auLd1BQiritA_1750268496
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-451d2037f1eso43922495e9.0
        for <virtualization@lists.linux.dev>; Wed, 18 Jun 2025 10:41:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750268496; x=1750873296;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cBlqU3v31THD5gXpB9nn15wD9nofG3PBMtxlPOPDIeI=;
        b=I0qGj2QFAOHZ956/f71LrQkx4rHY5trUWqPwPRUmbzbuwiAAQqMeqUdePNjBtkvrIf
         qK+pBHvkUlNU6zx6Heixb99zCDM00LLhRjtMJoheREwh4AyJQRpwMBgkM3u4GMA2IfBR
         bd2wWbZr5KoUWgTkFI7/665fG2Mqwp3GNrf1f33yKOFmbnUkMm+PMv9nVGfTSKXHQwmF
         5PvGJEDxxlZ+S0MKQDm4XIPMKr7An5MpLC0d41C0LRw4GDQtd9Gpc+o141vcebDDrcf4
         ig7NoBL3RO8hj7/UrD1yaIvOPKqidloGFHgIrrtbWzNyu4NKFvdFf+UpPIsF6y+NZXLE
         SSLg==
X-Forwarded-Encrypted: i=1; AJvYcCUVeUbVvg6alLmrjHdEKMbZ6yaoT1uUolVJXn4OtxFaNrBEhLa9+yPmCPhv5sms0rDQfPsFGJrR2UwBvPMOMQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy1yp8t9lR3QIeOsjw6flLIJeGR8zLr/kn4Sc984dzpw78qEf+6
	wFAdyz3BMpUo7XXon23bRY24laxcT3dyvO+Oz1GMxQeiko9KxbdvlPTrcvl4MUQmmzHTobTe8Nn
	Gan/gW+T3IRjryEw/g8yxhGw6QgdHy19+j1zq+8qEvJXU3tFZQ+iZwRfg/cyktaMlUHRT
X-Gm-Gg: ASbGnct9W5PVaXtro2V4yEIgLXH0G4ioKWqynDVXAkZbXKB644qaOB+fJPNQwnG+gXc
	7fKTPN5TtmKD5c1H83nm4ZMCEBJVGvsnxJJw0gp4z3nzAsst3hPZK1l+w8OIv5MgAFyQhpdkXM3
	JwIrIepD3bZXgQ9VBjR3yAaw29YFC42b5r+Dd8HX8MLki4FHV0loXfZBPCtdMIETfOEkDdNYNVg
	NO+T/YK/rbxfg7zfPDGKLsJKyBuH8l5pgIzCsT1QZztg0zLpmHwOXo9qcIo4uiU12tgZw9tHBCP
	2eWBRD4+6zS7PJiFtpsS3xvlvW1bOujXHGVJnNzSZVRa3NGxaUmpl5a6gr1n4C7h7VotMQfy3CV
	JU1P7Xg==
X-Received: by 2002:a05:600c:5253:b0:453:66f:b96e with SMTP id 5b1f17b1804b1-4534219a64fmr154424455e9.11.1750268496138;
        Wed, 18 Jun 2025 10:41:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFQJSoFqz4Qx4eaIpu3abT7lqqTMcn+cWB1r/wxQDnmsMcckQg5l2MzM3eBNzoSDxLAyECFAg==
X-Received: by 2002:a05:600c:5253:b0:453:66f:b96e with SMTP id 5b1f17b1804b1-4534219a64fmr154423805e9.11.1750268495716;
        Wed, 18 Jun 2025 10:41:35 -0700 (PDT)
Received: from localhost (p200300d82f2d2400405203b5fff94ed0.dip0.t-ipconnect.de. [2003:d8:2f2d:2400:4052:3b5:fff9:4ed0])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4535eac8edbsm3459385e9.24.2025.06.18.10.41.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jun 2025 10:41:35 -0700 (PDT)
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
Subject: [PATCH RFC 29/29] mm/balloon_compaction: provide single balloon_page_insert() and balloon_mapping_gfp_mask()
Date: Wed, 18 Jun 2025 19:40:12 +0200
Message-ID: <20250618174014.1168640-30-david@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250618174014.1168640-1-david@redhat.com>
References: <20250618174014.1168640-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 6iBK8pnET5hXILCwJ6pvmXKngwIerQOorRE_XdiT2Ek_1750268496
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

