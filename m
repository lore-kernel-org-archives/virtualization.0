Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5A7728CF4A
	for <virtualization@lists.linux.dev>; Mon, 30 Jun 2025 13:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751288460; cv=none; b=Q0gwAj57EA48nIInYaRr/M2dN3Web5jqBeC5EKc7BKR6bSZG2IXFR2iJprXJod5fi36gBUOvDzw9tkUTLOqf9TQgHT4dpATGAyT8fb87ZTC9n5RW6/6tJERwB212mfUQVJHCl1SyyT/jZi03nc6xLpoooayt/HHbyfCkweYTIss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751288460; c=relaxed/simple;
	bh=B4KdnntE/37K79ZPh7jyK3I0hRR/1p6A2DVmbrYflX0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=hT4awGqMY7vpjGVJBRfvsJhu0GQTmZPs6yjhGj5kjFH2PFXQ+T5r+FVerbUR6aqJWFRAB6Hqb2HBj2ilrwWGDeNBcYkoBYb7UIPhUdeDCjDbihbHYIedd9LnGsLKrT001qJWlbbxYvdqPMIzf2khb0fgmC8bzqyjx8FTMUHaFt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F7X7GFqv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F7X7GFqv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751288454;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HE4ZFr/3yO/kcvQGBFxRWJWFhigh7sWDavgkH8Q96v8=;
	b=F7X7GFqv/rB7W7PAaVotWQ4OSTg96AgGCp4MvB5PWRtDVUhTtNqUmNr2Q00xxz6FzPyVPA
	3jCT64PkdW3PRAnh4jb/PV20yUEnBIibe/s4IawWZlRHhrwojHCcYvbV7UoQWxmFHKiHT0
	/+zqIlYbem45o7bDCSo7sGP1B2/N2Qc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-607-mTM8CBN0N66IAO4S_Ypw2g-1; Mon, 30 Jun 2025 09:00:53 -0400
X-MC-Unique: mTM8CBN0N66IAO4S_Ypw2g-1
X-Mimecast-MFC-AGG-ID: mTM8CBN0N66IAO4S_Ypw2g_1751288451
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3a503f28b09so2270034f8f.0
        for <virtualization@lists.linux.dev>; Mon, 30 Jun 2025 06:00:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751288451; x=1751893251;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HE4ZFr/3yO/kcvQGBFxRWJWFhigh7sWDavgkH8Q96v8=;
        b=VvpN9G9E/ZYfd0vZiTqOIM5F/uXA3Rdxc1BQhy5Mzglwc3d74c9l0YtWKgMFYzpUqk
         9WDzCkIx7AtZrVRNEhIRqP0GMRSYoxUbO9jc6V6oVjjhZrIjp6ViYIt0sQ1VHL4qqVjN
         xA9JftL6vfwrnwQk+ErplryfXDehN7lj8WJFT8KdcvJt5Juw33ALPknZoKK/NZnfx9Si
         dxjsTr3c16XqYsRI394agXyXGPgBKnN+cRzIC0iKNyZk+r0Jr1tvDHBTtWIlgizhEkga
         bB2G/wtQey4F2gXpYbTXI5aPQG3p19ZMDybmojS6R7/XmzfJZ/oNGWVkn0ReDsorBIv6
         c7+Q==
X-Forwarded-Encrypted: i=1; AJvYcCWmJbnFHveUSJq2llJ/eox2zZs0hVgwZQM3ta3lPmFqt6FzgG2kJQKvav9ATNOXe1YqSgreiZyYTmcGb4xMMQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxi/ZlXO8eOp7FY+upbPUmmap5p86Pm9q/v7QK1Fu36wWVh8iGr
	s7LdAWg7eW2mZOhz0JgkynlF1m1HCD7JZsWf7d12nVW1K8zeXXteCqkfOd2n+H4VowJnfPFwxMy
	hKYIxKlaUg0v14dp1W+azscTfjenU0o9jVw5ILTQE98eOc8aVLIrfVwE7lElDEazCx8kP
X-Gm-Gg: ASbGncsAHIT3y4jCjg+IqCM4/at2C9tZxY1ztm7lRQU9pyLwOTsmHiajRL2MPs84ljI
	5GPN8v6roBSyV9S3rEuwAj+N9PeXPPFSMbmYkwHTp4jwbYaxDmXiPEb1v+ZYJ53Eo0Bi8rXHGgq
	Ci9RUfDYtQbZ78Pn4u/ShmzAVqv0sZNAMMJDa417ClTawUlusutqs6Gbyu27GanN0bv4BzTmAZJ
	4hLfoHGRXpvUZYp5iylOdUcAzEGX4uX8g7+6KkqOR4I7S60qAdqd2OamlrtgfS9kfifjhIX76ek
	5LYngAiM+HAeZ9P34H7RNyJD9+eBKfBGLMEzwTcXFi+FWxhCdB6SIpZ7IwYQSUnSIJGoLj5+j3D
	ueM0Z7lA=
X-Received: by 2002:a05:6000:2186:b0:3aa:ac7b:705a with SMTP id ffacd0b85a97d-3aaac7b761amr5970189f8f.11.1751288450495;
        Mon, 30 Jun 2025 06:00:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHB1TGCDIUZET9zX0pBSLAtGHjOK3AMuobCCTliN5r8xMP/2a92mQUobTb4bSUGBJMrG9p6Jg==
X-Received: by 2002:a05:6000:2186:b0:3aa:ac7b:705a with SMTP id ffacd0b85a97d-3aaac7b761amr5969952f8f.11.1751288447748;
        Mon, 30 Jun 2025 06:00:47 -0700 (PDT)
Received: from localhost (p200300d82f40b30053f7d260aff47256.dip0.t-ipconnect.de. [2003:d8:2f40:b300:53f7:d260:aff4:7256])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3a88c80b5aesm10252042f8f.44.2025.06.30.06.00.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jun 2025 06:00:47 -0700 (PDT)
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
Subject: [PATCH v1 12/29] mm/zsmalloc: stop using __ClearPageMovable()
Date: Mon, 30 Jun 2025 14:59:53 +0200
Message-ID: <20250630130011.330477-13-david@redhat.com>
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
X-Mimecast-MFC-PROC-ID: jWQxlpFxpv6hacg4hf4vi5H3IyQB7amzubJ9J7dR75w_1751288451
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

