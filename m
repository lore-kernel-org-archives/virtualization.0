Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 567DA1BF7FA
	for <virtualization@lists.linux.dev>; Fri, 30 Aug 2024 20:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725049761; cv=none; b=YFbariEZQ8XMv18V6//6F/M3KZnrWLPHym/1CL6t1ekaV5mO0CskNvUenYLks+mvugROURKiE2z1n05pDUg9S9qe8pubzr3MDbnlHRCF7dnQ6r8g7RBpdDme4K8O66FNmHG29UblH51N5Y2Z/Aeu0ChpOXHB35HiX3mBg5lUKjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725049761; c=relaxed/simple;
	bh=2Z7WqHHtadOoniUD2wkzM9RIwzsPQ0rDh4Ey1ktLjRE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Bjhy2b4vcsPWeI4Dz39tjxuSdMO9yJLEUzjMYpyr1I1B5i3Fm7gpfHEJCAAB6VkemaZJdAFAIETBcY89pOREPrs7p6KnsXA6rZnLjDq/4IfV0MnTN/A2OQB6CDcFwIYYOBZDgQwkILK7BDojBXhnKJFkwpQffbgY+P9VpvKiuQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BOffhvKQ; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BOffhvKQ"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-70cec4aa1e4so1615823b3a.1
        for <virtualization@lists.linux.dev>; Fri, 30 Aug 2024 13:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725049759; x=1725654559; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GjM4TCQPcyD2c0/3KvrBI/E6RtEEAPLZc40kpXbn95A=;
        b=BOffhvKQ/Xq42I6/iFf1RK0nYpSVw8isUtCJ2SBhDABWCfG8jN5mny0x5WsO/fhGFo
         J0u32A2X7MewXa6bSxhMNbuiLFhCR5578vbAOC/8i2S1wrHT6+2qP8BcJBKvZ5eaySoJ
         9rXKFVX1h/6MJdRogAGJV2nVlt41Xwft4THNQGQkqAKz58IW0AhH6G+exMeP/DBMGzLg
         543kxXgy5MW8kFl8QKAWeI1Kua8n1wEaf9lXZkHqpQMH25+srC2WfJG3YUQ+f4seKsZb
         +44goOI/DmAJ50ma7+Mc2ChGU7Sxq3arkj41BJDsHqPKVfr+vPOe7qPBRxoGWrURXbyD
         SH/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725049759; x=1725654559;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GjM4TCQPcyD2c0/3KvrBI/E6RtEEAPLZc40kpXbn95A=;
        b=HETxkfLCG5yUi/Q2jGbhLWCot0tzis+ST2J+v8HbPbrNPr2S2ygHpKDy4d2inqcYz6
         pJWc9SffGdVtKJJ40y9jkOJ7+8IRkptnQ/bD/DWIOYi+A6zoCR08NroiXdYRgHUo8tdu
         xzMKjO57MT5vFPtrR4q90bk0NitfYOyjqO1dsl7fbOv6s3clnIHudVDmgSubMbVmjDTb
         L3EjbI6TQvgEzb8E+HmzVV99wQw6eTcfri74JJTebNX/lPGXXZBvukwg1tP2bQjpxKPl
         oM4Qs/+cSjLUV7aD4uUjnSzyAR2TR7NtOznsj2g93KTU2gD6EcPtmKOCpPYwogAXfj1F
         AP/A==
X-Forwarded-Encrypted: i=1; AJvYcCUFlKsi9hFDmo9CqCGRc8qA/SGaw97sZINVl4lTQOpl/wTX/9lbLEKxbRZBCMLnyPUkQ7GLwPik06jdh4smVA==@lists.linux.dev
X-Gm-Message-State: AOJu0YySqaGFInx5I8eNzK6M5B7Hy1ds+S8+Q95XgUIAgJjxQBS7ENH6
	wOB+cEHb5k/1sC3zmtehN+flG9ZTSQ5YFs2HYorE/kqS25LU03Pj
X-Google-Smtp-Source: AGHT+IHPNF3P8o/k5P1eGJ2+IaqrDvOqEe4xWUj5fF+7bw0WYag1yVFsYkqRh8YXWo7n9ciahhhJHA==
X-Received: by 2002:a05:6a00:a06:b0:70b:cf1:8dc9 with SMTP id d2e1a72fcca58-715dfced5efmr9881420b3a.25.1725049759477;
        Fri, 30 Aug 2024 13:29:19 -0700 (PDT)
Received: from localhost.localdomain ([2407:7000:8942:5500:aaa1:59ff:fe57:eb97])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-715e56d74eesm3257035b3a.147.2024.08.30.13.29.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 13:29:19 -0700 (PDT)
From: Barry Song <21cnbao@gmail.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org,
	virtualization@lists.linux.dev
Cc: david@redhat.com,
	42.hyeyoo@gmail.com,
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
	laoar.shao@gmail.com,
	Jason Wang <jasowang@redhat.com>,
	Xie Yongji <xieyongji@bytedance.com>
Subject: [PATCH v4 1/3] vduse: avoid using __GFP_NOFAIL
Date: Sat, 31 Aug 2024 08:28:21 +1200
Message-Id: <20240830202823.21478-2-21cnbao@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240830202823.21478-1-21cnbao@gmail.com>
References: <20240830202823.21478-1-21cnbao@gmail.com>
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
2.34.1

