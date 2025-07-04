Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B70622F3C02
	for <virtualization@lists.linux.dev>; Fri,  4 Jul 2025 10:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751624743; cv=none; b=TD4GKqpD6AH5fnC7vyoB3rSWckhgDgnxd6TsA9uZX1rkazReloPjATUtcQuBtMkXcrHlhiADWevwJR8jjrqC/I6aYauOfGcw5d/O9NotONzfF0wYP3WbenKYNgi6m5KpxQKEV/ZDDTryXugcUybfT2g+aPee5tRdEkhWVGJgmYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751624743; c=relaxed/simple;
	bh=yirVZfO+dHe5+EJCXh68ilzI6s3sApzRdgd2Lx9ZJLw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=TtUseMwRk8V+7mA2bfHKo9r/voo+YuKuImLlOqiSRa1hquB/bDNjvApXR0LC3pdHg0C3bEDn63AX8w2+82Bf5xGTtBafLN77hbIh8MbWeBNguAg9FC+ivGEUJetmOKVbLZeRHYkW8Qo3wu7UWaYXz2wf6KHpBij6/H1GNkF3AlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NtUiAvpM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NtUiAvpM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751624740;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Km36h+57LoMclmINdAl2JdQwpEFbx1KUS9NaV7ZwoS0=;
	b=NtUiAvpMUPICAfbqX3UBTWG/iDZyYaUc9CQVnN7YXy52qwHf2sjD3WZqBPuXqXFKG2TFec
	DOY67fiRkW+z+XAd9h+kNZuXJ8dp5jnbQjl6SBK9O7JR/hjstijDNHLcHEabOs7ZZYD+9D
	+9xHqqP6kS4ZTfv9aE1HlxzV7bkf2pc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-22-MQqcQPg3MiqIHJTCKU3gFQ-1; Fri, 04 Jul 2025 06:25:37 -0400
X-MC-Unique: MQqcQPg3MiqIHJTCKU3gFQ-1
X-Mimecast-MFC-AGG-ID: MQqcQPg3MiqIHJTCKU3gFQ_1751624736
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4538f375e86so5909105e9.3
        for <virtualization@lists.linux.dev>; Fri, 04 Jul 2025 03:25:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751624736; x=1752229536;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Km36h+57LoMclmINdAl2JdQwpEFbx1KUS9NaV7ZwoS0=;
        b=tsZDVyvGqDUmp+jyOnyHM3Xmj2S+nlFDRYilWNjNATYOK9NJW6Bhu9PCM6Cj/HePU2
         tTRhmYwqXwDSjenUOcCwXFLagRwIc3t9zkTfnAWnHAd/hq3xnciho/wNSeOQoGS/4JtM
         qEBNOqx/757Sy1ZrQpGOZKN65oCbEjAVqQ8LElItRujPbFGrxBbSkMNiqETm/UDgSlQD
         XHcqm0No1g57erM/eEJfJ2BdrdBycgbwmi4V73n+t2NGu5hZ8rZAfJbt37hIyVFFrMt7
         dt4F8dkmxkhjjm2omWATORY+B3WuVATJ7VHkIy3JSAnRvlx6hTU4gd+wUrUhoIHVc6Ps
         +xzA==
X-Forwarded-Encrypted: i=1; AJvYcCV1H+zqoTlUWtPlhyS0A4D993oRRmrS/ezqhK26Dh0hT5LEvXpFweypum1Fm6eGLafb+5YiC5LZV4kWIL+BgA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxKw8rHhidXZx9k9rD6bVdBwoyV9qSGOZW0gir6iHpZWaZLKwmP
	TByzbZjC7oOyYCBuh3koYu7qN3EA5K49I/1yHKEYW0Mp+BSiHTEYOc5j6jNnBfQYiqkLI6Q/6x4
	k2hbDxiNURbe1lu0xWTYZtiBvmukBDLOtrRuMVie/gLOWAPN9JrubjxznWjcGtj8KD9JZ
X-Gm-Gg: ASbGncsUwXKD9vl76UvJ6pPLeZi+ek2eW+YOwmbk1anHHIWZw+uC6lHAt/0EdGhJLBK
	y1GvdhCzEYUov4NifcA8K2BaVSGp/FnvJagZZStB8wqKUr4Gs5+UbhtldyGfBcWISLoB6Fxkc7t
	fYS2jWnqNp2r15NIRz7H1USPTq/SzMR7WSuCF+DzlGQ7vkPb6o2D5gmQa5Uzh/nr41Zpi2CgX0r
	9Z4ZrTW9AiuSRf0+bAF/aWWA5cc3nvKBmQpCABP0zRvsVUY2nr2KoTOdYPuFxNLxoPym8W9zqVa
	ggw0gqZhKo44/+kuBXj5fMrlpy7G8WiY2aNmKD/9Hg9/nGAXZaubnVJC0QnPBdDgyxj8IGAVVFp
	Mtli63A==
X-Received: by 2002:a05:600c:348d:b0:453:608:a18b with SMTP id 5b1f17b1804b1-454b3096211mr21110775e9.9.1751624736369;
        Fri, 04 Jul 2025 03:25:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEYWTkwuG63kWN2pUNG4mMJ/rp0CK4ANHmE+tpQrKYs+JLvfC5kMT/JJWZ4Z30efeBW784Wqg==
X-Received: by 2002:a05:600c:348d:b0:453:608:a18b with SMTP id 5b1f17b1804b1-454b3096211mr21110415e9.9.1751624735911;
        Fri, 04 Jul 2025 03:25:35 -0700 (PDT)
Received: from localhost (p200300d82f2c5500098823f9faa07232.dip0.t-ipconnect.de. [2003:d8:2f2c:5500:988:23f9:faa0:7232])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3b4708d080csm2111024f8f.23.2025.07.04.03.25.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Jul 2025 03:25:35 -0700 (PDT)
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
Subject: [PATCH v2 03/29] mm/zsmalloc: drop PageIsolated() related VM_BUG_ONs
Date: Fri,  4 Jul 2025 12:24:57 +0200
Message-ID: <20250704102524.326966-4-david@redhat.com>
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
X-Mimecast-MFC-PROC-ID: limSjx2Qn0BCOKYx7w56Qcv4XXQ0UuDuBRBBSLIgXXg_1751624736
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Let's drop these checks; these are conditions the core migration code
must make sure will hold either way, no need to double check.

Acked-by: Zi Yan <ziy@nvidia.com>
Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Acked-by: Harry Yoo <harry.yoo@oracle.com>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/zpdesc.h   | 5 -----
 mm/zsmalloc.c | 5 -----
 2 files changed, 10 deletions(-)

diff --git a/mm/zpdesc.h b/mm/zpdesc.h
index d3df316e5bb7b..5cb7e3de43952 100644
--- a/mm/zpdesc.h
+++ b/mm/zpdesc.h
@@ -168,11 +168,6 @@ static inline void __zpdesc_clear_zsmalloc(struct zpdesc *zpdesc)
 	__ClearPageZsmalloc(zpdesc_page(zpdesc));
 }
 
-static inline bool zpdesc_is_isolated(struct zpdesc *zpdesc)
-{
-	return PageIsolated(zpdesc_page(zpdesc));
-}
-
 static inline struct zone *zpdesc_zone(struct zpdesc *zpdesc)
 {
 	return page_zone(zpdesc_page(zpdesc));
diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 999b513c7fdff..7f1431f2be98f 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -1719,8 +1719,6 @@ static bool zs_page_isolate(struct page *page, isolate_mode_t mode)
 	 * Page is locked so zspage couldn't be destroyed. For detail, look at
 	 * lock_zspage in free_zspage.
 	 */
-	VM_BUG_ON_PAGE(PageIsolated(page), page);
-
 	return true;
 }
 
@@ -1739,8 +1737,6 @@ static int zs_page_migrate(struct page *newpage, struct page *page,
 	unsigned long old_obj, new_obj;
 	unsigned int obj_idx;
 
-	VM_BUG_ON_PAGE(!zpdesc_is_isolated(zpdesc), zpdesc_page(zpdesc));
-
 	/* The page is locked, so this pointer must remain valid */
 	zspage = get_zspage(zpdesc);
 	pool = zspage->pool;
@@ -1811,7 +1807,6 @@ static int zs_page_migrate(struct page *newpage, struct page *page,
 
 static void zs_page_putback(struct page *page)
 {
-	VM_BUG_ON_PAGE(!PageIsolated(page), page);
 }
 
 static const struct movable_operations zsmalloc_mops = {
-- 
2.49.0

