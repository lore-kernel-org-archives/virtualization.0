Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D531CAA1
	for <virtualization@lists.linux.dev>; Wed, 24 Jul 2024 08:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721811372; cv=none; b=WwdFFhSHHnIFVjnBxzP6REhoY4jvM1UUFQyDjOiz8qs9SocCQj0zl3AB9FBU8oMQPqSXTsHtGcgVTNnZSKf+SgQBu4huwbE9n/SqIptsweYhQQECeizvAqgCk7LXAmw2uEXXnSZYxjkO2TaT09vv/Rq5BxnVN3uCfP/Mnz/peyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721811372; c=relaxed/simple;
	bh=yX7W44ni/GGMDVV24dPzUE6noPs5NmRkh+5rl6mOcb4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F1yuIShlh2OgJftgaxAnJpxFcQHQhzPLmG7jFXTK7/9LoohZ7LIo5O7teVTo5svczxEFUnmPSnU9QiOf5EHisOSi4oqlJtw/aJZY8xgVLKx/Dv9t1V4Xz/p2TaNTMiWglMwHfvpoFmi+zWdXBejJrsLa5uYmft+oXxIfiopf3Ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LI8cQoAM; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LI8cQoAM"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1fd90c2fc68so14049115ad.1
        for <virtualization@lists.linux.dev>; Wed, 24 Jul 2024 01:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721811371; x=1722416171; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t7uDCr0s9dVOVBXGdSQRDcVebs8SNqq3Sg0LbsWUCdM=;
        b=LI8cQoAMGl2EzSCiR4yzDdYj2YK0zWiPMIvpJ2vJvYLnPZ0li5mmvGW9jmP7S4076c
         2+21UKYSCCe9UMBw2adODh09bMgIHXu8PKcmKwdPGijW0mBHTHZ0rHyBtKQDG1/FNEOe
         VCmZ7zFiFephcuOtAyNnPBKy8rHHDaLWx6zrhCWkLrasJ7ZTKpDefcRWyuK2EK1iQjjj
         ga0UL8qya2ZfLASbvcuSmfKE++dCw7WVO6S+pqYRdEqJQJqX39jneeu9Fmjga9uWhNHJ
         6SOsOAxL5uptQ4naow4KHetpVnP0C4DqYhLT0I49UZyy8v1VHzwjam2C9hKCCAYvbLkk
         qY8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721811371; x=1722416171;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t7uDCr0s9dVOVBXGdSQRDcVebs8SNqq3Sg0LbsWUCdM=;
        b=c8UeH7gCCkK4RKPB8iBUVk4nmiyQZUxSFs39bZtSPtZ6psP2vDCAYHdCK7sxRKapPw
         MpiT9E69YnOxpuLs/dNH9s/LBESszyqNXNC53iB4034+Y1Ont3rXsyiAJjgR6dvxx/HD
         9ShXqMOlD/eCoHK/cK/vn19v2xk114eNqYYPvoNy/UYhfilYeLBsrpozXYpItksBVQz4
         MdT2cWCI5HLBqaj/JH2jtnBo54DFXhBuge/Bn62A/oXRq15Yz/P9cEcZB6HVKuDa1NeQ
         kb4lw8VYXjp7LOhIBQR+7JDwN2crcuwXZEnMLwaq6jMJlqgZrBlZdgIpCzSYPS4Fwsks
         MelA==
X-Forwarded-Encrypted: i=1; AJvYcCXRMljnj+yy4gsxfx0Msl3DQQZ1bQncPCbzr/s3wKmC2MEol3jZazxJ5QNRliZ8L8Y+iRTJfAk59er+A/hv5IphrMmNfzH4hey+QF5cZtE=
X-Gm-Message-State: AOJu0YzdJAteIaBKAU66DgkaIYnndtspfN5sYKQ3mm87l+DhzBONTZZj
	a6oEu/bC0QQwkRtMqq6Vk+OJOdDdlotl+u6QAfugy+9c4gVgbb3V
X-Google-Smtp-Source: AGHT+IFp7Y6XHWq5brJl9ajMXq+ZC2ugZjed/8XGp+DlegY+Ffu8Y1qBx5thXFo+DxGn4BRYSROzPw==
X-Received: by 2002:a17:902:c404:b0:1fd:67a8:845f with SMTP id d9443c01a7336-1fdd550e28dmr19098215ad.14.1721811370524;
        Wed, 24 Jul 2024 01:56:10 -0700 (PDT)
Received: from localhost.localdomain ([2407:7000:8942:5500:aaa1:59ff:fe57:eb97])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fd6f31855fsm89021895ad.156.2024.07.24.01.56.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 01:56:10 -0700 (PDT)
From: Barry Song <21cnbao@gmail.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org
Cc: 42.hyeyoo@gmail.com,
	cl@linux.com,
	hch@infradead.org,
	iamjoonsoo.kim@lge.com,
	lstoakes@gmail.com,
	mhocko@suse.com,
	penberg@kernel.org,
	rientjes@google.com,
	roman.gushchin@linux.dev,
	urezki@gmail.com,
	v-songbaohua@oppo.com,
	vbabka@suse.cz,
	virtualization@lists.linux.dev,
	hailong.liu@oppo.com,
	torvalds@linux-foundation.org,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Maxime Coquelin <maxime.coquelin@redhat.com>
Subject: [PATCH RFC 1/5] vpda: try to fix the potential crash due to misusing __GFP_NOFAIL
Date: Wed, 24 Jul 2024 20:55:40 +1200
Message-Id: <20240724085544.299090-2-21cnbao@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240724085544.299090-1-21cnbao@gmail.com>
References: <20240724085544.299090-1-21cnbao@gmail.com>
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

[RFC]: This has only been compile-tested; I'd prefer if the VDPA maintainers
handles it.

Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: "Eugenio Pérez" <eperezma@redhat.com>
Cc: Maxime Coquelin <maxime.coquelin@redhat.com>
Signed-off-by: Barry Song <v-songbaohua@oppo.com>
---
 drivers/vdpa/vdpa_user/iova_domain.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/drivers/vdpa/vdpa_user/iova_domain.c b/drivers/vdpa/vdpa_user/iova_domain.c
index 791d38d6284c..eff700e5f7a2 100644
--- a/drivers/vdpa/vdpa_user/iova_domain.c
+++ b/drivers/vdpa/vdpa_user/iova_domain.c
@@ -287,28 +287,44 @@ void vduse_domain_remove_user_bounce_pages(struct vduse_iova_domain *domain)
 {
 	struct vduse_bounce_map *map;
 	unsigned long i, count;
+	struct page **pages = NULL;
 
 	write_lock(&domain->bounce_lock);
 	if (!domain->user_bounce_pages)
 		goto out;
-
 	count = domain->bounce_size >> PAGE_SHIFT;
+	write_unlock(&domain->bounce_lock);
+
+	pages = kmalloc_array(count, sizeof(*pages), GFP_KERNEL | __GFP_NOFAIL);
+	for (i = 0; i < count; i++)
+		pages[i] = alloc_page(GFP_KERNEL | __GFP_NOFAIL);
+
+	write_lock(&domain->bounce_lock);
+	if (!domain->user_bounce_pages) {
+		for (i = 0; i < count; i++)
+			put_page(pages[i]);
+		kfree(pages);
+		goto out;
+	}
+
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
 		put_page(map->bounce_page);
 		map->bounce_page = page;
 	}
+	kfree(pages);
 	domain->user_bounce_pages = false;
 out:
 	write_unlock(&domain->bounce_lock);
-- 
2.34.1

