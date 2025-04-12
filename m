Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4451719CD1E
	for <virtualization@lists.linux.dev>; Sat, 12 Apr 2025 13:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744464067; cv=none; b=bTW2TDViHnhWPU0fQy3G4jutCS6Qczv3Y+AI76ByyYRZFZO8jDEDxGmSdsEt9d8lnrSYQRNpLFT3AKwT5XgI42OrMwdL1BLKEHnZrJlrkgxFRoiehZo/mFf/MOnEvBs284FFQMaddWDjP5SHnkWuu/KccipWTrLB7QT1Y0bOj3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744464067; c=relaxed/simple;
	bh=3TPNIoSPNI0MehJrLCyOai0X0fQvy/BYAPhC/wsGsaE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=QT2cPz6A/r3g0sNESQX/VGe1OEnuQt31ig6BLkP+tlP8lwmpBb7jMSm++AuEZzZp/Io7I2a0I89IBG1yqw7wL93vmnf4Hj7dTa2rAbsM8DneMcn3kqZ0Gtw2Zr9Z+Utb2nJfENliWc5iYG+WM3QSYKzw7j2l6aJoo/1axTWuoXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HwAQP4c4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HwAQP4c4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744464062;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=cK1rC0XjXhIHTt9tiNECT2Vn+CAc7jag5l0SYJ2eGBk=;
	b=HwAQP4c4LyCWFJGGIf48xoJ4B/AsUIAPQdxyOhtSEViJg2I6C4RJeS5xGjJSiSdK69fgqK
	6ILQQIDPoV9kaeCOzZQHGy9U21XZNMUhxoS7jyKpG+VUKAcQM+y1u4XjTutNt+jUNCNSI/
	5HL0bMPK6PmOo6YLF0pNzFqn8fw2UyI=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-73-r-LUuyZeNo-fOGZQdIfqYA-1; Sat, 12 Apr 2025 09:21:00 -0400
X-MC-Unique: r-LUuyZeNo-fOGZQdIfqYA-1
X-Mimecast-MFC-AGG-ID: r-LUuyZeNo-fOGZQdIfqYA_1744464060
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-22410053005so46148195ad.1
        for <virtualization@lists.linux.dev>; Sat, 12 Apr 2025 06:21:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744464059; x=1745068859;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cK1rC0XjXhIHTt9tiNECT2Vn+CAc7jag5l0SYJ2eGBk=;
        b=AQH2AsNWE7a3cAJsN4KsTsWrqjUzGocXcHHfWHXsdbBooig7wP63+mReBWGo0sE9BO
         BMY58n3hcTwUOsSLlMtOhYbp42OZRbyCWpJmIw5pc1fShMHsMKY46eklQZXAYtQl6KCd
         fU820Rc8qAbWi7NwvrofdxfifklXor3AxsOa+2NewB6g4Rg3udSLqu/nubK+8wmjiYii
         tN1i1JcS8llYEvpBWAJO8K4jaid0w64BgOZMZnBxFnbO+Jy61n34eSDaeDsxOXxOuSTz
         szQadKscIHxKpONeS9bQKHLdQbaIPXMu7RBpF839F2jHwc8Qubw585YuGeAmGC5EKbME
         fBmQ==
X-Forwarded-Encrypted: i=1; AJvYcCWM8t5vKrjbU5ai6wtxMpjLPZHaL5fgBa05FJu32AY/15REo7IWRIEdVnQcL9uySw5xcwxmUI5+e7bdgt6nJQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwELRMK9ntPB/NK2Xdy9fUmv0wHX9X0mrB+4bzi9XcRk9hSmOvE
	XK1wfMEqm87SH5xWMR1qGnUfXmVRlHUUDvnAA5D2NaRwLpCbHL1kgN8i4kLZMZdiPjTjaojI1Jf
	k8car6ljhoLvmy/riTfhIrdQEASWkkUm751i1uScueNOTGm8YgBzJ29QqbTBgzj5Z
X-Gm-Gg: ASbGncsA3rkr/kaZcd0jSyL3h/kw4Yb3Q354BBEjyt4MWz7fRrgTEv0ZAV39Ni3RxNU
	nQ4J2hT5pXJxg3AmTrB4+V7tN3MOyN0nqik/Du7C8wwyc15m8itB8i85yanXnkLKO3z9+Iq/p45
	ApTb93j2xS3/lPrS/U9x8SWAbpjjxKuJhEdAI4N5caR0AgEkk3Ygv4X2fPVSjZ/qS0SPEsUOxaU
	YGxI3jWr1oFVBrtF8lvICljomDfiy4pPeVIxzLjZfvMOI/iPGQgV8uujUl52JAvV1HjwCa98nk2
	A3WEXdkANYqp
X-Received: by 2002:a17:902:eb8a:b0:21f:6bda:e492 with SMTP id d9443c01a7336-22bea4f1acamr104191795ad.35.1744464059530;
        Sat, 12 Apr 2025 06:20:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEThxesy3Exij/NdLn+H03RMD7vSClcGR8SiZ0slO7o59/AF4Noe0XODfKIUFyC5GjjM9GJKw==
X-Received: by 2002:a17:902:eb8a:b0:21f:6bda:e492 with SMTP id d9443c01a7336-22bea4f1acamr104191255ad.35.1744464059038;
        Sat, 12 Apr 2025 06:20:59 -0700 (PDT)
Received: from zeus.elecom ([240b:10:83a2:bd00:6e35:f2f5:2e21:ae3a])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b02a0818248sm6466199a12.9.2025.04.12.06.20.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Apr 2025 06:20:58 -0700 (PDT)
From: Ryosuke Yasuoka <ryasuoka@redhat.com>
To: airlied@redhat.com,
	kraxel@redhat.com,
	dmitry.osipenko@collabora.com,
	gurchetansingh@chromium.org,
	olvaffe@gmail.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	simona@ffwll.ch,
	jfalempe@redhat.com
Cc: Ryosuke Yasuoka <ryasuoka@redhat.com>,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH] drm/virtio: Support drm_panic with non-vmapped shmem BO
Date: Sat, 12 Apr 2025 22:20:11 +0900
Message-ID: <20250412132012.291837-1-ryasuoka@redhat.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 7ilAYuE19mcSPWJgy20aK_0Ko04W-GqAeDDKGJDaHHQ_1744464060
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Pass array of pages of the scanout buffer [1] to shmem BO, allowing
drm_panic to work even if the BO is not vmapped.

[1] https://lore.kernel.org/all/20250407140138.162383-3-jfalempe@redhat.com/

Signed-off-by: Jocelyn Falempe <jfalempe@redhat.com>
Signed-off-by: Ryosuke Yasuoka <ryasuoka@redhat.com>
---
 drivers/gpu/drm/virtio/virtgpu_plane.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_plane.c b/drivers/gpu/drm/virtio/virtgpu_plane.c
index a6f5a78f436a..2ff57d559c86 100644
--- a/drivers/gpu/drm/virtio/virtgpu_plane.c
+++ b/drivers/gpu/drm/virtio/virtgpu_plane.c
@@ -500,11 +500,19 @@ static int virtio_drm_get_scanout_buffer(struct drm_plane *plane,
 
 	bo = gem_to_virtio_gpu_obj(plane->state->fb->obj[0]);
 
-	/* Only support mapped shmem bo */
-	if (virtio_gpu_is_vram(bo) || bo->base.base.import_attach || !bo->base.vaddr)
+	if (virtio_gpu_is_vram(bo) || bo->base.base.import_attach)
 		return -ENODEV;
 
-	iosys_map_set_vaddr(&sb->map[0], bo->base.vaddr);
+	if (bo->base.vaddr)
+		iosys_map_set_vaddr(&sb->map[0], bo->base.vaddr);
+	else {
+		struct drm_gem_shmem_object *shmem = &bo->base;
+
+		if (!shmem->pages)
+			return -ENODEV;
+		/* map scanout buffer later */
+		sb->pages = shmem->pages;
+	}
 
 	sb->format = plane->state->fb->format;
 	sb->height = plane->state->fb->height;

base-commit: e7bb7d44c3b97aea1f0e354c6499900154ac67f2
-- 
2.49.0

