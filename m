Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD2972FE30A
	for <virtualization@lists.linux.dev>; Wed, 18 Jun 2025 17:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750268459; cv=none; b=SDETIqSEfuEpMAJ7raItiEl1W/3irrKINKNQa4avDAA2ZQnOai/OO7rHdNtGOc5OQpo8udyaiRcnN4wVhQa+sBOd2Y0+U91cg6s3PCXJ0ryrV3Pg+pRrlNjsud3/uCWo5OAlQcx5L7FQuEf/5vUA5SzuEdyaVa2A0/2dz/7e6pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750268459; c=relaxed/simple;
	bh=B4KdnntE/37K79ZPh7jyK3I0hRR/1p6A2DVmbrYflX0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=k3zf8ezkO4oH6KwfUm6p2Swxmf/v4zVEnlFcv/hXkkPUMy8OIseCbx8mHFC52fvCvH+mSVOYyGjco9O7vOKyjMZZVsJ6THor4+gvejU+ZsHR776rqYqp4re8o3F5IDeordFRGsckkFqtKYH7jhiyhPcL2WEMAu9SxzlBemqLPXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K/YFpcQ3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K/YFpcQ3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750268452;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HE4ZFr/3yO/kcvQGBFxRWJWFhigh7sWDavgkH8Q96v8=;
	b=K/YFpcQ3G+12GwD4fz3kXUm+VDiN2cCOWCbL3/1TROiyh4MhBLAyE4iwpR20QBGUTGyOTl
	bkVP6BRaRtrpPVdFoqoG3pdGE92piCv6MO5EUSokeLH0do8SU/GvxY94vrGX1cK6cZadQR
	L6XOgnSAqIL3LqXK8Fn0cvcsgq7aIHc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-649-hw6e7h96Mr23wJESmVMduA-1; Wed, 18 Jun 2025 13:40:51 -0400
X-MC-Unique: hw6e7h96Mr23wJESmVMduA-1
X-Mimecast-MFC-AGG-ID: hw6e7h96Mr23wJESmVMduA_1750268450
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-451dda846a0so56145355e9.2
        for <virtualization@lists.linux.dev>; Wed, 18 Jun 2025 10:40:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750268449; x=1750873249;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HE4ZFr/3yO/kcvQGBFxRWJWFhigh7sWDavgkH8Q96v8=;
        b=IBJjXB8s86Q3MppHE5gBt9iNF6xnuuesvxDXHUFhvWuB2D9x4COFHRyyqrqegIgVba
         nPdnH6ssBeJp7kc2wxwu6ZBDa7JGMdwA9sLwmsCsrPnRsB9PXDOpbuX9wyaUES7qKLnt
         m2ozi8pBXUcK0qhYLguboCTXgkUJyUJk+N4AfrKdCsjJvhYK3W7CNj3VCQBc0YxvHzDV
         pIGWzH11POPCqXhdyXprZWlrzD76SWcI9rnsy30JLUZ+jKic4d1RUvXn3cVt+8AFv66/
         0u4lWVB5/zJ7q+nl5P/1cM/ihvlKiy03Rem+4MorXinn41yXiskYCt9eon/1bgDOA20L
         7o5A==
X-Forwarded-Encrypted: i=1; AJvYcCXGbUMh5o5uBt4kXcYXsilZDGil27t+qly2sU1MBnlP26em2dka+93PQz682f9D3A2+EzZ0W/kdQe50t2iUXw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzQujKrzdjIWiJoSH33pcbuZSvFWnC5XYw9cdaFZJyGl87BoWL2
	m8N2EdJ3ALqKk0Klfg9bBoO/O5DgzUyPYlPktBcZ0CuX8w6E/SSY7eHzGcHejg3B1UZu9HDCW6a
	g1lvRDgBhwNXQbZZBGGwO8UilQpzw3TM/g8VnQmHWA2+lUDJbKnuQR04cW/i62UUZiiGu
X-Gm-Gg: ASbGnctgv2Ku6hgnMWN/i6T1Qk5NdND77LqawO4RUYunhfBTqv6mQYW0CMxXEkDfptf
	iUV3gmQL2Gs7qL7bVWLMzS7SedNgjXLp3E+wD5074mT+y7Kcbc4grm7oUrCMyw1cuxuAW3XQtHd
	pGj0zXo+I5jkGskA0LG6L8IosfNtoat51ooe7LFy0qDlhk9D9ATH4HgDz/b9mqYe2co9QPHnOnQ
	gDCwkso1RJ1BW90Y5038TLQyEsx9CF6OlE/v9I0EaGZyMxkgukLHEL4jKZwl1qXiyNeRa2+7jsG
	tUvLDDGbYFebvhZVDH43YAPgPgwong1GthNCAQkRSGCKGeQ2wnYLfr0ElLkaetmRS0wSgoojrH0
	SXGvz2A==
X-Received: by 2002:a05:600c:1d8c:b0:43c:e70d:44f0 with SMTP id 5b1f17b1804b1-4533caad0aemr171064465e9.19.1750268449491;
        Wed, 18 Jun 2025 10:40:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGznKIGl3nAorQ6sfOY/mgzfowzauuqoYlpxs90ugUrSAZIVXpSWN8Es+fpzvWy+uQJD/IOZw==
X-Received: by 2002:a05:600c:1d8c:b0:43c:e70d:44f0 with SMTP id 5b1f17b1804b1-4533caad0aemr171064285e9.19.1750268449019;
        Wed, 18 Jun 2025 10:40:49 -0700 (PDT)
Received: from localhost (p200300d82f2d2400405203b5fff94ed0.dip0.t-ipconnect.de. [2003:d8:2f2d:2400:4052:3b5:fff9:4ed0])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4535e983c76sm3664265e9.10.2025.06.18.10.40.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jun 2025 10:40:48 -0700 (PDT)
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
Subject: [PATCH RFC 12/29] mm/zsmalloc: stop using __ClearPageMovable()
Date: Wed, 18 Jun 2025 19:39:55 +0200
Message-ID: <20250618174014.1168640-13-david@redhat.com>
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
X-Mimecast-MFC-PROC-ID: KG6_pcf9jpm5MiHCFP9yYVDdAbm9yDcnQ1NlkMMCE4w_1750268450
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Instead, let's check in the callbacks if the page was already destroyed,
which can be checked by looking at zpdesc->zspage (see reset_zpdesc()).

If we detect that the page was destroyed:

(1) Fail isolation, just like the migration core would

(2) Fake migration success just like the migration core would

In the putback case there is nothing to do, as we don't do anything just
like the migration core would do.

In the future, we should look into not letting these pages get destroyed
while they are isolated -- and instead delaying that to the
putback/migration call. Add a TODO for that.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/zsmalloc.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index f98747aed4330..72c2b7562c511 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -876,7 +876,6 @@ static void reset_zpdesc(struct zpdesc *zpdesc)
 {
 	struct page *page = zpdesc_page(zpdesc);
 
-	__ClearPageMovable(page);
 	ClearPagePrivate(page);
 	zpdesc->zspage = NULL;
 	zpdesc->next = NULL;
@@ -1715,10 +1714,11 @@ static void replace_sub_page(struct size_class *class, struct zspage *zspage,
 static bool zs_page_isolate(struct page *page, isolate_mode_t mode)
 {
 	/*
-	 * Page is locked so zspage couldn't be destroyed. For detail, look at
-	 * lock_zspage in free_zspage.
+	 * Page is locked so zspage can't be destroyed concurrently
+	 * (see free_zspage()). But if the page was already destroyed
+	 * (see reset_zpdesc()), refuse isolation here.
 	 */
-	return true;
+	return page_zpdesc(page)->zspage;
 }
 
 static int zs_page_migrate(struct page *newpage, struct page *page,
@@ -1736,6 +1736,13 @@ static int zs_page_migrate(struct page *newpage, struct page *page,
 	unsigned long old_obj, new_obj;
 	unsigned int obj_idx;
 
+	/*
+	 * TODO: nothing prevents a zspage from getting destroyed while
+	 * isolated: we should disallow that and defer it.
+	 */
+	if (!zpdesc->zspage)
+		return MIGRATEPAGE_SUCCESS;
+
 	/* The page is locked, so this pointer must remain valid */
 	zspage = get_zspage(zpdesc);
 	pool = zspage->pool;
-- 
2.49.0

