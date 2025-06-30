Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A2628C2B1
	for <virtualization@lists.linux.dev>; Mon, 30 Jun 2025 13:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751288445; cv=none; b=cTawshX4UbGjbEdS6VH7yl3TzwnSgUeHOXliXn/7osCOlghiI5fgwL6pmf9aMH0iYd3LgqiWvyzejxYWcXgJeaWNciGUOxTZ1ko6k6S6kflLEQ+tDyuxUvuknHLf/JGRIaMVCjJYLodXNjCsYQ7zIn/4AReapSZYt88R72m6W0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751288445; c=relaxed/simple;
	bh=QFR4ekfQkxloQewE0nsmyAbq1SFLKM7czL9sZhql/lw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=U08VHNQx7N90Dm+RJW/pLEhkh3WKSueYTNfc41csoeZlup6OGqLsMUNMYMFkNCh/rg7w4jHj2tus2x4gg22Fg8/NRwbvMTepmBWTWM789qdso7rKtZLPtYNwwWWkCbsImTrTe4Pjb6R6L+xrZmgGEf1qik1ftJrkQ4h5EVxeoBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z9ksBx4v; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z9ksBx4v"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751288443;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G4HyaliWLgvplqkgqKCCNJ5/P2ZKVlm1Wsjs2FxXnxE=;
	b=Z9ksBx4vLicA90+Am894f6dUYAAaEN/Qq4sI73FP5DQx5vCaU/j4vrqhs+wBED7nv+oyls
	iKjVNoaAHIz5FLX0Mu1wOAxb1x1dL9R47WldQkw5l6FxxJe5tV9/m7sGesfkUHQiXqKBaH
	RGobBHMYNNZbjsvezau8P/3JjyWKpXk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-pNKCzk-XN9CiYXDyjHJ9xQ-1; Mon, 30 Jun 2025 09:00:40 -0400
X-MC-Unique: pNKCzk-XN9CiYXDyjHJ9xQ-1
X-Mimecast-MFC-AGG-ID: pNKCzk-XN9CiYXDyjHJ9xQ_1751288438
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3a4f6ba526eso1305144f8f.1
        for <virtualization@lists.linux.dev>; Mon, 30 Jun 2025 06:00:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751288438; x=1751893238;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G4HyaliWLgvplqkgqKCCNJ5/P2ZKVlm1Wsjs2FxXnxE=;
        b=GicHYQh31DEc/5mWaBYmBHK6Th0TjnWHKM9RD0cV1B+w+Anr2ouUokHzOWNgm/L0K9
         MdB6/2AhhdpCLBKMu7O/1QmmUoiHWKLOsgzLZhe4vN3NC1FE3UK0LkCFzfu8IjqZeSkO
         S5U/t7ON4wjrYBooQBishUdvHj/J2isHBGY+qEjWrpVX46SVm2tttBS/CfWMx523UgLH
         4IxN3MzyR5+tArm+cTRLITIcpcHa6CWUCmCVKrl9IUO6MImBsAuK9C/RHR9JykvBiirm
         5Z9+JhHSvyGlKYVJlvIlVcKby/giCKtnFLgnmKyHKn1/7Nm7y/e02foK4osoePIiPrKz
         HuGg==
X-Forwarded-Encrypted: i=1; AJvYcCXdaRYW7ggBOJN2Saf5/RFRmdDY2SEHeeGuZ+1aK8HBtaVvKWKVl76DyFkPhA0eHLlXXvLCbrNB3BScTeKVoA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyoBAZVMv+k0VaUGuX9OY1W2fWDI5eX/yghsUWNodU7NF7M2La1
	Owy8/+Ih279bAoP9EjlCAiYrnckYWiIjgK+n+RPmZIvUawVRaujF7fauotRi7fkFipiY97Z62gW
	pHxgCf/o0eiqYkSwPjuvlfAHx2jadrJah7wFPwfN8Esn++bYNiqfW02y8vEyT7wbjYUnm
X-Gm-Gg: ASbGncsM/PFBwa08gwDRaH1llqRslBSq97zfonpGy6dSmzhVtFBWxzdLktXPhL8etF7
	CayRFf4h/Ua2Dq/TmeidT60EBUG7f+n5WjypjsorcXO/NpGxgB38z4VScqNtQvF/RslpF86AhMX
	zpITVQabO5NzvJkmFp8vcRF3YrJVn1zlzDCZPv/gY1OlXuAidecRVfy/UKzzaAff+McWu5ZhJhV
	iwIOsJR5HZJBO1ZMdH+KodfCGDJVCBfIflKpm5dWhAob9o0FJCtH9e2WZe2vQbk06wsejuq0pTE
	xCtBLfA5LurldazWrErCZtKYzL+7GiJJjwILqKRpKt8Qs8xPht/cZqlxoEZty8EZsq9oBH+0+nH
	CxgKFiFQ=
X-Received: by 2002:adf:b649:0:b0:3a4:cf40:ff37 with SMTP id ffacd0b85a97d-3a8f45494cdmr9830836f8f.6.1751288437751;
        Mon, 30 Jun 2025 06:00:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFEehlYPXkAQhWmsU6NKWbFkXt51tuHaEnt5gEo+HlKa0FWalrdKbSodH+fk72qwn9YuXcO6g==
X-Received: by 2002:adf:b649:0:b0:3a4:cf40:ff37 with SMTP id ffacd0b85a97d-3a8f45494cdmr9830683f8f.6.1751288436787;
        Mon, 30 Jun 2025 06:00:36 -0700 (PDT)
Received: from localhost (p200300d82f40b30053f7d260aff47256.dip0.t-ipconnect.de. [2003:d8:2f40:b300:53f7:d260:aff4:7256])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3a892e5b2a7sm10408982f8f.69.2025.06.30.06.00.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jun 2025 06:00:36 -0700 (PDT)
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
Subject: [PATCH v1 08/29] mm/migrate: rename putback_movable_folio() to putback_movable_ops_page()
Date: Mon, 30 Jun 2025 14:59:49 +0200
Message-ID: <20250630130011.330477-9-david@redhat.com>
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
X-Mimecast-MFC-PROC-ID: rBGybzLZMlwiS4q1ctDZRuJK3jsY2Hv1DisBhIcZUQY_1751288438
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

... and factor the complete handling of movable_ops pages out.
Convert it similar to isolate_movable_ops_page().

While at it, convert the VM_BUG_ON_FOLIO() into a VM_WARN_ON_PAGE().

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/migrate.c | 37 ++++++++++++++++++++++++-------------
 1 file changed, 24 insertions(+), 13 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index d4b4a7eefb6bd..d97f7cd137e63 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -133,12 +133,30 @@ bool isolate_movable_ops_page(struct page *page, isolate_mode_t mode)
 	return false;
 }
 
-static void putback_movable_folio(struct folio *folio)
+/**
+ * putback_movable_ops_page - putback an isolated movable_ops page
+ * @page: The isolated page.
+ *
+ * Putback an isolated movable_ops page.
+ *
+ * After the page was putback, it might get freed instantly.
+ */
+static void putback_movable_ops_page(struct page *page)
 {
-	const struct movable_operations *mops = folio_movable_ops(folio);
-
-	mops->putback_page(&folio->page);
-	folio_clear_isolated(folio);
+	/*
+	 * TODO: these pages will not be folios in the future. All
+	 * folio dependencies will have to be removed.
+	 */
+	struct folio *folio = page_folio(page);
+
+	VM_WARN_ON_ONCE_PAGE(!PageIsolated(page), page);
+	folio_lock(folio);
+	/* If the page was released by it's owner, there is nothing to do. */
+	if (PageMovable(page))
+		page_movable_ops(page)->putback_page(page);
+	ClearPageIsolated(page);
+	folio_unlock(folio);
+	folio_put(folio);
 }
 
 /*
@@ -166,14 +184,7 @@ void putback_movable_pages(struct list_head *l)
 		 * have PAGE_MAPPING_MOVABLE.
 		 */
 		if (unlikely(__folio_test_movable(folio))) {
-			VM_BUG_ON_FOLIO(!folio_test_isolated(folio), folio);
-			folio_lock(folio);
-			if (folio_test_movable(folio))
-				putback_movable_folio(folio);
-			else
-				folio_clear_isolated(folio);
-			folio_unlock(folio);
-			folio_put(folio);
+			putback_movable_ops_page(&folio->page);
 		} else {
 			node_stat_mod_folio(folio, NR_ISOLATED_ANON +
 					folio_is_file_lru(folio), -folio_nr_pages(folio));
-- 
2.49.0

