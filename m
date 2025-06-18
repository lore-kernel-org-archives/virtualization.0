Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A1A32F4A1A
	for <virtualization@lists.linux.dev>; Wed, 18 Jun 2025 17:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750268450; cv=none; b=q07jBkTEQNoz8MgHBiS859lZctQJh8WzuV/ffoCTQ15Fo87czNGJTQI4LvYM6D6hlHtrj5498Bxk2RmwPC/C5+TSRZJ3NKMm9tAv/qefMq8mAy1QCgYTJWUWuTcZcE/EoqxbdRX12EceolLWty4y85lLdCv0jf5Z5s14J1CcM9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750268450; c=relaxed/simple;
	bh=zbcjdtHnZ1BcawVRomdGBMsau7cooieEoCmjNLCJMWQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=mwzbR6dWWukIP74DbgbtiLcx4jayo0E4Yi6XiZsXp5NgcVYLYNCPG6fVhx+eg/7dfpJEjtwh0/WH/CA+9evkFMYu45TfO6xeYsmJOVkvX7snQ9Bpg4CmMCGner6+4IZkS32UhW97kVYdTmrpCneFhvO18/uHjSWeFzF9N15NdLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CppTbSKY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CppTbSKY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750268442;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5rGfc3zUjh7F4hWUWCipVozVPKyNvGr3sO3WbBx9inE=;
	b=CppTbSKYVFMZK6SzpRCHx9gHLIcl3rKVYYRRy29CCXG+WCYSW5NTWcwzHF8GOzQ4cvTrLW
	dJ60VNXYu0fNoLowV7RlrD4VimYYO2GbQkqbgXYc/Qt3lmhGCoQA2GnHc4iSWh4UjIoUSL
	AOU46I5Dr6B9pLQGHmSJyw/jg5dQcbI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-252-tHi0BQoAND-kHafg6xXBOA-1; Wed, 18 Jun 2025 13:40:40 -0400
X-MC-Unique: tHi0BQoAND-kHafg6xXBOA-1
X-Mimecast-MFC-AGG-ID: tHi0BQoAND-kHafg6xXBOA_1750268439
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3a4eec544c6so2846370f8f.0
        for <virtualization@lists.linux.dev>; Wed, 18 Jun 2025 10:40:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750268439; x=1750873239;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5rGfc3zUjh7F4hWUWCipVozVPKyNvGr3sO3WbBx9inE=;
        b=e9x8GGy2AGkjy++dYO86Sq7beG5t23UVC5+C98S/EwrCVWrAIMZN6vPCM1L2h2fkIX
         N4OQ7asIYSFXdW+K2ptrZYu0JwDrHDdPCFDgy4qNoEGgM9tSVKwXnJBIULL+S2mOHvfN
         MUz5/N8ndKMISLqDsa399+D7Gq1YDGWJRQgLs6sajgx4yelotw8f06A+L2agjYhhDv9q
         exHWNphxeDoL+ipkLBz1H/2Ly608xoPkGbK5mByRUDs9JetwtFsJOnwiksGPOnC3ty+L
         60wt+KDxxDQCkOZkpfGZBoCXN7ZLnFu3vugMdhIziobb6QtDe+T6PWeu30opH7hNTacs
         RXJg==
X-Forwarded-Encrypted: i=1; AJvYcCXPJWSO0SMjFsZ1N/Du3bR9iwOU0vZSMskqOlDbwaBOOpuO0TWx7nluIU6R7fh5exlEYz8+KfUo5DsfZn2qYg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxFtlhggRw9nFUKSPLfNsWPmk9C71DoD2pGaSy4+NLg6zYTs7Uy
	b/z7mm9UGmPgtfp+OOwros7RCbXvA+GxD4EfUXPXY+PxPNRZGtLkjZgS+a8+9jAklc4znQMH015
	C5wmvpxO4iHi3jhiLei0J/N/+6GrXDZ7fn5be6Q00o313FA4hplwnRp/CE8focTa4jFeR
X-Gm-Gg: ASbGncudTGCauaLft3RJ0206TOZ3qFvajBOqnWAJhFhirwTA0qNA3DjMuZ+4ujDc7L+
	3W+xFwsJiEaTmfivid0veC4mKBjrfQHkQAqpidLzvrbjs6wiWFu/42EqruucGOaDAsu+OwaqrEw
	LaBE92nJwUsaUySkHrsiS1IN0FcLtEW3R2dAIX6FWGoQ9CNH9uQ+ofbs6WcxX1idOKfCwOeAfuO
	GUEKR45IGRdcHU9/F7l47hOXZq3kBt9sGIX1ys+Khn50ONtRAL/MLF4HK3L5OfpqK/IgLAxP9e7
	8ZZ487MJPaHytxzeEEmFFZuwupfdDfK6lzwRYPg6uQOAA3sIejW1+MAmjx1ckW4F50vU44okevB
	o883ElQ==
X-Received: by 2002:a05:6000:144f:b0:3a3:7ba5:93a5 with SMTP id ffacd0b85a97d-3a57237c9a7mr17230279f8f.26.1750268438540;
        Wed, 18 Jun 2025 10:40:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGk4wH3M6h2T58ReQA5DPEIh/WOsy58XEgAZ0LBQTHsCj9tNbupSQVC4fwDx3ff0ep2cpGgew==
X-Received: by 2002:a05:6000:144f:b0:3a3:7ba5:93a5 with SMTP id ffacd0b85a97d-3a57237c9a7mr17230239f8f.26.1750268438093;
        Wed, 18 Jun 2025 10:40:38 -0700 (PDT)
Received: from localhost (p200300d82f2d2400405203b5fff94ed0.dip0.t-ipconnect.de. [2003:d8:2f2d:2400:4052:3b5:fff9:4ed0])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3a568a800d9sm17307416f8f.45.2025.06.18.10.40.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jun 2025 10:40:37 -0700 (PDT)
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
Subject: [PATCH RFC 08/29] mm/migrate: rename putback_movable_folio() to putback_movable_ops_page()
Date: Wed, 18 Jun 2025 19:39:51 +0200
Message-ID: <20250618174014.1168640-9-david@redhat.com>
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
X-Mimecast-MFC-PROC-ID: _R22_IlkodI3_mFRDz9tSQuHYsQPrXxz9-YBrGH8GpM_1750268439
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
index 6bbb455f8b593..32e77898f7d6c 100644
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

