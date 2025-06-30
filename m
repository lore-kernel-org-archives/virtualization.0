Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DD1328BAA1
	for <virtualization@lists.linux.dev>; Mon, 30 Jun 2025 13:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751288436; cv=none; b=eA1X4sHQAPwNShI4+CHakHRUpF+Quvi1qDKgZzIZkwk7bieRNsjbtUyFMxco4tYwjNuUr5lHfGBBjiSLGUk0aDRFQH8+xk67UXFbUp+VSyX0qMrnDuk06s8ACsOX+drVvw/pqGVzfmTEFqwOL+pH1Sdzl9SSJ9KrDviAfIiR6QM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751288436; c=relaxed/simple;
	bh=19X4bQvLwR3+OfNQbpdo9I8RjESqqjGAQVBNJ6TpCho=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=Q480gonpuvhA/yTq+Gw2lvA+dbG3Sgwr7L9oGgLK/9fvj0UsSGlu5ypfejhlblnKjsqJo2dqmC6UMVG6fe3E1z2bsksZz39XxCxWJe8oUdNjiAnI7yuN+To/6M22gF3JQG59e8yl89bn9TWblyYo00L/NeMjq7fYHNHVOn6luYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=It+nzEJa; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="It+nzEJa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751288434;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nJlezl1jqk1KHM/JmX+CbcKO2aiRBLF0rBMpUlNHwJA=;
	b=It+nzEJaN75faqwPBNjXXeNmnzb24bI0ik1fN+8ouPaeCeZdchkQC4v5PoSIL0AvaVK9g6
	BSlKiU3uApH7+LYfrZ4Hl81lTw9Dl12DB3AtipT0wQY/gughHp7nZdkhPKl21N2LwSfgYA
	GUt6A4ghLT8Laphkk3u7NrBgh+njcfY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-426-57IWJEkUPh6biuStmwxsqw-1; Mon, 30 Jun 2025 09:00:33 -0400
X-MC-Unique: 57IWJEkUPh6biuStmwxsqw-1
X-Mimecast-MFC-AGG-ID: 57IWJEkUPh6biuStmwxsqw_1751288432
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3a6df0c67a6so1309081f8f.3
        for <virtualization@lists.linux.dev>; Mon, 30 Jun 2025 06:00:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751288432; x=1751893232;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nJlezl1jqk1KHM/JmX+CbcKO2aiRBLF0rBMpUlNHwJA=;
        b=PCuMQaGZTc6lz1SanA4FumpZLgwXSJ8zpS4XC4yd4+WbgdNopU0JvIXo2ToV3V/vsJ
         LkiEDe6+KbBduaz80gRe6Tw44ro2pD0HN8hHF8/uxcgYyUTcoEdYo0cMJr29bZNBQW0s
         agXlG3TZLsky8T5RPShNEOdwZqaQyxbBafbvGIlzNVwhONuPZH7ayYh1No6OBmisMzf+
         d6N4100840CpII8VgHeEvPaPbCtgYjf8QuYlEDO9bJrAh1E11NMY53kovWVHbWO8WVms
         WDGU5A/PXWZdpW8egaILrkHs+h07i3zIQKdya/swqRKAE+G5kZnnQN0zE9Y0qYbATW0g
         PYqA==
X-Forwarded-Encrypted: i=1; AJvYcCWntjFzzLhiGVGvrEEEDzT+ejBhOsSA8kcYU8hGFkW26H+fx+l56IeMyNcaketZ3CPRumWTqtdM7agYl4+ppw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwkAhwWcZo1L/mYMg70PnWR5qucteBounDYRhHRhe842ArPQB0X
	rDzlZ3knGjCFbjpRs3eFFLXtfybtk/qru5APHtOFpplfY5bCTIC5AvjoSNR8M9B1nsDuORLwxPV
	0xZb/HLnee66wvatlI/qrCQFO1SURp7jVXjYeyrUa7dVxJ4+JaO1rEYgYmy6p01DFL3qS
X-Gm-Gg: ASbGncv1VpIALiWm1Dp2xTqcDyzlnIi/sHGRjsnN38LQBH0owuV9OY4/FRWIQWx2f6I
	jFMIXeU/9wT86fl3GBYig6BiyvEu5fF1hbwOY9WzupqMSsueaPoQk1faM7mmRD+i/kGp3286UJw
	xTkmnYtBDQ3xF+jgG/lilLGc+YNEk4LKx0L9KaUmDaUmk/ZwKegRWGq0skkKl7X4+nQOmb4q2Mr
	hAXe0L1C+nvOdVyM5sHX2PAgSi+fQTAqe6ifIattrpp++Cj0l98uKAreYyrt4oNR0G523FPt7Ky
	Tz+baYF26gOkSsS3LQC2Y1CEr1AwBCi5SKiX7PXPvAI2BrVrYpfeI0b0OsvM/sVfvmKQ3UvYAGL
	Oae1ZRuk=
X-Received: by 2002:adf:e181:0:b0:3a4:f038:af76 with SMTP id ffacd0b85a97d-3a8feb844cemr10501267f8f.53.1751288431548;
        Mon, 30 Jun 2025 06:00:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFGEarPHGaA16flG07pTm8Y+2ZoBRaEqSqyGzIU15EPr/yTHmV5lKxwKCSS//XnEer0oKPVNw==
X-Received: by 2002:adf:e181:0:b0:3a4:f038:af76 with SMTP id ffacd0b85a97d-3a8feb844cemr10501216f8f.53.1751288430998;
        Mon, 30 Jun 2025 06:00:30 -0700 (PDT)
Received: from localhost (p200300d82f40b30053f7d260aff47256.dip0.t-ipconnect.de. [2003:d8:2f40:b300:53f7:d260:aff4:7256])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3a88c7fadf3sm10557609f8f.34.2025.06.30.06.00.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jun 2025 06:00:30 -0700 (PDT)
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
Subject: [PATCH v1 06/29] mm/zsmalloc: make PageZsmalloc() sticky until the page is freed
Date: Mon, 30 Jun 2025 14:59:47 +0200
Message-ID: <20250630130011.330477-7-david@redhat.com>
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
X-Mimecast-MFC-PROC-ID: iJpi2839M21D7EdQ4NfM58qLx5j16vVLFoo60frTOs0_1751288432
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Let the page freeing code handle clearing the page type.

Acked-by: Zi Yan <ziy@nvidia.com>
Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Acked-by: Harry Yoo <harry.yoo@oracle.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/zpdesc.h   | 5 -----
 mm/zsmalloc.c | 3 +--
 2 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/mm/zpdesc.h b/mm/zpdesc.h
index 5cb7e3de43952..5763f36039736 100644
--- a/mm/zpdesc.h
+++ b/mm/zpdesc.h
@@ -163,11 +163,6 @@ static inline void __zpdesc_set_zsmalloc(struct zpdesc *zpdesc)
 	__SetPageZsmalloc(zpdesc_page(zpdesc));
 }
 
-static inline void __zpdesc_clear_zsmalloc(struct zpdesc *zpdesc)
-{
-	__ClearPageZsmalloc(zpdesc_page(zpdesc));
-}
-
 static inline struct zone *zpdesc_zone(struct zpdesc *zpdesc)
 {
 	return page_zone(zpdesc_page(zpdesc));
diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 7f1431f2be98f..f98747aed4330 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -880,7 +880,7 @@ static void reset_zpdesc(struct zpdesc *zpdesc)
 	ClearPagePrivate(page);
 	zpdesc->zspage = NULL;
 	zpdesc->next = NULL;
-	__ClearPageZsmalloc(page);
+	/* PageZsmalloc is sticky until the page is freed to the buddy. */
 }
 
 static int trylock_zspage(struct zspage *zspage)
@@ -1055,7 +1055,6 @@ static struct zspage *alloc_zspage(struct zs_pool *pool,
 		if (!zpdesc) {
 			while (--i >= 0) {
 				zpdesc_dec_zone_page_state(zpdescs[i]);
-				__zpdesc_clear_zsmalloc(zpdescs[i]);
 				free_zpdesc(zpdescs[i]);
 			}
 			cache_free_zspage(pool, zspage);
-- 
2.49.0

