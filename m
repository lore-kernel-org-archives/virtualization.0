Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5BBABA2D
	for <virtualization@lists.linux.dev>; Sat, 17 Aug 2024 06:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723875917; cv=none; b=IGP+vMQ9nbxLRWUj4eQULtFxpebSV/L/NAL1TkGVKhWcknM8TgLPt+pHm6YcA6XOJVd3aFblpWM36yJlUNR5WmcYG/I7PxDzEdXZIj2XCWNTI4y0ZWbTRr7G/8GCkFTSVXtBEx9mmyyosmyHw9pBMszvoqcm5J4wv/zxTgyqvR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723875917; c=relaxed/simple;
	bh=wvhtmbzlunhgqnTn5dPGIj0buAIniLy/2K3jvOXD06k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RUGiiAwffWUBrm6I9teu4GsS6Xq2C0oiA7ynM51Aya7brNoyBCN6V2Ve/Gql15C0fwvZTu2RTqvl7uVJ3oOndDXhtldyO8t9zUrFFxatD7Ee3YudnRH/gvJYBK9ear7eErZH0N/iyjzJzIw/HiEOcsKg8KTOhlTrQcIxjYYmcIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Up7FmPB/; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Up7FmPB/"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2d1daa2577bso2052323a91.2
        for <virtualization@lists.linux.dev>; Fri, 16 Aug 2024 23:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723875912; x=1724480712; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xisu3WuwKYF+5Cz14TC0TNfL+QngYLYmdZWec26IjWw=;
        b=Up7FmPB/CZoHCDbnTNi8AgFu5NCuVJBUIay9zDKysASoLjIh3vG9+dGcfo39feoRLV
         YZ6XNng+oM2iUms2CfSi86APJ2sFhhaBiv6PcGsCagEt28lv0+3jV18N017/f+67TqtU
         Z4ByA3u+xLzXDgcI5qdWLaCWXJRmU6LqtK2it1wEUdb0qrjcSmo+WWEwefPuQ8ygrPCl
         QBhhMqNJ1Bqq5pJ5GYf0NNbqoyJ40wI+6x7XTaLTVvuMRr9mInpMdnAbiSwWhlQnm44g
         +dn3uDcbHK3PCTIdQzDttlSWWEWw79dLXhd+fPSKFNCPHOtFqtrAlIZFNzeTiDbxlQm2
         Nf7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723875912; x=1724480712;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xisu3WuwKYF+5Cz14TC0TNfL+QngYLYmdZWec26IjWw=;
        b=CRlGXIZtHE4H9uY7oKMo2rJl+VQLQAmdBV0KU18i2UvvUN6hsGwXTlvfmuyRh/pX5u
         IKbfmCyA2oSy/dNehiNthvROknNOFjSfJ1vkUrz9Ak2mEPIwt32w7gSw4B4JgcH8FCNP
         BP26qpOKDjG+AfL5+WP2XIev0yrrLOMNDA4a+kv2qz2T4xHsaGLeh7j+PjtIhRPJ4WWE
         7weMnsqarS62CkeeQEpIVIa26vX+E+qKHhIWgcoCy+Xvm3WO1lKrhb/Gq+vTsNXIuabH
         YuxQ5Ggp33Ym/Qo+Vp7rPh4ccCcHpgMnuvwJ6e1JKSucO83Psz9uyZwCkvnxB+PgXfQu
         YY/Q==
X-Forwarded-Encrypted: i=1; AJvYcCUE+EFmL9dmQzfUCnUJpFp9SIyog4vGeVnUlpqVCFOomOjwVzt1k8neTzDOzUPfXlC/ZohT+zwSWGkz1Da+0tduyf8bk9afNHyko/b8dHY=
X-Gm-Message-State: AOJu0YwIuXFNO06D9pNZeWZ9pFEZkfoDZA1S9XtKbLti7FeUPLr/msst
	GPaY81WfsZRZL4hgfuKEzEV6KHj1VmN9ol02B4yaE5KoTJN+AGSG
X-Google-Smtp-Source: AGHT+IENdPsIQj8xmveRlL6yyjeMypK32/OjrVrt2yi6p6JSCZBnX1qKEm72i6xM5tYhi5eXrnZ5vA==
X-Received: by 2002:a17:90b:315:b0:2c7:c788:d34d with SMTP id 98e67ed59e1d1-2d3e0870ccfmr5702366a91.38.1723875911896;
        Fri, 16 Aug 2024 23:25:11 -0700 (PDT)
Received: from Barrys-MBP.hub ([2407:7000:8942:5500:fd84:292a:c6d0:8b67])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d3ac854f3bsm6768404a91.51.2024.08.16.23.25.05
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 16 Aug 2024 23:25:11 -0700 (PDT)
From: Barry Song <21cnbao@gmail.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org
Cc: 42.hyeyoo@gmail.com,
	cl@linux.com,
	hailong.liu@oppo.com,
	hch@infradead.org,
	iamjoonsoo.kim@lge.com,
	mhocko@suse.com,
	penberg@kernel.org,
	rientjes@google.com,
	roman.gushchin@linux.dev,
	torvalds@linux-foundation.org,
	urezki@gmail.com,
	v-songbaohua@oppo.com,
	vbabka@suse.cz,
	virtualization@lists.linux.dev,
	Jason Wang <jasowang@redhat.com>,
	Xie Yongji <xieyongji@bytedance.com>
Subject: [PATCH v3 1/4] vduse: avoid using __GFP_NOFAIL
Date: Sat, 17 Aug 2024 18:24:46 +1200
Message-Id: <20240817062449.21164-2-21cnbao@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20240817062449.21164-1-21cnbao@gmail.com>
References: <20240817062449.21164-1-21cnbao@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Wang <jasowang@redhat.com>

mm doesn't support non-blockable __GFP_NOFAIL allocation. Because
persisting in providing __GFP_NOFAIL services for non-block users
who cannot perform direct memory reclaim may only result in an
endless busy loop.

Therefore, in such cases, the current mm-core may directly return
a NULL pointer:

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

Unfortuantely, vpda does that nofail allocation under non-sleepable
lock. A possible way to fix that is to move the pages allocation out
of the lock into the caller, but having to allocate a huge number of
pages and auxiliary page array seems to be problematic as well per
Tetsuon: " You should implement proper error handling instead of
using __GFP_NOFAIL if count can become large."

So I choose another way, which does not release kernel bounce pages
when user tries to register userspace bounce pages. Then we can
avoid allocating in paths where failure is not expected.(e.g in
the release). We pay this for more memory usage as we don't release
kernel bounce pages but further optimizations could be done on top.

Fixes: 6c77ed22880d ("vduse: Support using userspace pages as bounce buffer")
Reviewed-by: Xie Yongji <xieyongji@bytedance.com>
Tested-by: Xie Yongji <xieyongji@bytedance.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
[v-songbaohua@oppo.com: Refine the changelog]
Signed-off-by: Barry Song <v-songbaohua@oppo.com>
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
2.39.3 (Apple Git-146)

