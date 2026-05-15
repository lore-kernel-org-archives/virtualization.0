Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4239423144
	for <virtualization@lists.linux.dev>; Fri, 15 May 2026 08:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778834444; cv=none; b=GaMtU3gKoJRcYoZkR6lCHo70opcD03WY0sQAlGMMoGUTvwra/mnYE+cf/+7HtB7S6E2Wmin8royr4WfnvIYH4M2g/cikPN1ESZWfn34dB2haP0X1zRRnyhOsrZph0coAk4Ju7CMll2TYX1z/BwEkBAOcVEW4dxFDJI5g/4NSExs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778834444; c=relaxed/simple;
	bh=bMjgEAA1AihAMMTwD1pxLHmMxEIVCiAxGqmaIQ/5jHA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e8JmyHsx1hEtyyj87spEpxHjz4WjfiWyvUCoJK4TyQn71N2abVucSRP70M0kaKk68paU2IFTCacwZUOJAtRoh2lx6gS6isR1+0P0rkDYhgUIPDscsH52LXJYe+pPWjOKIVGpRgw+VOgXdbfj+fMiJ62N51HIEVE//oVuFtNRdHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D8nGNAt9; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D8nGNAt9"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-366375c4076so4325522a91.3
        for <virtualization@lists.linux.dev>; Fri, 15 May 2026 01:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778834442; x=1779439242; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BcNd3ITFWzMqmrli28Wy6nyBCrJ36rIyJ26nJuqd1AM=;
        b=D8nGNAt9q/3Y0ZFCob0ex8dpchFHZ+rTjmi5E+Bs+2QXbHDuqIuEPNQau0c1bPhG3f
         hZouBUoh0jriz2q9zVTyEtVHt16I2UagkNKrvk/LrkqO1m+0m/XFPU3MXckXoNGA2xBq
         MAFqVAL8rF1WTm14KixW+ojEs6RkchsZYxHBFkGeUIsUMIhYb3CKPFWNi/scDAXJ5Dxe
         0jt1yOWSFCg/P06e88NH5c2nDUN7Z/bYoYOoWS6HBJhnTZdm5/LlWSd9iG9r0WMjVHPN
         FI2mmhPunauNT58jQYmMXSuwvUq0+wP7ngPjsPuG1RRevTm8mJ0d0+4zc+W2YBvvI6VK
         xVbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778834442; x=1779439242;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BcNd3ITFWzMqmrli28Wy6nyBCrJ36rIyJ26nJuqd1AM=;
        b=OzLNKSFXXicz6szLaQOWeIEsidL2jQ+JBH5V2E19OaqO0hd03fuWX4vOIs4SYiZdpG
         PTSADyqTTP96QEhHS7YPL9FO8QmlE2V0DlFqi86CPeX+RzDHclBnTBDuyozKXmhnkqlJ
         SuWHlhWFfMMHgKjnB49HCCeKZL7QgoxSopFbynO89M+G+zD8yeT2LZ1bvA7YXlRtx0q/
         mEPlAJ2tRwclnMUq5l63V8gqDmW+l+OrCvNcXBQJsvNlhTQf/hlXw7mpy81U8Vgxf9Ph
         +QXrBWgHBXFIU2vqHttJMgGG3/6YKdvuowV/v+TTrc7n5UP7hEWNHttGYitmZoqY5Bfs
         zwzQ==
X-Forwarded-Encrypted: i=1; AFNElJ8uhXkGSqisSvM6p5Y+zmtc0dwnpI2PwgGEhv9LTXt4fR1gWF2wCAbbfTe5VOc2wWcJCowJe6jFO0UL0wzNrg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyGC1ESNznc8FBbQSybUvZeqglIIj9Tq1STFcU98nGQ3jgDX1jm
	IbVKvn16luQPWb+EuDok5C2AhoFSMjizM7BX9RXMW976gDUJNW8HUmFC
X-Gm-Gg: Acq92OEIYLFaNPZdqDuBEhsqFZHc/2PHUOi5+a9uL6L1vM8vZdvpTOC3m4H/0lXLoHp
	m6wHltnAy07DMLhZpwAmHGTHtnF3bJeej3WC1brpn0fwMC/nycOZLn01SJOK9ErhkEiVlIh+Cu3
	T3FP392dAziTCaZMirRvkzB4HeW4AgvRRPWXCp/eQJmJJ21HKDsGpLfzZMPZzV2R9ZD5DgoOXY6
	qQTkR1KivgBHCqWMLjrq9XkSZMRFsfHr34j4s9t53S8uAuU7BPcktv3Bbx0B0nRs2RK+TTKrKrP
	sBOReeVL4TnpQDC1USEbrUosp5zlxWcdujTeQQ9hICJTGJ6zI0L2H4sHEtFgktcIVzXG+toTSc3
	PLi2kJR5pvg0HimeQaHz0xH27cMbV6Aj5rPBvBAxTMT4/U55YkNz8xMz4dHqlnNJyM04KrU/Qd3
	WJCMc/r77mEhX21aXETWKVr9DAuqtS+q9vZqUBdKs9IhMctmc69LOmEselESjBu4lL12rvxNBEk
	tTXnG8=
X-Received: by 2002:a17:90b:134b:b0:368:78da:803 with SMTP id 98e67ed59e1d1-36951a01748mr3017625a91.12.1778834441878;
        Fri, 15 May 2026 01:40:41 -0700 (PDT)
Received: from deepanshu-kernel-hacker.. ([2405:201:682f:383f:ad23:b1a5:6537:1208])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36956535742sm637091a91.3.2026.05.15.01.40.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 01:40:41 -0700 (PDT)
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
Subject: [PATCH v3] drm/virtio: use uninterruptible resv lock for plane updates
Date: Fri, 15 May 2026 14:10:30 +0530
Message-ID: <20260515084030.21986-1-kartikey406@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

virtio_gpu_cursor_plane_update() and virtio_gpu_resource_flush() lock
the framebuffer BO's dma_resv via virtio_gpu_array_lock_resv() and
ignore its return value. The function can fail with -EINTR from
dma_resv_lock_interruptible() (signal during lock wait) or with
-ENOMEM from dma_resv_reserve_fences() (fence slot allocation),
leaving the resv lock not held. The queue path then walks the object
array and calls dma_resv_add_fence(), which requires the lock held;
with lockdep enabled this trips dma_resv_assert_held():

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

Both call sites run inside the .atomic_update plane callback, which
DRM atomic helpers do not allow to fail (by the time it runs, the
commit has been signed off to userspace and there is no clean
rollback path). Moving the lock acquisition to .prepare_fb (v2) was
rejected because the broader lock scope deadlocks against other
BO locking paths in the same atomic commit.

Introduce virtio_gpu_array_lock_resv_uninterruptible() that uses
dma_resv_lock() instead of dma_resv_lock_interruptible() on the
nents==1 path. This eliminates the -EINTR failure mode -- the
realistic syzbot trigger -- without extending the lock hold across
the commit. Use it from both virtio_gpu_cursor_plane_update() and
virtio_gpu_resource_flush(); check the return value to handle the
remaining -ENOMEM case by freeing the objs and skipping the plane
update for that frame. The framebuffer BOs touched here are not
shared with other contexts and lock contention is expected to be
brief, so the loss of signal-interruptibility is acceptable.

Other callers of virtio_gpu_array_lock_resv() (the ioctl paths)
continue to use the interruptible variant.

The bug was reported by syzbot, triggered via fault injection
(fail_nth) on the DRM_IOCTL_MODE_CURSOR path, which forces the
-ENOMEM branch in dma_resv_reserve_fences().

Reported-by: syzbot+72bd3dd3a5d5f39a0271@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=72bd3dd3a5d5f39a0271
Fixes: 5cfd31c5b3a3 ("drm/virtio: fix virtio_gpu_cursor_plane_update().")
Cc: stable@vger.kernel.org
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
---
v3: Per maintainer feedback on v2 (lockup caused by the broader
    lock scope in prepare_fb conflicting with other BO locking in
    the same atomic commit): drop the prepare_fb/cleanup_fb
    approach, introduce an uninterruptible variant of
    virtio_gpu_array_lock_resv(), and use it in both
    virtio_gpu_cursor_plane_update() and virtio_gpu_resource_flush().
v2: Move resv lock acquisition from .atomic_update (which must not
    fail) to .prepare_fb (which may), per maintainer review of v1.
    The previous approach of silently skipping the cursor update on
    lock failure violated the atomic-commit contract with userspace.
---
 drivers/gpu/drm/virtio/virtgpu_drv.h   |  1 +
 drivers/gpu/drm/virtio/virtgpu_gem.c   | 24 ++++++++++++++++++++++++
 drivers/gpu/drm/virtio/virtgpu_plane.c | 10 ++++++++--
 3 files changed, 33 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/virtgpu_drv.h
index f17660a71a3e..43a7eb568e15 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.h
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
@@ -317,6 +317,7 @@ virtio_gpu_array_from_handles(struct drm_file *drm_file, u32 *handles, u32 nents
 void virtio_gpu_array_add_obj(struct virtio_gpu_object_array *objs,
 			      struct drm_gem_object *obj);
 int virtio_gpu_array_lock_resv(struct virtio_gpu_object_array *objs);
+int virtio_gpu_array_lock_resv_uninterruptible(struct virtio_gpu_object_array *objs);
 void virtio_gpu_array_unlock_resv(struct virtio_gpu_object_array *objs);
 void virtio_gpu_array_add_fence(struct virtio_gpu_object_array *objs,
 				struct dma_fence *fence);
diff --git a/drivers/gpu/drm/virtio/virtgpu_gem.c b/drivers/gpu/drm/virtio/virtgpu_gem.c
index f22dc5c21cd4..08c4b7ef8d44 100644
--- a/drivers/gpu/drm/virtio/virtgpu_gem.c
+++ b/drivers/gpu/drm/virtio/virtgpu_gem.c
@@ -238,6 +238,30 @@ int virtio_gpu_array_lock_resv(struct virtio_gpu_object_array *objs)
 	return ret;
 }
 
+int virtio_gpu_array_lock_resv_uninterruptible(struct virtio_gpu_object_array *objs)
+{
+	unsigned int i;
+	int ret = 0;
+
+	if (objs->nents == 1) {
+		dma_resv_lock(objs->objs[0]->resv, NULL);
+	} else {
+		ret = drm_gem_lock_reservations(objs->objs, objs->nents,
+						&objs->ticket);
+		if (ret)
+			return ret;
+	}
+
+	for (i = 0; i < objs->nents; ++i) {
+		ret = dma_resv_reserve_fences(objs->objs[i]->resv, 1);
+		if (ret) {
+			virtio_gpu_array_unlock_resv(objs);
+			return ret;
+		}
+	}
+	return 0;
+}
+
 void virtio_gpu_array_unlock_resv(struct virtio_gpu_object_array *objs)
 {
 	if (objs->nents == 1) {
diff --git a/drivers/gpu/drm/virtio/virtgpu_plane.c b/drivers/gpu/drm/virtio/virtgpu_plane.c
index a126d1b25f46..ef118cb4f0fa 100644
--- a/drivers/gpu/drm/virtio/virtgpu_plane.c
+++ b/drivers/gpu/drm/virtio/virtgpu_plane.c
@@ -215,7 +215,10 @@ static void virtio_gpu_resource_flush(struct drm_plane *plane,
 		if (!objs)
 			return;
 		virtio_gpu_array_add_obj(objs, vgfb->base.obj[0]);
-		virtio_gpu_array_lock_resv(objs);
+		if (virtio_gpu_array_lock_resv_uninterruptible(objs)) {
+			virtio_gpu_array_put_free(objs);
+			return;
+		}
 		virtio_gpu_cmd_resource_flush(vgdev, bo->hw_res_handle, x, y,
 					      width, height, objs,
 					      vgplane_st->fence);
@@ -459,7 +462,10 @@ static void virtio_gpu_cursor_plane_update(struct drm_plane *plane,
 		if (!objs)
 			return;
 		virtio_gpu_array_add_obj(objs, vgfb->base.obj[0]);
-		virtio_gpu_array_lock_resv(objs);
+		if (virtio_gpu_array_lock_resv_uninterruptible(objs)) {
+			virtio_gpu_array_put_free(objs);
+			return;
+		}
 		virtio_gpu_cmd_transfer_to_host_2d
 			(vgdev, 0,
 			 plane->state->crtc_w,
-- 
2.43.0

