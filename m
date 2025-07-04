Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7AAA2F5C5C
	for <virtualization@lists.linux.dev>; Fri,  4 Jul 2025 10:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751624768; cv=none; b=m8NLMPfjpAI7J5dglhUbE4dcWusAVETiwiI00kRzeZkUJ7nC5Iin9R7OpjiCm9znW4OKR7/4WfKGYeg5MpIPGEFGH+0Y6AdNn2qwk7GIBak+ILIl2z4cew6wtQLB11uW0nIvovzGlSzv1kIjro9Mwfz43XMmU+O92mEw2n53+Pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751624768; c=relaxed/simple;
	bh=CJvf72yESzg/zFJwrDYpnMTY8h01EO1RxbRXdSXev+g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=QdsaqnsDz4Y/ulddz1BtJjAVX3FE9/8FgXqOPF17opR2X7DDW6akhnqg2nXUFkYvzyc6oVy8D3I355M28BqJk9fux3/4z4HC/JkHPZedaRwSQeooE1CYLsBI2i9FAAPPGn5uJEAiLbmoqKcvW00SGWVxUt0QfvzaHYdLADa/FZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bBVhM5W8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bBVhM5W8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751624765;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eEGwdfNaBPNS/8dJw0FmIxAN0KCCoCPylWzGW8IBtSE=;
	b=bBVhM5W8Y9zCQtfQyVTpB2vMFL7CeC5hll0dMyDJKw624408Bgd/zfyI4pN+Yki8BTp6h0
	hWuILH7YYe5K3RhCC+f2MZTFOrtAwori9CL+Fyg1rh+swv7r2jwaMpcOoU0DTupHesgX7V
	Gg/sYCxTrW1I900kRAGRHdUCqBs8ijA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-650-ss6_UMZVNgiKeVWG_xcNRQ-1; Fri, 04 Jul 2025 06:26:04 -0400
X-MC-Unique: ss6_UMZVNgiKeVWG_xcNRQ-1
X-Mimecast-MFC-AGG-ID: ss6_UMZVNgiKeVWG_xcNRQ_1751624763
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4530ec2c87cso6378525e9.0
        for <virtualization@lists.linux.dev>; Fri, 04 Jul 2025 03:26:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751624763; x=1752229563;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eEGwdfNaBPNS/8dJw0FmIxAN0KCCoCPylWzGW8IBtSE=;
        b=t4JCFXxbaLzXshgo2/3Vak5wUJk3ziWkKZ3OX+Z5qhmckM62jF5D5oJrCpt24Zw6SZ
         /9uTkSMLhRprZUTO+gsMx7T8LeRv8rwXWOn1WUXK3BYL1w1UZzHn9RIgTd+IXmw4npPY
         e/TDM0u/XacFXiv6A8bMwNYJBGyzgUxVvFQbdYya2iO+PO9X963ORHNMMoL7aLkHRZdv
         e4FlAe4EOwmCmc8ZURXWN94EMMzVxuLRfs38A4aGZ0KvhsXSNvM9AKuhRLCowegMZve1
         LuayMyXIalbe2Q4wR46lRPhl3I/629VjtG+4KbpMRBwjbZ0u7puir8GOVUmkV+iG9m6A
         b3ug==
X-Forwarded-Encrypted: i=1; AJvYcCU6cRMK+626RkfYi4XGGChjJt4u9dxzioTXOebMxonZz7Rwio2b8V5uaHxtIwKIUfdZ/IhpXQFF964we+fn9g==@lists.linux.dev
X-Gm-Message-State: AOJu0YyBZCQC/5ejjGLZx+ojeKte9qtlCBJDbBTvRLtuAuC9EU8j1Ee9
	jX8teJduecY8uJ/0F4IzbNwP0Pm0a6JEGmb9gPwZb2ENESJFZrZb6Gp4OLLqwsGBMhSM7OwkNBu
	tnHsb9/SFbsVMMmpcpeYvOQZuQJWiLZL7gXxtAVaVGf8u/haJybn5JtbPU3C4XMFw0x4c
X-Gm-Gg: ASbGnctjfeJFIc5EUobO58eYTVtxLohoMKG/uWugCdvJU1QJKJD6UqRRaZzEs6vcOB1
	XTpCqVb42hzgkBCzEBKDL8JJRwM1z+NxaCRjsmJGZAtVwXaVZzOczm5Z+kUT5cAx42onQpfVfSZ
	WPUbeRWsvzCu2rbnieNSywyi+4YBMmf8avR21X5SxGhYbctebXleCe7yWieImw5nq8pwTZF0brV
	2Xcah3Q0zXqfQyAQi9WagjRhZrhsz0ffe1XNHq2SYTFzwg+Lrug5oQ/49PiiL/KLPRe5U6to1Ek
	QZdhCADjg4Kx/UPR2ZcsUJMM0TmQL9dK/g0NStWqBr5vdQhB/zNU0adKQ6DcrNiCgwhIpzNIBEy
	z/AJ0Gw==
X-Received: by 2002:a05:600c:6488:b0:441:d437:e3b8 with SMTP id 5b1f17b1804b1-454b30fd93dmr18455005e9.23.1751624763375;
        Fri, 04 Jul 2025 03:26:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEaIuaoI26pT9FgBV1ege1h6FCnLUNFU1vB3jXtS4mgBNx0jG0s+pACxWtozwax9rYlgVZB5g==
X-Received: by 2002:a05:600c:6488:b0:441:d437:e3b8 with SMTP id 5b1f17b1804b1-454b30fd93dmr18454285e9.23.1751624762724;
        Fri, 04 Jul 2025 03:26:02 -0700 (PDT)
Received: from localhost (p200300d82f2c5500098823f9faa07232.dip0.t-ipconnect.de. [2003:d8:2f2c:5500:988:23f9:faa0:7232])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-454a9bde3b9sm52654415e9.28.2025.07.04.03.26.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Jul 2025 03:26:02 -0700 (PDT)
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
Subject: [PATCH v2 12/29] mm/zsmalloc: stop using __ClearPageMovable()
Date: Fri,  4 Jul 2025 12:25:06 +0200
Message-ID: <20250704102524.326966-13-david@redhat.com>
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
X-Mimecast-MFC-PROC-ID: UENvL9Cv-diAF3fDnTrYfRPvGjiMWhAllsCpVenZVNc_1751624763
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

Reviewed-by: Harry Yoo <harry.yoo@oracle.com>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/zsmalloc.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 626f09fb27138..b12250e219bb7 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -877,7 +877,6 @@ static void reset_zpdesc(struct zpdesc *zpdesc)
 {
 	struct page *page = zpdesc_page(zpdesc);
 
-	__ClearPageMovable(page);
 	ClearPagePrivate(page);
 	zpdesc->zspage = NULL;
 	zpdesc->next = NULL;
@@ -1716,10 +1715,11 @@ static void replace_sub_page(struct size_class *class, struct zspage *zspage,
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
@@ -1737,6 +1737,16 @@ static int zs_page_migrate(struct page *newpage, struct page *page,
 	unsigned long old_obj, new_obj;
 	unsigned int obj_idx;
 
+	/*
+	 * TODO: nothing prevents a zspage from getting destroyed while
+	 * it is isolated for migration, as the page lock is temporarily
+	 * dropped after zs_page_isolate() succeeded: we should rework that
+	 * and defer destroying such pages once they are un-isolated (putback)
+	 * instead.
+	 */
+	if (!zpdesc->zspage)
+		return MIGRATEPAGE_SUCCESS;
+
 	/* The page is locked, so this pointer must remain valid */
 	zspage = get_zspage(zpdesc);
 	pool = zspage->pool;
-- 
2.49.0

