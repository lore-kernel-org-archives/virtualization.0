Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D12128D828
	for <virtualization@lists.linux.dev>; Mon, 30 Jun 2025 13:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751288461; cv=none; b=DnS0zBqDoht9jHs/YrKSftS0YjFSPpr6G8Sm1Qkk97rnkgh6E0vxal5/xZLrUzl9Ut6GUod2dUU4rQGKNFbAuMDY6NVr7tfk07XuO+PBHF/WpjhBuIaU3DpYeM+TUupEByqGT4Bq2Ti73tGzQLXIxsnBJjeEjFmxZj/zG9Vy3/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751288461; c=relaxed/simple;
	bh=h679pTWyf5chDo0jTdgc5eTOddfWMzqMz/6J3iuD7Gs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=Y7ZvcRxTg/jncAnHRe7QpAhBsSff1F5cq08OuSgON7SoVMYvrMwTjvP23noHh/LaFBxs6YAbGZQ9ryc9SG8+yvqj8WZQtL1gl8QnPLDc7kB9Wrfe/PtJarsgBZek39bPaUjv3iPPyx3vxXg8X0cZxMsm+kbMatpSJj4gOVh2+lY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iZopPIkg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iZopPIkg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751288456;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rZbSryMy27xk/lWuJyIeQilPAEeTxdVw8qHGMwbITkw=;
	b=iZopPIkg+chd6Wnf99i0DX3sfmn5OCbjG5BTeDolZ5+xwnew8fbeDmGMrz9tCP1vljf+ph
	895iALiiw+0+fLll4BnrOjZ4WpQvkS1iqJOJ0jqqG42HJET9Evo4GkwVld3BQOkg1vvN+u
	o6vjSElhNuIQCK3x483upQhMBNLe1qc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-410-RliOLPhgP1iOpVSHyRtP4A-1; Mon, 30 Jun 2025 09:00:54 -0400
X-MC-Unique: RliOLPhgP1iOpVSHyRtP4A-1
X-Mimecast-MFC-AGG-ID: RliOLPhgP1iOpVSHyRtP4A_1751288452
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3a4eee2398bso1690599f8f.1
        for <virtualization@lists.linux.dev>; Mon, 30 Jun 2025 06:00:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751288452; x=1751893252;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rZbSryMy27xk/lWuJyIeQilPAEeTxdVw8qHGMwbITkw=;
        b=LcJ/Hk2KPLnd8ZcPYSb2yxWf8AmYVBYdk8fUXOrW8o+Q6/pglTSWqgVqJ3YWtbggT6
         XnSrPVBDM1ztWfIv3DybvDjkU3JZeqXJTyKr0lUrvhoPG74fk3/0K07ermq/mSmaSlaP
         Ea1ek1keJcJ1sLM9IBno4gAWmig5fx7O3QWjyrKb70v1dQPU70UkeHAmFoUvweRI+tQx
         f76jqwUNd1DaYkblEjZ1jC6a1TsSH9s5zEpG2wCdxePYCkBCtnEjaLOc1PBykti6adWf
         ChA9EShRdp0pWvDLFAHJa9z0t/W0VKrog4ZCP3Yy4hDN5AgZi0NAns4qm8oa0QtD8FHU
         WpLw==
X-Forwarded-Encrypted: i=1; AJvYcCVucHneDKfE3YJN5QQHJ4Lhl04Fbxlr9Kk29o0WMx9vMdAbMq1uxlFsPCE5B9JQIvllETxvRjL2TgnrpydKrg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxmYlgYv77yK6kHYZMRO0M+HJ/6PX2Sw66sFMBwx2/84kBLb54P
	QQMbbB5/1+ABDoqdU80bK5GSL4bCxmoPp0jmdgF5AsyrdPYE+s8dwaUfSA8ubzc/Y1abnFFW4rm
	UI5MdOLs4GnyNJsF9Kuc6ratNwqVXMxiC1N/RZWarzNW28PO4RmuqaBrqY7ocNP7pG9Mt
X-Gm-Gg: ASbGncskIRGFukTjLVxNl0Ib1/gfJslQc7uHFpnss87KQNo0xswqs1bPFAZ0CtPpGny
	6GuhiRSaYk6bY+3BzvMDIKloBiWlfV04h46+VmOc1G2trJgpl/Kp595WGX7RMzKyGxpx1lgCngH
	Rgj+4w1y/irkAX+++ENvySNivQV6b7ZsecHg7AC4OqlMcQe+Ma8kSu1MUH2rdXk0U+PjWFDwKxW
	Inn/EgPsds6vEB4Epljw8gx88Ll93hQMcEByWEO8YmSEsw8hJwBPzSbKjZOpWci4vjFjEQVP+Yy
	PIVh7QBQ1lzJLBZJLx5Tu1cZ+T2cS2krZaWjds/dx/iyzyBvdJAMouoOZbrCuZn8J+MTLhOxgdi
	BdfU/BTY=
X-Received: by 2002:adf:a143:0:b0:3a5:8565:44d1 with SMTP id ffacd0b85a97d-3a8fe8917d5mr8134389f8f.25.1751288451259;
        Mon, 30 Jun 2025 06:00:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEcHR74Vg3fOLDK1bhOkeMb0O7J5iWXrvKqq6qclu6yGGjB1xdv/xPEmRceAckepewzfNXHQQ==
X-Received: by 2002:adf:a143:0:b0:3a5:8565:44d1 with SMTP id ffacd0b85a97d-3a8fe8917d5mr8134296f8f.25.1751288450453;
        Mon, 30 Jun 2025 06:00:50 -0700 (PDT)
Received: from localhost (p200300d82f40b30053f7d260aff47256.dip0.t-ipconnect.de. [2003:d8:2f40:b300:53f7:d260:aff4:7256])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-453823b6d50sm167133055e9.30.2025.06.30.06.00.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jun 2025 06:00:49 -0700 (PDT)
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
Subject: [PATCH v1 13/29] mm/balloon_compaction: stop using __ClearPageMovable()
Date: Mon, 30 Jun 2025 14:59:54 +0200
Message-ID: <20250630130011.330477-14-david@redhat.com>
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
X-Mimecast-MFC-PROC-ID: gaBft3q35nq92p_3e8e2aZI1hSTlBwCUE9FbebSawF4_1751288452
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

We can just look at the balloon device (stored in page->private), to see
if the page is still part of the balloon.

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

