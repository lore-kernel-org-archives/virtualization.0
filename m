Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F0D24F594
	for <virtualization@lists.linux.dev>; Wed,  5 Mar 2025 15:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741188413; cv=none; b=kWLcSmpO5q2xfz4ahXR+JdkwFQhNzU+LuhkhDoGawG/jLDUkqjiNURLO5cXOBj2PVM19u/huY7A/ExnFhrTh/xqBpBSptNhT8e5BP0dk+KeU6jj8NE0BeppH4xe2IZgriwHuowhF8mHbTr0Ii5jvrKTEHByw86t1gbWADYJ5RH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741188413; c=relaxed/simple;
	bh=WuSs0ccIERyzfHTV1tmUgRKBiDqHcxHRwmn33redAdI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=iVeqyStWuz0upe4FTGnmeB+WpFo/G+jiNriRE26qLFRwupRChlP3MVm8CpEsyWkLYN4EBiL3iDpJ3Wb3UuJbYVUWV/QUzZKIOImVsrHQIy3G2w45xP1HsY8lfFyXhKRliJPu2vm9+SATEYV20XJECIfHI5wfj3viWeaxj3yAyPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aWNBq6GF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aWNBq6GF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741188410;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qPtUDuBhtdSX6GhOg+XQnbMK00oSmP61u2YCpHroymk=;
	b=aWNBq6GFFvr/DKNJj/ovtyI2fvVDP994a8HN0ZnyO2gOhrA6DP7VGhc5tsaajktkTNvD0q
	jFDTXHO7pmMfFxqfqf/M75OBP2YCsQM5+iY43uuOTONwayiqRN3TKil3QWsclO8k1f3lKv
	fv/c8/bWDBBYKyVE/4xJJnc3pMH2Wx8=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-124-oC3EqYbUMs6WKIn--AMOIw-1; Wed, 05 Mar 2025 10:26:48 -0500
X-MC-Unique: oC3EqYbUMs6WKIn--AMOIw-1
X-Mimecast-MFC-AGG-ID: oC3EqYbUMs6WKIn--AMOIw_1741188407
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2234bf13b47so132309695ad.0
        for <virtualization@lists.linux.dev>; Wed, 05 Mar 2025 07:26:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741188407; x=1741793207;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qPtUDuBhtdSX6GhOg+XQnbMK00oSmP61u2YCpHroymk=;
        b=CfGqn/wAdof4uniFyB4IE7wIbfAe0y72tyzxiTkzjxCHUH3pJKEGddiL/KJduoEf+s
         5p+qb7BB1l8ZPNUgvR6dWf9cfNnStLZtOeFFC0kSwDNhnjymwC2PfMny6mjeB09ZoXC/
         gZwRmhX3nZInBNSBcBO3s0azI1W+TalpOIzuiE76+uh4WZFMn6Z8xsvEgJwWpkhvPTdt
         21rNNeoWKFrC8UVh8L97vHUaULkhUZJQoIjAORqvXHJZAl84to3izhY9p0CZbTOBS1Br
         JJRW9k0Krn1bdfxTYXJIIQwoUBYxmn5DNUsUqxJpu0ST2ZmwJJq2IUpw/pDg19DArfFw
         Zddg==
X-Forwarded-Encrypted: i=1; AJvYcCXX8fi/1+G4K2CQCkV3K6JebFzh4UIbBd0p9GUGx1d6Vmux1j6NniyNIcg3B4TAYn0l+H6LnBxate3n7yHuAA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy8dqIE2L5pfqj1NFNs/2Dk5+IFvFCkwAEcRGP/bAIh4WU0FQi5
	3TDoO/ExhBQGvYafY72ciaGJS1ClTzXc1Mof1QqGC+dLoC4kb99wlVqTRmb5sLMCo5JSPk5d5Ix
	4qxt7RmqPhPWJR3U6UakXHMp9j/WF54A2wXrSrd0KPilZlfm1p3JLjFpTSfmMMdfb
X-Gm-Gg: ASbGnctz4xcZ2szrFB7e2U+jVLqiW5zDB0JcC0TXTlEl+DfJxFxwwJUtHPJji5EAh3X
	lzBY7j6C3Lj8rqs/d62nLrQ4z2dqxmXbNRNs42gnW1cr0mZVNHzUy/a+lUMjm2oRmU3m5njLxeT
	zHuW/Ow/JhR9wFAE3D17GDuladUXTL7nImHPlZEYx8sdXpLMbJq+puuPW/b/uBQpMN3vHQiLuFG
	6x+XMQh6hlUYgbKe/jzmyHalFkhEcJTOcsP0aSGRmXyItTRr+TCzIfGTbGAm4i2ESm4hTar17Z6
	mlKJssNk0RuQ3yjo
X-Received: by 2002:a05:6a00:998:b0:736:46b4:beef with SMTP id d2e1a72fcca58-73682b55144mr6706590b3a.3.1741188406434;
        Wed, 05 Mar 2025 07:26:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IECYyXVd+Gb6leHDb5NO82ag7tQipklHOXKqXQqY4fydYrcJZzPu+CjaBp7aum4qt8U11Vpow==
X-Received: by 2002:a05:6a00:998:b0:736:46b4:beef with SMTP id d2e1a72fcca58-73682b55144mr6706526b3a.3.1741188406066;
        Wed, 05 Mar 2025 07:26:46 -0800 (PST)
Received: from zeus.elecom ([240b:10:83a2:bd00:6e35:f2f5:2e21:ae3a])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7364b4eff66sm6983292b3a.83.2025.03.05.07.26.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 07:26:45 -0800 (PST)
From: Ryosuke Yasuoka <ryasuoka@redhat.com>
To: maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	kraxel@redhat.com,
	gurchetansingh@chromium.org,
	olvaffe@gmail.com,
	akpm@linux-foundation.org,
	urezki@gmail.com,
	hch@infradead.org,
	dmitry.osipenko@collabora.com,
	jfalempe@redhat.com
Cc: Ryosuke Yasuoka <ryasuoka@redhat.com>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev,
	linux-mm@kvack.org
Subject: [PATCH drm-next 2/2] drm/virtio: Use atomic_vmap to work drm_panic in GUI
Date: Thu,  6 Mar 2025 00:25:54 +0900
Message-ID: <20250305152555.318159-3-ryasuoka@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250305152555.318159-1-ryasuoka@redhat.com>
References: <20250305152555.318159-1-ryasuoka@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: pBzVmwm7YJ6yGqCl5er2to59cb5agPl6rwdGzIN9Mww_1741188407
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

virtio drm_panic supports only vmapped shmem BO because there is no
atomic vmap feature. Now atomic_vmap is supported, so drm_panic tries to
vmap addr if it is not mapped.

Signed-off-by: Ryosuke Yasuoka <ryasuoka@redhat.com>
---
 drivers/gpu/drm/drm_gem.c              | 51 ++++++++++++++++++++++++++
 drivers/gpu/drm/drm_gem_shmem_helper.c | 51 ++++++++++++++++++++++++++
 drivers/gpu/drm/virtio/virtgpu_plane.c | 14 +++++--
 include/drm/drm_gem.h                  |  1 +
 include/drm/drm_gem_shmem_helper.h     |  2 +
 5 files changed, 116 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
index ee811764c3df..eebfaef3a52e 100644
--- a/drivers/gpu/drm/drm_gem.c
+++ b/drivers/gpu/drm/drm_gem.c
@@ -535,6 +535,57 @@ static void drm_gem_check_release_batch(struct folio_batch *fbatch)
 	cond_resched();
 }
 
+struct page **drm_gem_atomic_get_pages(struct drm_gem_object *obj)
+{
+	struct address_space *mapping;
+	struct page **pages;
+	struct folio *folio;
+	long i, j, npages;
+
+	if (WARN_ON(!obj->filp))
+		return ERR_PTR(-EINVAL);
+
+	/* This is the shared memory object that backs the GEM resource */
+	mapping = obj->filp->f_mapping;
+
+	/* We already BUG_ON() for non-page-aligned sizes in
+	 * drm_gem_object_init(), so we should never hit this unless
+	 * driver author is doing something really wrong:
+	 */
+	WARN_ON((obj->size & (PAGE_SIZE - 1)) != 0);
+
+	npages = obj->size >> PAGE_SHIFT;
+
+	pages = kmalloc_array(npages, sizeof(struct page *), GFP_ATOMIC);
+	if (pages == NULL)
+		return ERR_PTR(-ENOMEM);
+
+	mapping_set_unevictable(mapping);
+
+	i = 0;
+	while (i < npages) {
+		long nr;
+
+		folio = shmem_read_folio_gfp(mapping, i,
+				GFP_ATOMIC);
+		if (IS_ERR(folio))
+			return ERR_PTR(-ENOMEM);
+		nr = min(npages - i, folio_nr_pages(folio));
+		for (j = 0; j < nr; j++, i++)
+			pages[i] = folio_file_page(folio, i);
+
+		/* Make sure shmem keeps __GFP_DMA32 allocated pages in the
+		 * correct region during swapin. Note that this requires
+		 * __GFP_DMA32 to be set in mapping_gfp_mask(inode->i_mapping)
+		 * so shmem can relocate pages during swapin if required.
+		 */
+		BUG_ON(mapping_gfp_constraint(mapping, __GFP_DMA32) &&
+				(folio_pfn(folio) >= 0x00100000UL));
+	}
+
+	return pages;
+}
+
 /**
  * drm_gem_get_pages - helper to allocate backing pages for a GEM object
  * from shmem
diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
index 5ab351409312..789dfd726a36 100644
--- a/drivers/gpu/drm/drm_gem_shmem_helper.c
+++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
@@ -186,6 +186,34 @@ void drm_gem_shmem_free(struct drm_gem_shmem_object *shmem)
 }
 EXPORT_SYMBOL_GPL(drm_gem_shmem_free);
 
+static int drm_gem_shmem_atomic_get_pages(struct drm_gem_shmem_object *shmem)
+{
+	struct drm_gem_object *obj = &shmem->base;
+	struct page **pages;
+
+	pages = drm_gem_atomic_get_pages(obj);
+	if (IS_ERR(pages)) {
+		drm_dbg_kms(obj->dev, "Failed to get pages (%ld)\n",
+			    PTR_ERR(pages));
+		shmem->pages_use_count = 0;
+		return PTR_ERR(pages);
+	}
+
+	/*
+	 * TODO: Allocating WC pages which are correctly flushed is only
+	 * supported on x86. Ideal solution would be a GFP_WC flag, which also
+	 * ttm_pool.c could use.
+	 */
+#ifdef CONFIG_X86
+	if (shmem->map_wc)
+		set_pages_array_wc(pages, obj->size >> PAGE_SHIFT);
+#endif
+
+	shmem->pages = pages;
+
+	return 0;
+}
+
 static int drm_gem_shmem_get_pages(struct drm_gem_shmem_object *shmem)
 {
 	struct drm_gem_object *obj = &shmem->base;
@@ -317,6 +345,29 @@ void drm_gem_shmem_unpin(struct drm_gem_shmem_object *shmem)
 }
 EXPORT_SYMBOL(drm_gem_shmem_unpin);
 
+int drm_gem_shmem_atomic_vmap(struct drm_gem_shmem_object *shmem,
+			      struct iosys_map *map)
+{
+	struct drm_gem_object *obj = &shmem->base;
+	int ret = 0;
+
+	pgprot_t prot = PAGE_KERNEL;
+
+	ret = drm_gem_shmem_atomic_get_pages(shmem);
+	if (ret)
+		return -ENOMEM;
+
+	if (shmem->map_wc)
+		prot = pgprot_writecombine(prot);
+	shmem->vaddr = atomic_vmap(shmem->pages, obj->size >> PAGE_SHIFT,
+				   VM_MAP, prot);
+	if (!shmem->vaddr)
+		return -ENOMEM;
+	iosys_map_set_vaddr(map, shmem->vaddr);
+
+	return 0;
+}
+
 /*
  * drm_gem_shmem_vmap - Create a virtual mapping for a shmem GEM object
  * @shmem: shmem GEM object
diff --git a/drivers/gpu/drm/virtio/virtgpu_plane.c b/drivers/gpu/drm/virtio/virtgpu_plane.c
index a6f5a78f436a..2a977c5cf42a 100644
--- a/drivers/gpu/drm/virtio/virtgpu_plane.c
+++ b/drivers/gpu/drm/virtio/virtgpu_plane.c
@@ -500,11 +500,19 @@ static int virtio_drm_get_scanout_buffer(struct drm_plane *plane,
 
 	bo = gem_to_virtio_gpu_obj(plane->state->fb->obj[0]);
 
-	/* Only support mapped shmem bo */
-	if (virtio_gpu_is_vram(bo) || bo->base.base.import_attach || !bo->base.vaddr)
+	if (virtio_gpu_is_vram(bo) || bo->base.base.import_attach)
 		return -ENODEV;
 
-	iosys_map_set_vaddr(&sb->map[0], bo->base.vaddr);
+	/* try to vmap it if possible */
+	if (!bo->base.vaddr) {
+		int ret;
+
+		ret = drm_gem_shmem_atomic_vmap(&bo->base, &sb->map[0]);
+		if (ret)
+			return ret;
+	} else {
+		iosys_map_set_vaddr(&sb->map[0], bo->base.vaddr);
+	}
 
 	sb->format = plane->state->fb->format;
 	sb->height = plane->state->fb->height;
diff --git a/include/drm/drm_gem.h b/include/drm/drm_gem.h
index fdae947682cd..cfed66bc12ef 100644
--- a/include/drm/drm_gem.h
+++ b/include/drm/drm_gem.h
@@ -529,6 +529,7 @@ void drm_gem_free_mmap_offset(struct drm_gem_object *obj);
 int drm_gem_create_mmap_offset(struct drm_gem_object *obj);
 int drm_gem_create_mmap_offset_size(struct drm_gem_object *obj, size_t size);
 
+struct page **drm_gem_atomic_get_pages(struct drm_gem_object *obj);
 struct page **drm_gem_get_pages(struct drm_gem_object *obj);
 void drm_gem_put_pages(struct drm_gem_object *obj, struct page **pages,
 		bool dirty, bool accessed);
diff --git a/include/drm/drm_gem_shmem_helper.h b/include/drm/drm_gem_shmem_helper.h
index d22e3fb53631..86a357945f42 100644
--- a/include/drm/drm_gem_shmem_helper.h
+++ b/include/drm/drm_gem_shmem_helper.h
@@ -105,6 +105,8 @@ void drm_gem_shmem_free(struct drm_gem_shmem_object *shmem);
 void drm_gem_shmem_put_pages(struct drm_gem_shmem_object *shmem);
 int drm_gem_shmem_pin(struct drm_gem_shmem_object *shmem);
 void drm_gem_shmem_unpin(struct drm_gem_shmem_object *shmem);
+int drm_gem_shmem_atomic_vmap(struct drm_gem_shmem_object *shmem,
+			      struct iosys_map *map);
 int drm_gem_shmem_vmap(struct drm_gem_shmem_object *shmem,
 		       struct iosys_map *map);
 void drm_gem_shmem_vunmap(struct drm_gem_shmem_object *shmem,
-- 
2.48.1

