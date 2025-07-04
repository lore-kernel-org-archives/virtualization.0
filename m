Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB4D2F4A09
	for <virtualization@lists.linux.dev>; Fri,  4 Jul 2025 10:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751624760; cv=none; b=KK1x0zE7eR6UqXQY6mIQigPdEedM0kY1C4w3XDu9nhXDwFfIg8VBe8KKgD2etlJOHaMFEKhnjL/GNalwPpuLnlurnaLw9jWqJWc/78t7UwopvsM7nYP4AICI17fk5+YgIDPZE2LR6YUHmYvZray2P7ZOWMyMmvIzm9Z5BiB6q9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751624760; c=relaxed/simple;
	bh=H2phfaA1UHj2m35/TopTQ1tPJK7fzhUyx1mWAfz2IOM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=cPWm5x9V1Mj/mNQDZJvzGsAM3vmxQr7C+zf6WiltP25UFuQ8EGW3gVgikQPNl6N96pfCtGwLjlhtd8nu1rdO5lFFaWxPuoFALb8mtEnx3xW2e5w81ggibmYd/PaMxBZHm8PfSWvPOssr3zBhB2lWx7AVbIqcfXGT0Ml1AB4c/Hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RPnE7xPP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RPnE7xPP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751624757;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QfBSPQaG9xeZudkGcFWJAgBBxYLZuNBkDrffE/+eDPg=;
	b=RPnE7xPP9v5R4M8rwpuTVRXSAoyMbvUNZivsmnjz6q/Z9ux2JZXjhnLfjJOPvZ7/+NH2ef
	hEhdBpPcJghdKfcLoZfqq/0QrodrKN9tB9tNCjm9rWBBOsYztrErPyQYSTZHvwDJsw4wt5
	ANF21Et031hwXurburXg0OTIPDgHWFM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-536-bKWAD4HANzmgCKgHhRyb7g-1; Fri, 04 Jul 2025 06:25:56 -0400
X-MC-Unique: bKWAD4HANzmgCKgHhRyb7g-1
X-Mimecast-MFC-AGG-ID: bKWAD4HANzmgCKgHhRyb7g_1751624755
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4539b44e7b1so5192455e9.1
        for <virtualization@lists.linux.dev>; Fri, 04 Jul 2025 03:25:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751624755; x=1752229555;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QfBSPQaG9xeZudkGcFWJAgBBxYLZuNBkDrffE/+eDPg=;
        b=A08UmrOkwn4YVq3wRTXghwv5lc1b6VCTw65PlU0RBxm9YeFDz2j7cQW7CQ2n5QOrXO
         33pUAxYxiYf4rHn+UcvXYHUlr1JVF6OwRFNaG5KNu8GM1rZIA/VgQCMCwpMRiltnOZE0
         55tEvZ+o4ZnjaLmM5VkcOaGo58RAbrIz/bZ5X68tCM164Mg2Gx+rilA4O07xm9pQB3qL
         xUZpoXJwTzX2xYx0wpqKaBzC5dd5yJwOdVrKj+C7ywmpwAJ4M4zSq6pR7wAXCHTeK6bG
         4pI0Ob+0bKMRzD6s0uSU6MizyoYdffEZZv4R/ei5Glzcu9VMMdp5KvKhs//cNR1yt941
         cNzA==
X-Forwarded-Encrypted: i=1; AJvYcCX7qrvP5NcHxbcAZF4X9jlWh9rQAHnDmv9aWL9rrBYlrwNLeaGFJ3PkIgsQk5M7ScgfJBdcVm/hgm26aXQqAg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzgRsvEJwAnNJZaJ/ES6VLsGSCKnAL8yGkFyVpOxhDQav/x4dbo
	P3KdCV2/BY4Opn2bipJGstf0ncQQfZRqcsdUS9N+o4uTVzcEJwtDXsTWZUkpOvzG33jRGzrp0gk
	EYekogqNlTkrQZQxQwbz5ntXBnQGy6qeRoWGHdc/OcTeB1v1d7XtOuvCC/ZjapklaMx0V
X-Gm-Gg: ASbGncsqpP6JssWHWs4tdCc4Q+FNKZExyufACcGTx3VbxMasLso9Q7wLdkbs69NVAwD
	/sHtQ2F0QS0qbpCo9pvqzHWHtzi2jjjEAQtFxPGAytUqExNv32Gmfu7HpR386ItpLA3qfQecFVw
	R+s/G/fU9LGCYgUOgfszJy0FsoQK5w7fGzUg5//9bC9TgGxNsdyOksSNGqlXVj/bqwmOZV7ieqF
	6CbHFMYWq3fVJQr3rZZRtu3aPXSOC4I0SmY3zJiCXgw9YK1W6LnEYcJ/GXsjxxO1nPngnLK5oPv
	Q9NANsIrD7RPGbt1FIeecgneUjK00p2i7afx6tRAQlokIXsM/+2DfR5GqUTpCXJe4vINGcgoUyx
	RMZF5xQ==
X-Received: by 2002:a05:6000:2312:b0:3a4:e54c:adf2 with SMTP id ffacd0b85a97d-3b497011964mr1275718f8f.5.1751624754798;
        Fri, 04 Jul 2025 03:25:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGfrhXd/yIZyYpWVcak9U+vZiPIE1G2M2XMax2kqYgfF02lLZKKCminarbrdx4X4RqYGyvSNg==
X-Received: by 2002:a05:6000:2312:b0:3a4:e54c:adf2 with SMTP id ffacd0b85a97d-3b497011964mr1275679f8f.5.1751624754226;
        Fri, 04 Jul 2025 03:25:54 -0700 (PDT)
Received: from localhost (p200300d82f2c5500098823f9faa07232.dip0.t-ipconnect.de. [2003:d8:2f2c:5500:988:23f9:faa0:7232])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3b47285e241sm2143549f8f.94.2025.07.04.03.25.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Jul 2025 03:25:53 -0700 (PDT)
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
Subject: [PATCH v2 09/29] mm/migrate: factor out movable_ops page handling into migrate_movable_ops_page()
Date: Fri,  4 Jul 2025 12:25:03 +0200
Message-ID: <20250704102524.326966-10-david@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250704102524.326966-1-david@redhat.com>
References: <20250704102524.326966-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: bMzX_QTTZ91wgqrfaHIs2Xb_3QYEWNUeDmd3njCY1_8_1751624755
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Let's factor it out, simplifying the calling code.

Before this change, we would have called flush_dcache_folio() also on
movable_ops pages. As documented in Documentation/core-api/cachetlb.rst:

	"This routine need only be called for page cache pages which can
	 potentially ever be mapped into the address space of a user
	 process."

So don't do it for movable_ops pages. If there would ever be such a
movable_ops page user, it should do the flushing itself after performing
the copy.

Note that we can now change folio_mapping_flags() to folio_test_anon()
to make it clearer, because movable_ops pages will never take that path.

Reviewed-by: Zi Yan <ziy@nvidia.com>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/migrate.c | 82 ++++++++++++++++++++++++++++------------------------
 1 file changed, 45 insertions(+), 37 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index c3cd66b05fe2f..d66d0776036c3 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -159,6 +159,45 @@ static void putback_movable_ops_page(struct page *page)
 	folio_put(folio);
 }
 
+/**
+ * migrate_movable_ops_page - migrate an isolated movable_ops page
+ * @page: The isolated page.
+ *
+ * Migrate an isolated movable_ops page.
+ *
+ * If the src page was already released by its owner, the src page is
+ * un-isolated (putback) and migration succeeds; the migration core will be the
+ * owner of both pages.
+ *
+ * If the src page was not released by its owner and the migration was
+ * successful, the owner of the src page and the dst page are swapped and
+ * the src page is un-isolated.
+ *
+ * If migration fails, the ownership stays unmodified and the src page
+ * remains isolated: migration may be retried later or the page can be putback.
+ *
+ * TODO: migration core will treat both pages as folios and lock them before
+ * this call to unlock them after this call. Further, the folio refcounts on
+ * src and dst are also released by migration core. These pages will not be
+ * folios in the future, so that must be reworked.
+ *
+ * Returns MIGRATEPAGE_SUCCESS on success, otherwise a negative error
+ * code.
+ */
+static int migrate_movable_ops_page(struct page *dst, struct page *src,
+		enum migrate_mode mode)
+{
+	int rc = MIGRATEPAGE_SUCCESS;
+
+	VM_WARN_ON_ONCE_PAGE(!PageIsolated(src), src);
+	/* If the page was released by it's owner, there is nothing to do. */
+	if (PageMovable(src))
+		rc = page_movable_ops(src)->migrate_page(dst, src, mode);
+	if (rc == MIGRATEPAGE_SUCCESS)
+		ClearPageIsolated(src);
+	return rc;
+}
+
 /*
  * Put previously isolated pages back onto the appropriate lists
  * from where they were once taken off for compaction/migration.
@@ -1023,51 +1062,20 @@ static int move_to_new_folio(struct folio *dst, struct folio *src,
 								mode);
 		else
 			rc = fallback_migrate_folio(mapping, dst, src, mode);
-	} else {
-		const struct movable_operations *mops;
 
-		/*
-		 * In case of non-lru page, it could be released after
-		 * isolation step. In that case, we shouldn't try migration.
-		 */
-		VM_BUG_ON_FOLIO(!folio_test_isolated(src), src);
-		if (!folio_test_movable(src)) {
-			rc = MIGRATEPAGE_SUCCESS;
-			folio_clear_isolated(src);
+		if (rc != MIGRATEPAGE_SUCCESS)
 			goto out;
-		}
-
-		mops = folio_movable_ops(src);
-		rc = mops->migrate_page(&dst->page, &src->page, mode);
-		WARN_ON_ONCE(rc == MIGRATEPAGE_SUCCESS &&
-				!folio_test_isolated(src));
-	}
-
-	/*
-	 * When successful, old pagecache src->mapping must be cleared before
-	 * src is freed; but stats require that PageAnon be left as PageAnon.
-	 */
-	if (rc == MIGRATEPAGE_SUCCESS) {
-		if (__folio_test_movable(src)) {
-			VM_BUG_ON_FOLIO(!folio_test_isolated(src), src);
-
-			/*
-			 * We clear PG_movable under page_lock so any compactor
-			 * cannot try to migrate this page.
-			 */
-			folio_clear_isolated(src);
-		}
-
 		/*
-		 * Anonymous and movable src->mapping will be cleared by
-		 * free_pages_prepare so don't reset it here for keeping
-		 * the type to work PageAnon, for example.
+		 * For pagecache folios, src->mapping must be cleared before src
+		 * is freed. Anonymous folios must stay anonymous until freed.
 		 */
-		if (!folio_mapping_flags(src))
+		if (!folio_test_anon(src))
 			src->mapping = NULL;
 
 		if (likely(!folio_is_zone_device(dst)))
 			flush_dcache_folio(dst);
+	} else {
+		rc = migrate_movable_ops_page(&dst->page, &src->page, mode);
 	}
 out:
 	return rc;
-- 
2.49.0

