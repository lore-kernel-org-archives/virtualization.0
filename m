Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 691362F5315
	for <virtualization@lists.linux.dev>; Fri,  4 Jul 2025 10:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751624758; cv=none; b=mYbYC31XHaXoTP6Ks6ESXVFfdqDBP8NWGo22Ux+0FWuvhqOG5euJQeDig2qQKO0EXnNEoJm3pwePqaoC7C5oVBDddp8Q5Rmy6JfLlj/q4l19qjMY4fiKHFaYk2Vx0dajTQHq11YXPwewbesZkt3KpoW3Kh6U1Mqjq0c2hN6lNL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751624758; c=relaxed/simple;
	bh=cpXSWX6aTPOh+pmlPrRH6DoAXsk2bYocWaGA0TOO5Uw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=ncsHYgU2yG0bmpNSKApj1MHP3ROwFrqDlJkkhIz5A6T0vxnGiTbqVYm/PmRSAvezOyc0MmmdSBKEWKMnKDovDrLv7/C6vJI+CO1u/ULTN0MMZVA2u3KsH8H0g44rSdu4DWeClXW9ZuJxD4D2ABJPIaujOu3TmeGMScqRk0yW9ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KcoEH3mQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KcoEH3mQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751624756;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OVyour2UNFNS7aNaSR0hE5hzdL3B1bhwCvX/GUFQiSw=;
	b=KcoEH3mQfVkK32aGVJfzwsATUyp/X6+VHAbhWvO64WNJmAiHsXX4wOuBFPKe2TUbE3mjDf
	BuJ7X0yp95T9ObJ99eqP8tZE01dnwRCkSG84oqTGdRFXGgme1gHGzPmP5bEJxRloyQMqTS
	afT0fQOmSSM3GagLh3yY0wWi510u3qw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-218-deCWvIerOuees2r_iZw9tA-1; Fri, 04 Jul 2025 06:25:55 -0400
X-MC-Unique: deCWvIerOuees2r_iZw9tA-1
X-Mimecast-MFC-AGG-ID: deCWvIerOuees2r_iZw9tA_1751624752
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-451ecc3be97so3899725e9.0
        for <virtualization@lists.linux.dev>; Fri, 04 Jul 2025 03:25:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751624752; x=1752229552;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OVyour2UNFNS7aNaSR0hE5hzdL3B1bhwCvX/GUFQiSw=;
        b=rhirtbUCfAei63LSB/ITlrBcIBCxjcoJYZhBtiovQMC7AtCTrpLZeEsN8+ZXUOir/f
         QuuU8pBpaiPKidLr6KAjBUqKRi2AfXQ2pyuENH/cSbtBJf2qWjMcnBUQcdRvEWu7WKGm
         pl7psKQadwJkUKX83OK9BYkzrZ6ItTdTp2yQg5EQ7tH/Daz22GZx1u+cMs+OLeRShSA0
         0qFQaDfBmfWD2Iqasm7CBhQGcTy5I86KBvcOv4aLsZg8a+UwpfWu9SibkbAWBoTMrps6
         jQ7zZssl4bG6tHoLNbyoCCs/Za2pFgDui+1hMgXtYA6Up0AriLFC/BnO1rnFQE9va0K1
         t8Sw==
X-Forwarded-Encrypted: i=1; AJvYcCU4QTmMSZQ7oBG4PZgRDyGGiaCIgkuXfmYi2LKdcOSw/IkXvXVm1nGAyTX8WebDH3rIp0UE5G+mUl7gKzRmLQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwE21a93FvjVJRBJJHzUfc0cBMSng4ZIH+ZyfUVQIVaNQu7hwau
	9g2n8PBI4gluLv9ETf4hDrpSnlWgQ+qUzwKwwESgJkiVplM2edLgDemNvQmnYijisnVXXyTLUYV
	C0c08kG8QQZ4bCdzyR7Xob8AHvrKaaQwNJR/67qmwHuDA1HZ73zxRZTNtTlyPaUQ8Z2zF
X-Gm-Gg: ASbGncu+PoA7QZMZbFixR5iUUW1kP3voSMtpu8G/iyYXmfYKVtD8Ac68jw6/+0lPn+a
	f8Gd/MigbJiikIkcGEgKt+2YKz/+y0oJJdEwSUrHXEtTwQnAIGlisU31ElX/WG3V36yJdZR2+TA
	r87+RE7A04lVGp+6a1CIKGyXXCxFKX7mbe3hDv6I/YpVkirFrNu9CnRpczj+9kEPaXHmQammx8W
	n4+/buvP4cTj7pkn4dpOkZelObv4jJ9Jm5tf+88/bWrrUu1pNTyWUYioq04r2sQ65r0t0f1NeTA
	sfOGciMo4YCtM4gA7kc0+XdrumpPGGbqXkV37Pspzl77BmidRXzw7PTVhijy1Zpn5dNTWkQzxcw
	xvPIwrg==
X-Received: by 2002:a05:600c:4f07:b0:43b:cc42:c54f with SMTP id 5b1f17b1804b1-454b835631bmr1455995e9.14.1751624751503;
        Fri, 04 Jul 2025 03:25:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE2Rez8KVGPQFiDbU29hzAgNjBI7xFdtw4twkMv/+PHLeFt8+nZnPGBAy1buVfR9Z9nLRQVCg==
X-Received: by 2002:a05:600c:4f07:b0:43b:cc42:c54f with SMTP id 5b1f17b1804b1-454b835631bmr1455215e9.14.1751624750855;
        Fri, 04 Jul 2025 03:25:50 -0700 (PDT)
Received: from localhost (p200300d82f2c5500098823f9faa07232.dip0.t-ipconnect.de. [2003:d8:2f2c:5500:988:23f9:faa0:7232])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-454b1634b0fsm22804075e9.17.2025.07.04.03.25.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Jul 2025 03:25:49 -0700 (PDT)
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
Subject: [PATCH v2 08/29] mm/migrate: rename putback_movable_folio() to putback_movable_ops_page()
Date: Fri,  4 Jul 2025 12:25:02 +0200
Message-ID: <20250704102524.326966-9-david@redhat.com>
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
X-Mimecast-MFC-PROC-ID: tQ8CkG3m7OL3lDcPKmZJ8vyzGgnh0xVeFq9IYcfzrWA_1751624752
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

... and factor the complete handling of movable_ops pages out.
Convert it similar to isolate_movable_ops_page().

While at it, convert the VM_BUG_ON_FOLIO() into a VM_WARN_ON_PAGE().

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reviewed-by: Harry Yoo <harry.yoo@oracle.com>
Reviewed-by: Zi Yan <ziy@nvidia.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/migrate.c | 37 ++++++++++++++++++++++++-------------
 1 file changed, 24 insertions(+), 13 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index 2e648d75248e4..c3cd66b05fe2f 100644
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

