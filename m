Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01BBB8462
	for <virtualization@lists.linux.dev>; Wed, 31 Jul 2024 00:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722384172; cv=none; b=FgrBgDByOF2LYFgG8bJQspMDCWxP83ErI23zHmAMuC2Kq3M+bUhdMXDOxzInZFjgU/s3SSArLefj9T1wL/hpU1ApKpReb2kIQyirlfx8goTYR8jq+TgR0m0ee2w0JA/1Syvjj/iP2LDsKTPxSzVgEa+sHEEHi/7FZF6p5D7Aegs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722384172; c=relaxed/simple;
	bh=nY+FLxuTElyz6Jzwyg8rc9iV7qdvZsDSLDdWPhWf2+s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TzeSEO4gspjxcBR0EYl3Rr8/j5K7LkU71TaeuJZKQKVShG8P98ekLeAcaEdtYOKNu98XMEzwqudJ+APufndMwza9bOakr9k/XS2S846KDMJEQn9o+eRSSkzLk20gvQ96a1td8UezIjpufWQfODTGCCo7Qeax0NGkbehxzOZZZys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jm+zmf8J; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jm+zmf8J"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-7a1843b4cdbso3003908a12.2
        for <virtualization@lists.linux.dev>; Tue, 30 Jul 2024 17:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722384170; x=1722988970; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R9U0Fc8KKm2y+wN/fyBwzUhu47z8lWa3dO4TTNX5JgU=;
        b=jm+zmf8JX3HG4mBqXKaVeTnbpa9efP8wRUDyK3K80+RtLDXJIleV957NItMSKAqZZJ
         yvNj6T80m64j74ralz6Q6Eh4fc0U1wiZTdNjBX9Qwbl4/+VRfsony2gGApO0Ri9U+3OD
         J7PU+Q46IYoVNLp+zAxjGxc6B6XlevfgQmzqio3h62Fj381xRlPMW8E147v1GOcD6pcF
         ldcX8C9y+ntA9ewl30FvohHo1x9wBRn7ovdwMqwtTqea+mK7PW+Lhoto4tx+oXilu3Uj
         13vdxvZ7Y2ir5f2sAbWNO6reW6Bd0ywslkhxHgK0OBk+Wo6W8cRmsuoX/GSZkqvhUcTd
         9lJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722384170; x=1722988970;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R9U0Fc8KKm2y+wN/fyBwzUhu47z8lWa3dO4TTNX5JgU=;
        b=g15UeJUX2KbZfAyJAltaVPPA/V5O5CUtGchN8DXPKX+xbecpbxlHGfSKAhxeVUSIOW
         vSGTZ42fPBAwvsdQZyzOJHc34NAqTmjzEM7rqR+JWCcWYBvZ7Ns717jazJRVaNuYSRe9
         iEW9k99/5qNbRirU0xKCcIvF6kGSl5WJ7ySotNbvLIMtEpK0PJ0E8qz7RJpW/dRcJ8Iq
         8o2k0p1Ll/Rznr6Hv5l5jv0vyFVzUzBkz161f4woizGmtiJpqLGMBjRTgDA+wlJnHGd3
         q+CBJPzump2PmO+kZZguQy+DOhB4fgJR6EIMwrC+oiPPv9JxEdr021EUH3iDnPYdGPRB
         aR4w==
X-Forwarded-Encrypted: i=1; AJvYcCXAWC65O2qadTeEfcWx6WAqXK/MNSgZSYFxlluM2syPf9sy2qXKB58N3lEak8dxH8UUVtyyud3XQMlXpISwYhnz3j9Xt2RFNQGXDuMb61Y=
X-Gm-Message-State: AOJu0YxdftaAIw4ZrnTbCPrSWJVVjx9oH+94C9wOzLWArUa+HzZf4mfU
	z+sbYcIxQb7uNJ0BlScVOWOoV4CvHTUdgSPBGOAt/aGb72BSTa8E
X-Google-Smtp-Source: AGHT+IGI7znVrv6bYKQx7zu+8g6RSUkckxO77j0m9ryhAOr73jAUCoQuk4sG//4hffslQyeyVIjtfg==
X-Received: by 2002:a05:6a21:32aa:b0:1c4:9f31:ac8f with SMTP id adf61e73a8af0-1c4a14d92e1mr11148238637.37.1722384169966;
        Tue, 30 Jul 2024 17:02:49 -0700 (PDT)
Received: from localhost.localdomain ([2407:7000:8942:5500:aaa1:59ff:fe57:eb97])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70ead6e1a2asm8871689b3a.23.2024.07.30.17.02.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 17:02:49 -0700 (PDT)
From: Barry Song <21cnbao@gmail.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org
Cc: 42.hyeyoo@gmail.com,
	cl@linux.com,
	hailong.liu@oppo.com,
	hch@infradead.org,
	iamjoonsoo.kim@lge.com,
	lstoakes@gmail.com,
	mhocko@suse.com,
	penberg@kernel.org,
	rientjes@google.com,
	roman.gushchin@linux.dev,
	torvalds@linux-foundation.org,
	urezki@gmail.com,
	v-songbaohua@oppo.com,
	vbabka@suse.cz,
	virtualization@lists.linux.dev,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Maxime Coquelin <maxime.coquelin@redhat.com>
Subject: [PATCH RFT v2 1/4] vpda: try to fix the potential crash due to misusing __GFP_NOFAIL
Date: Wed, 31 Jul 2024 12:01:52 +1200
Message-Id: <20240731000155.109583-2-21cnbao@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240731000155.109583-1-21cnbao@gmail.com>
References: <20240731000155.109583-1-21cnbao@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Barry Song <v-songbaohua@oppo.com>

mm doesn't support non-blockable __GFP_NOFAIL allocation. Because
__GFP_NOFAIL without direct reclamation may just result in a busy
loop within non-sleepable contexts.

static inline struct page *
__alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
                                                struct alloc_context *ac)
{
        ...
        /*
         * Make sure that __GFP_NOFAIL request doesn't leak out and make sure
         * we always retry
         */
        if (gfp_mask & __GFP_NOFAIL) {
                /*
                 * All existing users of the __GFP_NOFAIL are blockable, so warn
                 * of any new users that actually require GFP_NOWAIT
                 */
                if (WARN_ON_ONCE_GFP(!can_direct_reclaim, gfp_mask))
                        goto fail;
                ...
        }
        ...
fail:
        warn_alloc(gfp_mask, ac->nodemask,
                        "page allocation failure: order:%u", order);
got_pg:
        return page;
}

Let's move the memory allocation out of the atomic context and use
the normal sleepable context to get pages.

[RFT]: This has only been compile-tested; I'd prefer if the VDPA maintainers
handles it.

Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: "Eugenio Pérez" <eperezma@redhat.com>
Cc: Maxime Coquelin <maxime.coquelin@redhat.com>
Signed-off-by: Barry Song <v-songbaohua@oppo.com>
---
 drivers/vdpa/vdpa_user/iova_domain.c | 31 +++++++++++++++++++++++-----
 drivers/vdpa/vdpa_user/iova_domain.h |  5 ++++-
 drivers/vdpa/vdpa_user/vduse_dev.c   |  4 +++-
 3 files changed, 33 insertions(+), 7 deletions(-)

diff --git a/drivers/vdpa/vdpa_user/iova_domain.c b/drivers/vdpa/vdpa_user/iova_domain.c
index 791d38d6284c..9318f059a8b5 100644
--- a/drivers/vdpa/vdpa_user/iova_domain.c
+++ b/drivers/vdpa/vdpa_user/iova_domain.c
@@ -283,7 +283,23 @@ int vduse_domain_add_user_bounce_pages(struct vduse_iova_domain *domain,
 	return ret;
 }
 
-void vduse_domain_remove_user_bounce_pages(struct vduse_iova_domain *domain)
+struct page **vduse_domain_alloc_pages_to_remove_bounce(struct vduse_iova_domain *domain)
+{
+	struct page **pages;
+	unsigned long count, i;
+
+	if (!domain->user_bounce_pages)
+		return NULL;
+
+	count = domain->bounce_size >> PAGE_SHIFT;
+	pages = kmalloc_array(count, sizeof(*pages), GFP_KERNEL | __GFP_NOFAIL);
+	for (i = 0; i < count; i++)
+		pages[i] = alloc_page(GFP_KERNEL | __GFP_NOFAIL);
+
+	return pages;
+}
+
+void vduse_domain_remove_user_bounce_pages(struct vduse_iova_domain *domain, struct page **pages)
 {
 	struct vduse_bounce_map *map;
 	unsigned long i, count;
@@ -294,15 +310,16 @@ void vduse_domain_remove_user_bounce_pages(struct vduse_iova_domain *domain)
 
 	count = domain->bounce_size >> PAGE_SHIFT;
 	for (i = 0; i < count; i++) {
-		struct page *page = NULL;
+		struct page *page = pages[i];
 
 		map = &domain->bounce_maps[i];
-		if (WARN_ON(!map->bounce_page))
+		if (WARN_ON(!map->bounce_page)) {
+			put_page(page);
 			continue;
+		}
 
 		/* Copy user page to kernel page if it's in use */
 		if (map->orig_phys != INVALID_PHYS_ADDR) {
-			page = alloc_page(GFP_ATOMIC | __GFP_NOFAIL);
 			memcpy_from_page(page_address(page),
 					 map->bounce_page, 0, PAGE_SIZE);
 		}
@@ -310,6 +327,7 @@ void vduse_domain_remove_user_bounce_pages(struct vduse_iova_domain *domain)
 		map->bounce_page = page;
 	}
 	domain->user_bounce_pages = false;
+	kfree(pages);
 out:
 	write_unlock(&domain->bounce_lock);
 }
@@ -543,10 +561,13 @@ static int vduse_domain_mmap(struct file *file, struct vm_area_struct *vma)
 static int vduse_domain_release(struct inode *inode, struct file *file)
 {
 	struct vduse_iova_domain *domain = file->private_data;
+	struct page **pages;
+
+	pages = vduse_domain_alloc_pages_to_remove_bounce(domain);
 
 	spin_lock(&domain->iotlb_lock);
 	vduse_iotlb_del_range(domain, 0, ULLONG_MAX);
-	vduse_domain_remove_user_bounce_pages(domain);
+	vduse_domain_remove_user_bounce_pages(domain, pages);
 	vduse_domain_free_kernel_bounce_pages(domain);
 	spin_unlock(&domain->iotlb_lock);
 	put_iova_domain(&domain->stream_iovad);
diff --git a/drivers/vdpa/vdpa_user/iova_domain.h b/drivers/vdpa/vdpa_user/iova_domain.h
index f92f22a7267d..17efa5555b3f 100644
--- a/drivers/vdpa/vdpa_user/iova_domain.h
+++ b/drivers/vdpa/vdpa_user/iova_domain.h
@@ -74,7 +74,10 @@ void vduse_domain_reset_bounce_map(struct vduse_iova_domain *domain);
 int vduse_domain_add_user_bounce_pages(struct vduse_iova_domain *domain,
 				       struct page **pages, int count);
 
-void vduse_domain_remove_user_bounce_pages(struct vduse_iova_domain *domain);
+void vduse_domain_remove_user_bounce_pages(struct vduse_iova_domain *domain,
+					   struct page **pages);
+
+struct page **vduse_domain_alloc_pages_to_remove_bounce(struct vduse_iova_domain *domain);
 
 void vduse_domain_destroy(struct vduse_iova_domain *domain);
 
diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
index 7ae99691efdf..5d8d5810df57 100644
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -1030,6 +1030,7 @@ static int vduse_dev_queue_irq_work(struct vduse_dev *dev,
 static int vduse_dev_dereg_umem(struct vduse_dev *dev,
 				u64 iova, u64 size)
 {
+	struct page **pages;
 	int ret;
 
 	mutex_lock(&dev->mem_lock);
@@ -1044,7 +1045,8 @@ static int vduse_dev_dereg_umem(struct vduse_dev *dev,
 	if (dev->umem->iova != iova || size != dev->domain->bounce_size)
 		goto unlock;
 
-	vduse_domain_remove_user_bounce_pages(dev->domain);
+	pages = vduse_domain_alloc_pages_to_remove_bounce(dev->domain);
+	vduse_domain_remove_user_bounce_pages(dev->domain, pages);
 	unpin_user_pages_dirty_lock(dev->umem->pages,
 				    dev->umem->npages, true);
 	atomic64_sub(dev->umem->npages, &dev->umem->mm->pinned_vm);
-- 
2.34.1

