Received: from mail-qt1-f194.google.com (mail-qt1-f194.google.com [209.85.160.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70BF914A088
	for <virtualization@lists.linux.dev>; Tue,  3 Dec 2024 16:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733241743; cv=none; b=QpNjwPmeS4c///M/3pb+vRXPxI5rmU7R1b9qbXgnuQizF/cQ42oWrPoCpvH9GCqhoAkx72xOD3MJltGd5S7NQnlZqRI3iTwTgYtcCXIoHffzq9lbosh2MgyT+4NzC3vQQjMiqAyB8C9sdubraqLq3X6QYLY9LxFLxU17ei/I7cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733241743; c=relaxed/simple;
	bh=GChH/jFCdkIBNyblvULtWTux4IPlCojVUfqnBTARLcg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bcr5ODsN4cZEhpTOe/cobaZU53OofknViEX9VB+nXq0eZa0OO6DryzHgZrw5Yb6Sw2KNLHJzVe0t5TXA4C2dsMoEOS0EruCuJN4LH9UNotAirTex4w9U10q1OenyKVLsQPf4BLxxICJvJUEgMdyQnNfsQy6IGQILrYSXMjbe380=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hgiHt+9o; arc=none smtp.client-ip=209.85.160.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hgiHt+9o"
Received: by mail-qt1-f194.google.com with SMTP id d75a77b69052e-46686a258c2so49137601cf.2
        for <virtualization@lists.linux.dev>; Tue, 03 Dec 2024 08:02:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733241739; x=1733846539; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+WTzDeex6MvV2fYh0DDtmM+R3bGWHPFsxwrTc0tB2Uk=;
        b=hgiHt+9oUJXTxkIaJ7F0YEL5FGxQwKUfSPmSx3gbhma/7mqoOzycY/ODCW8Ud2VsnZ
         1dWrAUhHfYHeJlYeUaFzjiHb7zPV6cGKZ+1DigKLttOjGN/aPeV0Z5wDEvXm8pxXVT2O
         nNCwOUZEVAeHbPzd3cje68bpS1U5uv3VTGdVyn3To06nYUP4rPWV9RRWAnhhHA8eimr0
         swboCH3UNB46IfiYxxa3nt+15/0BbK1ZaL9tRmmkMy/Moe8kk1B5PBeBYaMXnOaSF5ni
         EEYUu29CiXBGknT8NRfiTem1TrdRwXIz2JzqoXzilm8UzM7WNSW8r8Rq3Vpraidt5/BP
         bI5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733241739; x=1733846539;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+WTzDeex6MvV2fYh0DDtmM+R3bGWHPFsxwrTc0tB2Uk=;
        b=MkUpw5kGaE7Uo/nvok2Y23sKKhU57wonabF95DOkKqvlxSuGbekWhIXizfJ6cUrSRs
         QgB/4gynQM9m8dZoczlO28fIFb/DUg1IA8KmNP+b92CVXV8O6sl0eXrGGW9rfBfzLExk
         4tDSMvQdUmMDWldvICrnVpaZcas9UXGgit8Ww1OjseKhI+ucy7Bk+1g5FDSnKKfYwLd5
         jl8AdgPUEQxM/X5eWBEKv8X5l1+q9iJ5LFdAuuOQ+6NsW5lBsTfbHX2sMIC7hNMIXzs1
         EZuJZb+3H1c3Vqndzsp9lvnjDGakN/fEeDoP3Dt4PuE5+tYYkJWyJfFSnBbYw8nHQ/3V
         UkYg==
X-Forwarded-Encrypted: i=1; AJvYcCXzn3B1lL+cWLF3m5Tg+fUjzLJfLMdyAJKoSPrF4derVTpp8zRnKkB/cgqs5Zrg1Nm867jz2i/6j96vEgYTPw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzIVCM7bP3Qd2epKSLDuEPuaKCgLlVw7aB7jdckmiSK+5XupZmB
	Vr7x2tn84hWWHc2tnF23VNymOagKycAIFmWprHHOqR3k63bRUw4E
X-Gm-Gg: ASbGncshrNE1V1QXUttSDvgjpns1qXy32soS+m1dNTj6eRX8RcoWZR4iMAF+v/4Rwp0
	onOh3P5BeEUnxZocaSIjrW+VMpKfOIkA8xx2kNXog8qfNAVySOqS2UwTw6rnTeYSWz0z4Xz2jQT
	RYq0mYv7trSK6dMBGVqXZmPCyAeUCYBIB6QezD7x7WDPKwRwYy6P8SQsPBXlSaMEH212jfu9d07
	ifGuiSZAoyGQP0xQ/DL4yOzs0oYTycyKwfAYp33vE3uMf9UW20pc2PHyJivrR66LwEBbvNiuCYM
	dE7hhgGVcu0vszOCK6loodjnlijFILwpYJm8c1sMoIgP6wSZ+IY6Gg46/T8=
X-Google-Smtp-Source: AGHT+IGDeeGWcRCTKyUCOq7c8fevpRJKKIBDhzv1JtFZuhU7+1av0GGQHLhd5L0WUnUDcgzYEzYebw==
X-Received: by 2002:ac8:5a8b:0:b0:466:ad0d:f0ca with SMTP id d75a77b69052e-4670c6c5432mr40809661cf.50.1733241739116;
        Tue, 03 Dec 2024 08:02:19 -0800 (PST)
Received: from localhost.localdomain (host-36-26.ilcul54.champaign.il.us.clients.pavlovmedia.net. [68.180.36.26])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-466c42319b6sm62809341cf.77.2024.12.03.08.02.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 08:02:18 -0800 (PST)
From: Gax-c <zichenxie0106@gmail.com>
To: maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	thierry.reding@gmail.com,
	mperttunen@nvidia.com,
	jonathanh@nvidia.com,
	kraxel@redhat.com,
	gurchetansingh@chromium.org,
	olvaffe@gmail.com,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	mst@redhat.com,
	airlied@redhat.com
Cc: dri-devel@lists.freedesktop.org,
	linux-tegra@vger.kernel.org,
	virtualization@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Zichen Xie <zichenxie0106@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] drm: cast calculation to __u64 to fix potential integer overflow
Date: Tue,  3 Dec 2024 10:02:00 -0600
Message-Id: <20241203160159.8129-1-zichenxie0106@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zichen Xie <zichenxie0106@gmail.com>

Like commit b0b0d811eac6 ("drm/mediatek: Fix coverity issue with
unintentional integer overflow"), directly multiply pitch and
height may lead to integer overflow. Add a cast to avoid it.

Fixes: 6d1782919dc9 ("drm/cma: Introduce drm_gem_cma_dumb_create_internal()")
Fixes: dc5698e80cf7 ("Add virtio gpu driver.")
Fixes: dc6057ecb39e ("drm/tegra: gem: dumb: pitch and size are outputs")
Signed-off-by: Zichen Xie <zichenxie0106@gmail.com>
Cc: stable@vger.kernel.org
---
 drivers/gpu/drm/drm_gem_dma_helper.c | 6 +++---
 drivers/gpu/drm/tegra/gem.c          | 2 +-
 drivers/gpu/drm/virtio/virtgpu_gem.c | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/drm_gem_dma_helper.c b/drivers/gpu/drm/drm_gem_dma_helper.c
index 870b90b78bc4..020c3b17fc02 100644
--- a/drivers/gpu/drm/drm_gem_dma_helper.c
+++ b/drivers/gpu/drm/drm_gem_dma_helper.c
@@ -272,8 +272,8 @@ int drm_gem_dma_dumb_create_internal(struct drm_file *file_priv,
 	if (args->pitch < min_pitch)
 		args->pitch = min_pitch;
 
-	if (args->size < args->pitch * args->height)
-		args->size = args->pitch * args->height;
+	if (args->size < (__u64)args->pitch * args->height)
+		args->size = (__u64)args->pitch * args->height;
 
 	dma_obj = drm_gem_dma_create_with_handle(file_priv, drm, args->size,
 						 &args->handle);
@@ -306,7 +306,7 @@ int drm_gem_dma_dumb_create(struct drm_file *file_priv,
 	struct drm_gem_dma_object *dma_obj;
 
 	args->pitch = DIV_ROUND_UP(args->width * args->bpp, 8);
-	args->size = args->pitch * args->height;
+	args->size = (__u64)args->pitch * args->height;
 
 	dma_obj = drm_gem_dma_create_with_handle(file_priv, drm, args->size,
 						 &args->handle);
diff --git a/drivers/gpu/drm/tegra/gem.c b/drivers/gpu/drm/tegra/gem.c
index d275404ad0e9..a84acdbbbe3f 100644
--- a/drivers/gpu/drm/tegra/gem.c
+++ b/drivers/gpu/drm/tegra/gem.c
@@ -548,7 +548,7 @@ int tegra_bo_dumb_create(struct drm_file *file, struct drm_device *drm,
 	struct tegra_bo *bo;
 
 	args->pitch = round_up(min_pitch, tegra->pitch_align);
-	args->size = args->pitch * args->height;
+	args->size = (__u64)args->pitch * args->height;
 
 	bo = tegra_bo_create_with_handle(file, drm, args->size, 0,
 					 &args->handle);
diff --git a/drivers/gpu/drm/virtio/virtgpu_gem.c b/drivers/gpu/drm/virtio/virtgpu_gem.c
index 7db48d17ee3a..d5407316b12e 100644
--- a/drivers/gpu/drm/virtio/virtgpu_gem.c
+++ b/drivers/gpu/drm/virtio/virtgpu_gem.c
@@ -72,7 +72,7 @@ int virtio_gpu_mode_dumb_create(struct drm_file *file_priv,
 		return -EINVAL;
 
 	pitch = args->width * 4;
-	args->size = pitch * args->height;
+	args->size = (__u64)pitch * args->height;
 	args->size = ALIGN(args->size, PAGE_SIZE);
 
 	params.format = virtio_gpu_translate_format(DRM_FORMAT_HOST_XRGB8888);
-- 
2.34.1

