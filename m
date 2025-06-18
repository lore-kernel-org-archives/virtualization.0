Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC5F2FE32F
	for <virtualization@lists.linux.dev>; Wed, 18 Jun 2025 17:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750268461; cv=none; b=KFyaXAIAycTOzWnxnyA+kY0Sn7lgYI0JShemhonIaVVKO2RZPxcl4CkRPGImXpBpQDXF9pVC9N/5oTe89Dyidr5xWAWLrtVmvmTAEgBVu5FCJ/dn45dfR9HdvZbNC5jfHOI6FMSIpQBgQzboj0GMId8aVmY3j2heNiCtOiG+dDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750268461; c=relaxed/simple;
	bh=qF9Vy6Hq3fkswUG+ny4V9wMgoAlWF7MBQAZDgFpHwys=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=hFK/kd+J1xfS12x5TNBhaelBt78XwVI23IKXLO3zJ047evx13fdko4mURCExZXAqD60dekAde+miibAS6XMhT0s3h+V2b5SP1MIBeXPYFWDEdih3S687+76f6MtyW7c//Ac9DfQpisOLED+5l0a6sO/WXznkmCtrd4PAmjkw2Rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fc4OJfnC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fc4OJfnC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750268454;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l6C8lbjEXu6LV6W+fOxtWyWYf418kuz/nIG8TPoHlVI=;
	b=fc4OJfnCBw6j5q7OF93nF5BrM1rsO/ZUajsr4VHVxbZFZXJ3H64Dvfd7FdvSf9/QGOqOU4
	mmaCNVZ+Lp0z9sQkeEYnlM2i8hPXwIlaj7Xa1nUkZ/ZxJIOuNOuFuT9R7UrU1zbtdjgV1W
	2gmiO17EpIzfTzuQ2zmsgeN8Zk1HOwE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619-iOiR-irTN9WavST8ab0-Nw-1; Wed, 18 Jun 2025 13:40:53 -0400
X-MC-Unique: iOiR-irTN9WavST8ab0-Nw-1
X-Mimecast-MFC-AGG-ID: iOiR-irTN9WavST8ab0-Nw_1750268452
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3a52cb5684dso4142299f8f.3
        for <virtualization@lists.linux.dev>; Wed, 18 Jun 2025 10:40:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750268452; x=1750873252;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l6C8lbjEXu6LV6W+fOxtWyWYf418kuz/nIG8TPoHlVI=;
        b=kNFEZXn9DuEQUDG+wpHE3OWSXtuUvy17stS6bEd/hfUjfM9QwnBFJEwCxdEknXw19l
         eEuN3xoBmU9Z33sVitcvw6iDfJRTCYVXrPDhgXbLnyKgLrn34++5K+2HVwmnY1cgcGDk
         bOT5+WbhQgEGo2m6ih1KipCOaCQM5ZHGE3Ey3nX9IUQtZPymKMhk3ZVWGMQVe4bK6YPl
         g38H/JsH3KDcPo9RtdXNT2vNX86qpDaFnJuHJhRJGWD0HVoACy1uRNVGQpgwNv8spu9Q
         yAIecDeEIpFvMDZ8e8Mm5Yxj4Vw0wdYASM/jG1pO3/8Cv2X1G8vGlxij68dtOIktP9Bl
         IIBg==
X-Forwarded-Encrypted: i=1; AJvYcCWGnciJOyQIGueohyedM7hQwIYGNqKTxi+1w4aOfZZzN20Wpt+V8G7LMr3u7sI2CeWOQ26Hu7tm49wDggLS0Q==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw/rbcg4eqJ+RG1EVWj1Aclgnd80EyEoaReyKoeZqmMPorffJCv
	qGXpunrRONqbRotm5DWXP+NEnV/0dhJGA2VVKz8FrDEoFqJkx65IgaymGWaDXBQCxqnfnd+wimx
	O11Eotzjh7WAwtovm9u1pzkHA67FNAAQhzXid5qVPqKkfx67HSo5zHbtQ63vzIYc43b06WqEfKP
	xKWW8=
X-Gm-Gg: ASbGncva2l2eIhFCrR29ct3rafk2arGZ5rh9DKJj6VD391FrydpjvoblERHyjb2FbVT
	+c0e/3wRfkhxQ8vo9QT8Pb3hgtz2piRnpMFERKmUNL2L9g/1njXGluYek32+HAOWOOQ+KZFhh6/
	Mx5+xpXeMU8xHs3Ztqcjcmrk+tR9yfwSGnKQ3paVBtR+xYKF0Mwz9D7G+K5+DciU6StlGynAH9W
	48lGwc25JbMUmH+NEeOqTw7dNMNWMzdnI62dSjKiKx5Kf83F3hAf033wgFCZbRm6BdP5BxqaEcr
	X9OWKqJQhalnRoujdc9o/yM4iD4Hj6Qb9cy5Aa0m7UQh171Fy+F7fRUUhi3ke3kLGfoJlSUhuIt
	bjgDVQw==
X-Received: by 2002:a5d:64ce:0:b0:3a4:f513:7f03 with SMTP id ffacd0b85a97d-3a572e8bfb1mr13954330f8f.44.1750268452315;
        Wed, 18 Jun 2025 10:40:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG4X4ziwIkhys2144e75SHEIZN/Ibpbo9aRHgWcvkByvBS3juQ4aklJtEd9sXicogG+MbEwPQ==
X-Received: by 2002:a5d:64ce:0:b0:3a4:f513:7f03 with SMTP id ffacd0b85a97d-3a572e8bfb1mr13954276f8f.44.1750268451787;
        Wed, 18 Jun 2025 10:40:51 -0700 (PDT)
Received: from localhost (p200300d82f2d2400405203b5fff94ed0.dip0.t-ipconnect.de. [2003:d8:2f2d:2400:4052:3b5:fff9:4ed0])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3a568b089c2sm17710418f8f.59.2025.06.18.10.40.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jun 2025 10:40:51 -0700 (PDT)
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
Subject: [PATCH RFC 13/29] mm/balloon_compaction: stop using __ClearPageMovable()
Date: Wed, 18 Jun 2025 19:39:56 +0200
Message-ID: <20250618174014.1168640-14-david@redhat.com>
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
X-Mimecast-MFC-PROC-ID: MtNUBwt2H7Atk6s5pYiNPTT_on6uBEQcHDmHzeyP59Q_1750268452
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

We can just look at the balloon device (stored in page->private), to see
of the page is still part of the balloon.

As isolated balloon pages cannot get released (they are taken off the
balloon list while isolated), we don't have to worry about this case in
the putback and migration callback. Add a WARN_ON_ONCE for now.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/balloon_compaction.h |  4 +---
 mm/balloon_compaction.c            | 11 +++++++++++
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/include/linux/balloon_compaction.h b/include/linux/balloon_compaction.h
index bfc6e50bd004b..9bce8e9f5018c 100644
--- a/include/linux/balloon_compaction.h
+++ b/include/linux/balloon_compaction.h
@@ -136,10 +136,8 @@ static inline gfp_t balloon_mapping_gfp_mask(void)
  */
 static inline void balloon_page_finalize(struct page *page)
 {
-	if (IS_ENABLED(CONFIG_BALLOON_COMPACTION)) {
-		__ClearPageMovable(page);
+	if (IS_ENABLED(CONFIG_BALLOON_COMPACTION))
 		set_page_private(page, 0);
-	}
 	/* PageOffline is sticky until the page is freed to the buddy. */
 }
 
diff --git a/mm/balloon_compaction.c b/mm/balloon_compaction.c
index ec176bdb8a78b..e4f1a122d786b 100644
--- a/mm/balloon_compaction.c
+++ b/mm/balloon_compaction.c
@@ -206,6 +206,9 @@ static bool balloon_page_isolate(struct page *page, isolate_mode_t mode)
 	struct balloon_dev_info *b_dev_info = balloon_page_device(page);
 	unsigned long flags;
 
+	if (!b_dev_info)
+		return false;
+
 	spin_lock_irqsave(&b_dev_info->pages_lock, flags);
 	list_del(&page->lru);
 	b_dev_info->isolated_pages++;
@@ -219,6 +222,10 @@ static void balloon_page_putback(struct page *page)
 	struct balloon_dev_info *b_dev_info = balloon_page_device(page);
 	unsigned long flags;
 
+	/* Isolated balloon pages cannot get deflated. */
+	if (WARN_ON_ONCE(!b_dev_info))
+		return;
+
 	spin_lock_irqsave(&b_dev_info->pages_lock, flags);
 	list_add(&page->lru, &b_dev_info->pages);
 	b_dev_info->isolated_pages--;
@@ -234,6 +241,10 @@ static int balloon_page_migrate(struct page *newpage, struct page *page,
 	VM_BUG_ON_PAGE(!PageLocked(page), page);
 	VM_BUG_ON_PAGE(!PageLocked(newpage), newpage);
 
+	/* Isolated balloon pages cannot get deflated. */
+	if (WARN_ON_ONCE(!balloon))
+		return -EAGAIN;
+
 	return balloon->migratepage(balloon, newpage, page, mode);
 }
 
-- 
2.49.0

