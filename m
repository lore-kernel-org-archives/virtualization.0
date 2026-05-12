Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF31F2DB79E
	for <virtualization@lists.linux.dev>; Tue, 12 May 2026 02:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778551654; cv=none; b=gw29nuHKDitYjpTkEwTJn0Qk/hsGmOUTY2JxfS3FILYlr7maM8rXvQLOibuTTpcKyRf8+QclH2rwnXX35ST9xUA6phOF+ieB3Sn/3Rt1uuPtCQIFQ40UsIxJXACHDcfhQcSyHQdX25KwCWEdDL7NN4eWzPL+YLCqkw5ZaIjgK/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778551654; c=relaxed/simple;
	bh=/hyU8HQWFXy/zCsuWFPRPpPFHAKfFRaB5wW/ZNRXdFw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=a154zafOJjhVxuIl3v7bNx1mSxFHm+ySt3LonStKlyvmebaD7KegeHbmwgLjkxzgtnMsnsg+gk7vcg7uidCBpp24TKeEgOk41VvJctg2qac6aaw7NPORv6WgxtkS/qVJ3qKVVeLwJlCFkZiciQsnE0xdS0b6rN+TkrWkfRZ7s6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dm3M1y4C; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dm3M1y4C"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-8367df48711so2279870b3a.1
        for <virtualization@lists.linux.dev>; Mon, 11 May 2026 19:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778551652; x=1779156452; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/QiKU/+m/deMkZnUgiMPX7icRFO8sAPHl3F/zxCh9ig=;
        b=Dm3M1y4Cp3DdYmjs0TxXTJ0mbuwNUSyPy6B4O3NyhAt9twZWELuhurFBOByE/3j3Pp
         4zmjhodAOK4FCcvPcC2W6feQdm7xIXPIrhTcKgk6v8Vb49D8BJHDxlD61ngrxLfwWKNM
         +oTqFFi2CqVVpuuNJLaZvaUF8KmE1O5bKDrOj/6yCr3PI/u1PcHfTgfrcbc8ceKRF2Dj
         +F9uIqtvLmhoopXdt4GH2WOZ8RYU4QGnkHAQOb/gtLG7az5QloPe7UM/8gCRDi25f/Sm
         id5w/XMxjqa8/p3OktKREiLjJVTzC/1a8ibPsY+Tdqelejc6tqE3tkCC4A32n1HLxT2l
         BLPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778551652; x=1779156452;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/QiKU/+m/deMkZnUgiMPX7icRFO8sAPHl3F/zxCh9ig=;
        b=YZZrdySkX/RRah0Pm85HLx4V1oyCC4O9JZHzefxHmYNVdZc+JEvoywSJl8VzSwZzv7
         N8ZXo8qX+k13iORMdUmhKwIEYQCUtSde8jujzujyFF9nTuduu58MWrd+Lbpk4yaYaLDU
         g65Jbtjkv3I4hgxyudOOU6SpGqO1eh/RVU1PAsOSDFhmWd1f0h6AAd/ehde5JvV8HZrz
         gioef09mRMLpagPz6eYBSfGzlmG3R8qsQMnOvLS4VsIv0vbstUaw1+BnrF7cyaswBlpk
         6X8rnf/QzhXGlbb53zFFQCYvdZCi+j/gc8gLPZl0yzBIESvxbGy1cf2HqTs6OTkHbzbk
         I6ag==
X-Forwarded-Encrypted: i=1; AFNElJ8bc2y+THbe44fdIGbKFDNGspCWf9trIfE/JC3bWUPwsjP+MpEsRh0awBK2Xpv4v48shrY2+1ysQzu7nf6Hbw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxuuxxKCd7JiQZRJy36oYEg++KkdPylZePhdlhM7VeB9bEClvD7
	70EzvV/0bBAwyxkRdEr7ZQQOwDNw6ompcOrOSV5p1auYy/PsJVZzSq7VyNx9BvCw
X-Gm-Gg: Acq92OHwcBz1fcl1B0NlsQk1SPfnjxn+6N0mj2h9v9CN0dlAoBeBBWgETL3XncB78vm
	uYabORG/UClsKfpq1XFXecHdv9clpfp9jVnON8JsEb6oaZpxD1ZGP5PHHQ2A/ttQFKxCVQVUF4u
	wcUzczMyCR0sUybypPD3/pn/CDtqW3qvkGq47FFwuYn7DPyiZgUMgJNqYgHwfYpoPCLEwnibyVv
	hJ7Qa0w0Rq69yjTwzQxBe73oZeM1Mi0shCPG83c/5sv8SkcHidWLJo6uoqKbBGE6O0QgUkk9scL
	dLbsAkSmWqHBvlpLnfO1FMQ98t48IcX6nsbnMWpBuXuUFg0yPsDLmhE4KRZz/QzU343miguxn3R
	YXxk8Fpijhb2XcQbyv/NZvyvNfNZ8eXNLPU6+nzT4pj0gErYhoaHW/gnv1ZpDHuDOQkPQ7h6196
	sBHaFWPEurKxo4ThowmOhfDU4E2UhNAC3aoCfpW0vEMmj1FalkjUl+jzzM1kSuc4N+WUQE7mJhB
	ISsRNg=
X-Received: by 2002:a05:6a00:ad8a:b0:82a:17b8:1474 with SMTP id d2e1a72fcca58-83eeb9f0e34mr977275b3a.1.1778551652212;
        Mon, 11 May 2026 19:07:32 -0700 (PDT)
Received: from deepanshu-kernel-hacker.. ([2405:201:682f:383f:b0ab:8219:937d:e207])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83967dbf7d2sm28966425b3a.49.2026.05.11.19.07.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 19:07:31 -0700 (PDT)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: airlied@redhat.com,
	kraxel@redhat.com,
	dmitry.osipenko@collabora.com,
	gurchetansingh@chromium.org,
	olvaffe@gmail.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	simona@ffwll.ch,
	sumit.semwal@linaro.org,
	christian.koenig@amd.com
Cc: dri-devel@lists.freedesktop.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	linaro-mm-sig@lists.linaro.org,
	Deepanshu Kartikey <kartikey406@gmail.com>,
	syzbot+72bd3dd3a5d5f39a0271@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: [PATCH v2] drm/virtio: move cursor resv lock acquisition to prepare_fb
Date: Tue, 12 May 2026 07:37:18 +0530
Message-ID: <20260512020718.108044-1-kartikey406@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

virtio_gpu_cursor_plane_update() allocates a virtio_gpu_object_array,
locks its dma_resv, and queues a fenced transfer to the host. The
lock acquisition can fail in two ways:

  - dma_resv_lock_interruptible() returns -EINTR when a signal is
    delivered while waiting for the reservation lock.
  - dma_resv_reserve_fences() returns -ENOMEM if it fails to allocate
    a fence slot; in this case lock_resv unlocks before returning.

The return value was ignored, so the cursor path could proceed with
the resv lock not held. The queue path then walks the object array
and calls dma_resv_add_fence(), which requires the lock; with lockdep
enabled this trips dma_resv_assert_held():

  WARNING: drivers/dma-buf/dma-resv.c:296 at dma_resv_add_fence+0x71e/0x840
  Call Trace:
   virtio_gpu_array_add_fence
   virtio_gpu_queue_ctrl_sgs
   virtio_gpu_queue_fenced_ctrl_buffer
   virtio_gpu_cursor_plane_update
   drm_atomic_helper_commit_planes
   drm_atomic_helper_commit_tail
   commit_tail
   drm_atomic_helper_commit
   drm_atomic_commit
   drm_atomic_helper_update_plane
   __setplane_atomic
   drm_mode_cursor_universal
   drm_mode_cursor_common
   drm_mode_cursor_ioctl
   drm_ioctl
   __x64_sys_ioctl

Beyond the WARN, mutating the dma_resv fence list without the lock
races with concurrent readers/writers and can corrupt the list.

The DRM atomic helpers do not allow .atomic_update to fail: by the
time it runs, the commit has been signed off to userspace and there
is no clean rollback path. Move the fallible work -- objs allocation,
dma_resv locking, and fence slot reservation -- into
virtio_gpu_plane_prepare_fb, which is the designated callback for
resource acquisition and may return errors that the framework
handles by rolling back the commit. Stash the prepared object array
on virtio_gpu_plane_state so the update step can consume it.

Make virtio_gpu_plane_cleanup_fb release the objs if the commit was
rolled back before update ran (i.e., objs not consumed). The queue
path already unlocks the resv after attaching the fence (vq.c:411)
and frees the array via put_free_delayed after host completion
(vq.c:271), so the update step only needs to clear vgplane_st->objs
to transfer ownership.

Simplify virtio_gpu_cursor_plane_update to a no-fail queue submission
that hands the prepared, locked objs to the queue path.

The bug was reported by syzbot, triggered via fault injection
(fail_nth) on the DRM_IOCTL_MODE_CURSOR path, which forces the
-ENOMEM branch in dma_resv_reserve_fences().

Reported-by: syzbot+72bd3dd3a5d5f39a0271@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=72bd3dd3a5d5f39a0271
Fixes: 5cfd31c5b3a3 ("drm/virtio: fix virtio_gpu_cursor_plane_update().")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/all/20260510053025.100224-1-kartikey406@gmail.com/T/ [v1]
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
---
v2: Move resv lock acquisition from .atomic_update (which must not
    fail) to .prepare_fb (which may), per maintainer review of v1.
    The previous approach of silently skipping the cursor update on
    lock failure violated the atomic-commit contract with userspace.
---
 drivers/gpu/drm/virtio/virtgpu_drv.h   |  1 +
 drivers/gpu/drm/virtio/virtgpu_plane.c | 38 ++++++++++++++++++++------
 2 files changed, 30 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/virtgpu_drv.h
index f17660a71a3e..e51f959dce46 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.h
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
@@ -198,6 +198,7 @@ struct virtio_gpu_framebuffer {
 struct virtio_gpu_plane_state {
 	struct drm_plane_state base;
 	struct virtio_gpu_fence *fence;
+	struct virtio_gpu_object_array *objs;
 };
 #define to_virtio_gpu_plane_state(x) \
 	container_of(x, struct virtio_gpu_plane_state, base)
diff --git a/drivers/gpu/drm/virtio/virtgpu_plane.c b/drivers/gpu/drm/virtio/virtgpu_plane.c
index a126d1b25f46..b0511ace89e6 100644
--- a/drivers/gpu/drm/virtio/virtgpu_plane.c
+++ b/drivers/gpu/drm/virtio/virtgpu_plane.c
@@ -381,6 +381,23 @@ static int virtio_gpu_plane_prepare_fb(struct drm_plane *plane,
 			goto err_fence;
 	}
 
+	if (plane->type == DRM_PLANE_TYPE_CURSOR && bo->dumb) {
+		struct virtio_gpu_object_array *objs;
+
+		objs = virtio_gpu_array_alloc(1);
+		if (!objs) {
+			ret = -ENOMEM;
+			goto err_fence;
+		}
+		virtio_gpu_array_add_obj(objs, vgfb->base.obj[0]);
+		ret = virtio_gpu_array_lock_resv(objs);
+		if (ret) {
+			virtio_gpu_array_put_free(objs);
+			goto err_fence;
+		}
+		vgplane_st->objs = objs;
+	}
+
 	return 0;
 
 err_fence:
@@ -417,6 +434,12 @@ static void virtio_gpu_plane_cleanup_fb(struct drm_plane *plane,
 		vgplane_st->fence = NULL;
 	}
 
+	if (vgplane_st->objs) {
+		virtio_gpu_array_unlock_resv(vgplane_st->objs);
+		virtio_gpu_array_put_free(vgplane_st->objs);
+		vgplane_st->objs = NULL;
+	}
+
 	obj = state->fb->obj[0];
 	if (drm_gem_is_imported(obj))
 		virtio_gpu_cleanup_imported_obj(obj);
@@ -452,21 +475,18 @@ static void virtio_gpu_cursor_plane_update(struct drm_plane *plane,
 	}
 
 	if (bo && bo->dumb && (plane->state->fb != old_state->fb)) {
-		/* new cursor -- update & wait */
-		struct virtio_gpu_object_array *objs;
-
-		objs = virtio_gpu_array_alloc(1);
-		if (!objs)
-			return;
-		virtio_gpu_array_add_obj(objs, vgfb->base.obj[0]);
-		virtio_gpu_array_lock_resv(objs);
+		/* objs and fence were prepared in virtio_gpu_plane_prepare_fb;
+		 * the resv is already locked. The queue path takes ownership
+		 * of objs and unlocks the resv after attaching the fence.
+		 */
 		virtio_gpu_cmd_transfer_to_host_2d
 			(vgdev, 0,
 			 plane->state->crtc_w,
 			 plane->state->crtc_h,
-			 0, 0, objs, vgplane_st->fence);
+			 0, 0, vgplane_st->objs, vgplane_st->fence);
 		virtio_gpu_notify(vgdev);
 		dma_fence_wait(&vgplane_st->fence->f, true);
+		vgplane_st->objs = NULL;
 	}
 
 	if (plane->state->fb != old_state->fb) {
-- 
2.43.0

