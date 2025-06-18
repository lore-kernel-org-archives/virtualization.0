Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9DD52FE370
	for <virtualization@lists.linux.dev>; Wed, 18 Jun 2025 17:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750268449; cv=none; b=X/YdJeeF7gmAcrHEw6FzBWFkoEKINL9RnYiEUE27yY03T7iRQmKlK8tgstF0lWZVpUe0r1+WABofYjcvI0m4Oq4VWw0BmDJC5vJl/hCIWcU/WX3suHNZJrA70rdNH6gct93F7sYRgJzZ93/JsET9ZJRi3QtfOndb3sXkgWMElf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750268449; c=relaxed/simple;
	bh=aEP6DnjEOauJOFrkxr2zR+ZZpgBJ0tgUTK1LoPRl2/E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=suf7LEvjeGxQRBsdcw+gvrgqu0SAWMKfNxO1M1d0JHpOve4KOs3Llnr8NBjuXnaZqGigBiW0M9Nmj8mG1zX+LKjHq+cMinng+4Gnha5hcYGvli2tKLOx9ndprNpPUTY3Y0BlT4ipp5+W0kUALlCgI7x1ymyIz7aoey7ndYim4yQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BgMkcbAH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BgMkcbAH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750268443;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j8LuODrccx/EBs9A7vTNySqHbhe9k9tI08r8Ga0Xgcs=;
	b=BgMkcbAHy1/eVRLRmgt+sjcBKKoLlDiVaBgDx7ZFsNVFKXo8Str57NYXPa38pr6aN1/dXG
	cxd/FwKChObXG6wgBnhdhr6PrE/hz5cHkC2nc16nOqhSSEk6UxNYL8Ub5hZXBfjhXcBtAw
	G65q+hM6tZb/Z/I2ED/Usg8o+Xn8dS4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-532-PjmwptA9NP6HoxKLbitHpQ-1; Wed, 18 Jun 2025 13:40:42 -0400
X-MC-Unique: PjmwptA9NP6HoxKLbitHpQ-1
X-Mimecast-MFC-AGG-ID: PjmwptA9NP6HoxKLbitHpQ_1750268441
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4530c186394so32130825e9.0
        for <virtualization@lists.linux.dev>; Wed, 18 Jun 2025 10:40:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750268441; x=1750873241;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j8LuODrccx/EBs9A7vTNySqHbhe9k9tI08r8Ga0Xgcs=;
        b=HFAFUqvVI987xWaA6XfRAZCpquWPuvoePKj8kwpHQknhF7GMXk/BgNwTWHjDM/fS5T
         X0MIn1oyKJKPrb7HXRea7m7ESz/GMAE5oAfvY1PkQwWcyxUrSqoN63dK78qlLgmq3JBT
         4VAU9vLxejfBLB7VZ2E1F2gLT4fDdOwmL6gKECysUswAc/TBCHzllJv1kWzgJrvZ3sj7
         tgvf0xzKkNLYRSaAeIvfLVr0Rx5sLZG7A75hw8RQ6RR8iZ1vhV0PvqxAKjky1Pnc8Wb1
         zrEs6eewh5SeMTMRO6sPptGeyhxAjf5krL+1JD2XtPD5/aTABXJqXtTRXI2BICmqXr56
         dZgg==
X-Forwarded-Encrypted: i=1; AJvYcCXi9YCSLdlAcCJbRz8OsY54fm6dlcnI4+Up1Z/9JgAboN2hkDFPz1/BGm8BePlBKYxD7CpsKtDa+y/NhSaFMA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyZl/knyHk/2191xjsD7ODUUTx7lRPI/4hN4KZ53LU+uBz2ZTKe
	RzQ0tnVbSyzoRYFlOl5x5orkupYn8rjmyCmBBgUV9btCqRulvJ638Osfg6r8bTOEZrK7WXarjeo
	oqL4Kw3G+c30TJPBmgnbngOfDMkdY9kmsBG/rj3DBn2Ze+XgK1Hxgd6hKRW21l6j0ua1T
X-Gm-Gg: ASbGnctnPpAv8lujOVmp5N2Ls8DPV+v70S92pBKP40ohYs1rsV4BZWO2/QgVww5tDY4
	RzQGeRjd195hpChve9Ks0KO7IXMIYvWp4i+y3ioq8y3Y8paKp7pB+be7FUfV2VLbUiN70i8uHiK
	DTb/ITmlytcaGFDh8MTdINnOHe15tM/g4L3XrNmonMRhEbk8P0gH/ddc0Ry38q7guZyiIyPe9dr
	GFxJaxm1N48xIng33ryFYeNahtuGB9nFF58rlW5XJKleJVV+LJn9wglfc/GC6KyPxkCaL3ZLW1m
	VwdSWPYZ6jhURuatsei9uwde1mtEhCvjRZl7BtAR3BKECyswgE8JddXgilLSO1VOUZ0lOYoCSmE
	XjTxMNw==
X-Received: by 2002:a05:600c:1ca1:b0:440:54ef:dfdc with SMTP id 5b1f17b1804b1-4533cae6605mr166407865e9.8.1750268441201;
        Wed, 18 Jun 2025 10:40:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHc4TaNXORzdooVLODlvwGNYZ3WZPNGmS5C2sKfTSdPVLBbA2Ps3b4UKdLfdRWvy1N8seVTmg==
X-Received: by 2002:a05:600c:1ca1:b0:440:54ef:dfdc with SMTP id 5b1f17b1804b1-4533cae6605mr166407185e9.8.1750268440690;
        Wed, 18 Jun 2025 10:40:40 -0700 (PDT)
Received: from localhost (p200300d82f2d2400405203b5fff94ed0.dip0.t-ipconnect.de. [2003:d8:2f2d:2400:4052:3b5:fff9:4ed0])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4535e97ab95sm3814165e9.7.2025.06.18.10.40.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jun 2025 10:40:40 -0700 (PDT)
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
Subject: [PATCH RFC 09/29] mm/migrate: factor out movable_ops page handling into migrate_movable_ops_page()
Date: Wed, 18 Jun 2025 19:39:52 +0200
Message-ID: <20250618174014.1168640-10-david@redhat.com>
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
X-Mimecast-MFC-PROC-ID: A1hiDu3uJe7VkIlCT2W7bol-KGRq8LsXWuvKPvfCXbI_1750268441
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

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/migrate.c | 82 ++++++++++++++++++++++++++++------------------------
 1 file changed, 45 insertions(+), 37 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index 32e77898f7d6c..456e41dad83a2 100644
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

