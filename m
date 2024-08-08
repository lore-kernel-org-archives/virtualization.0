Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA021181B88
	for <virtualization@lists.linux.dev>; Thu,  8 Aug 2024 05:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723095821; cv=none; b=ipLEnlRnghp/MyVmaYvOdk/XYy1qPENLv4nG8l71B4paRvF9Yqgn6Jw/PYqjZcumDGA/hscHEPo1BfhBh4PlGo4CqDDoHGFPWsD37sI2PIND3sdZobupAoaigyagtlgHRduBpBv37s4dhYSo0+xbWKdWerbuQeoBHiItjMPMRmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723095821; c=relaxed/simple;
	bh=Td3Qt+02+frocPvVrit8EHuAtzKrHvkt3Rze4g2oy9s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cOjo0qh9eV0gFnNJOcV7rO/mzBzQyoF1IKwmKcIUjXxRhNMg87DmfW8EHN+iypqHCO1cYK2845GdTbgCVSpsfQZ+NgvvN03vONI2TG9L/TKu5QT4+dkQ1vT/LsMXQpneA9JHyTcXWqaGgkuTB//RaG5uI/FBNxkGGim8M8uKrA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NVs/uEzb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NVs/uEzb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723095817;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=/mZbYDO1Ex7c0f6PetoijrkxUL0pCY6E2YxfayltoBE=;
	b=NVs/uEzb4zYJLItEfKYCBpKDABgsz3SgucpIPZlOTP3fSI8ZTdJxRQJo64nC2eiJ6Jh5ej
	wMpTOsHwZFNM+eokc5P1pCLgzzrqyGPWZ/D/eB+OABRxerAfKW5ilryRFqSSwdwVltNdzK
	k9g7NXpUqlQhyMp94Xg3uuc2+K9ee+s=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-532-OXGivJ_lOw63AypQMctqdA-1; Thu,
 08 Aug 2024 01:43:33 -0400
X-MC-Unique: OXGivJ_lOw63AypQMctqdA-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4F74E1955D5D;
	Thu,  8 Aug 2024 05:43:31 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.23])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0E00019560A3;
	Thu,  8 Aug 2024 05:43:23 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com
Cc: maxime.coquelin@redhat.com,
	xieyongji@bytedance.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	21cnbao@gmail.com,
	penguin-kernel@i-love.sakura.ne.jp,
	linux-mm@kvack.org,
	akpm@linux-foundation.org
Subject: [PATCH v2] vduse: avoid using __GFP_NOFAIL
Date: Thu,  8 Aug 2024 13:43:19 +0800
Message-ID: <20240808054320.10017-1-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Barry said [1]:

"""
mm doesn't support non-blockable __GFP_NOFAIL allocation. Because
__GFP_NOFAIL without direct reclamation may just result in a busy
loop within non-sleepable contexts.

The current code will result in returning a NULL pointer but
not a busy-loop.

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

We have two choices to address the issue:
1. busy-loop
2. BUG_ON

the below patch chose 2:
https://lore.kernel.org/linux-mm/20240731000155.109583-5-21cnbao@gmail.com/
""“

Unfortuantely, we do that under read lock. A possible way to fix that
is to move the pages allocation out of the lock into the caller, but
having to allocate a huge number of pages and auxiliary page array
seems to be problematic as well per Tetsuon [2]:

"""
You should implement proper error handling instead of using
__GFP_NOFAIL if count can become large.
"""

So I choose another way, which does not release kernel bounce pages
when user tries to register usersapce bounce pages. Then we don't need
to do allocation in the path which is not expected to be fail (e.g in
the release). We pay this for more memory usage as we don't release
kernel bounce pages but further optimizations could be done on top.

[1] https://lore.kernel.org/all/CACGkMEtcOJAA96SF9B8m-nZ1X04-XZr+nq8ZQ2saLnUdfOGOLg@mail.gmail.com/T/#m3caef86a66ea6318ef94f9976ddb3a0ccfe6fcf8
[2] https://lore.kernel.org/all/CACGkMEtcOJAA96SF9B8m-nZ1X04-XZr+nq8ZQ2saLnUdfOGOLg@mail.gmail.com/T/#m7ad10eaba48ade5abf2d572f24e185d9fb146480

Fixes: 6c77ed22880d ("vduse: Support using userspace pages as bounce buffer")
Reviewed-by: Xie Yongji <xieyongji@bytedance.com>
Tested-by: Xie Yongji <xieyongji@bytedance.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
Changes since V1:
- Tweak the commit log
- Assign map->user_bounce_page to NULL for safety
---
 drivers/vdpa/vdpa_user/iova_domain.c | 19 +++++++++++--------
 drivers/vdpa/vdpa_user/iova_domain.h |  1 +
 2 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/vdpa/vdpa_user/iova_domain.c b/drivers/vdpa/vdpa_user/iova_domain.c
index 791d38d6284c..58116f89d8da 100644
--- a/drivers/vdpa/vdpa_user/iova_domain.c
+++ b/drivers/vdpa/vdpa_user/iova_domain.c
@@ -162,6 +162,7 @@ static void vduse_domain_bounce(struct vduse_iova_domain *domain,
 				enum dma_data_direction dir)
 {
 	struct vduse_bounce_map *map;
+	struct page *page;
 	unsigned int offset;
 	void *addr;
 	size_t sz;
@@ -178,7 +179,10 @@ static void vduse_domain_bounce(struct vduse_iova_domain *domain,
 			    map->orig_phys == INVALID_PHYS_ADDR))
 			return;
 
-		addr = kmap_local_page(map->bounce_page);
+		page = domain->user_bounce_pages ?
+		       map->user_bounce_page : map->bounce_page;
+
+		addr = kmap_local_page(page);
 		do_bounce(map->orig_phys + offset, addr + offset, sz, dir);
 		kunmap_local(addr);
 		size -= sz;
@@ -270,9 +274,8 @@ int vduse_domain_add_user_bounce_pages(struct vduse_iova_domain *domain,
 				memcpy_to_page(pages[i], 0,
 					       page_address(map->bounce_page),
 					       PAGE_SIZE);
-			__free_page(map->bounce_page);
 		}
-		map->bounce_page = pages[i];
+		map->user_bounce_page = pages[i];
 		get_page(pages[i]);
 	}
 	domain->user_bounce_pages = true;
@@ -297,17 +300,17 @@ void vduse_domain_remove_user_bounce_pages(struct vduse_iova_domain *domain)
 		struct page *page = NULL;
 
 		map = &domain->bounce_maps[i];
-		if (WARN_ON(!map->bounce_page))
+		if (WARN_ON(!map->user_bounce_page))
 			continue;
 
 		/* Copy user page to kernel page if it's in use */
 		if (map->orig_phys != INVALID_PHYS_ADDR) {
-			page = alloc_page(GFP_ATOMIC | __GFP_NOFAIL);
+			page = map->bounce_page;
 			memcpy_from_page(page_address(page),
-					 map->bounce_page, 0, PAGE_SIZE);
+					 map->user_bounce_page, 0, PAGE_SIZE);
 		}
-		put_page(map->bounce_page);
-		map->bounce_page = page;
+		put_page(map->user_bounce_page);
+		map->user_bounce_page = NULL;
 	}
 	domain->user_bounce_pages = false;
 out:
diff --git a/drivers/vdpa/vdpa_user/iova_domain.h b/drivers/vdpa/vdpa_user/iova_domain.h
index f92f22a7267d..7f3f0928ec78 100644
--- a/drivers/vdpa/vdpa_user/iova_domain.h
+++ b/drivers/vdpa/vdpa_user/iova_domain.h
@@ -21,6 +21,7 @@
 
 struct vduse_bounce_map {
 	struct page *bounce_page;
+	struct page *user_bounce_page;
 	u64 orig_phys;
 };
 
-- 
2.31.1

