Received: from mail-pj2-f41.google.com (mail-pj2-f41.google.com [74.125.227.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D228435F5E3
	for <virtualization@lists.linux.dev>; Sun, 27 Sep 2026 04:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790482024; cv=none; b=NdIaOlIVhPvkqs65TiwGYcNAjv+K00Stk1Fuh0BslWVAG5+gOJ8+BI4BnmYCv3IffFUhOB8PUBoe/r04Wv3m+KsHwtjYiIFxC2uy5geyH/2Lefm3PIdmqjAkaBibZXlUPDAVyO1Mbf4Ff1ex6Wp6r5TD2a5YaxoFFEzV+BnS5Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790482024; c=relaxed/simple;
	bh=088gMiMMdfhBakYerlGjzfvUzuNsGRYEXZYzg3JNdDw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PyZJ1mg9eSOfaBN23Zh1WbBESzErd/CLKNEXLhCfCgdCYpUqq8kpGmpqPRXPIoC2D+1TD14k9LVD/KHVNEuqlQ35BdsOnWjbcIpuuE/CsSyubq5uBZmZsINnCEORSQ8qZy8AbdCQvIJbb5s/Qcpt9zhyBJAf1mTSVbbe9G/nbFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pB4SJQ+V; arc=none smtp.client-ip=74.125.227.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pB4SJQ+V"
Received: by mail-pj2-f41.google.com with SMTP id 98e67ed59e1d1-3a0b6200eb0so1533892a91.2
        for <virtualization@lists.linux.dev>; Sat, 26 Sep 2026 21:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790482022; x=1791086822; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=7z9jyGFvSNyPE4j90ojKfCFxGEKOnKcOHIMpedzYh5o=;
        b=pB4SJQ+V5Va3hz/+Pr5buH+dnWNjq1Ob2cfQGbDe7yNPDfCpY9+IR6oPEumDW57bCR
         HlIlLNfQ1hh/8o3UcNdx8Vm3Csewir7ROUZ9/j2wheoGIU+xE5RGduLYxuKdU7+tHO1N
         h+3crZXsxSWSofA+rzzhvifb6ooDdtSfm4E/1k4swAEJmbURAqPIIh7WWYs/DFJcbs/4
         VwI/7w1vKhYv0ykybJF0LxnIn3P5cvibSzMm+KMAYZD+6/EffRF25NjsTITbtduXVwfN
         deBWepsvjBoP9bTfaBschplMftcWcJn3jrtfZXn9kWn0forn3lPuikhyOY0JHPEYHs3K
         C9Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790482022; x=1791086822;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7z9jyGFvSNyPE4j90ojKfCFxGEKOnKcOHIMpedzYh5o=;
        b=iY4eR6KlfBxP0d6h9Vv9Vhav7HNMdCBQoYMs22rGVzCDaL1p6SF34mKIG1RJ6xSaB5
         SDFxMhihyKQv+jDrdZy/ccYNyHbL5bVC5oLAnILuVrDIBeKQouYLp6AWJsuTbKxBHveB
         a6fODc0VACQNQM9rSe9/Jl1cSZ2HEpo80zQ3tLmSyPdG0qhRVo+Cs/CPsVmllkhFB5Gl
         iPPDBPb/ectTX0nwD+LId3Pc4KSY1KUQkDYEb/JQdBXdo7ec4F4M03fNnqNJ+vejTUL1
         lmiKDFp/8MrwyCbW7wgvnmrP56zlggkfhVQj5PtLPKawauYVXXrR7HBusW3cQDniZkb+
         iTkg==
X-Forwarded-Encrypted: i=1; AKwUvBxBf80ysecjfru+Y6rsqqXHWFA14H/HEZ56PO/MXV1FsAhIvBjwn74naQW6RUL8zBBbgj6pOeao6pBO5cNjhg==@lists.linux.dev
X-Gm-Message-State: AFq9FYKely5ZPzwmEXAc0b183irAT/u8a1PJYeMT4f06ixg86HMdks62
	FGjVP2xc0ohkDgqGXXXluHlxCHQ28Zt0l74Y6qw4/B74TXbhx9+eN7zf
X-Gm-Gg: AYBFou2KtbPzDiboE52hUfxufbiQt62Ri+1WlDZcHDS7EMF4x3j0l4L3OeNw8hlAtpa
	jOU1DOWW5exENYSlXzrdchFQQ8Rx0dHZu1VaXaULQ1L17J2rR3j7+4ccQQQixi4foI5TDP0VKiB
	0PVt8ietcf2BLWpFjocvzpKAYRjX9U7FhE7uwo2DgrNlpiJll0vZja6efrbN/VHT4lNLM0WacZx
	W2ggX6lHkbrxKqGL6A17UMVXmOQuLUpsk9BkZSR9eVGQMUDs74ZEhmxBhdZmtEBa2kwRzmr870d
	SBM4PcE1Om6sPDYU8nd7oL6x2/P3gR++1k11KmeOU2i9pqtDtaO3JxSrljAlQzoc14XP74agW1F
	PFi2kRq3XIBCWXjeWGV65bTLApDerUEBTHwSianBKUA/eFGpNj3zC/GcVDS/i4EMPzIdU+UTywj
	PKoBx8gh5cimxzIXjk6BjBjWr0GLYtkcTUe+iwaRHeLq5ZrYUBEdpIIWzdokKMkoRnmTemdlfOo
	IF3UOoeGazC5AFv
X-Received: by 2002:a17:90b:57e8:b0:39e:6c6a:6578 with SMTP id 98e67ed59e1d1-3a0bb6537admr5254135a91.59.1790482022096;
        Sat, 26 Sep 2026 21:07:02 -0700 (PDT)
Received: from thangnn-ASUS.. ([2405:4802:1d4a:e90:3a0c:2ea9:4ab7:bd1b])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0e7036e3bsm5833191a91.13.2026.09.26.21.06.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 21:07:01 -0700 (PDT)
From: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
To: David Airlie <airlied@redhat.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: Gurchetan Singh <gurchetansingh@chromium.org>,
	Chia-I Wu <olvaffe@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Simona Vetter <simona@ffwll.ch>,
	dri-devel@lists.freedesktop.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>,
	syzbot+d93b9064fe5f74af3aa3@syzkaller.appspotmail.com
Subject: [PATCH] drm/virtio: put GEM objects when dropping a vbuf on unplug
Date: Sun, 27 Sep 2026 11:06:55 +0700
Message-ID: <20260927040655.14531-1-ngocthang2710.1999@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

virtio_gpu_queue_ctrl_sgs() drops the command when drm_dev_enter() fails
or when vqs_released is set. It unlocks the reservation and frees the
vbuf, but never releases the references that the caller handed over in
vbuf->objs. Those references are normally dropped from the dequeue path,
which never sees a command that was not queued.

If a framebuffer flush races with device removal, the GEM object backing
the fbdev buffer keeps a stale reference, is never freed, and its node is
still in the vma offset manager when the drm_device is released:

  Memory manager not clean during takedown.
  WARNING: drivers/gpu/drm/drm_mm.c:965 at drm_mm_takedown
  Call Trace:
   drm_managed_release
   drm_dev_put
   virtio_dev_remove
   virtio_pci_remove
   pci_device_remove
   remove_store

Drop the object references together with the vbuf on both early-exit
paths.

Reported-by: syzbot+d93b9064fe5f74af3aa3@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=d93b9064fe5f74af3aa3
Fixes: b7170f9457f2 ("drm/virtio: return virtio_gpu_queue errors")
Signed-off-by: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
---
 drivers/gpu/drm/virtio/virtgpu_vq.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/virtgpu_vq.c
index c02c03c10d92..b36c4da04b18 100644
--- a/drivers/gpu/drm/virtio/virtgpu_vq.c
+++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
@@ -208,6 +208,17 @@ static void free_vbuf(struct virtio_gpu_device *vgdev,
 	kmem_cache_free(vgdev->vbufs, vbuf);
 }
 
+static void virtio_gpu_drop_vbuf(struct virtio_gpu_device *vgdev,
+				 struct virtio_gpu_vbuffer *vbuf, bool locked)
+{
+	if (vbuf->objs) {
+		if (locked)
+			virtio_gpu_array_unlock_resv(vbuf->objs);
+		virtio_gpu_array_put_free(vbuf->objs);
+	}
+	free_vbuf(vgdev, vbuf);
+}
+
 void virtio_gpu_reclaim_vbufs(struct virtio_gpu_device *vgdev)
 {
 	struct virtio_gpu_vbuffer *vbuf;
@@ -410,9 +421,7 @@ static int virtio_gpu_queue_ctrl_sgs(struct virtio_gpu_device *vgdev,
 	int ret, idx;
 
 	if (!drm_dev_enter(vgdev->ddev, &idx)) {
-		if (fence && vbuf->objs)
-			virtio_gpu_array_unlock_resv(vbuf->objs);
-		free_vbuf(vgdev, vbuf);
+		virtio_gpu_drop_vbuf(vgdev, vbuf, fence);
 		return -ENODEV;
 	}
 
@@ -432,9 +441,7 @@ static int virtio_gpu_queue_ctrl_sgs(struct virtio_gpu_device *vgdev,
 		 * synchronize_srcu() wait in drm_dev_unplug().
 		 */
 		if (vgdev->vqs_released) {
-			if (fence && vbuf->objs)
-				virtio_gpu_array_unlock_resv(vbuf->objs);
-			free_vbuf(vgdev, vbuf);
+			virtio_gpu_drop_vbuf(vgdev, vbuf, fence);
 			drm_dev_exit(idx);
 			return -ENODEV;
 		}
-- 
2.43.0

