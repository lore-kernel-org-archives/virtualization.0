Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F6F528AAED
	for <virtualization@lists.linux.dev>; Mon, 30 Jun 2025 13:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751288453; cv=none; b=bA1uJj3lDwSdzyzlRXse+ldHKv7Hugj6otGULYgW8i16NoCOQjJn5b2TapAq98cd8w1IpiZ+9JtP6SpKxuedh4DaFfRyUGFlGbAZu5a8yUoHmIhPs0ruZpBJ5foCPRmrgMvSeOc4LAqeRFX6s0vV2Jpko/1JNfhs4vKmjUSZO5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751288453; c=relaxed/simple;
	bh=eiWjuQAK343S0iGCo5U1CeA1xAD7ABzULSg4BICmapk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=CmF1Nq1ock49wX1VSzkayqNmwt4Gf5icriGFSfKI2Zg+qJKi7zqUP6EFbISw78oiW85CRVk+s54ebPWqwgQh44HrxY3MrYICqt60sSoQcawAdHN5G20iudG0v26pIjuNo8F3fcC387n88b9lkSwlWakpdpLMU16aitpsj/oMS5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Zm904/ea; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zm904/ea"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751288447;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZjlP0D3eY9tZf8Nb4qLq/i9Tdq3zqU6lo6GiM8rDh3E=;
	b=Zm904/eacc8qn81OpLLg7A9fPXDoxMaHAio0sU3gAB7E9cm3y+xjDRWaAkZnwmJNqIpnqQ
	7FULCaBoybacbWV+ho6xujbsTaXxRnPoWZjoi0b7397YlNkFQUWLyllTlMqGke4ALApjo+
	GeaXWVyfdOjUvjFXeUgcPBMMmOPQYtM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-137-eRAG7rjVPzyUY49_eBCeSw-1; Mon, 30 Jun 2025 09:00:46 -0400
X-MC-Unique: eRAG7rjVPzyUY49_eBCeSw-1
X-Mimecast-MFC-AGG-ID: eRAG7rjVPzyUY49_eBCeSw_1751288445
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3a4ff581df3so2194886f8f.1
        for <virtualization@lists.linux.dev>; Mon, 30 Jun 2025 06:00:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751288445; x=1751893245;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZjlP0D3eY9tZf8Nb4qLq/i9Tdq3zqU6lo6GiM8rDh3E=;
        b=fO8nswY4U69dEy9jf6lCUubORejti0cR7wtjZtkRHF4lLcDXkZERRIH76ZJRqT8tbf
         H0YFkBlQItYO9COqP/TAgMDQ7PCJMt2zU+DS9vjAvFN8ejpcTwFyLI0dK7th+/LltCxi
         9kzfhpEYGu7dX8U5GWFmz1nB3t0sFo3WGdaFxYtFfIrws8j8aGSbHbcB9wDitQmR6CuY
         IV8kYv4COk4sclEt9sePsJjUMemW6JhGcQxzOluBUh51w32VAxS0UBbD56XnGKOV2r+j
         YewL1QjKnotjfSgGiuMCV7RK3v/ApdhqqgLK9LaN0RRSpCOFWry66hFNIZals/bBlO8M
         t8iQ==
X-Forwarded-Encrypted: i=1; AJvYcCUqwe2mzk2jodp01/lZ7lxSdzi0Q6SAknqtIPpz8r4GIms0Zseszix5PF3ruNtE3iqeqMyhnkapImgUGRvvJg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxq6APVfe9ZhOabg6zsBJ6ciZBK4sUAw5W5H8Xzx9qHL7zDrohN
	Vm7OmoZHigii7nugHSQYUh0br7wc+aOb+lVuOtUAmVLW3T78n+CRkbPgVXRyqpMv4mY9zAs+/UH
	hj5+i7J22pD9i4wvUfYzO53GZxjNAa4DupqqH7/ZVrFmh5sMmprl3YFC/0d8lmjy4vQAj
X-Gm-Gg: ASbGnctyWEGm85FeypC9JBoQXRVBBw91t6cDqWAXouuvrwcF3IalcUC1vQRFku16oD9
	s+oaBfaZJyCpegjzrHun58DWhW7yjCQ6jlazubC7c7bhx4n3En7xYRSn2Ok+lfejLZSahwKBt9L
	PXZdAlEfLnIuHjG20njFL9bwu4auvkUEZeqJfVBYelAVU606i2cCJcGOl+sQzA+j55Y/NqYvY6D
	eOwnFaFM5QM0om1UXur0ijfI5i6S+g9hmKAAWoRrfSUnY10XqnhKpzWjsVp2KGQX2u2g9caQcDB
	xoWvmUSg7zl86golcNIdfq1Uwo8F/ccpCSO+myzPdx1lVEdF3B/d6dcr6OuwKPRI5X7i51YLsia
	jkkraeA8=
X-Received: by 2002:a05:6000:200e:b0:3a6:daff:9e5 with SMTP id ffacd0b85a97d-3a6f31023bdmr13743964f8f.7.1751288444883;
        Mon, 30 Jun 2025 06:00:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFaNYb3ONKvqKvr320nfpncqFiQLJi8PiPIyho0Wzz9N7dVDIemJ3QiyBdfpFdZCgx38anKxQ==
X-Received: by 2002:a05:6000:200e:b0:3a6:daff:9e5 with SMTP id ffacd0b85a97d-3a6f31023bdmr13743499f8f.7.1751288439567;
        Mon, 30 Jun 2025 06:00:39 -0700 (PDT)
Received: from localhost (p200300d82f40b30053f7d260aff47256.dip0.t-ipconnect.de. [2003:d8:2f40:b300:53f7:d260:aff4:7256])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3a892e52ca4sm10445235f8f.58.2025.06.30.06.00.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jun 2025 06:00:39 -0700 (PDT)
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
Subject: [PATCH v1 09/29] mm/migrate: factor out movable_ops page handling into migrate_movable_ops_page()
Date: Mon, 30 Jun 2025 14:59:50 +0200
Message-ID: <20250630130011.330477-10-david@redhat.com>
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
X-Mimecast-MFC-PROC-ID: 3EZemjHPyTCoe3GQaQpJeoFy-0K1UIwfoTL79AtQwDo_1751288445
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Let's factor it out, simplifying the calling code.

The assumption is that flush_dcache_page() is not required for
movable_ops pages: as documented for flush_dcache_folio(), it really
only applies when the kernel wrote to pagecache pages / pages in
highmem. movable_ops callbacks should be handling flushing
caches if ever required.

Note that we can now change folio_mapping_flags() to folio_test_anon()
to make it clearer, because movable_ops pages will never take that path.

Reviewed-by: Zi Yan <ziy@nvidia.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/migrate.c | 82 ++++++++++++++++++++++++++++------------------------
 1 file changed, 45 insertions(+), 37 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index d97f7cd137e63..0898ddd2f661f 100644
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

