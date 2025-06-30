Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B308128DB52
	for <virtualization@lists.linux.dev>; Mon, 30 Jun 2025 13:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751288465; cv=none; b=rgb53IN9LBqa8jwe+183ki4pVz4s3qekM9Tn7C0b29rh6f9R7+rvF7pEGVX+E8vQMQDcJRygbry4LzJQUFhhC2QQuXXkp0lg3TTVdiHOs3SCkQJqQ4VqH8QQZ0A5/BEd2Di+WCYS/c4GNA5aY84jgWRxnHbK3kjVTFAZQ2uWzOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751288465; c=relaxed/simple;
	bh=UHifpKu5ufl8QF9rCxhzhbIhhsXhSiIoRV9644qN9BA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=dyVZDBar55SqO0A+7X/cDfFV8Gh6OCgPw39MZBz/GObeE4VBwvW/sSY6qdA1jIFcHhAf58Qkj2LxasU/8N3p9DLSoaz4xS9DCnAFpO4DMotv9UmHsutRwbpOna2lLOqNwFA9kCwbcGUW5RCkBtir6O2tzCzPBrDxfjBccHZw3Yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZvkMsU6K; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZvkMsU6K"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751288459;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JRChIqxUOgPOieQj0YeNNw03RDlWoIXMOrbpFO40kH0=;
	b=ZvkMsU6K524KeVogJDbNPGVCPcLdUXAM8U1Ijt28S7FxiecWlp71ZPWHL0abNODJ+9kj1k
	6gfNKwi6Kwpx3hnTwvuiI7MjHds87gBauOF6EQ1SVXDfRpTjfhZbvMjzrfNNAdLPOah5Xq
	V9k30GrmYVLCJTizjjc222Q8nfoBecg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-353-Ii4wtHjwOa2A_T2LDYxOeA-1; Mon, 30 Jun 2025 09:00:56 -0400
X-MC-Unique: Ii4wtHjwOa2A_T2LDYxOeA-1
X-Mimecast-MFC-AGG-ID: Ii4wtHjwOa2A_T2LDYxOeA_1751288455
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4530c186394so9156695e9.0
        for <virtualization@lists.linux.dev>; Mon, 30 Jun 2025 06:00:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751288455; x=1751893255;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JRChIqxUOgPOieQj0YeNNw03RDlWoIXMOrbpFO40kH0=;
        b=Y25eSS2hk87kgy//hzZ6IqqqjjsgbYdvVInKTe/GC7amla0iT/rn+DA2idmF8FrQSM
         oXU+fU1hS562cEWD1KaKTTaMa6H7XYjJ6XGjuLiZPXv1a4UqOA4WbL74ujlFzLe/py4i
         rmfCWbgUTEzjCT8dNhOCk/Ah9fzHIJRxP6Q2rszncVjRpT7CBjSh/GSTUJtB17/zUEzk
         hsBhashNBavG0HNAWKiuI8DWCKtGwFvJ8wir5G89alAFjPUr+uX8HNsaFtme2anYKDQF
         /pYhZz0nPKCaY5GJsjHyl2MYg01+RhDQUxvoIQcaLUaWzELN59Ft8agPUodTxwC+S3pW
         20rA==
X-Forwarded-Encrypted: i=1; AJvYcCUmGQ3Dkn2gBFM4WA8wm0JMXF9oT53zplcz+ZWTSGozAmgPUsaaN/5ChxA4dV/EiZTqSihRiD3c2XE8lax1rQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzWQNVSpyLdfukViB6oWrf7FYa1VzsEAhiZnpxGi4hy75MLkqYS
	CAdNWb6HyZtutjGv8XnDZfWJ7DvaXhdT611nmyrZXoWaU3Dy2H3Z+IavR1KI0E4nQEOLBxkrugN
	oLiZHHV3xtuBDeVzo9IW3bc/r+xUT4IWveGcgjDqJ2dUYZ1D2umt4mvWTHrE7acdBN8cD
X-Gm-Gg: ASbGncsmsBWQ7vTEmT6pez15aE3EVOZLmaFRPF+79A45Km1Qpb/gkNACNgkkwTcUJfT
	sUTqZo62aqr+HqFhky7BileSzKZuEQ4tqIhtdMorskEKmRX72Px4VR3kDVzpYboyL6/B4zAxcRm
	3kDPdPYX1e7ZtGI4XsDJ4chMisonqIXVy6yylH7Da3jFZgQIRI5Oix+bOjqWh68sm4u/0GhERkO
	Z1kavozk7Yv3U1ouEyjAPQEVEND6mCivcz2Wety0YFbBNlej5NO8hGL5bqXgpHYLPmJ+YmI9bIU
	z8mQ04EfXA0X17AgZFhTpDfhi3pbnG2t06CYaLme1WCsU4QvijZVYtEL2tVG3N+JAb6oJ5//sB6
	bH+rWfD8=
X-Received: by 2002:a05:600c:3b8e:b0:43c:f513:9591 with SMTP id 5b1f17b1804b1-453913c5a63mr120798415e9.14.1751288454061;
        Mon, 30 Jun 2025 06:00:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHZHtsc7XNjhOjxkvKCZ2uHLxZSkMRI4G1PqHHBjrp6rzXGUbjSQmg1iO1pCKPy78A7k9Rgqw==
X-Received: by 2002:a05:600c:3b8e:b0:43c:f513:9591 with SMTP id 5b1f17b1804b1-453913c5a63mr120797265e9.14.1751288453316;
        Mon, 30 Jun 2025 06:00:53 -0700 (PDT)
Received: from localhost (p200300d82f40b30053f7d260aff47256.dip0.t-ipconnect.de. [2003:d8:2f40:b300:53f7:d260:aff4:7256])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3a892e59ab5sm10144896f8f.82.2025.06.30.06.00.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jun 2025 06:00:52 -0700 (PDT)
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
Subject: [PATCH v1 14/29] mm/migrate: remove __ClearPageMovable()
Date: Mon, 30 Jun 2025 14:59:55 +0200
Message-ID: <20250630130011.330477-15-david@redhat.com>
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
X-Mimecast-MFC-PROC-ID: 9-yk00Oq22B8d6Co8bPRGex4NuaOmggtmEihY37D-Vw_1751288455
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Unused, let's remove it.

The Chinese docs in Documentation/translations/zh_CN/mm/page_migration.rst
still mention it, but that whole docs is destined to get outdated and
updated by somebody that actually speaks that language.

Reviewed-by: Zi Yan <ziy@nvidia.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/migrate.h |  8 ++------
 mm/compaction.c         | 11 -----------
 2 files changed, 2 insertions(+), 17 deletions(-)

diff --git a/include/linux/migrate.h b/include/linux/migrate.h
index c99a00d4ca27d..6eeda8eb1e0d8 100644
--- a/include/linux/migrate.h
+++ b/include/linux/migrate.h
@@ -35,8 +35,8 @@ struct migration_target_control;
  * @src page.  The driver should copy the contents of the
  * @src page to the @dst page and set up the fields of @dst page.
  * Both pages are locked.
- * If page migration is successful, the driver should call
- * __ClearPageMovable(@src) and return MIGRATEPAGE_SUCCESS.
+ * If page migration is successful, the driver should
+ * return MIGRATEPAGE_SUCCESS.
  * If the driver cannot migrate the page at the moment, it can return
  * -EAGAIN.  The VM interprets this as a temporary migration failure and
  * will retry it later.  Any other error value is a permanent migration
@@ -106,16 +106,12 @@ static inline int migrate_huge_page_move_mapping(struct address_space *mapping,
 #ifdef CONFIG_COMPACTION
 bool PageMovable(struct page *page);
 void __SetPageMovable(struct page *page, const struct movable_operations *ops);
-void __ClearPageMovable(struct page *page);
 #else
 static inline bool PageMovable(struct page *page) { return false; }
 static inline void __SetPageMovable(struct page *page,
 		const struct movable_operations *ops)
 {
 }
-static inline void __ClearPageMovable(struct page *page)
-{
-}
 #endif
 
 static inline
diff --git a/mm/compaction.c b/mm/compaction.c
index 17455c5a4be05..889ec696ba96a 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -137,17 +137,6 @@ void __SetPageMovable(struct page *page, const struct movable_operations *mops)
 }
 EXPORT_SYMBOL(__SetPageMovable);
 
-void __ClearPageMovable(struct page *page)
-{
-	VM_BUG_ON_PAGE(!PageMovable(page), page);
-	/*
-	 * This page still has the type of a movable page, but it's
-	 * actually not movable any more.
-	 */
-	page->mapping = (void *)PAGE_MAPPING_MOVABLE;
-}
-EXPORT_SYMBOL(__ClearPageMovable);
-
 /* Do not skip compaction more than 64 times */
 #define COMPACT_MAX_DEFER_SHIFT 6
 
-- 
2.49.0

