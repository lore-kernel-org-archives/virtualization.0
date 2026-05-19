Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02FA63E1681
	for <virtualization@lists.linux.dev>; Tue, 19 May 2026 08:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779178994; cv=none; b=jxwkukLdtiUqwrySBbjzEKxJDtLesZtTj6xLNVRuoP3dWalG/IeOWhgWGcg+oJsQYrSmUZWeOaP9vOBMRZHx03dWBtfK7zKi6GX6NpTH2I99EBjwHzM/mpG1Dl5tbisM968KxlSl+LAQ0msbRgeqjpDor1z7wjTbspC4rE0mdgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779178994; c=relaxed/simple;
	bh=P2aRkSF/wE8PSlTzoEmkJdge0lfompjr7htI4yHRBRA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bwDXTLH/RKFLqMFhpWYoNHsq2rct/kZtYKnFHSwkUU+X/ORN2vxxMsg+SawwwJVoDtrwHzeqXvlosXfU1vcLQ9/M28vMit8vrydrB8AFfecYabj0WlEhthCo8uQEOgNo6bCG0ehJS2+z54VXB4o9VdyyAyPeAuh0yJiIgLannoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dNEzjFOH; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dNEzjFOH"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-368f25ff4c4so1559485a91.2
        for <virtualization@lists.linux.dev>; Tue, 19 May 2026 01:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779178992; x=1779783792; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Cw+HXkNbB/u5QBrnahLqduKfToHyIm0xf5S3V5dfPlI=;
        b=dNEzjFOHtTXN3StyauitX6A9zfK/1JHSunI5dJrMtig5RtPJ5r7Q4jhmatH6Uqyafs
         HLm7V7nuC1StveZUt9jy/xgRdCa94+E8sUyukV5ziNMQYnixdKaff92PT5VUafMZ3mDq
         8sKb1JpUYLN0xRBA7LnwnP4kSbS7yu9u0I5VxZaiShth4+rcSSRpYI2pu9PCHlQzsxI9
         4YZfWtmU7tSw8KXS12aeHCG/+45x/FLBnfhhjggWRQd+Z7yfK5teGtH6hgjH0lnEjk2B
         yeGn2vxo/1RrpCvLBMCilQuhbxXPXLkT2ByEqC1NMi6RMejZqvu9JwZNi1f7fo4Hx/4O
         S8ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779178992; x=1779783792;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cw+HXkNbB/u5QBrnahLqduKfToHyIm0xf5S3V5dfPlI=;
        b=j0Ljiy720w0pWzjiLSlyy1eaJSBMGXswN5wkNp6SDiWdVHyfUBjpO85phQYrMZpZ2c
         LLBoi7KqyQ+QihSznlZVKuztKuIcH/w835DqiB0zrb1cq/bAvCswu2HhS4MZhH/mExDH
         6O4ehD1e1KH9d7OMXWf4bnnRseCnW/jJ23FwZW30A1BF/EavrkRzHUMaQEtWOY29Xt+d
         TsLLp+6joxAhKUopbHhJ3l+QmkxTIVXNWFuFdB2jhaBCcZfFcGvd42eMl/3v7Fm4e4E2
         mxPQP52ei75/gVQ7j9O4E1EEA8Klb1w1q+QAB8oJVJRModSOX4XZ6EyoA5MnZdYVvcU7
         8z5A==
X-Forwarded-Encrypted: i=1; AFNElJ97FW792VjZBX5Hkp2qu0azO1poVWvXm7ju47kPFgKla07lQ2GmqOqDiCMELTQwgiK0Ix0CNs8TJSfMCxBuww==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx/5rd6owaNRmCPA8UEulvExj6YJngdSuboaq9SBUvrcsxnUPjF
	O7/zFVIBWTlzUHS/ufJ2zNd//xwYeRxnfZcD9TpmaMM8S7J8j4RtZV74
X-Gm-Gg: Acq92OFd+Q/d1tAQtDPGzXAe20le1l2qRMITfhRBKO2qyLG16+u+3PKmK1d9IB0zV8E
	tXNd9wjyKvgHU8QK1vOwn/nWNPq/fVvjmBstF6hjXOSJVcS5DTXERdbxFmQ/zRYcsM75JoQyaFs
	QMnNW3DERcImreR0lH+VbKdBdQtdXpGUM3Jh+pvba7HEyczisIFTSdmkj6YGbwmxNM5e4nUb4it
	iejyRIedtwGyDwOUC36WFe8T7nP+vm4uJ4iq6v17oxGMlSVLbaLK/nH907K9HO8VphVP8bQ9qEW
	N1ZNq6LuIaA00+xBN2iVSWQwdu0ItzL89vwWBjhCBe27xX/4VrD9bAxNKeCnLCQzJBtquhAvIkn
	iC5Qri+hjCyhAjqX8xh12Vm2xHzImklWBohLzZ7p2nsjJOlKgZ3l665w8tzf+NxtxknVHOrZc95
	L9fWHi1DV3j35eDY2Eed7OA2WJ2R/tWGL1b58db+j01bNCel7bQfT8vtMDazUIJt0S5RA74WERc
	WmxrYTFBCkDd6k=
X-Received: by 2002:a17:90b:4b8c:b0:359:87a8:e65c with SMTP id 98e67ed59e1d1-36951b8280dmr18284305a91.17.1779178992328;
        Tue, 19 May 2026 01:23:12 -0700 (PDT)
Received: from deepanshu-kernel-hacker.. ([2405:201:682f:383f:d693:97f:df7:b062])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3695126feabsm13019156a91.6.2026.05.19.01.23.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 01:23:11 -0700 (PDT)
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
Subject: [PATCH v4] drm/virtio: use uninterruptible resv lock for plane updates
Date: Tue, 19 May 2026 13:52:47 +0530
Message-ID: <20260519082247.34470-1-kartikey406@gmail.com>
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
rollback path). Moving the lock acquisition to .prepare_fb was
rejected because the broader lock scope deadlocks against other BO
locking paths in the same atomic commit.

Introduce virtio_gpu_lock_one_resv_uninterruptible() that uses
dma_resv_lock() instead of dma_resv_lock_interruptible(). This
eliminates the -EINTR failure mode -- the realistic syzbot trigger
-- without extending the lock hold across the commit. The helper
locks a single BO and rejects nents > 1 with -EINVAL; both fix
sites lock exactly one BO.

Use it from virtio_gpu_cursor_plane_update() and
virtio_gpu_resource_flush(); check the return value to handle the
remaining -ENOMEM case from dma_resv_reserve_fences() by freeing
the objs and skipping the plane update for that frame. The
framebuffer BOs touched here are not shared with other contexts
and lock contention is expected to be brief, so the loss of
signal-interruptibility is acceptable.

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
v4: Rename the helper to virtio_gpu_lock_one_resv_uninterruptible()
    and reject objs->nents > 1 with -EINVAL. The v3 helper's
    multi-object branch used drm_gem_lock_reservations(), which is
    interruptible, contradicting the "uninterruptible" name; both
    fix sites lock a single BO so the multi-object path is dropped.
    (Dmitry Osipenko)
v3: Drop the prepare_fb/cleanup_fb approach from v2 (it deadlocked
    against virtio_gpu_resource_flush(), which also locks the BO in
    the same atomic commit). Instead add an uninterruptible variant
    of the resv lock helper and use it in both
    virtio_gpu_cursor_plane_update() and virtio_gpu_resource_flush().
    (Dmitry Osipenko)
v2: Move resv lock acquisition from .atomic_update (which must not
    fail) to .prepare_fb (which may), per maintainer review of v1.
    The v1 approach of silently skipping the cursor update on lock
    failure violated the atomic-commit contract with userspace.
---
 drivers/gpu/drm/virtio/virtgpu_drv.h   |  1 +
 drivers/gpu/drm/virtio/virtgpu_gem.c   | 17 +++++++++++++++++
 drivers/gpu/drm/virtio/virtgpu_plane.c | 10 ++++++++--
 3 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/virtgpu_drv.h
index f17660a71a3e..2f3531950aa4 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.h
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
@@ -317,6 +317,7 @@ virtio_gpu_array_from_handles(struct drm_file *drm_file, u32 *handles, u32 nents
 void virtio_gpu_array_add_obj(struct virtio_gpu_object_array *objs,
 			      struct drm_gem_object *obj);
 int virtio_gpu_array_lock_resv(struct virtio_gpu_object_array *objs);
+int virtio_gpu_lock_one_resv_uninterruptible(struct virtio_gpu_object_array *objs);
 void virtio_gpu_array_unlock_resv(struct virtio_gpu_object_array *objs);
 void virtio_gpu_array_add_fence(struct virtio_gpu_object_array *objs,
 				struct dma_fence *fence);
diff --git a/drivers/gpu/drm/virtio/virtgpu_gem.c b/drivers/gpu/drm/virtio/virtgpu_gem.c
index f22dc5c21cd4..435d37d36034 100644
--- a/drivers/gpu/drm/virtio/virtgpu_gem.c
+++ b/drivers/gpu/drm/virtio/virtgpu_gem.c
@@ -238,6 +238,23 @@ int virtio_gpu_array_lock_resv(struct virtio_gpu_object_array *objs)
 	return ret;
 }
 
+int virtio_gpu_lock_one_resv_uninterruptible(struct virtio_gpu_object_array *objs)
+{
+	int ret;
+
+	if (objs->nents != 1)
+		return -EINVAL;
+
+	dma_resv_lock(objs->objs[0]->resv, NULL);
+
+	ret = dma_resv_reserve_fences(objs->objs[0]->resv, 1);
+	if (ret) {
+		virtio_gpu_array_unlock_resv(objs);
+		return ret;
+	}
+	return 0;
+}
+
 void virtio_gpu_array_unlock_resv(struct virtio_gpu_object_array *objs)
 {
 	if (objs->nents == 1) {
diff --git a/drivers/gpu/drm/virtio/virtgpu_plane.c b/drivers/gpu/drm/virtio/virtgpu_plane.c
index a126d1b25f46..652352424744 100644
--- a/drivers/gpu/drm/virtio/virtgpu_plane.c
+++ b/drivers/gpu/drm/virtio/virtgpu_plane.c
@@ -215,7 +215,10 @@ static void virtio_gpu_resource_flush(struct drm_plane *plane,
 		if (!objs)
 			return;
 		virtio_gpu_array_add_obj(objs, vgfb->base.obj[0]);
-		virtio_gpu_array_lock_resv(objs);
+		if (virtio_gpu_lock_one_resv_uninterruptible(objs)) {
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
+		if (virtio_gpu_lock_one_resv_uninterruptible(objs)) {
+			virtio_gpu_array_put_free(objs);
+			return;
+		}
 		virtio_gpu_cmd_transfer_to_host_2d
 			(vgdev, 0,
 			 plane->state->crtc_w,
-- 
2.43.0

